#!/bin/bash

# Docker Start Script for Project Reva
# This script helps you get started quickly

echo "🚀 Starting Project Reva with Docker..."

# Check if .env file exists
if [ ! -f .env ]; then
    echo "⚠️  .env file not found. Creating from env.example..."
    cp env.example .env
    echo "✅ Created .env file. Please review and update it if needed."
    echo ""
fi

# Create necessary directories
echo "📁 Creating necessary directories..."
mkdir -p Public/uploads
mkdir -p temp_downloads
echo "✅ Directories created."

# Build and start containers
echo ""
echo "🔨 Building and starting Docker containers..."
docker-compose up -d --build

# Wait for services to be ready
echo ""
echo "⏳ Waiting for services to start..."
sleep 10

# Check if containers are running
echo ""
echo "📊 Container Status:"
docker-compose ps

echo ""
echo "✅ Setup complete!"
echo ""
echo "🌐 Application should be available at: http://localhost:4000"
echo ""
echo "📝 Default login credentials:"
echo "   Staff: master_user / master123"
echo "   Operator: operator_user / operator123"
echo "   Super Admin: admin_demo / Demo@123"
echo "   Customer: customer_demo / Demo@123"
echo ""
echo "📋 To view logs: docker-compose logs -f"
echo "🛑 To stop: docker-compose down"

