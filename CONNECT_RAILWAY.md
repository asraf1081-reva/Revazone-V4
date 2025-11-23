# 🔗 Connect Your GitHub Repo to Railway

## Your Repository
- **Repository**: `Revazone-V4`
- **Owner**: `asraf1081-reva`
- **Full URL**: `https://github.com/asraf1081-reva/Revazone-V4`

---

## Step-by-Step: Connect to Railway

### Step 1: In Railway Dashboard

1. You're on the "New Project" screen
2. Click **"GitHub Repository"** (the first option with GitHub logo)

### Step 2: Authorize Railway (First Time Only)

1. Railway will ask you to **authorize** access to GitHub
2. Click **"Authorize Railway"** or **"Install Railway App"**
3. You'll be redirected to GitHub
4. On GitHub, you can choose:
   - **"Only select repositories"** → Choose `Revazone-V4`
   - OR **"All repositories"** (if you're comfortable)
5. Click **"Install"** or **"Authorize"**

### Step 3: Select Your Repository

1. After authorization, Railway will show a list of your repositories
2. Look for: **`asraf1081-reva/Revazone-V4`**
3. **Click on it** to select it

### Step 4: Railway Auto-Setup

Railway will automatically:
- ✅ Detect your `Dockerfile`
- ✅ Create a web service
- ✅ Start the deployment process
- ✅ Set up the project

---

## Alternative: If Repository Not Showing

If your repository doesn't appear in the list:

### Option A: Check Repository Visibility
1. Go to your GitHub repo: https://github.com/asraf1081-reva/Revazone-V4
2. Make sure it's **Public** (or you've given Railway access to private repos)
3. Settings → General → Scroll to "Danger Zone" → Change visibility if needed

### Option B: Manual Connection
1. In Railway, click **"Empty Project"** instead
2. Click **"+ New"** → **"GitHub Repo"**
3. Search for `Revazone-V4` or `asraf1081-reva`
4. Select your repository

---

## Verify Your Repository Has Required Files

Before connecting, make sure your GitHub repo has these files:
- ✅ `Dockerfile` (for Railway to build)
- ✅ `package.json` (Node.js dependencies)
- ✅ `index.js` (main application file)
- ✅ `seed.js` (database seeding)
- ✅ `backend.js` (backend routes)
- ✅ `docker-compose.yml` (optional, for local use)
- ✅ `views/` folder (EJS templates)
- ✅ `Public/` folder (static files)

**Check your repo**: https://github.com/asraf1081-reva/Revazone-V4

---

## After Connection

Once Railway connects to your repo:

1. **Railway will start building** automatically
2. You'll see build logs in real-time
3. **Wait for the build to complete** (2-5 minutes)
4. Then proceed with:
   - Adding PostgreSQL database
   - Setting environment variables
   - Configuring start command

---

## Quick Checklist

- [ ] Clicked "GitHub Repository" in Railway
- [ ] Authorized Railway on GitHub
- [ ] Selected `asraf1081-reva/Revazone-V4` repository
- [ ] Railway detected Dockerfile
- [ ] Build started automatically

---

## 🆘 Troubleshooting

### "Repository not found"
- Make sure you've authorized Railway to access your GitHub account
- Check that the repository exists: https://github.com/asraf1081-reva/Revazone-V4
- Verify you have access to the repository

### "No Dockerfile detected"
- Make sure `Dockerfile` is in the root of your repository
- Check the file is committed and pushed to GitHub
- File should be named exactly `Dockerfile` (no extension)

### "Build failed"
- Check the build logs in Railway
- Make sure all required files are in the repository
- Verify `package.json` has all dependencies

---

## Next Steps After Connection

Once connected and building:

1. **Add PostgreSQL Database**
   - Click "+ New" → "Database" → "Add PostgreSQL"

2. **Set Environment Variables**
   - Go to web service → "Variables" tab
   - Add database and app variables

3. **Configure Start Command**
   - Settings → Deploy → Start Command: `node seed.js && node index.js`

4. **Get Public URL**
   - Settings → Networking → Generate Domain

---

**Ready? Go back to Railway and click "GitHub Repository" now!** 🚀

