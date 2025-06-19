{ ... }:

{
  programs.helix = {
    enable = true;

    settings = {
      theme = "onedarker";

      editor = {
        line-number      = "relative";
        soft-wrap.enable = true;
      };
    };
  };
}
