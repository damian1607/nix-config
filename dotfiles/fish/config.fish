set -g fish_greeting

# fastfetch only in Alacritty, not in nvim or VSCodium terminals
if status is-interactive; and test "$TERM" = alacritty
  fastfetch
end
