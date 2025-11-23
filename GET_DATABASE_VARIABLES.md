# 🔍 Get Database Variables from Postgres Service

## What You're Seeing

The "8 variables added by Railway" are **Railway system variables** (like `RAILWAY_PUBLIC_DOMAIN`, etc.). These are NOT the database connection variables we need.

## ✅ What We Need

We need database connection variables from your **Postgres service**:
- `PGPORT`
- `PGDATABASE`
- `PGUSER`
- `PGPASSWORD`

## 🎯 How to Get Database Variables

### Method 1: Use Railway Reference (Easiest)

1. Stay in your **web service** Variables tab
2. Click **"+ New Variable"**
3. Add these 4 variables one by one:

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

**Important**: Replace `Postgres` with your actual Postgres service name if it's different. Check your Architecture view to see the exact name.

---

### Method 2: Get Actual Values from Postgres Service

1. Go back to **Architecture** view (click "Architecture" in top nav)
2. Click on your **Postgres** service (the database card)
3. Go to **"Variables"** tab in the Postgres service
4. You'll see variables like:
   - `PGHOST`
   - `PGPORT`
   - `PGDATABASE`
   - `PGUSER`
   - `PGPASSWORD`
5. Click the **eye icon** 👁️ next to each to reveal values
6. Copy each value
7. Go back to your **web service** Variables tab
8. Add each as a new variable with the actual values

---

## 📋 Complete Variable List You Need

After adding, you should have **9 total variables** in your web service:

### Database (5):
- ✅ `PGHOST` (you already have)
- ⚠️ `PGPORT` (add this)
- ⚠️ `PGDATABASE` (add this)
- ⚠️ `PGUSER` (add this)
- ⚠️ `PGPASSWORD` (add this)

### App (4):
- ✅ `PORT=4000` (you have)
- ✅ `NODE_ENV=production` (you have)
- ✅ `SESSION_SECRET` (you have)
- ✅ `CONTACT_EMAIL` (you have)

---

## 🚀 Quick Steps

1. **Click "+ New Variable"** in your web service
2. **Add `PGPORT`** with value `${{Postgres.PGPORT}}`
3. **Add `PGDATABASE`** with value `${{Postgres.PGDATABASE}}`
4. **Add `PGUSER`** with value `${{Postgres.PGUSER}}`
5. **Add `PGPASSWORD`** with value `${{Postgres.PGPASSWORD}}`

**Note**: If `${{Postgres.XXX}}` doesn't work, use Method 2 to get actual values.

---

## ✅ After Adding Variables

1. Verify all 9 variables are set
2. Go to **"Settings"** tab
3. Set **"Start Command"**: `node seed.js && node index.js`
4. Railway will auto-redeploy
5. Check **"Deployments"** tab for progress

---

**Try Method 1 first (using `${{Postgres.XXX}}` syntax). If that doesn't work, use Method 2 to get actual values from the Postgres service!**

