#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Step 1: Commit changes to the main branch
echo "Committing changes to the main branch..."
git add .
git commit -m "Update blog content"

# Step 2: Render the Quarto site
echo "Rendering the Quarto site..."
quarto render

# Step 3: Deploy the site to the gh-pages branch
echo "Deploying the site to the gh-pages branch..."
git checkout gh-pages

# Clear the current files (but keep .git directory)
find . -maxdepth 1 ! -name '.git' ! -name '.' -exec rm -rf {} \;

# Copy the newly rendered site files from the _site directory
cp -r _site/* .

# Add and commit the new site files
git add .
git commit -m "Update site"

# Push the updated site to the gh-pages branch
git push origin gh-pages --force

# Switch back to the main branch
git checkout main

echo "Deployment complete!"
