# 🚀 Quick Deployment Guide - Get Your App Online in 10 Minutes

## Choose Your Platform

### ⭐ **Railway** (Easiest - Recommended)
- Free $5/month credit
- No spin-down
- Easiest setup
- [railway.app](https://railway.app)

### 🌐 **Render** (Truly Free)
- Free forever
- No credit card needed
- Spins down after 15 min (wakes in ~30s)
- [render.com](https://render.com)

---

## 🎯 Railway Deployment (5 Steps)

### 1. Sign Up
- Go to [railway.app](https://railway.app)
- Sign up with GitHub

### 2. Create Project
- Click **"New Project"**
- Select **"Deploy from GitHub repo"**
- Connect your repository

### 3. Add Database
- Click **"+ New"** → **"Database"** → **"Add PostgreSQL"**

### 4. Add Web Service
- Click **"+ New"** → **"GitHub Repo"**
- Select your repository
- Railway auto-detects Dockerfile

### 5. Set Environment Variables
In your web service → **Variables** tab, add:

```
PGHOST=${{Postgres.PGHOST}}
PGPORT=${{Postgres.PGPORT}}
PGDATABASE=${{Postgres.PGDATABASE}}
PGUSER=${{Postgres.PGUSER}}
PGPASSWORD=${{Postgres.PGPASSWORD}}
PORT=4000
NODE_ENV=production
SESSION_SECRET=generate-a-random-string-here
```

**Set Start Command** (Settings → Deploy):
```
node seed.js && node index.js
```

### 6. Get Your URL
- Settings → Networking → **"Generate Domain"**
- Your app is live! 🎉

---

## 🌐 Render Deployment (5 Steps)

### 1. Sign Up
- Go to [render.com](https://render.com)
- Sign up with GitHub (no credit card needed!)

### 2. Create Database
- Click **"New +"** → **"PostgreSQL"**
- Name: `reva-db`
- Plan: **Free**
- Click **"Create Database"**

### 3. Create Web Service
- Click **"New +"** → **"Web Service"**
- Connect GitHub repo
- Settings:
  - Runtime: **Docker**
  - Dockerfile Path: `Dockerfile`
  - Plan: **Free**

### 4. Set Environment Variables
Add these in the **Environment** section:

```
NODE_ENV=production
PORT=4000
SESSION_SECRET=generate-a-random-string-here
PGHOST=<from-your-database-service>
PGPORT=5432
PGDATABASE=reva_db
PGUSER=reva_user
PGPASSWORD=<from-your-database-service>
```

**Set Start Command** (Advanced):
```
node seed.js && node index.js
```

### 5. Deploy
- Click **"Create Web Service"**
- Wait 5-10 minutes for first build
- Your app is live! 🎉

---

## 🔑 Default Login Credentials

After deployment, you can log in with:

- **Staff**: `master_user` / `master123`
- **Operator**: `operator_user` / `operator123`
- **Super Admin**: `admin_demo` / `Demo@123`
- **Customer**: `customer_demo` / `Demo@123`

---

## ⚡ Quick Tips

1. **Generate Secure SESSION_SECRET**:
   ```bash
   # Linux/Mac
   openssl rand -base64 32
   
   # Windows PowerShell
   [Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Maximum 256 }))
   ```

2. **Get Database Credentials**:
   - Railway: Click PostgreSQL service → Variables tab
   - Render: Click PostgreSQL service → Internal Database URL

3. **View Logs**:
   - Railway: Click service → Logs tab
   - Render: Click service → Logs tab

4. **Redeploy After Changes**:
   - Railway: Auto-deploys on git push
   - Render: Auto-deploys on git push

---

## 🆘 Need Help?

See full guide: [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)

---

## ✅ Checklist

- [ ] Account created
- [ ] Repository connected
- [ ] PostgreSQL database created
- [ ] Web service created
- [ ] Environment variables set
- [ ] Start command configured
- [ ] Deployment successful
- [ ] App accessible via public URL
- [ ] Can log in with default credentials

---

**That's it! Your app is now live and accessible to anyone! 🎉**

