#!/usr/bin/env zsh
cd ..

echo "Get current directory"
mydir="$(pwd)"
echo "Current dir: $mydir"

# Get path where create clean architecture structure.
featureFolderName="profile"

if [ -z "$featureFolderName" ]; then
    echo "Feature folder name must not be empty!"
    exit 1
fi

pathCleanArch="$mydir/lib/$featureFolderName"

# Create Feature folder.
mkdir -p "$pathCleanArch"

# Create Single feature structure.
mkdir -p "$pathCleanArch/data"
mkdir -p "$pathCleanArch/application"
mkdir -p "$pathCleanArch/domain"

# Create Data folder Structure
mkdir -p "$pathCleanArch/data/source"
mkdir -p "$pathCleanArch/data/repo"
mkdir -p "$pathCleanArch/data/repo/source"
mkdir -p "$pathCleanArch/data/repo/source/dto"

# Create Domain folder structure
mkdir -p "$pathCleanArch/domain/entities"
mkdir -p "$pathCleanArch/domain/services"
mkdir -p "$pathCleanArch/domain/services/repo"

# Create Application folder structure
mkdir -p "$pathCleanArch/application/constants"
mkdir -p "$pathCleanArch/application/controllers"
mkdir -p "$pathCleanArch/application/exceptions"
mkdir -p "$pathCleanArch/application/mixins"
mkdir -p "$pathCleanArch/application/utils"
mkdir -p "$pathCleanArch/application/ux"
mkdir -p "$pathCleanArch/application/ux/pages"
mkdir -p "$pathCleanArch/application/ux/widgets"
mkdir -p "$pathCleanArch/application/viewmodel"