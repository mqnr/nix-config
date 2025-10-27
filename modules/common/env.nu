$env.PATH = (
  [
    ($env.HOME | path join ".nix-profile" "bin")
    ("/etc/profiles/per-user" | path join $env.USER "bin")
    "/run/current-system/sw/bin"
    "/nix/var/nix/profiles/default/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "/usr/local/bin"
    "/usr/bin"
    "/bin"
    "/usr/sbin"
    "/sbin"
  ]
  | where { |path| ($path | path exists) }
  | str join ":"
)

$env.NIX_PATH = $"nixpkgs=($env.HOME)/.nix-defexpr/channels/nixpkgs"
$env.NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-certificates.crt"
