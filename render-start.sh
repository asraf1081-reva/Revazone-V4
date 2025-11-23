#!/bin/bash
# Render start script - runs seed then starts the app
echo "🌱 Seeding database..."
node seed.js
echo "✅ Database seeded!"
echo "🚀 Starting application..."
node index.js

