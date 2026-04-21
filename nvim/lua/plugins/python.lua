return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "black" },
      },
      formatters = {
        black = {
          env = {
            PATH = (function()
              local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
              local dirs = {}
              for dir in (os.getenv("PATH") or ""):gmatch("[^:]+") do
                if dir ~= mason_bin then
                  table.insert(dirs, dir)
                end
              end
              return table.concat(dirs, ":")
            end)(),
          },
        },
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
}
