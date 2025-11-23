# Docker Setup Guide for Project Reva

This guide will help you set up and run the Project Reva application using Docker with PostgreSQL database, backend, and frontend all configured.

## Prerequisites

- Docker Desktop installed (for Windows/Mac) or Docker Engine + Docker Compose (for Linux)
- Git (optional, if cloning the repository)

## Quick Start

### Step 1: Configure Environment Variables

1. Copy the example environment file:
   ```bash
   cp .env.example .env
   ```

2. Edit `.env` file and update the following if needed:
   - `DB_PASSWORD`: Change to a strong password for your database
   - `SESSION_SECRET`: Change to a secure random string
   - Other optional settings (SMTP, API URLs, etc.)

### Step 2: Build and Start Containers

Run the following command to build and start all services:

```bash
docker-compose up -d
```

This will:
- Pull PostgreSQL 15 image
- Build the Node.js application image
- Start both containers
- Initialize the database
- Run the seed script to populate initial data
- Start the application server

### Step 3: Access the Application

Once the containers are running, access the application at:
- **Application**: http://localhost:4000
- **Database**: localhost:5432 (if you need direct access)

### Step 4: Default Login Credentials

After seeding, you can log in with:

**Staff/Admin Login:**
- Username: `master_user`
- Password: `master123`

**Operator Login:**
- Username: `operator_user`
- Password: `operator123`

**Super Admin (Demo):**
- Username: `admin_demo`
- Password: `Demo@123`

**Customer (Demo):**
- Username: `customer_demo`
- Password: `Demo@123`

## Docker Commands

### View Running Containers
```bash
docker-compose ps
```

### View Logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f app
docker-compose logs -f db
```

### Stop Containers
```bash
docker-compose stop
```

### Start Containers
```bash
docker-compose start
```

### Stop and Remove Containers
```bash
docker-compose down
```

### Stop, Remove Containers, and Delete Volumes (⚠️ This deletes database data)
```bash
docker-compose down -v
```

### Rebuild After Code Changes
```bash
docker-compose up -d --build
```

### Execute Commands in Container
```bash
# Access app container shell
docker-compose exec app sh

# Access database
docker-compose exec db psql -U reva_user -d reva_db

# Run seed script manually
docker-compose exec app node seed.js
```

## Project Structure

```
Project Reva -v4.2/
├── docker-compose.yml      # Docker Compose configuration
├── Dockerfile              # Application container definition
├── .dockerignore           # Files to exclude from Docker build
├── .env.example            # Environment variables template
├── .env                    # Your actual environment variables (create this)
├── init-db.sql             # Database initialization script
├── index.js                # Main application file
├── backend.js              # Backend routes
├── seed.js                 # Database seeding script
├── package.json            # Node.js dependencies
├── Public/                 # Static files (uploads, etc.)
└── views/                  # EJS templates (frontend)
```

## Services Overview

### 1. Database Service (`db`)
- **Image**: PostgreSQL 15 Alpine
- **Port**: 5432 (mapped to host)
- **Volume**: `postgres_data` (persistent storage)
- **Health Check**: Automatically checks if database is ready

### 2. Application Service (`app`)
- **Image**: Built from Dockerfile
- **Port**: 4000 (mapped to host)
- **Dependencies**: Waits for database to be healthy
- **Volumes**: 
  - `Public/uploads` - For file uploads
  - `temp_downloads` - For temporary downloads

## Environment Variables

Key environment variables (see `.env.example` for full list):

| Variable | Description | Default |
|----------|-------------|---------|
| `DB_USER` | PostgreSQL username | `reva_user` |
| `DB_PASSWORD` | PostgreSQL password | `reva_password` |
| `DB_NAME` | Database name | `reva_db` |
| `PORT` | Application port | `4000` |
| `SESSION_SECRET` | Session encryption key | (change in production) |

## Troubleshooting

### Database Connection Issues

If the app can't connect to the database:

1. Check if database container is running:
   ```bash
   docker-compose ps
   ```

2. Check database logs:
   ```bash
   docker-compose logs db
   ```

3. Verify environment variables in `.env` file

### Application Won't Start

1. Check application logs:
   ```bash
   docker-compose logs app
   ```

2. Verify all dependencies are installed:
   ```bash
   docker-compose exec app npm list
   ```

3. Rebuild the container:
   ```bash
   docker-compose up -d --build
   ```

### Port Already in Use

If port 4000 or 5432 is already in use:

1. Change the port in `.env`:
   ```
   APP_PORT=4001
   DB_PORT=5433
   ```

2. Update `docker-compose.yml` if needed

### Reset Everything

To start fresh (⚠️ deletes all data):

```bash
docker-compose down -v
docker-compose up -d --build
```

## Production Deployment

For production deployment:

1. **Change all default passwords** in `.env`
2. **Use strong SESSION_SECRET** (generate with: `openssl rand -base64 32`)
3. **Set NODE_ENV=production**
4. **Configure proper SMTP settings** for email
5. **Use Docker secrets** or environment variable management
6. **Set up reverse proxy** (nginx/traefik) for HTTPS
7. **Configure database backups**
8. **Set resource limits** in docker-compose.yml

## Additional Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [PostgreSQL Docker Image](https://hub.docker.com/_/postgres)

## Support

For issues or questions, check the application logs:
```bash
docker-compose logs -f
```

