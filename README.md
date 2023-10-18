# dvd.nvim

Play the famous DVD animation inside a neovim buffer

## Install

### Packer

```lua
use {
    'njegg/dvd.nvim',
    requires = {
        {'eandrju/cellular-automaton.nvim'},
        {'uga-rosa/utf8.nvim'}
    }
}
```

## Keymap
```lua
vim.keymap.set("n", "<leader>dvd", ":CellularAutomaton dvd<CR>")
```
