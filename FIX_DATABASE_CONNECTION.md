# 🔧 Fix Database Connection Error

## ❌ The Problem

Your app is trying to connect to `localhost` (`::1:5432`) instead of Railway's Postgres service. This means `PGHOST` is not set correctly.

## ✅ Solution: Get Actual Database Values

### Step 1: Get Database Connection Details from Postgres Service

1. In Railway, go to **Architecture** view
2. Click on your **Postgres** service (the database card)
3. Go to **"Variables"** tab
4. You'll see variables like:
   - `PGHOST`
   - `PGPORT`
   - `PGDATABASE`
   - `PGUSER`
   - `PGPASSWORD`
5. **Click the eye icon** 👁️ next to each to reveal the actual values
6. **Copy each value** - you'll need them!

### Step 2: Set Variables in Web Service

1. Go back to your **web service** (reva-app)
2. Go to **"Variables"** tab
3. Check if these variables exist:
   - `PGHOST` - **This is the most important one!**
   - `PGPORT`
   - `PGDATABASE`
   - `PGUSER`
   - `PGPASSWORD`

### Step 3: Update or Add PGHOST

**If PGHOST exists but is wrong:**
1. Click the **three dots** `⋮` next to `PGHOST`
2. Select **"Edit"**
3. Paste the actual value from Postgres service (should be something like `postgres.railway.internal` or an IP)
4. Click **"Save"**

**If PGHOST doesn't exist:**
1. Click **"+ New Variable"**
2. Key: `PGHOST`
3. Value: Paste the actual value from Postgres service
4. Click **"Save"**

### Step 4: Verify All Database Variables

Make sure you have all 5 database variables with correct values:

- ✅ `PGHOST` = (actual hostname from Postgres, NOT localhost)
- ✅ `PGPORT` = (usually 5432)
- ✅ `PGDATABASE` = (database name)
- ✅ `PGUSER` = (username)
- ✅ `PGPASSWORD` = (password)

### Step 5: Redeploy

1. After updating variables, Railway will auto-redeploy
2. Or go to **"Deployments"** tab → Click **"Redeploy"**
3. Watch the logs - you should see successful database connection

---

## 🎯 Quick Fix Steps

1. **Postgres service** → Variables tab → Copy `PGHOST` value
2. **Web service** → Variables tab → Update `PGHOST` with actual value
3. **Verify** all 5 database variables are set
4. **Redeploy** and check logs

---

## 🔍 What PGHOST Should Look Like

The `PGHOST` value should be something like:
- `postgres.railway.internal`
- `containers-us-west-xxx.railway.app`
- An internal IP address
- **NOT** `localhost` or `127.0.0.1` or `::1`

---

## ⚠️ Important Notes

- Railway services communicate via internal networking
- `PGHOST` must be the Railway Postgres service hostname
- The reference syntax `${{Postgres.PGHOST}}` might not work - use actual values
- All 5 database variables must be set correctly

---

**Go to Postgres service → Variables → Copy PGHOST value → Update in web service!** 🚀

