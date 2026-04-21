return {
  -- Register rustfmt as the formatter for Rust files
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" },
      },
    },
  },

  -- Configure rust-analyzer inlay hints
  {
    "mrcjkb/rustaceanvim",
    opts = {
      server = {
        default_settings = {
          ["rust-analyzer"] = {
            inlayHints = {
              bindingModeHints = { enable = false },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 25 },
              closureReturnTypeHints = { enable = "with_block" },
              lifetimeElisionHints = { enable = "skip_trivial", useParameterNames = true },
              maxLength = { enable = true, value = 25 },
              parameterHints = { enable = true },
              rangeExclusiveHints = { enable = false },
              reborrowHints = { enable = "skip_trivial" },
              renderColons = { enable = true },
              typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
            },
          },
        },
      },
    },
  },
}
