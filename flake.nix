{
  description = "Drip API documentation - a Middleman (Slate) static site";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }:
    let
      systems = [ "aarch64-darwin" "x86_64-darwin" "aarch64-linux" "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      formatter = forAllSystems (pkgs: pkgs.nixfmt-rfc-style);

      devShells = forAllSystems (pkgs:
        let
          # Everything the site build itself depends on.
          siteTools = with pkgs; [
            ruby_3_3
            bundler
            pkg-config
            nodejs
            gnumake
            git
          ];

          siteLibs = with pkgs; [
            libxml2
            libxslt
            zlib
            libffi
            openssl
          ];

          # gnu toolset, shadowing the macOS bsd variants in /usr/bin
          gnuTools = with pkgs; [
            coreutils
            gnused
            gnugrep
            gawk
            findutils
            gnutar
            diffutils
          ];

          repoTools = with pkgs; [
            ripgrep
            fd
            jq
            yq-go
            curl
            tree
            python3
          ];

          shellTools = with pkgs; [
            bashInteractive
            bash-completion
            neovim
            less
          ];

          archiveTools = with pkgs; [
            gzip
            xz
            zstd
            unzip
            delta
            bat
          ];

          common = {
            buildInputs = siteLibs;

            # Gems live in the checkout, not the user profile.
            BUNDLE_PATH = "vendor/bundle";
            BUNDLE_BIN = "vendor/bundle/bin";

            # nokogiri links against the libxml2/libxslt above rather than
            # compiling its vendored copies.
            BUNDLE_BUILD__NOKOGIRI = "--use-system-libraries";

            shellHook = ''
              export GEM_HOME="$PWD/.gem"
              mkdir -p "$GEM_HOME/bin" "$PWD/vendor/bundle/bin"
              export PATH="$PWD/vendor/bundle/bin:$GEM_HOME/bin:$PATH"
            '';
          };
        in
        {
          # Build-only closure, for CI.
          ci = pkgs.mkShell (common // {
            name = "api-docs-ci";
            nativeBuildInputs = siteTools ++ gnuTools;
          });

          default = pkgs.mkShell (common // {
            name = "api-docs";
            nativeBuildInputs = siteTools ++ gnuTools ++ repoTools ++ shellTools ++ archiveTools;
            shellHook = common.shellHook + ''
              export BASH_COMPLETION="${pkgs.bash-completion}/share/bash-completion/bash_completion"
            '';
          });
        });
    };
}
