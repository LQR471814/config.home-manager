{ HOME, ... }:
{
  enable = true;
  shellAliases = {
    lzg = "lazygit";
    y = "yazi";
    ls = "ls --color=auto";
    nvt = "tmux-spawn $PWD 'nvim .'";
    shut = "sudo shutdown now -h";
    batchargefull = "sudo tlp setcharge 0 100";
    batcharge80 = "sudo tlp setcharge 0 80";
    batreset = "sudo tlp start";
    notes = "tmux-spawn ~/Nextcloud/Documents/Notes 'nvim ~/Nextcloud/Documents/Notes'";
    hmconf = "tmux-spawn ~/.config/home-manager 'nvim ~/.config/home-manager'";
    osconf = "tmux-spawn ~/.config/nixos 'nvim ~/.config/nixos'";
    nvconf = "tmux-spawn ~/.config/nvim 'nvim ~/.config/nvim'";
  };
  interactiveShellInit = ''
    set fish_greeting ""
    set -g fish_key_bindings fish_vi_key_bindings

    function __fish_yank_selection
        # copy current selection (or current line if no selection) to system clipboard
        fish_clipboard_copy

        # get back to normal mode
    	commandline -f end-selection
        set fish_bind_mode default
        commandline -f repaint
    end

    function __fish_yank_line
        # yank whole line (useful for "yy" or "Y")
        fish_clipboard_copy
    end

    # install the vi-friendly bindings
    function fish_user_key_bindings
        # in visual mode: 'y' should yank selection to the system clipboard
        bind -M visual 'y' __fish_yank_selection

        # common normal-mode yanks: 'yy' and 'Y' => yank whole line
        bind 'yy' __fish_yank_line
        bind 'Y'  __fish_yank_line

        # paste from system clipboard in normal mode with 'p'
        bind 'p' fish_clipboard_paste
    end
  '';
}
