# NVIM CONFIG
inspired by:
(https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/)

use `:h 'option'` to get documentation on an option
set an option with `vim.opt.option = value`

```lua
use vim.keymap.set({mode}, {lhs}, {rhs}, {opts})
```
to set keybindings

## {mode}
Specifies the mode where the keybindings can execute
| {mode} | Mode             |
|:-------|:-----------------|
|n       |Normal            |
|i       |Insert            |
|v       |Visual + Selection|
|t       |Terminal          |
|o       |Operator-pending  |
|''      |n + v + o         |

## {lhs}
Key being binded

## {rhs}
Action to be executed, can be a lua function

## {opts}
lua table with any of the following properties

### desc
String describing the keymap

### remap
Can the binding be recursive(default false)

### buffer
boolean or number, if true it's only effective in the current file, if a number it must be in the id of an open buffer

### silent
Can the keybind not show a message(default false)

### expr
Boolean, if true use vimscript or lua to calculate the value of {rhs}

<leader> is used as mapleader global variable(space in this config)
