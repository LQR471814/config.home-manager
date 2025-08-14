{ pkgs, ... }:
{
  enable = true;
  enableGitIntegration = true;
  shellIntegration.enableFishIntegration = true;
  themeFile = "Catppuccin-Mocha";
  font.package = pkgs.nerd-fonts.monaspace;
  font.name = "MonaspiceNe NF Light";
  settings = {
    confirm_os_window_close = 0;
	clear_all_shortcuts = true;
  };
  keybindings = {
	"ctrl+0" = "send_text all \\u001b[48;5u";
	"ctrl+1" = "send_text all \\u001b[49;5u";
	"ctrl+2" = "send_text all \\u001b[50;5u";
	"ctrl+3" = "send_text all \\u001b[51;5u";
	"ctrl+4" = "send_text all \\u001b[52;5u";
	"ctrl+5" = "send_text all \\u001b[53;5u";
	"ctrl+6" = "send_text all \\u001b[54;5u";
	"ctrl+7" = "send_text all \\u001b[55;5u";
	"ctrl+8" = "send_text all \\u001b[56;5u";
	"ctrl+9" = "send_text all \\u001b[57;5u";
  };
}
