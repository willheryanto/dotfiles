local function is_env_file(bufnr)
  local name = vim.api.nvim_buf_get_name(bufnr or 0)
  local basename = vim.fs.basename(name)

  return basename == ".env" or vim.startswith(basename, ".env.")
end

local function make_region(line_num, from_col, to_col)
  if not from_col then
    return nil
  end

  local region = {
    from = { line = line_num, col = from_col },
  }

  if to_col and to_col >= from_col then
    region.to = { line = line_num, col = to_col }
  end

  return region
end

local function trim_range(line, from_col, to_col)
  while from_col <= to_col and line:sub(from_col, from_col):match("%s") do
    from_col = from_col + 1
  end
  while to_col >= from_col and line:sub(to_col, to_col):match("%s") do
    to_col = to_col - 1
  end

  return from_col, to_col
end

local function parse_env_assignment(line)
  local line_len = #line
  local cursor = 1

  while cursor <= line_len and line:sub(cursor, cursor):match("%s") do
    cursor = cursor + 1
  end

  if cursor > line_len or line:sub(cursor, cursor) == "#" then
    return nil
  end

  local export_prefix = line:sub(cursor):match("^(export%s+)")
  if export_prefix then
    cursor = cursor + #export_prefix
  end

  local in_single_quote = false
  local in_double_quote = false
  local escaped = false
  local eq_col

  for col = cursor, line_len do
    local char = line:sub(col, col)

    if in_single_quote then
      if char == "'" then
        in_single_quote = false
      end
    elseif in_double_quote then
      if escaped then
        escaped = false
      elseif char == "\\" then
        escaped = true
      elseif char == '"' then
        in_double_quote = false
      end
    else
      if char == "'" then
        in_single_quote = true
      elseif char == '"' then
        in_double_quote = true
      elseif char == "=" then
        eq_col = col
        break
      end
    end
  end

  if not eq_col then
    return nil
  end

  local key_from, key_to = trim_range(line, cursor, eq_col - 1)
  if key_from > key_to then
    return nil
  end

  local value_from = eq_col + 1
  while value_from <= line_len and line:sub(value_from, value_from):match("%s") do
    value_from = value_from + 1
  end

  if value_from > line_len then
    return {
      key = { from_col = key_from, to_col = key_to },
      value_a = { from_col = value_from, to_col = nil },
      value_i = { from_col = value_from, to_col = nil },
    }
  end

  local first_char = line:sub(value_from, value_from)
  if first_char == '"' or first_char == "'" then
    local quote = first_char
    local value_to = line_len
    local inner_from = value_from + 1
    local inner_to = line_len
    escaped = false

    for col = value_from + 1, line_len do
      local char = line:sub(col, col)

      if quote == '"' and escaped then
        escaped = false
      elseif quote == '"' and char == "\\" then
        escaped = true
      elseif char == quote then
        value_to = col
        inner_to = col - 1
        break
      end
    end

    return {
      key = { from_col = key_from, to_col = key_to },
      value_a = { from_col = value_from, to_col = value_to },
      value_i = { from_col = inner_from, to_col = inner_to },
    }
  end

  local value_to = line_len

  for col = value_from, line_len do
    if line:sub(col, col) == "#" and (col == value_from or line:sub(col - 1, col - 1):match("%s")) then
      value_to = col - 1
      break
    end
  end

  _, value_to = trim_range(line, value_from, value_to)

  return {
    key = { from_col = key_from, to_col = key_to },
    value_a = { from_col = value_from, to_col = value_to },
    value_i = { from_col = value_from, to_col = value_to },
  }
end

local function env_textobject(kind)
  return function(ai_type)
    if not is_env_file(0) then
      return nil
    end

    local regions = {}
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

    for line_num, line in ipairs(lines) do
      local assignment = parse_env_assignment(line)
      if assignment then
        local target = assignment[kind]

        if kind == "value" then
          target = ai_type == "a" and assignment.value_a or assignment.value_i
        end

        local region = make_region(line_num, target.from_col, target.to_col)
        if region then
          table.insert(regions, region)
        end
      end
    end

    return regions
  end
end

local function apply_env_miniai_textobjects(args)
  local bufnr = args.buf
  if not is_env_file(bufnr) then
    return
  end

  local buffer_config = vim.b[bufnr].miniai_config or {}
  local custom_textobjects = vim.tbl_extend("force", buffer_config.custom_textobjects or {}, {
    k = env_textobject("key"),
    ["="] = env_textobject("value"),
  })

  vim.b[bufnr].miniai_config = vim.tbl_deep_extend("force", buffer_config, {
    custom_textobjects = custom_textobjects,
  })
end

-- Mini.nvim modules
return {
  -- Comment: Toggle comments
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    opts = {
      -- Default mappings:
      -- gcc - Toggle comment on current line
      -- gc{motion} - Toggle comment on motion (e.g., gcip for paragraph)
      -- gc in visual mode - Toggle comment on selection
    },
  },

  -- Surround: Add/delete/change surroundings
  {
    "echasnovski/mini.surround",
    event = "VeryLazy",
    opts = {
      -- Default mappings (customized to gz prefix to avoid conflict with Flash):
      -- gza - Add surrounding (e.g., gzaiw" adds " around word)
      -- gzd - Delete surrounding (e.g., gzd" deletes surrounding ")
      -- gzr - Replace surrounding (e.g., gzr"' replaces " with ')
      -- gzf - Find surrounding (move cursor right)
      -- gzF - Find surrounding (move cursor left)
      -- gzh - Highlight surrounding
      -- gzn - Update n_lines for searching
      mappings = {
        add = "gza",
        delete = "gzd",
        replace = "gzr",
        find = "gzf",
        find_left = "gzF",
        highlight = "gzh",
        update_n_lines = "gzn",
      },
    },
  },

  -- AI: Better text objects
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = {
      n_lines = 500,
      -- Custom text objects:
      -- q - quotes (works with any quote type)
      -- b - brackets (works with any bracket type)
      -- a - argument
      -- f - function call
      -- t - tag
      -- u - UUID
      -- U - URL (http/https)
      custom_textobjects = {
        -- Whole buffer
        g = function()
          local from = { line = 1, col = 1 }
          local to = {
            line = vim.fn.line("$"),
            col = math.max(vim.fn.getline("$"):len(), 1),
          }
          return { from = from, to = to }
        end,
        -- Matches canonical UUIDs like 123e4567-e89b-12d3-a456-426614174000
        u = {
          "%f[%x]%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x%f[^%x%-]",
        },
        -- Matches URLs and trims common trailing punctuation.
        U = function()
          local patterns = {
            "https://[%w%-._~:/%?#%[%]@!$&'()*+,;%%=]+",
            "http://[%w%-._~:/%?#%[%]@!$&'()*+,;%%=]+",
          }
          local trailing_punctuation = "[%.,;:!%?%)%]%}]+$"
          local regions = {}

          for line_num = 1, vim.api.nvim_buf_line_count(0) do
            local line = vim.fn.getline(line_num)

            for _, pattern in ipairs(patterns) do
              local init = 1
              while init <= #line do
                local from_col, to_col = line:find(pattern, init)
                if not from_col then
                  break
                end

                local url = line:sub(from_col, to_col)
                local trimmed = url:gsub(trailing_punctuation, "")
                if trimmed ~= "" then
                  table.insert(regions, {
                    from = { line = line_num, col = from_col },
                    to = { line = line_num, col = from_col + #trimmed - 1 },
                  })
                end

                init = to_col + 1
              end
            end
          end

          return regions
        end,
      },
    },
    config = function(_, opts)
      require("mini.ai").setup(opts)

      local group = vim.api.nvim_create_augroup("mini_ai_env_textobjects", { clear = true })
      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile", "BufEnter" }, {
        group = group,
        pattern = { ".env", ".env.*" },
        callback = apply_env_miniai_textobjects,
      })

      for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
          apply_env_miniai_textobjects({ buf = bufnr })
        end
      end
    end,
  },

  -- Cmdline: Enhance command line
  -- {
  --   "nvim-mini/mini.cmdline",
  --   version = false,
  --   event = "VeryLazy",
  --   opts = {},
  -- },
}
