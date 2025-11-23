# Free Tier Deployment Guide - Project Reva

This guide will help you deploy your Project Reva application to free hosting platforms so it's accessible to anyone on the internet.

## 🎯 Best Free Options

### Option 1: Railway (Recommended) ⭐
- **Free Tier**: $5 credit/month (enough for small apps)
- **Pros**: Easiest setup, supports Docker Compose, automatic HTTPS
- **Cons**: Limited free tier, requires credit card (no charge unless you exceed)
- **URL Format**: `your-app-name.railway.app`

### Option 2: Render
- **Free Tier**: Free forever (with limitations)
- **Pros**: Truly free, no credit card needed, automatic HTTPS
- **Cons**: Spins down after 15 min inactivity (takes ~30s to wake up)
- **URL Format**: `your-app-name.onrender.com`

### Option 3: Fly.io
- **Free Tier**: Generous free tier
- **Pros**: Good performance, global deployment
- **Cons**: More complex setup, PostgreSQL requires separate service

---

## 🚀 Option 1: Deploy to Railway (Easiest)

### Step 1: Create Railway Account

1. Go to [railway.app](https://railway.app)
2. Sign up with GitHub (recommended) or email
3. Add payment method (won't be charged on free tier)

### Step 2: Create New Project

1. Click **"New Project"**
2. Select **"Deploy from GitHub repo"** (if you have GitHub) OR **"Empty Project"**

### Step 3: Add PostgreSQL Database

1. In your project, click **"+ New"**
2. Select **"Database"** → **"Add PostgreSQL"**
3. Railway will automatically create a PostgreSQL database
4. Note the connection details (you'll need them)

### Step 4: Add Web Service

1. Click **"+ New"** again
2. Select **"GitHub Repo"** (if using GitHub) OR **"Empty Service"**
3. If using GitHub:
   - Connect your repository
   - Railway will auto-detect the Dockerfile
4. If using Empty Service:
   - Click on the service
   - Go to **Settings** → **Source**
   - Connect your GitHub repo or upload files

### Step 5: Configure Environment Variables

1. Click on your **web service**
2. Go to **Variables** tab
3. Add these environment variables:

```bash
# Database (Railway provides these automatically, but verify)
PGHOST=${{Postgres.PGHOST}}
PGPORT=${{Postgres.PGPORT}}
PGDATABASE=${{Postgres.PGDATABASE}}
PGUSER=${{Postgres.PGUSER}}
PGPASSWORD=${{Postgres.PGPASSWORD}}

# Application
PORT=4000
NODE_ENV=production
SESSION_SECRET=your-secure-random-string-here

# Optional
CONTACT_EMAIL=reva.zone@revartix.com
```

**To get database variables:**
- Click on your PostgreSQL service
- Go to **Variables** tab
- Copy the connection variables (they start with `${{Postgres.}}`)

### Step 6: Configure Start Command

1. In your web service, go to **Settings**
2. Under **Deploy**, set **Start Command**:
   ```
   node seed.js && node index.js
   ```

### Step 7: Deploy

1. Railway will automatically deploy when you push to GitHub
2. Or click **"Deploy"** if you uploaded files manually
3. Wait for deployment to complete (2-5 minutes)

### Step 8: Get Your Public URL

1. Click on your web service
2. Go to **Settings** → **Networking**
3. Click **"Generate Domain"** to get a free `.railway.app` domain
4. Your app is now live! 🎉

---

## 🌐 Option 2: Deploy to Render (Truly Free)

### Step 1: Create Render Account

1. Go to [render.com](https://render.com)
2. Sign up with GitHub (recommended) or email
3. **No credit card required!**

### Step 2: Create PostgreSQL Database

1. Click **"New +"** → **"PostgreSQL"**
2. Configure:
   - **Name**: `reva-db`
   - **Database**: `reva_db`
   - **User**: `reva_user`
   - **Plan**: **Free**
3. Click **"Create Database"**
4. Wait for database to be created (1-2 minutes)
5. Note the **Internal Database URL** (you'll need it)

### Step 3: Create Web Service

1. Click **"New +"** → **"Web Service"**
2. Connect your GitHub repository
3. Configure:
   - **Name**: `reva-app`
   - **Region**: Choose closest to you
   - **Branch**: `main` (or your default branch)
   - **Root Directory**: Leave empty (or `.` if needed)
   - **Runtime**: **Docker**
   - **Dockerfile Path**: `Dockerfile`
   - **Docker Context**: `.`
   - **Plan**: **Free**

### Step 4: Configure Environment Variables

In the **Environment** section, add:

```bash
NODE_ENV=production
PORT=4000
SESSION_SECRET=your-secure-random-string-here
CONTACT_EMAIL=reva.zone@revartix.com

# Database (Render will auto-populate these from your PostgreSQL service)
PGHOST=your-db-host-from-render
PGPORT=5432
PGDATABASE=reva_db
PGUSER=reva_user
PGPASSWORD=your-db-password-from-render
```

**To get database credentials:**
- Go to your PostgreSQL service
- Copy the **Internal Database URL** or individual connection details

### Step 5: Configure Start Command

In **Advanced** settings, add:

```bash
node seed.js && node index.js
```

### Step 6: Deploy

1. Click **"Create Web Service"**
2. Render will start building (5-10 minutes first time)
3. Watch the build logs for progress

### Step 7: Get Your Public URL

1. Once deployed, Render provides a free `.onrender.com` URL
2. Your app is live! 🎉
3. **Note**: Free tier spins down after 15 min inactivity (takes ~30s to wake up)

---

## 🔧 Option 3: Deploy to Fly.io

### Step 1: Install Fly CLI

```bash
# Windows (PowerShell)
iwr https://fly.io/install.ps1 -useb | iex

# Mac/Linux
curl -L https://fly.io/install.sh | sh
```

### Step 2: Create Fly.io Account

```bash
fly auth signup
```

### Step 3: Create Fly.io App

```bash
fly launch
```

Follow the prompts to create your app.

### Step 4: Add PostgreSQL

```bash
fly postgres create --name reva-db
fly postgres attach reva-db
```

### Step 5: Deploy

```bash
fly deploy
```

### Step 6: Get Your URL

```bash
fly open
```

---

## 📝 Important Notes for All Platforms

### 1. Update Session Cookie Settings

For production, update session cookie settings in `index.js`:

```javascript
app.use(session({
  secret: process.env.SESSION_SECRET || 'a-secure-secret-key-for-revartix',
  resave: false,
  saveUninitialized: true,
  cookie: { 
    secure: process.env.NODE_ENV === 'production', // HTTPS only in production
    httpOnly: true,
    maxAge: 24 * 60 * 60 * 1000 // 24 hours
  }
}));
```

### 2. Generate Secure Session Secret

Generate a secure random string:

```bash
# Linux/Mac
openssl rand -base64 32

# Windows (PowerShell)
[Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Maximum 256 }))
```

### 3. Database Seeding

The seed script runs automatically on first deploy. If you need to re-seed:

**Railway:**
```bash
railway run node seed.js
```

**Render:**
- Use the Shell feature in Render dashboard
- Or add a one-time script

**Fly.io:**
```bash
fly ssh console
node seed.js
```

### 4. File Uploads

For persistent file storage, consider:
- **Railway**: Use volumes (paid feature) or external storage (S3, etc.)
- **Render**: Use external storage (S3, Cloudinary, etc.)
- **Fly.io**: Use volumes

---

## 🔍 Troubleshooting

### Application Won't Start

1. **Check logs**:
   - Railway: View logs in dashboard
   - Render: View logs in dashboard
   - Fly.io: `fly logs`

2. **Common issues**:
   - Database connection: Verify environment variables
   - Port binding: Ensure app listens on `process.env.PORT || 4000`
   - Missing dependencies: Check Dockerfile includes all packages

### Database Connection Errors

1. Verify all database environment variables are set
2. Check database service is running
3. Ensure database host is correct (use internal hostname, not localhost)

### Build Failures

1. Check Dockerfile syntax
2. Verify all files are in repository
3. Check build logs for specific errors

### Slow First Load (Render Free Tier)

- Render free tier spins down after 15 min inactivity
- First request after spin-down takes ~30 seconds
- This is normal for free tier

---

## 🎉 After Deployment

### Test Your Deployment

1. Visit your public URL
2. Try logging in with default credentials:
   - Staff: `master_user` / `master123`
   - Operator: `operator_user` / `operator123`
   - Super Admin: `admin_demo` / `Demo@123`
   - Customer: `customer_demo` / `Demo@123`

### Share Your App

Your app is now accessible to anyone with the URL! Share it with:
- Clients
- Team members
- Stakeholders

### Monitor Your App

- **Railway**: Dashboard shows metrics and logs
- **Render**: Dashboard shows metrics and logs
- **Fly.io**: `fly status` and `fly logs`

---

## 🔐 Security Recommendations

1. **Change default passwords** after first login
2. **Use strong SESSION_SECRET** (generate with openssl)
3. **Enable HTTPS** (automatic on all platforms)
4. **Set up environment variables** properly
5. **Regular backups** (consider upgrading for production)

---

## 📚 Additional Resources

- [Railway Documentation](https://docs.railway.app/)
- [Render Documentation](https://render.com/docs)
- [Fly.io Documentation](https://fly.io/docs/)

---

## 💡 Quick Comparison

| Feature | Railway | Render | Fly.io |
|---------|---------|--------|--------|
| Free Tier | $5/month credit | Free forever | Generous free tier |
| Credit Card | Required | Not required | Not required |
| Spin Down | No | Yes (15 min) | No |
| Setup Difficulty | Easy | Easy | Medium |
| Docker Support | ✅ | ✅ | ✅ |
| PostgreSQL | ✅ | ✅ | ✅ (separate) |
| Auto HTTPS | ✅ | ✅ | ✅ |

**Recommendation**: Start with **Railway** for easiest setup, or **Render** if you want truly free (no credit card).

