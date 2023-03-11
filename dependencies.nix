pkgs : with pkgs; [
    fzf
    nodePackages.intelephense
    nil # nix language server
    sumneko-lua-language-server
    pyright
    ripgrep
    rnix-lsp # Unmaintained? Poor suggestions..
    nil # Nix LS (wip).
    nixpkgs-fmt # Nix formatter.
    statix # Static nix checker.
    # deno # dependency for markdown preview
    # chromium # dependency for markdown preview
]
