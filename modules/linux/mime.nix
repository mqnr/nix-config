{ pkgs, ... }:

{
  # TODO: move this somewhere else?
  home.sessionVariables = let browserPath = "${pkgs.librewolf}/bin/librewolf"; in {
    BROWSER         = browserPath;
    DEFAULT_BROWSER = browserPath;
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      browser        = [ "librewolf.desktop" ];
      documentViewer = [ "org.kde.okular.desktop" ];
      imageViewer    = [ "viewnior.desktop" ];
    in {
      # Default browser
      "text/html"                = browser;
      "x-scheme-handler/http"    = browser;
      "x-scheme-handler/https"   = browser;
      "x-scheme-handler/about"   = browser;
      "x-scheme-handler/unknown" = browser;

      # PDF files in Okular
      "application/pdf"   = documentViewer;
      "application/x-pdf" = documentViewer;

      # Image files in Viewnior
      "image/jpeg"    = imageViewer;
      "image/png"     = imageViewer;
      "image/gif"     = imageViewer;
      "image/webp"    = imageViewer;
      "image/tiff"    = imageViewer;
      "image/bmp"     = imageViewer;
      "image/x-icon"  = imageViewer;
      "image/svg+xml" = imageViewer;
    };
  };
}
