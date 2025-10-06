{
  config,
  pkgs,
  lib,
  ...
}:

lib.mkIf config.isPC {
  home-manager.sharedModules = [
    {
      home.sessionVariables =
        let
          browserPath = "${pkgs.firefox}/bin/firefox";
        in
        {
          BROWSER = browserPath;
          DEFAULT_BROWSER = browserPath;
        };

      xdg.mimeApps = {
        enable = true;
        defaultApplications =
          let
            browser = "firefox.desktop";
            documentViewer = "org.kde.okular.desktop";
            imageViewer = "org.gnome.Loupe.desktop";
            videoPlayer = "org.kde.haruna.desktop";
          in
          {
            # Default browser
            "text/html" = browser;
            "x-scheme-handler/http" = browser;
            "x-scheme-handler/https" = browser;
            "x-scheme-handler/about" = browser;
            "x-scheme-handler/unknown" = browser;

            # PDF files
            "application/pdf" = documentViewer;
            "application/x-pdf" = documentViewer;

            # Image files
            "image/jpeg" = imageViewer;
            "image/jpg" = imageViewer;
            "image/png" = imageViewer;
            "image/gif" = imageViewer;
            "image/webp" = imageViewer;
            "image/tiff" = imageViewer;
            "image/bmp" = imageViewer;
            "image/svg+xml" = imageViewer;
            "image/x-icon" = imageViewer;

            # Video files
            "video/mp4" = videoPlayer;
            "video/x-msvideo" = videoPlayer; # .avi
            "video/quicktime" = videoPlayer; # .mov
            "video/x-matroska" = videoPlayer; # .mkv
            "video/webm" = videoPlayer;
            "video/x-flv" = videoPlayer;
            "video/x-ms-wmv" = videoPlayer;
            "application/x-matroska" = videoPlayer;
          };
      };
    }
  ];
}
