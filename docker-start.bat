@echo off
REM Docker Start Script for Project Reva (Windows)
REM This script helps you get started quickly

echo 🚀 Starting Project Reva with Docker...

REM Check if .env file exists
if not exist .env (
    echo ⚠️  .env file not found. Creating from env.example...
    copy env.example .env
    echo ✅ Created .env file. Please review and update it if needed.
    echo.
)

REM Create necessary directories
echo 📁 Creating necessary directories...
if not exist "Public\uploads" mkdir "Public\uploads"
if not exist "temp_downloads" mkdir "temp_downloads"
echo ✅ Directories created.

REM Build and start containers
echo.
echo 🔨 Building and starting Docker containers...
docker-compose up -d --build

REM Wait for services to be ready
echo.
echo ⏳ Waiting for services to start...
timeout /t 10 /nobreak >nul

REM Check if containers are running
echo.
echo 📊 Container Status:
docker-compose ps

echo.
echo ✅ Setup complete!
echo.
echo 🌐 Application should be available at: http://localhost:4000
echo.
echo 📝 Default login credentials:
echo    Staff: master_user / master123
echo    Operator: operator_user / operator123
echo    Super Admin: admin_demo / Demo@123
echo    Customer: customer_demo / Demo@123
echo.
echo 📋 To view logs: docker-compose logs -f
echo 🛑 To stop: docker-compose down

pause

