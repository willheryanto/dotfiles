-- Cucumber/Gherkin language support (Cypress)

-- Configure cucumber language server
vim.lsp.config("cucumber_language_server", {
  cmd = { "cucumber-language-server", "--stdio" },
  filetypes = { "cucumber", "feature" },
  root_markers = { "cypress.config.js", "cypress.config.ts", "cucumber.yml", ".git" },
  settings = {
    cucumber = {
      features = { "cypress/e2e/**/*.feature" },
      glue = { "cypress/e2e/**/*.js" },
    },
  },
})
vim.lsp.enable("cucumber_language_server")

return {
  -- NOTE: nvim-treesitter doesn't currently ship a `gherkin` parser in the
  -- locked version of this config, so we don't try to install it here.
}
