return {
  "matbme/JABS.nvim",
  cmd = "JABSOpen",
  config = function()
    require("config.jabs").setup()
  end,
}
