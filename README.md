# Neovim Config

## lazy-lock.json

`lazy-lock.json` is gitignored. Since this is a personal config (not shared/team), tracking exact plugin versions adds commit noise without meaningful benefit. Plugins are updated via `lazy update` and pinning specific versions isn't needed.

## Language servers

This repo intentionally keeps setup lightweight.

- Lua, Ruby, TypeScript, and Go LSPs are all optional and resolved from your PATH when available.
- Elixir LSP is optional. It is only enabled when a language server executable is found.
- If you never use Elixir on a given machine, there is nothing to install.

If you want Elixir support, install it on that machine (how you do this is up to you):

- with mise: `mise use -g elixir@1.18.4 elixir-ls@0.30.0 erlang@28.1 java@17.0.2`

Then restart Neovim. If the command is unavailable, Neovim will show a normal "not installed" warning and keep running.

If you use this config on many machines and want consistent Elixir versions there, use a repo-local `.mise.toml` (for example `[tools] elixir = "1.18.4" elixir-ls = "0.30.0"`) and decide whether to keep it committed per machine.
