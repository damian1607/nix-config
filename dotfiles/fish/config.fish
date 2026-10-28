set -g fish_greeting

if status is-interactive
  alias ls "eza --icons"
  alias cat "bat -pp --theme=ansi"

  # fastfetch only in Ghostty
  if test "$TERM" = xterm-ghostty
    fastfetch
  end
end
