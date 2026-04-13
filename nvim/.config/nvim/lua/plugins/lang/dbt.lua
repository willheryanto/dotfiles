-- Custom gf handler for dbt ref() and source() navigation
local function dbt_goto_file()
  local line = vim.fn.getline(".")

  -- Find dbt project root
  local dbt_project = vim.fn.findfile("dbt_project.yml", ".;")
  if dbt_project == "" then
    vim.cmd("normal! gf")
    return
  end

  local project_root = vim.fn.fnamemodify(dbt_project, ":p:h")
  local models_dir = project_root .. "/models"

  -- Match source('source_name', 'table_name') pattern
  local source_name, table_name = line:match("source%s*%(%s*['\"]([^'\"]+)['\"]%s*,%s*['\"]([^'\"]+)['\"]")

  if source_name and table_name then
    -- Search for YAML files containing the source definition
    local yaml_files = vim.fn.globpath(models_dir, "**/*.yaml", false, true)
    local yml_files = vim.fn.globpath(models_dir, "**/*.yml", false, true)
    vim.list_extend(yaml_files, yml_files)

    for _, file in ipairs(yaml_files) do
      local lines = vim.fn.readfile(file)
      local content = table.concat(lines, "\n")

      -- Check if file contains both source name and table name in correct structure
      local source_pattern = "-%s*name:%s*" .. vim.pesc(source_name)
      local source_pos = content:find(source_pattern)

      if source_pos then
        -- Find tables: section after source name
        local tables_pos = content:find("tables:", source_pos)
        if tables_pos then
          -- Find next source block (if any) to limit our search
          local next_source_pos = content:find("\n%- name:", tables_pos)

          -- Look for table name between tables: and next source (or end of file)
          local search_end = next_source_pos or #content
          local tables_section = content:sub(tables_pos, search_end)
          local table_pattern = "-%s*name:%s*" .. vim.pesc(table_name) .. "%s*\n"

          if tables_section:find(table_pattern) then
            -- Find the line number of the table definition
            local target_line = nil
            for i, line_content in ipairs(lines) do
              if line_content:match("^%s*-%s*name:%s*" .. vim.pesc(table_name) .. "%s*$") then
                target_line = i
                break
              end
            end

            vim.cmd("edit " .. vim.fn.fnameescape(file))
            if target_line then
              vim.api.nvim_win_set_cursor(0, { target_line, 0 })
            end
            return
          end
        end
      end
    end
    vim.notify("Source '" .. source_name .. "." .. table_name .. "' not found", vim.log.levels.WARN)
    return
  end

  -- Match ref('model_name') pattern
  local ref_name = line:match("ref%s*%(%s*['\"]([^'\"]+)['\"]")

  if ref_name then
    -- Search for SQL file matching the ref name
    local sql_files = vim.fn.globpath(models_dir, "**/" .. ref_name .. ".sql", false, true)

    if #sql_files > 0 then
      vim.cmd("edit " .. vim.fn.fnameescape(sql_files[1]))
      return
    end

    -- Also check macros directory
    local macros_dir = project_root .. "/macros"
    sql_files = vim.fn.globpath(macros_dir, "**/" .. ref_name .. ".sql", false, true)

    if #sql_files > 0 then
      vim.cmd("edit " .. vim.fn.fnameescape(sql_files[1]))
      return
    end

    vim.notify("Model '" .. ref_name .. "' not found", vim.log.levels.WARN)
    return
  end

  -- Fall back to normal gf
  vim.cmd("normal! gf")
end

-- Setup dbt navigation for SQL files in dbt projects
local function setup_dbt_gf()
  local dbt_project = vim.fn.findfile("dbt_project.yml", ".;")
  if dbt_project ~= "" then
    vim.keymap.set("n", "gf", dbt_goto_file, { buffer = true, desc = "dbt go to file" })
  end
end

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = { "*.sql" },
  callback = setup_dbt_gf,
  desc = "Set dbt gf mapping for ref/source navigation",
})

return {}
