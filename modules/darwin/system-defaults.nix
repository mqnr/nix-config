{ ... }:

{
  system.defaults = {
    # Dock settings
    dock = {
      mru-spaces = false;
      show-recents = false;
      showhidden = true;

      tilesize = 48;
    };

    # Finder settings
    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      QuitMenuItem = true; # Allow quitting Finder

      _FXShowPosixPathInTitle = true;
      FXPreferredViewStyle = "Nlsv"; # Default to list view
      ShowPathbar = true;
      ShowStatusBar = true;
      ShowMountedServersOnDesktop = true;

      _FXSortFoldersFirst = true;
      _FXSortFoldersFirstOnDesktop = false;
      FXRemoveOldTrashItems = true;
    };

    # Global macOS settings (NSGlobalDomain)
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      AppleScrollerPagingBehavior = true; # Jump to the spot that’s clicked on the scroll bar
      AppleShowScrollBars = "Automatic";

      InitialKeyRepeat = 15;
      KeyRepeat = 2;
      ApplePressAndHoldEnabled = false; # Disable press-and-hold for special characters

      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticInlinePredictionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;

      NSNavPanelExpandedStateForSaveMode = true;
      NSNavPanelExpandedStateForSaveMode2 = true;
      PMPrintingExpandedStateForPrint = true;
      PMPrintingExpandedStateForPrint2 = true;

      NSDocumentSaveNewDocumentsToCloud = false; # Save to disk by default, not iCloud

      NSWindowResizeTime = 0.003;

      AppleKeyboardUIMode = 2; # Enable full keyboard access for all controls (not just text boxes and lists)
    };

    # Screenshots
    screencapture = {
      location = "~/Pictures/Screenshots";
      type = "png";
    };

    # Login window settings
    loginwindow = {
      DisableConsoleAccess = true;
      GuestEnabled = false;
    };

    LaunchServices.LSQuarantine = false;

    CustomSystemPreferences = {
      # No.
      "com.apple.AdLib" = {
        allowApplePersonalizedAdvertising = false;
        allowIdentifierForAdvertising = false;
        forceLimitAdTracking = true;
        personalizedAdsMigrated = false;
      };
    };

  };

  # Ensure screenshots directory exists
  home-manager.sharedModules = [ { home.file."Pictures/Screenshots/.keep".text = ""; } ];
}
