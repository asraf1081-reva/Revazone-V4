@echo off
REM Quick script to push files to GitHub
REM Run this from your project folder

echo ========================================
echo  Pushing Project Reva to GitHub
echo ========================================
echo.

REM Check if git is initialized
if not exist .git (
    echo Initializing Git repository...
    git init
    echo.
)

echo Adding all files...
git add .
echo.

echo Creating commit...
git commit -m "Initial commit - Project Reva V4.2"
echo.

echo Connecting to GitHub repository...
git remote remove origin 2>nul
git remote add origin https://github.com/asraf1081-reva/Revazone-V4.git
echo.

echo Setting main branch...
git branch -M main
echo.

echo Pushing to GitHub...
echo NOTE: You may be asked for GitHub credentials
echo       Use Personal Access Token if prompted for password
echo.
git push -u origin main

echo.
echo ========================================
if %ERRORLEVEL% EQU 0 (
    echo ✅ Successfully pushed to GitHub!
    echo.
    echo Check your repository:
    echo https://github.com/asraf1081-reva/Revazone-V4
) else (
    echo ❌ Push failed. Check error messages above.
    echo.
    echo Common issues:
    echo - Authentication: Use Personal Access Token
    echo - Repository access: Make sure you have write access
)
echo ========================================
echo.
pause

