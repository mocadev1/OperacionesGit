#!/usr/bin/bash 

# This part of the script until line 10 was to cover instruction for the point 2

# read -p "Please enter the \"-p\" argument for the patch to be applied: " slash_number
# 
# read -p "Please enter the patch filename: " patchfile
# 
# # The line below applies a patch given a "strip" number
# patch -p $slash_number < $patchfile

# ___________________________
# Modifying patch information

formatted_patch="formatted.patch"
# Generates a patch from a given commit for a specific file 
git format-patch --output=$formatted_patch -1  e9ae46322d77ce9047008c6eb6c276c0d416e40d -- README.md

# Modifying the git-format-patch output for the author identity, this was done only for educational purposes, all rights reserved to original author
sed -i "s/Steven Maude.*$/Carlos Omar Beltran Miguel <OmarBeltran@users.noreply.github.com>/" $formatted_patch
# modifying the patch itself
sed -i "19 s/joke/useless/1" $formatted_patch

# Moving to a commit previous to the one in the "From" of the patchfile
git checkout 02e8680ea523f31c4caba29e116035c0ec243152

# Applying patch
git apply $formatted_patch

# Cat the patched file in the detachd HEAD and grep to the changed word
echo -e "\n\n\n\n============================================="
echo "This line below was modified by the patch"
echo -e "=============================================\n\n"
cat README.md | grep useless
echo -e "\n\n=============================================\n"

# Discarding all changes by restoring the `unstaged` files for commit
git restore README.md

# Moving back to `master` branch
git checkout master