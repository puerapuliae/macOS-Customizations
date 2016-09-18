#!/bin/sh

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `customize.sh` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Set computer name (as done via System Preferences → Sharing)
sudo scutil --set ComputerName "x-wing"
sudo scutil --set HostName "x-wing"
sudo scutil --set LocalHostName "x-wing"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "x-wing"

### make the dock as unobtrusive as possible
defaults write com.apple.dock tilesize -int 1
defaults write com.apple.dock pinning -string start

# turn off creation of .DS_Store on network drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# tcp segment size to something more 'modern'
sudo sysctl -w net.inet.tcp.mssdflt=1460

# modify boot time images
sudo cp backgrounds/BootLogo.png /System/Library/CoreServices/
sudo cp backgrounds/DefaultDesktop.jpg /System/Library/CoreServices/

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Disable opening and closing window animations
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Increase window resize speed for Cocoa applications
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Disable window animations and Get Info animations in Finder
defaults write com.apple.finder DisableAllAnimations -bool true

# Show all filename extensions in Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Empty Trash securely by default
defaults write com.apple.finder EmptyTrashSecurely -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable Resume system-wide
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Automatically illuminate built-in MacBook keyboard in low light
defaults write com.apple.BezelServices kDim -bool true
# Turn off keyboard illumination when computer is not used for 5 minutes
defaults write com.apple.BezelServices kDimTime -int 300

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Enable subpixel font rendering on non-Apple LCDs
defaults write NSGlobalDomain AppleFontSmoothing -int 2

# Make expose animations happen really damn quick
defaults write com.apple.dock expose-animation-duration -float 0.01

# Set my preferred desktop background
sudo cp backgrounds/star_wars_force_awakens.jpg "/Library/Desktop Pictures/"
defaults write com.apple.desktop Background '{default = {ImageFilePath = "/Library/Desktop Pictures/star_wars_force_awakens.jpg"; };}'

# Show standard unix directories in finder
sudo chflags nohidden /bin /etc /usr

#Show Path bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

#Show Status bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

#Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Kill affected applications
for app in Safari Finder Dock Mail SystemUIServer; do killall "$app" > /dev/null 2>&1; done
echo "Done. Note that some of these changes require a logout/restart to take effect."


