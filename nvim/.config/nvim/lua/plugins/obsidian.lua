local vault_root = vim.fs.normalize(vim.fn.expand("~/vaults/main"))

local function normalize_tag(tag)
  if type(tag) ~= "string" then
    return nil
  end

  tag = vim.trim(tag):gsub("^#+", "")
  if tag == "" then
    return nil
  end

  return tag
end

local function reorder_tags_on_current_note(tags)
  local api = require "obsidian.api"
  local log = require "obsidian.log"

  local note = api.current_note(0)
  if not note then
    log.warn("'%s' is not a note in your workspace", vim.api.nvim_buf_get_name(0))
    return
  end

  local selected = {}
  local selected_set = {}
  for _, tag in ipairs(tags or {}) do
    tag = normalize_tag(tag)
    if tag and not selected_set[tag] then
      selected[#selected + 1] = tag
      selected_set[tag] = true
    end
  end

  if vim.tbl_isempty(selected) then
    log.info "No tags selected"
    return
  end

  local reordered = {}
  for _, tag in ipairs(note.tags or {}) do
    if not selected_set[tag] then
      reordered[#reordered + 1] = tag
    end
  end
  for _, tag in ipairs(selected) do
    reordered[#reordered + 1] = tag
  end

  if vim.deep_equal(note.tags or {}, reordered) then
    log.info "Tags already in that order"
    return
  end

  note.tags = reordered

  if note:update_frontmatter(0) then
    log.info("Updated tag order %s", selected)
  else
    log.warn "Frontmatter unchanged"
  end
end

local function pick_tags_for_current_note()
  local api = require "obsidian.api"
  local log = require "obsidian.log"
  local search = require "obsidian.search"

  local note = api.current_note(0)
  if not note then
    log.warn("'%s' is not a note in your workspace", vim.api.nvim_buf_get_name(0))
    return
  end

  search.find_tags_async("", function(tag_locations)
    local seen = {}
    local tags = {}

    for _, tag in ipairs(note.tags or {}) do
      tag = normalize_tag(tag)
      if tag and not seen[tag] then
        tags[#tags + 1] = tag
        seen[tag] = true
      end
    end

    local discovered = {}
    for _, tag_loc in ipairs(tag_locations) do
      local tag = normalize_tag(tag_loc.tag)
      if tag and not seen[tag] then
        discovered[#discovered + 1] = tag
        seen[tag] = true
      end
    end

    table.sort(discovered)
    vim.list_extend(tags, discovered)

    vim.schedule(function()
      if vim.tbl_isempty(tags) then
        vim.ui.input({ prompt = "New tag: " }, function(input)
          local tag = normalize_tag(input)
          if tag then
            reorder_tags_on_current_note({ tag })
          end
        end)
        return
      end

      require("fzf-lua").fzf_exec(tags, {
        prompt = "Add tags ❯ ",
        winopts = {
          title = "Obsidian Add Tag",
        },
        fzf_opts = {
          ["--multi"] = true,
          ["--header"] = "TAB toggle, ENTER apply order, CTRL-N add current query as new tag",
        },
        actions = {
          ["enter"] = function(selected)
            reorder_tags_on_current_note(selected or {})
          end,
          ["ctrl-n"] = function(_, fzf_opts)
            local tag = normalize_tag(fzf_opts.query)
            if not tag then
              log.warn "Type a tag name first"
              return
            end

            reorder_tags_on_current_note({ tag })
          end,
        },
      })
    end)
  end, { dir = api.resolve_workspace_dir() })
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  cond = function()
    return vim.uv.fs_stat(vault_root) ~= nil
  end,
  ft = "markdown",
  cmd = { "Obsidian", "ObsidianAddTag" },
  keys = {
    { "<leader>oa", pick_tags_for_current_note, desc = "Add tags to note" },
    { "<leader>oc", "<cmd>Obsidian toc<cr>", desc = "Current note outline" },
    { "<leader>od", "<cmd>Obsidian dailies<cr>", desc = "Daily notes" },
    { "<leader>of", "<cmd>Obsidian quick_switch<cr>", desc = "Quick switch note" },
    { "<leader>ol", "<cmd>Obsidian links<cr>", desc = "Current note links" },
    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New note" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Backlinks" },
    { "<leader>oo", "<cmd>Obsidian today<cr>", desc = "Today's note" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search notes" },
    { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Tags" },
  },
  ---@module "obsidian"
  ---@type obsidian.config
  opts = {
    legacy_commands = false,
    workspaces = {
      {
        name = "main",
        path = "~/vaults/main",
      },
    },
    daily_notes = {
      enabled = true,
      folder = "Journal",
      date_format = "YYYY-MM-DD",
      default_tags = { "daily-notes" },
      workdays_only = true,
    },
    templates = {
      folder = "Templates",
      date_format = "YYYY-MM-DD",
      time_format = "HH:mm",
      substitutions = {},
    },
    sync = {
      enabled = true,
      mode = "bidirectional",
      conflict_strategy = "merge",
      file_types = {},
      device_name = "nvim-main",
    },
    picker = {
      name = "fzf-lua",
    },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    vim.api.nvim_create_user_command("ObsidianAddTag", pick_tags_for_current_note, {
      desc = "Add tags to current Obsidian note",
    })
  end,
}
