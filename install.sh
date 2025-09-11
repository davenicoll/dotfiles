#!/bin/bash

echo "This script will install tools and modify system settings. Requesting sudo..."

# Authenticate as admin up front
sudo -v

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Symlink dotfiles
ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/.zprofile" "$HOME/.zprofile"
ln -sf "$PWD/.p10k.zsh" "$HOME/.p10k.zsh"

# Symlink iTerm configuration
cp "$PWD/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/com.googlecode.iterm2.plist"

# Remove any old versions of the jetbrains mono nerd font and install the latest version
# rm ~/Library/Fonts/JetBrainsMonoNerd*
# rm ~/Library/Fonts/JetBrainsMonoNLNerdFont*
cp fonts/* "$HOME/Library/Fonts/"

# Install homebrew
if [[ $(which brew | grep bin | wc -l) -eq 0 ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  export PATH="$HOME/homebrew/bin:$HOME/homebrew/sbin:$PATH"
fi

if ! command -v brew &>/dev/null; then
  echo "Error: Homebrew is not installed or not in PATH." >&2
  exit 1
fi

# Install tools
brew install \
  zsh-completions \
  eza \
  fzf \
  zoxide \
  yt-dlp \
  ffmpeg \
  btop \
  htop \
  jq \
  yq \
  lolcat \
  figlet \
  progress \
  bat \
  tree \
  nmap

# Install coding & devops tools
brew install \
  shellcheck \
  gh \
  atmos \
  tfenv \
  az \
  checkov \
  tfsec \
  terraform-docs \
  awscli \
  pyenv \
  pre-commit \
  node \
  yamlfmt \
  yamllint \
  helm \
  terraform-ls \
  qemu \
  k9s \
  ansible \
  kubectl \
  postman \
  dagger \
  uv \
  openssl readline xz zlib
  
# Install casks
brew install --cask mac-mouse-fix rectangle shottr raycast iterm2 monitorcontrol bitwarden angry-ip-scanner hex-fiend appcleaner vlc angry-ip-scanner

# Install node tools (npx, pnpm, yarn, etc)
npm install -g corepack
corepack enable

# Install powershell
brew install powershell/tap/powershell
pwsh -c "Install-Module -Name Az -Repository PSGallery -Force"

###############################################################################
# Mac specific settings                                                       #
###############################################################################

# Set keyboard shortcuts and turn off spotlight (use raycast)
cp -f com.apple.symbolichotkeys.plist ~/Library/Preferences/

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable Mission Control spaces (drag to screen top)
defaults write com.apple.dock mcx-expose-disabled -bool true
defaults write com.apple.spaces spans-displays -bool true
killall Dock

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space
defaults write com.apple.dock dashboard-in-overlay -bool true

# Always show scrollbars
defaults write "Apple Global Domain" AppleShowScrollBars -string Always

# Enable/disable menu bar items and set their position
defaults write "com.apple.controlcenter" "NSStatusItem Preferred Position Battery" 260
defaults write "com.apple.controlcenter" "NSStatusItem Preferred Position BentoBox" 156
defaults write "com.apple.controlcenter" "NSStatusItem Preferred Position Bluetooth" 308
defaults write "com.apple.controlcenter" "NSStatusItem Preferred Position NowPlaying" 313
defaults write "com.apple.controlcenter" "NSStatusItem Preferred Position Sound" 270
defaults write "com.apple.controlcenter" "NSStatusItem Preferred Position WiFi" 222
defaults write "com.apple.controlcenter" "NSStatusItem Visible Battery" 1
defaults write "com.apple.controlcenter" "NSStatusItem Visible BentoBox" 1
defaults write "com.apple.controlcenter" "NSStatusItem Visible Bluetooth" 1
defaults write "com.apple.controlcenter" "NSStatusItem Visible Clock" 1
defaults write "com.apple.controlcenter" "NSStatusItem Visible Item-0" 0
defaults write "com.apple.controlcenter" "NSStatusItem Visible Item-1" 0
defaults write "com.apple.controlcenter" "NSStatusItem Visible Item-2" 0
defaults write "com.apple.controlcenter" "NSStatusItem Visible Item-3" 0
defaults write "com.apple.controlcenter" "NSStatusItem Visible Item-4" 0
defaults write "com.apple.controlcenter" "NSStatusItem Visible Item-5" 0
defaults write "com.apple.controlcenter" "NSStatusItem Visible NowPlaying" 1
defaults write "com.apple.controlcenter" "NSStatusItem Visible Sound" 1
defaults write "com.apple.controlcenter" "NSStatusItem Visible WiFi" 1

# Disable click wallpaper to show desktop items
defaults write "com.apple.WindowManager" EnableStandardClickToRevealDesktop -bool false
defaults write "com.apple.WindowManager" EnableStandardClickToShowDesktop -bool false
killall WindowManager

# Turn off Siri
defaults write com.apple.assistant.support "Assistant Enabled" -bool false
defaults write com.apple.Siri StatusMenuVisible -bool false

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

cp com.apple.symbolichotkeys.plist "/Users/$USER/Library/Preferences/com.apple.symbolichotkeys.plist"

# Enable home and end keys on external keyboard
mkdir -p ~/Library/KeyBindings
cat <<EOF >~/Library/KeyBindings/DefaultKeyBinding.dict
{
  "\UF729"  = moveToBeginningOfParagraph:; // home
  "\UF72B"  = moveToEndOfParagraph:; // end
  "$\UF729" = moveToBeginningOfParagraphAndModifySelection:; // shift-home
  "$\UF72B" = moveToEndOfParagraphAndModifySelection:; // shift-end
  "^\UF729" = moveToBeginningOfDocument:; // ctrl-home
  "^\UF72B" = moveToEndOfDocument:; // ctrl-end
  "^$\UF729" = moveToBeginningOfDocumentAndModifySelection:; // ctrl-shift-home
  "^$\UF72B" = moveToEndOfDocumentAndModifySelection:; // ctrl-shift-end
}
EOF

# Disable smart quotes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a faster keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 30

# Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true
# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Trackpad: map bottom right corner to right-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

# Disable “natural” (Lion-style) scrolling
defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false

# Increase sound quality for Bluetooth headphones/headsets
# defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2>/dev/null

###############################################################################
# Screen                                                                      #
###############################################################################

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true
# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true
# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true
# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# Avoid creating .DS_Store files on USB drives
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Enable snap-to-grid for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library folder
chflags nohidden ~/Library
# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool true \
  Privileges -bool true

###############################################################################
# Dock                                                                        #
###############################################################################

# Configure dock
defaults write "com.apple.dock" "minimize-to-application" -bool true
defaults write "com.apple.dock" "show-recents" -bool false
defaults write com.apple.dock tilesize -int 39

# Add Home and Downloads folders to the dock

USERNAME=$(whoami)

defaults write "com.apple.dock" "persistent-others" \
  '<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<array>
        <dict>
                <key>GUID</key>
                <integer>3060904667</integer>
                <key>tile-data</key>
                <dict>
                        <key>arrangement</key>
                        <integer>1</integer>
                        <key>book</key>
                        <data>
                        Ym9vawwCAAAAAAQQMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
                        AAAAAAAAAAAAIAEAAAQAAAADAwAAAAAAIAwAAAABAQAAQXBwbGlj
                        YXRpb25zBAAAAAEGAAAQAAAACAAAAAQDAADPOAAAAAAAAAQAAAAB
                        BgAAMAAAAAgAAAAABAAAQcU9M06Tzs4YAAAAAQIAAAIAAAAAAAAA
                        DwAAAAAAAAAAAAAAAAAAAAAAAAABBQAACAAAAAEJAABmaWxlOi8v
                        LwwAAAABAQAATWFjaW50b3NoIEhECAAAAAQDAAAAAIcROQAAAAgA
                        AAAABAAAQcU9LocAAAAkAAAAAQEAADY5MTIyRDA3LTNCOEYtNEY0
                        NC05NDM3LUY3N0U4OUYwODVCMBgAAAABAgAAgQAAAAEAAADvEwAA
                        AQAAAAAAAAAAAAAAAQAAAAEBAAAvAAAAtAAAAP7///8BAAAAAAAA
                        AA4AAAAEEAAAJAAAAAAAAAAFEAAAQAAAAAAAAAAQEAAAXAAAAAAA
                        AABAEAAATAAAAAAAAAACIAAAFAEAAAAAAAAFIAAAhAAAAAAAAAAQ
                        IAAAlAAAAAAAAAARIAAAyAAAAAAAAAASIAAAqAAAAAAAAAATIAAA
                        uAAAAAAAAAAgIAAA9AAAAAAAAAAwIAAAfAAAAAAAAAAB0AAAfAAA
                        AAAAAAAQ0AAABAAAAAAAAAA=
                        </data>
                        <key>displayas</key>
                        <integer>1</integer>
                        <key>file-data</key>
                        <dict>
                                <key>_CFURLString</key>
                                <string>file:///Applications/</string>
                                <key>_CFURLStringType</key>
                                <integer>15</integer>
                        </dict>
                        <key>file-label</key>
                        <string>Applications</string>
                        <key>file-mod-date</key>
                        <integer>60670189247699</integer>
                        <key>file-type</key>
                        <integer>2</integer>
                        <key>is-beta</key>
                        <false/>
                        <key>parent-mod-date</key>
                        <integer>3773814286</integer>
                        <key>preferreditemsize</key>
                        <integer>-1</integer>
                        <key>showas</key>
                        <integer>2</integer>
                </dict>
                <key>tile-type</key>
                <string>directory-tile</string>
        </dict>
        <dict>
                <key>GUID</key>
                <integer>2885655737</integer>
                <key>tile-data</key>
                <dict>
                        <key>arrangement</key>
                        <integer>3</integer>
                        <key>book</key>
                        <data>
                        Ym9va5ACAAAAAAQQMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
                        AAAAAAAAAAAAjAEAAAQAAAADAwAAAAAAIAUAAAABAQAAVXNlcnMA
                        AAAHAAAAAQEAAGRuaWNvbGwACQAAAAEBAABEb3dubG9hZHMAAAAM
                        AAAAAQYAABAAAAAgAAAAMAAAAAgAAAAEAwAAyzgAAAAAAAAIAAAA
                        BAMAADxwAAAAAAAACAAAAAQDAABvcAAAAAAAAAwAAAABBgAAWAAA
                        AGgAAAB4AAAACAAAAAAEAABBxT0zVYAAABgAAAABAgAAAgAAAAAA
                        AAAPAAAAAAAAAAAAAAAAAAAACAAAAAQDAAABAAAAAAAAAAQAAAAD
                        AwAA9gEAAAgAAAABCQAAZmlsZTovLy8MAAAAAQEAAE1hY2ludG9z
                        aCBIRAgAAAAEAwAAAACHETkAAAAIAAAAAAQAAEHFPS6HAAAAJAAA
                        AAEBAAA2OTEyMkQwNy0zQjhGLTRGNDQtOTQzNy1GNzdFODlGMDg1
                        QjAYAAAAAQIAAIEAAAABAAAA7xMAAAEAAAAAAAAAAAAAAAEAAAAB
                        AQAALwAAAAAAAAABBQAAzAAAAP7///8BAAAAAAAAABAAAAAEEAAA
                        RAAAAAAAAAAFEAAAiAAAAAAAAAAQEAAArAAAAAAAAABAEAAAnAAA
                        AAAAAAACIAAAeAEAAAAAAAAFIAAA6AAAAAAAAAAQIAAA+AAAAAAA
                        AAARIAAALAEAAAAAAAASIAAADAEAAAAAAAATIAAAHAEAAAAAAAAg
                        IAAAWAEAAAAAAAAwIAAAhAEAAAAAAAABwAAAzAAAAAAAAAARwAAA
                        IAAAAAAAAAASwAAA3AAAAAAAAAAQ0AAABAAAAAAAAAA=
                        </data>
                        <key>displayas</key>
                        <integer>1</integer>
                        <key>file-data</key>
                        <dict>
                                <key>_CFURLString</key>
                                <string>file:///Users/'${USERNAME}'/Downloads/</string>
                                <key>_CFURLStringType</key>
                                <integer>15</integer>
                        </dict>
                        <key>file-label</key>
                        <string>Downloads</string>
                        <key>file-mod-date</key>
                        <integer>161971287791798</integer>
                        <key>file-type</key>
                        <integer>2</integer>
                        <key>is-beta</key>
                        <false/>
                        <key>parent-mod-date</key>
                        <integer>2597936339149</integer>
                        <key>preferreditemsize</key>
                        <integer>-1</integer>
                        <key>showas</key>
                        <integer>1</integer>
                </dict>
                <key>tile-type</key>
                <string>directory-tile</string>
        </dict>
</array>
</plist>'

killall Dock # restart the dock

###############################################################################
# Spotlight                                                                   #
###############################################################################

# Hide Spotlight tray-icon (and subsequent helper)
#sudo chmod 600 /System/Library/CoreServices/Search.bundle/Contents/MacOS/Search
# Disable Spotlight indexing for any volume that gets mounted and has not yet
# been indexed before.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing any volume.
# sudo defaults write /.Spotlight-V100/VolumeConfiguration Exclusions -array "/Volumes"
# Change indexing order and disable some search results
# Yosemite-specific search results (remove them if you are using macOS 10.9 or older):
# 	MENU_DEFINITION
# 	MENU_CONVERSION
# 	MENU_EXPRESSION
# 	MENU_SPOTLIGHT_SUGGESTIONS (send search queries to Apple)
# 	MENU_WEBSEARCH             (send search queries to Apple)
# 	MENU_OTHER
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 1;"name" = "APPLICATIONS";}' \
  '{"enabled" = 1;"name" = "SYSTEM_PREFS";}'
# Load new settings before rebuilding the index
killall mds >/dev/null 2>&1
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / >/dev/null
# Rebuild the index from scratch
sudo mdutil -E / >/dev/null

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
# hash tmutil &>/dev/null && sudo tmutil disablelocal

# Disable local Time Machine snapshots
# sudo tmutil disablelocal

###############################################################################
# XCode                                                                       #
###############################################################################

print_result() {
  [ $1 -eq 0 ] && echo "$2" || echo "$2"

  return $1
}

if ! xcode-select --print-path &>/dev/null; then

  # Prompt user to install the XCode Command Line Tools
  xcode-select --install &>/dev/null

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Wait until the XCode Command Line Tools are installed
  until xcode-select --print-path &>/dev/null; do
    sleep 5
  done

  echo $? 'Install XCode Command Line Tools'

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Point the `xcode-select` developer directory to
  # the appropriate directory from within `Xcode.app`
  # https://github.com/alrra/dotfiles/issues/13

  sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
  print_result $? 'Make "xcode-select" developer directory point to Xcode'

  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  # Prompt user to agree to the terms of the Xcode license
  # https://github.com/alrra/dotfiles/issues/10

  sudo xcodebuild -license accept
  print_result $? 'Agree with the XCode Command Line Tools licence'

fi

print_result $? 'XCode Command Line Tools'

echo "You must restart (not just logout) for changes to take effect."
