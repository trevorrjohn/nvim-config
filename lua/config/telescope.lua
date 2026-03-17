local telescope = require("telescope")

local opts = {}
local has_fzf, _ = pcall(require, "telescope._extensions.fzf")

if has_fzf then
  opts.extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  }
end

telescope.setup(opts)

if has_fzf then
  pcall(telescope.load_extension, "fzf")
end
