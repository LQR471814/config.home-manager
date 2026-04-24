{ pkgs, ... }:
{
  enable = true;
  plugins = with pkgs; {
    inherit (yaziPlugins)
      bookmarks
      ;
  };
  settings = {
    open.prepend_rules = [
      {
        mime = "application/zip";
        use = "unzip";
      }
      {
        mime = "text/*";
        use = "edit";
      }
      {
        mime = "video/*";
        use = "play";
      }
      {
        mime = "inode/directory";
        use = "shell";
      }
    ];
    opener = {
      unzip = [
        {
          run = ''unzip "$1" -d "$\{1%.*}"'';
          block = false;
          orphan = true;
          desc = "Unzip the current file.";
        }
      ];
      open = [
        {
          run = ''xdg-open "$@"'';
          desc = "Open with xdg.";
          block = false;
          orphan = true;
        }
      ];
      play = [
        {
          run = ''vlc "$@"'';
          desc = "Play file.";
          block = false;
          orphan = true;
        }
      ];
      edit = [
        {
          run = ''nvim "$@"'';
          desc = "Edit file.";
          block = true;
        }
      ];
      shell = [
        {
          run = ''kitty -d "$@"'';
          desc = "Open directory in new terminal.";
          block = false;
          orphan = true;
        }
      ];
    };
  };
  keymap = {
    mgr.append_keymap = [
      {
        on = [
          "g"
          "c"
        ];
        run = "cd ~/Code";
        desc = "Go to Code";
      }
      {
        on = [
          "g"
          "g"
        ];
        run = "cd ~/files";
        desc = "Go to files";
      }
      {
        on = [
          "g"
          "D"
        ];
        run = "cd ~/Documents";
        desc = "Go to Documents";
      }
      {
        on = [
          "g"
          "k"
        ];
        run = "cd '~/Documents/Knowledge Base'";
        desc = "Go to Knowledge Base";
      }
      {
        on = [
          "g"
          "s"
        ];
        run = "cd '~/Documents/School'";
        desc = "Go to School";
      }
      {
        on = [
          "g"
          "S"
        ];
        run = "cd '/srv/shared'";
        desc = "Go to virtual shared folder";
      }
      {
        on = [
          "g"
          "r"
        ];
        run = "cd '~/Documents/Recruiting'";
        desc = "Go to Recruiting";
      }
      {
        on = [
          "g"
          "b"
        ];
        run = "cd ~/Books";
        desc = "Go to Books";
      }
      {
        on = [
          "g"
          "m"
        ];
        run = "cd ~/Music";
        desc = "Go to Music";
      }
    ];
    mgr.prepend_keymap = [
      {
        on = [ "m" ];
        run = "plugin bookmarks save";
        desc = "Save current position as a bookmark";
      }
      {
        on = [ "'" ];
        run = "plugin bookmarks jump";
        desc = "Jump to a bookmark";
      }
      {
        on = [
          "b"
          "d"
        ];
        run = "plugin bookmarks delete";
        desc = "Delete a bookmark";
      }
      {
        on = [
          "b"
          "D"
        ];
        run = "plugin bookmarks delete_all";
        desc = "Delete all bookmarks";
      }
      {
        on = [ "F" ];
        run = [
          "search_do --via=fd"
          "filter --smart"
        ];
        desc = "Find files using fd";
      }
    ];
  };
}
