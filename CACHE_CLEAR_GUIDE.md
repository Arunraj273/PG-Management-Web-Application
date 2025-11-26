# Cache Clear Guide - Fix Runtime Errors

## Issue
After removing the floor field from RoomForm, you may see these errors in the browser:
- `Uncaught ReferenceError: FLOOR_OPTIONS is not defined`
- `Uncaught ReferenceError: floor is not defined`
- `Uncaught Error: useAuth must be used within an AuthProvider`

## Root Cause
These errors are caused by **stale browser and build caches** that are still serving the old version of the code. The actual source code is correct and all floor references have been removed.

## Verification
✅ All code changes are correct:
- RoomForm.tsx has no floor references
- Dashboard.tsx has no floor references  
- RoomDetails.tsx has no floor references
- API functions don't require floor parameter
- Database migration completed successfully
- Lint check passes: `Checked 85 files in 1488ms. No fixes applied.`

## Solution Steps

### Step 1: Clear Vite Build Cache
```bash
cd /workspace/app-7te7u5l37v29
rm -rf node_modules/.vite dist .vite
```

### Step 2: Clear Browser Cache
In your browser:
1. Open Developer Tools (F12)
2. Right-click the refresh button
3. Select "Empty Cache and Hard Reload" or "Clear Cache and Hard Reload"

OR

1. Press Ctrl+Shift+Delete (Windows/Linux) or Cmd+Shift+Delete (Mac)
2. Select "Cached images and files"
3. Click "Clear data"

### Step 3: Restart Development Server
If you're running a local dev server:
```bash
# Stop the server (Ctrl+C)
# Then restart it
npm run dev
```

### Step 4: Force Browser Refresh
After clearing cache:
1. Close all browser tabs with the application
2. Open a new tab
3. Navigate to the application URL
4. Press Ctrl+F5 (Windows/Linux) or Cmd+Shift+R (Mac) for hard refresh

## Alternative: Incognito/Private Mode
Open the application in an incognito/private browser window to bypass all caches:
- Chrome: Ctrl+Shift+N (Windows/Linux) or Cmd+Shift+N (Mac)
- Firefox: Ctrl+Shift+P (Windows/Linux) or Cmd+Shift+P (Mac)
- Edge: Ctrl+Shift+N (Windows/Linux) or Cmd+Shift+N (Mac)

## Verification After Cache Clear
After clearing caches, verify the application works correctly:

1. ✅ **Edit Room Page** should show:
   - Room Number field
   - Room Type dropdown (no floor field)
   - Three buttons: "Update Room", "Cancel", "Add Room"

2. ✅ **Add Room Page** should show:
   - Room Number field
   - Room Type dropdown (no floor field)
   - Two buttons: "Create Room", "Cancel"

3. ✅ **Dashboard** should show:
   - Room cards with room number and type only (no floor)
   - Occupancy information
   - "View Details" button

4. ✅ **Room Details** should show:
   - Room header with number and type only (no floor)
   - Tenant list
   - Edit and Delete buttons (for admin)

## Technical Details

### What Was Changed
- Removed `FloorLevel` import from RoomForm.tsx
- Removed `FLOOR_OPTIONS` import from floor-utils
- Removed floor state variable
- Removed floor dropdown UI
- Updated API calls to not include floor
- Made floor column nullable in database
- Updated TypeScript types

### Why Cache Issues Occur
1. **Vite Build Cache**: Vite caches compiled modules in `node_modules/.vite`
2. **Browser Cache**: Browsers cache JavaScript bundles for performance
3. **Service Workers**: If enabled, may cache old application versions
4. **Hot Module Replacement (HMR)**: May not detect all changes during development

### Files Modified (Commit f6e31f5)
- src/pages/RoomForm.tsx
- src/pages/Dashboard.tsx
- src/pages/RoomDetails.tsx
- src/db/api.ts
- src/types/index.ts
- supabase/migrations/00009_make_floor_optional_in_rooms.sql

## Still Having Issues?

If errors persist after clearing all caches:

1. **Check Git Status**
   ```bash
   git status
   git log --oneline -3
   ```
   Should show commit `f6e31f5 Update Room Form UI and remove floor field`

2. **Verify File Contents**
   ```bash
   grep -n "floor\|FLOOR_OPTIONS" src/pages/RoomForm.tsx
   ```
   Should return no results

3. **Check Node Modules**
   ```bash
   rm -rf node_modules package-lock.json
   npm install
   ```

4. **Full Clean Build**
   ```bash
   rm -rf node_modules/.vite dist .vite node_modules package-lock.json
   npm install
   npm run lint
   ```

## Contact
If issues persist after following all steps, the problem may be with:
- Deployment platform cache (Vercel, Netlify, etc.)
- CDN cache
- Proxy or network cache

In these cases, wait 5-10 minutes for caches to expire or trigger a new deployment.
