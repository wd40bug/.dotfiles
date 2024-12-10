local tln = ']' -- Tree Leader Next
local tlp = '[' -- Tree Leader Previous

---@diagnostic disable-next-line: missing-fields
require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true, -- Better syntax highlighting
  },
  indent = {
    enable = true
  },
  textsubjects = {
    enable = true,
    prev_selection = ',', -- (Optional) keymap to select the previous selection
    keymaps = {
      ['.'] = 'textsubjects-smart',
      [';'] = 'textsubjects-container-outer',
      ['i;'] = 'textsubjects-container-inner',
    },
  },
  textobjects = {
    select = { -- Selections of text objects
      enable = true,
      lookahead = true,
      keymaps = {
        ['ap'] = '@parameter.outer',
        ['ip'] = '@parameter.inner',
        ['l'] = '@assignment.lhs',
        ['r'] = '@assignment.rhs',

      }
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_next_start = {
        [tln .. 'f'] = '@function.outer',
        [tln .. 't'] = '@class.outer',
        [tln .. 'p'] = '@parameter.outer',
        [tln .. 'r'] = '@return.outer',


      },
      goto_next_end = {
        [tln .. 'F'] = '@function.outer',
        [tln .. 'T'] = '@class.outer',
        [tln .. 'P'] = '@parameter.outer',
        [tln .. 'R'] = '@return.outer',


      },
      goto_previous_start = {
        [tlp .. 'f'] = '@function.outer',
        [tlp .. 't'] = '@class.outer',
        [tlp .. 'p'] = '@parameter.outer',
        [tlp .. 'r'] = '@return.outer',


      },
      goto_previous_end = {
        [tlp .. 'F'] = '@function.outer',
        [tlp .. 'T'] = '@class.outer',
        [tlp .. 'P'] = '@parameter.outer',
        [tlp .. 'R'] = '@return.outer',


      },
    }
  },
  ensure_installed = {
    'rust',
    'c',
    'json',
    'toml',
    'verilog',
    'lua',
    'markdown',
    'vimdoc',
    'java',
    'svelte',
  },
})

local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
parser_config.powershell = {
    install_info = {
        url = "~/Downloads/tree-sitter-powershell",
        files = { "src/parser.c", "src/scanner.c" },                 
        branch = "main",                            
        generate_requires_npm = false,              
        requires_generate_from_grammar = false,     
    },
    filetype = "ps1",                               
}
