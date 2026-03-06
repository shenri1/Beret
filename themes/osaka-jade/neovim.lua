return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      terminal_colors = true,
      on_colors = function(colors)
        colors.bg        = "#111c18"
        colors.bg_dark   = "#0d1610"
        colors.fg        = "#C1C497"
        colors.green     = "#549e6a"
        colors.teal      = "#2DD5B7"
        colors.cyan      = "#ACD4CF"
        colors.blue      = "#509475"
        colors.magenta   = "#D2689C"
        colors.yellow    = "#E5C736"
        colors.red       = "#FF5345"
        colors.comment   = "#53685B"
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight-night")
    end,
  },
}
