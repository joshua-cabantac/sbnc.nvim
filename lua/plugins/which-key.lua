return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
  win = {
    title = true,
    title_pos = "center",
    width = 40,
    col = 0,
    row = math.huge,
	  }
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
