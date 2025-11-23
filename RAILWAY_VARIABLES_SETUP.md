# 🔧 Railway Variables Setup - Complete Guide

## ✅ What You Have (5 Variables)

I can see you already have:
- ✅ `CONTACT_EMAIL`
- ✅ `NODE_ENV`
- ✅ `PGHOST`
- ✅ `PORT`
- ✅ `SESSION_SECRET`

## 🔍 What You Need to Check

### Step 1: Check Railway's Auto-Added Variables

1. Click on **"> 8 variables added by Railway"** to expand it
2. Look for these database variables:
   - `PGPORT`
   - `PGDATABASE`
   - `PGUSER`
   - `PGPASSWORD`

**If you see these 4 variables**, you're good! Skip to Step 3.

**If you DON'T see them**, continue to Step 2.

---

### Step 2: Add Missing Database Variables

If Railway didn't auto-add the database variables, you need to add them manually:

1. Click **"+ New Variable"** button
2. Add each of these variables one by one:

#### Option A: Use Railway Reference (Recommended)
This automatically gets values from your Postgres service:

**Variable 1:**
- **Key**: `PGPORT`
- **Value**: `${{Postgres.PGPORT}}`

**Variable 2:**
- **Key**: `PGDATABASE`
- **Value**: `${{Postgres.PGDATABASE}}`

**Variable 3:**
- **Key**: `PGUSER`
- **Value**: `${{Postgres.PGUSER}}`

**Variable 4:**
- **Key**: `PGPASSWORD`
- **Value**: `${{Postgres.PGPASSWORD}}`

#### Option B: Use Actual Values
If the reference syntax doesn't work:

1. Click on your **Postgres** service (in Architecture view)
2. Go to **"Variables"** tab
3. Click the **eye icon** 👁️ next to each variable to reveal values
4. Copy the actual values and paste them in your web service variables

---

### Step 3: Verify All Required Variables

You should have **9 total variables**:

#### Database Variables (5):
- ✅ `PGHOST` (you have this)
- ⚠️ `PGPORT` (check if exists)
- ⚠️ `PGDATABASE` (check if exists)
- ⚠️ `PGUSER` (check if exists)
- ⚠️ `PGPASSWORD` (check if exists)

#### Application Variables (4):
- ✅ `PORT=4000` (you have this)
- ✅ `NODE_ENV=production` (you have this)
- ✅ `SESSION_SECRET` (you have this)
- ✅ `CONTACT_EMAIL` (you have this)

---

### Step 4: Verify Variable Values

Click the **eye icon** 👁️ next to each variable to verify values:

**PGHOST**: Should be something like `postgres.railway.internal` or an IP
**PORT**: Should be `4000`
**NODE_ENV**: Should be `production`
**SESSION_SECRET**: Should be a long random string (if not, generate one)
**CONTACT_EMAIL**: Should be `reva.zone@revartix.com` or your email

---

### Step 5: Generate SESSION_SECRET (If Needed)

If `SESSION_SECRET` is not set or is weak:

1. Open PowerShell on your computer
2. Run this command:
   ```powershell
   [Convert]::ToBase64String((1..32 | ForEach-Object { Get-Random -Maximum 256 }))
   ```
3. Copy the output
4. In Railway, click the **three dots** `⋮` next to `SESSION_SECRET`
5. Select **"Edit"**
6. Paste the generated string
7. Click **"Save"**

---

## 📋 Complete Variable Checklist

Make sure you have ALL of these:

### Required Database Variables:
- [ ] `PGHOST` ✅ (you have)
- [ ] `PGPORT`
- [ ] `PGDATABASE`
- [ ] `PGUSER`
- [ ] `PGPASSWORD`

### Required App Variables:
- [ ] `PORT=4000` ✅ (you have)
- [ ] `NODE_ENV=production` ✅ (you have)
- [ ] `SESSION_SECRET` ✅ (you have - verify it's strong)
- [ ] `CONTACT_EMAIL` ✅ (you have)

---

## 🎯 Quick Action Steps

1. **Expand** "> 8 variables added by Railway"
2. **Check** if `PGPORT`, `PGDATABASE`, `PGUSER`, `PGPASSWORD` are there
3. **If missing**, add them using `${{Postgres.XXX}}` syntax
4. **Verify** `SESSION_SECRET` is a strong random string
5. **Save** all changes

---

## ✅ After Variables Are Set

Once all variables are configured:

1. Go to **"Settings"** tab
2. Set **"Start Command"**: `node seed.js && node index.js`
3. Railway will automatically redeploy
4. Check **"Deployments"** tab for build progress
5. Get your public URL from **"Settings"** → **"Networking"**

---

## 🆘 Troubleshooting

### "Variables added by Railway" not showing database vars
- Make sure your Postgres service is in the same project
- Try using actual values instead of references
- Check Postgres service is running (green status)

### Can't see variable values
- Click the **eye icon** 👁️ to reveal masked values
- Some sensitive values (like passwords) are always masked

### Variables not working
- Make sure there are no spaces in variable names
- Values should not have quotes unless needed
- Use `${{Postgres.XXX}}` syntax exactly as shown

---

**First, expand "> 8 variables added by Railway" and check if the database variables are there!** 👆

