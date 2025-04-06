{ config, lib, pkgs, ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = let docViewer = "org.kde.okular.desktop"; imgViewer = "viewnior.desktop"; in {
      # PDF files in Okular
      "application/pdf" = [docViewer];
      "application/x-pdf" = [docViewer];

      # Image files in Viewnior
      "image/jpeg" = [imgViewer];
      "image/png" = [imgViewer];
      "image/gif" = [imgViewer];
      "image/webp" = [imgViewer];
      "image/tiff" = [imgViewer];
      "image/bmp" = [imgViewer];
      "image/x-icon" = [imgViewer];
      "image/svg+xml" = [imgViewer];
    };
  };
}
