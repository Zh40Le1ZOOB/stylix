{ config, lib, ... }:

{
  options.stylix.targets.fish = {
    enable = config.lib.stylix.mkEnableTarget "Fish" true;
    enableApply = lib.mkEnableOption "apply config for Fish" // {
      default = true;
    };
    config = lib.mkOption {
      type = lib.types.attrs;
      default = lib.mkIf (config.stylix.enable && config.stylix.targets.fish.enable) {
        programs.fish.promptInit = import ./prompt.nix config;
      };
      readOnly = true;
    };
  };

  config = lib.mkIf config.stylix.targets.fish.enableApply config.stylix.targets.fish.config;
}
