local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Ruby function snippet
ls.add_snippets("ruby", {
  s("defn", {
    t("def "), i(1, "method_name"), t("("), i(2, "args"), t({")", "  "}),
    i(0),
    t({"", "end"})
  }),
})

-- Tab / Shift-Tab to move through snippet nodes
vim.keymap.set({ "i", "s" }, "<Tab>", function()
  return ls.expand_or_jumpable() and ls.expand_or_jump() or "<Tab>"
end, { expr = true })

vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  return ls.jumpable(-1) and ls.jump(-1) or "<S-Tab>"
end, { expr = true })

