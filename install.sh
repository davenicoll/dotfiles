#!/bin/bash

# Symlink dotfiles
ln -sf "$PWD/.zshrc" "$HOME/.zshrc"
ln -sf "$PWD/.zprofile" "$HOME/.zprofile"

# Symlink iTerm configuration
ln -sf "$PWD/com.googlecode.iterm2.plist" "$HOME/Library/Preferences/com.googlecode.iterm2.plist"

# Remove any old versions of the jetbrains mono nerd font
rm ~/Library/Fonts/JetBrainsMonoNerd*
rm ~/Library/Fonts/JetBrainsMonoNLNerdFont*

# Symlink font files
for font_file in fonts/*.ttf; do
    base_name=$(basename "$font_file")
    echo "Symlinking $font_file to $HOME/Library/Fonts/$base_name"
    ln -s "$PWD/$font_file" "$HOME/Library/Fonts/$base_name"
done

exit

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install formulas
brew install shellcheck eza fzf zoxide

# Install casks
brew install --cask mac-mouse-fix rectangle shottr raycast iterm2 copyclip monitorcontrol bitwarden

# Mac specific settings

# Disable Mission Control spaces (drag to screen top)
defaults write com.apple.dock mcx-expose-disabled -bool TRUE && killall Dock

# Always show scrollbars
defaults write "Apple Global Domain" AppleShowScrollBars -string Always

# Set keyboard typing preferences
defaults write -g InitialKeyRepeat -int 35 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2         # normal minimum is 2 (30 ms)

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

# Turn of desktop click / StageManager in Sonoma (and later)
defaults write "com.apple.WindowManager" EnableStandardClickToShowDesktop 0

# Turn off Siri
defaults write com.apple.assistant.support "Assistant Enabled" -bool false
defaults write com.apple.Siri StatusMenuVisible -bool false

# Configure dock
defaults write "com.apple.dock" "minimize-to-application" -bool true
defaults write "com.apple.dock" "show-recents" -bool false
defaults write com.apple.dock tilesize -int 39

# Configure Finder
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
# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# Show the ~/Library folder
chflags nohidden ~/Library
# Show the /Volumes folder
sudo chflags nohidden /Volumes

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

# Accept the xcode license
sudo xcodebuild -license accept
