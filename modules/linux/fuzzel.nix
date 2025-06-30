{ ... }:

{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        font     = "Aporetic Sans:size=14";
        use-bold = true;

        match-counter = true;

        horizontal-pad = 16;
        inner-pad      = 8;

        line-height = 24;
      };

      colors = let text-color = "ffffffff"; in {
        background      = "26302fe6";
        text            = text-color;
        prompt          = "c1bcdcff";
        input           = text-color;
        match           = "d188a9ff";
        selection       = "3e5a70ff";
        selection-text  = text-color;
        selection-match = "d188a9ff";
        border          = "73b8e5ff";
      };

      border = {
        width  = 2;
        radius = 6;
      };
    };
  };
}
