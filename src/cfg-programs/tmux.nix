{ ... }:
{
  enable = true;

  escapeTime = 0;
  focusEvents = true;
  keyMode = "vi";
  prefix = "M-a";
  terminal = "tmux-256color";
  clock24 = true;

  extraConfig = ''
    # allow ctrl-1, etc... special key combos to work
    set -s extended-keys on

    # make tmux set the window title of the terminal
    set-option -g set-titles on

    bind h select-pane -L
    bind l select-pane -R
    bind k select-pane -U
    bind j select-pane -D

    bind \\ split-window -h
    bind - split-window -v
    unbind '"'
    unbind %

    bind -T copy-mode-vi v send -X begin-selection
    bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
    bind r source-file ~/.config/tmux/tmux.conf
    bind P paste-buffer
    bind Q kill-session

    set -g base-index 1
    setw -g pane-base-index 1
    set-option -g renumber-windows on
  '';
}
