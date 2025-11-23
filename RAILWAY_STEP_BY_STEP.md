# 🚂 Railway Deployment - Step by Step Guide

## Step 1: Create New Project

You're currently on the "New Project" screen. Here's what to do:

1. **Click on "GitHub Repository"** (the first option with the GitHub logo)
   - This will allow Railway to connect to your GitHub account and deploy directly from your repository

2. If prompted, **authorize Railway** to access your GitHub repositories
   - Click "Authorize Railway" or "Install Railway App" on GitHub
   - Select the repositories you want to give Railway access to (or select "All repositories")

3. **Select your repository** from the list
   - Look for "Project Reva -v4.2" or whatever you named your repository
   - Click on it

4. Railway will automatically detect your Dockerfile and start setting up the project

---

## Step 2: Add PostgreSQL Database

After your project is created, you need to add a database:

1. In your project dashboard, click the **"+ New"** button (usually at the top or bottom)
2. Select **"Database"** from the dropdown menu
3. Choose **"Add PostgreSQL"**
4. Railway will automatically create a PostgreSQL database for you
5. Wait a few seconds for it to initialize (you'll see a green checkmark when ready)

**Important**: Note the database service name (it will be something like "Postgres" or "PostgreSQL")

---

## Step 3: Configure Your Web Service

1. You should see your web service (it might be called "web" or your repository name)
2. **Click on the web service** to open its settings

---

## Step 4: Set Environment Variables

1. In your web service, click on the **"Variables"** tab
2. Click **"+ New Variable"** to add each of these:

### Database Connection Variables

Add these variables. Railway provides them automatically, so you can use the reference syntax:

```
PGHOST=${{Postgres.PGHOST}}
PGPORT=${{Postgres.PGPORT}}
PGDATABASE=${{Postgres.PGDATABASE}}
PGUSER=${{Postgres.PGUSER}}
PGPASSWORD=${{Postgres.PGPASSWORD}}
```

**How to get these values:**
- Click on your **PostgreSQL service** in the project
- Go to the **"Variables"** tab
- You'll see variables like `PGHOST`, `PGPORT`, etc.
- Copy the values or use the `${{Postgres.XXX}}` syntax

### Application Variables

Add these additional variables:

```
PORT=4000
NODE_ENV=production
SESSION_SECRET=your-secure-random-string-here
CONTACT_EMAIL=reva.zone@revartix.com
```

**To generate SESSION_SECRET:**
- Windows PowerShell: `[Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Maximum 256 }))`
- Or use an online generator: https://randomkeygen.com/

---

## Step 5: Configure Start Command

1. In your web service, go to the **"Settings"** tab
2. Scroll down to **"Deploy"** section
3. Find **"Start Command"** field
4. Enter this command:
   ```
   node seed.js && node index.js
   ```
5. Click **"Save"** or the command will auto-save

This ensures the database is seeded before the app starts.

---

## Step 6: Deploy

1. Railway will automatically start deploying when you:
   - First connect the repository
   - Push new code to GitHub
   - Or you can manually trigger it

2. **To manually deploy:**
   - Go to the **"Deployments"** tab
   - Click **"Redeploy"** if needed

3. **Watch the build logs:**
   - Click on the deployment
   - You'll see the build progress in real-time
   - Wait for "Deploy successful" message (usually 2-5 minutes)

---

## Step 7: Get Your Public URL

1. In your web service, go to **"Settings"** tab
2. Scroll to **"Networking"** section
3. Click **"Generate Domain"** button
4. Railway will create a free domain like: `your-app-name.railway.app`
5. **Copy this URL** - this is your public URL!

---

## Step 8: Test Your Deployment

1. Open the URL in your browser (e.g., `https://your-app-name.railway.app`)
2. You should see the login page
3. Try logging in with:
   - **Staff**: `master_user` / `master123`
   - **Operator**: `operator_user` / `operator123`
   - **Super Admin**: `admin_demo` / `Demo@123`
   - **Customer**: `customer_demo` / `Demo@123`

---

## ✅ Verification Checklist

- [ ] Project created
- [ ] GitHub repository connected
- [ ] PostgreSQL database added
- [ ] Environment variables set (all 8 variables)
- [ ] Start command configured (`node seed.js && node index.js`)
- [ ] Deployment successful (green checkmark)
- [ ] Public URL generated
- [ ] Can access login page
- [ ] Can log in with default credentials

---

## 🆘 Troubleshooting

### Build Fails

1. Check the **Deployments** tab for error messages
2. Common issues:
   - Missing environment variables
   - Dockerfile errors
   - Port binding issues

### Database Connection Errors

1. Verify all database environment variables are set
2. Make sure you're using the correct syntax: `${{Postgres.PGHOST}}`
3. Check that PostgreSQL service is running (green status)

### App Won't Start

1. Check **Logs** tab in your web service
2. Look for error messages
3. Verify start command is correct: `node seed.js && node index.js`

### Can't Access URL

1. Make sure deployment is complete (green checkmark)
2. Check that domain is generated
3. Wait a minute for DNS propagation
4. Try the URL in an incognito/private window

---

## 📝 Quick Reference

**Your Railway Project Structure:**
```
Your Project
├── PostgreSQL (Database Service)
└── Web Service (Your App)
    ├── Variables (Environment Variables)
    ├── Settings (Start Command)
    └── Deployments (Build History)
```

**Important URLs:**
- Railway Dashboard: https://railway.app
- Your App: `https://your-app-name.railway.app`

---

## 🎉 Success!

Once you can access your app and log in, your deployment is complete! Share the URL with anyone you want to give access to.

---

**Need help?** Check the logs in Railway dashboard or refer to the main `DEPLOYMENT_GUIDE.md` for more details.

