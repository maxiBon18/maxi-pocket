#!/usr/bin/env zsh
# Resolve Flutter package root (parent of lib/) from this script's location:
# .../maxi_pocket/.cursor/skills/new-feature/scripts/this-file.sh
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../../.." && pwd)"
cd "$PROJECT_ROOT" || exit 1

echo "Get current directory"
mydir="$(pwd)"
echo "Current dir: $mydir"

# Get path where create clean architecture structure.
featureFolderName=<featureFolderName>

if [ -z "$featureFolderName" ]; then
    echo "Feature folder name must not be empty!"
    exit 1
fi

pathCleanArch="$mydir/lib/$featureFolderName"
pathAssets="$mydir/assets"

if [ -z "$pathAssets" ]; then
    echo "Assets folder must not be empty!"
    exit 1
fi

# Create Assets folder and subfolders.
mkdir -p "$pathAssets"
mkdir -p "$pathAssets/images"
mkdir -p "$pathAssets/images/svg"
mkdir -p "$pathAssets/images/1.5x"
mkdir -p "$pathAssets/images/2.0x"
mkdir -p "$pathAssets/images/3.0x"
mkdir -p "$pathAssets/images/4.0x"
mkdir -p "$pathAssets/fonts"
mkdir -p "$pathAssets/icons"

# Create Feature folder.
mkdir -p "$pathCleanArch"

# Create Single feature structure.
mkdir -p "$pathCleanArch/data"
mkdir -p "$pathCleanArch/presentation"
mkdir -p "$pathCleanArch/domain"
mkdir -p "$pathCleanArch/shared"

# Create Data folder Structure
mkdir -p "$pathCleanArch/data/source"
mkdir -p "$pathCleanArch/data/repo"
mkdir -p "$pathCleanArch/data/repo/source"
mkdir -p "$pathCleanArch/data/repo/source/dto"

# Create Domain folder structure
mkdir -p "$pathCleanArch/domain/entities"
mkdir -p "$pathCleanArch/domain/services"
mkdir -p "$pathCleanArch/domain/services/repo"

# Create Presentation folder structure
mkdir -p "$pathCleanArch/presentation/ux"
mkdir -p "$pathCleanArch/presentation/ux/pages"
mkdir -p "$pathCleanArch/presentation/ux/widgets"
mkdir -p "$pathCleanArch/presentation/viewmodel"

# Create Shared folder structure
mkdir -p "$pathCleanArch/shared/constants"
mkdir -p "$pathCleanArch/shared/controllers"
mkdir -p "$pathCleanArch/shared/exceptions"
mkdir -p "$pathCleanArch/shared/mixins"
mkdir -p "$pathCleanArch/shared/utils"