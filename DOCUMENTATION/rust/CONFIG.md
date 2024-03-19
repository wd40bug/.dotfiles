# Rust

## Rust Analyzer
[User Manual](https://rust-analyzer.github.io/manual.html)
Configured through LSP messages(configured in editor).
See Nvim and Helix documentation for specifics

## Rust Format
See `rustfmt --help=config` for [configuration options](https://rust-lang.github.io/rustfmt/?version=v1.6.0&search=)
Configured using rustfmt.toml or .rustfmt.toml in project, or in [global config directory](https://docs.rs/dirs/5.0.1/dirs/fn.config_dir.html)

## Clippy
[User Manual](https://doc.rust-lang.org/clippy/)
Configured using a `clippy.toml` or `.clippy.toml` file in 
1. Directory Specified by `CLIPPY_CONF_DIR` variable
2. Directory Specified by `CARGO_MANIFEST_DIR` variable
3. Current Directory
[Lint Configurations](https://doc.rust-lang.org/clippy/lint_configuration.html)
