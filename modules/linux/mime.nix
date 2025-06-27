{ ... }:

{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = let
      documentViewer = [ "org.kde.okular.desktop" ];
      imageViewer    = [ "viewnior.desktop" ];
    in {
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
