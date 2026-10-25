set -g fish_greeting

# fastfetch only in Ghostty, not in nvim or VSCodium terminals
if status is-interactive; and test "$TERM" = xterm-ghostty
  fastfetch
end
