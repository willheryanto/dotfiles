-- DAP: Debug Adapter Protocol
return {
  -- nvim-dap core
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Minimalist DAP view
      { "igorlfs/nvim-dap-view" },
      -- Virtual text for DAP
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      {
        "<leader>dC",
        function()
          local dap = require("dap")
          local fzf = require("fzf-lua")
          local configs = dap.configurations[vim.bo.filetype] or {}
          if #configs == 0 then
            vim.notify("No DAP configurations for " .. vim.bo.filetype, vim.log.levels.WARN)
            return
          end
          local items = {}
          for i, cfg in ipairs(configs) do
            items[i] = { name = cfg.name, index = i }
          end
          fzf.fzf_exec(
            vim.tbl_map(function(item) return item.name end, items),
            {
              prompt = "DAP Config> ",
              actions = {
                ["default"] = function(selected)
                  for _, item in ipairs(items) do
                    if item.name == selected[1] then
                      dap.run(configs[item.index])
                      break
                    end
                  end
                end,
              },
            }
          )
        end,
        desc = "Run Configuration",
      },
      { "<leader>df", function() require("fzf-lua").dap_frames() end, desc = "Frames" },
      { "<leader>dx", function() require("fzf-lua").dap_breakpoints() end, desc = "List Breakpoints" },
      { "<leader>dR", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dv", function() require("dap-view").toggle() end, desc = "Toggle DAP View" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
    config = function()
      local dap = require("dap")
      local dap_view = require("dap-view")

      -- Setup dap-view
      dap_view.setup()

      -- Auto open/close dap-view
      dap.listeners.before.attach["dap-view-config"] = function()
        dap_view.open()
      end
      dap.listeners.before.launch["dap-view-config"] = function()
        dap_view.open()
      end
      dap.listeners.before.event_terminated["dap-view-config"] = function()
        dap_view.close()
      end
      dap.listeners.before.disconnect["dap-view-config"] = function()
        dap_view.close()
      end

      -- Signs
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◐", texthl = "DiagnosticWarn" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticError" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DiagnosticInfo" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DiagnosticWarn", linehl = "DapStoppedLine" })

      -- Setup virtual text
      require("nvim-dap-virtual-text").setup()

      --
      -- Language-specific adapters and configurations
      --

      -- TypeScript/JavaScript (vscode-js-debug)
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.expand("~/ghq/github.com/microsoft/vscode-js-debug/dist/src/dapDebugServer.js"),
            "${port}",
          },
        },
      }
      for _, lang in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[lang] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch Test (Jest)",
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
          },
        }
      end
    end,
  },
}
