-- Database initialization script
-- This script runs automatically when the PostgreSQL container is first created

-- Create extensions if needed
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Note: The application will create tables automatically via the ensureControlCenterSchema() function
-- This script can be used for any initial setup or custom configurations

-- Set timezone (optional)
SET timezone = 'UTC';

