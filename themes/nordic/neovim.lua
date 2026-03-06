return {
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent = false,
      terminal_color = true,
    },
    config = function(_, opts)
      require("nordic").setup(opts)
      vim.cmd("colorscheme nordic")
    end,
  },
}
