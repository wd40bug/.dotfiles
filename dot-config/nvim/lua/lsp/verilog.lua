Lspconfig.verible.setup({
  capabilities = Lsp_capabilities,
  cmd = {'verible-verilog-ls', '--rules_config_search'},
})

-- For verilog only create .rules.verible_lint with the contents
-- parameter-name-style=localparam_style:ALL_CAPS
-- -always-comb
-- -explicit-parameter-storage-type
-- -unpacked-dimensions-range-ordering
