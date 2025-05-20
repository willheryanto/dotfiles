return {
  "mfussenegger/nvim-dap",
  keys = {
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "Continue",
    },
    {
      "<F10>",
      function()
        require("dap").step_over()
      end,
      desc = "Step Over",
    },
    {
      "<F11>",
      function()
        require("dap").step_into()
      end,
      desc = "Step Into",
    },
    {
      "<F12>",
      function()
        require("dap").step_out()
      end,
      desc = "Step Out",
    },
  },
  dependencies = {
    {
      "igorlfs/nvim-dap-view",
      keys = {
        {
          "<leader>du",
          "<cmd>DapViewToggle<cr>",
          desc = "Dap view toggle",
        },
      },
      opts = {
        windows = {
          terminal = {
            hide = { "pwa-node", "node" },
          },
        },
      },
      config = function(_, opts)
        local dap, dv = require("dap"), require("dap-view")
        dap.listeners.before.attach["dap-view-config"] = function()
          dv.open()
        end
        dap.listeners.before.launch["dap-view-config"] = function()
          dv.open()
        end
        dap.listeners.before.event_terminated["dap-view-config"] = function()
          dv.close()
        end
        dap.listeners.before.event_exited["dap-view-config"] = function()
          dv.close()
        end

        dv.setup(opts)
      end,
    },
  },
  opts = function()
    local languages = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

    local dap = require("dap")

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
      },
    }

    dap.adapters["pwa-chrome"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "js-debug-adapter",
        args = { "${port}" },
      },
    }

    require("dap.ext.vscode").load_launchjs(nil, {
      ["pwa-node"] = languages,
      ["node"] = languages,
      ["chrome"] = languages,
      ["pwa-chrome"] = languages,
    })

    for _, language in ipairs(languages) do
      vim.list_extend(dap.configurations[language], {
        {
          type = "pwa-node",
          request = "launch",
          name = "My launch file",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "ts-node",
          args = { "${file}" },
          sourceMaps = true,
          protocol = "inspector",
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          resolveSourceMapLocations = {
            "${workspaceFolder}/**",
            "!**/node_modules/**",
          },
          console = "integratedTerminal",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "My attach to process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          console = "integratedTerminal",
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "My start Chrome on port",
          url = function()
            local port = vim.fn.input({
              prompt = "Port ",
              completion = "file",
            })
            return "http://localhost:3000" .. port
          end,
          webRoot = "${workspaceFolder}",
          userDataDir = "${workspaceFolder}/.vscode/vscode-chrome-debug-userdatadir",
          console = "integratedTerminal",
        },
      })
    end
  end,
}
