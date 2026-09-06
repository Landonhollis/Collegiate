# Collegiate Tracking Setup Instructions

## What's Been Done

1. ✅ Supabase MCP server installed
2. ✅ Supabase agent skills installed
3. ✅ SQL script created for visits table ([create_visits_table.sql](create_visits_table.sql))
4. ✅ Tracking code added to [index.html](index.html)

## What You Need to Do

### Step 1: Authenticate with Supabase
Run in your terminal:
```bash
claude /mcp
```
- Select the `supabase` server
- Choose "Authenticate" to begin the flow

### Step 2: Get Your Supabase Anon Key
1. Go to https://supabase.com/dashboard/project/qjvpwnlbcnpqxqbhnmsw/settings/api
2. Copy the `anon` `public` key
3. Replace `YOUR_SUPABASE_ANON_KEY` in [index.html](index.html:337) with your actual key

### Step 3: Create the Database Table
Run the SQL in [create_visits_table.sql](create_visits_table.sql) in your Supabase SQL Editor:
1. Go to https://supabase.com/dashboard/project/qjvpwnlbcnpqxqbhnmsw/sql/new
2. Copy the SQL from `create_visits_table.sql`
3. Run it

Or I can do this for you after authentication.

### Step 4: Test the Tracking
1. Open your site: `collegiate.live?source=qr&location=library`
2. Open browser console (F12)
3. Look for "Visit tracked successfully"
4. Check Supabase table for the entry

## How to Use the Tracking

### QR Code URLs
Generate QR codes with these URL formats:

**Library QR Code:**
```
https://collegiate.live?source=qr&location=library&campaign=fall2024
```

**Student Center QR Code:**
```
https://collegiate.live?source=qr&location=student_center&campaign=fall2024
```

### Ad Campaign URLs

**Facebook Ad:**
```
https://collegiate.live?source=facebook&campaign=fall2024&ad_id=fb_001
```

**Google Ad:**
```
https://collegiate.live?source=google&campaign=fall2024&ad_id=g_001
```

## Querying Your Data

### Total visits:
```sql
SELECT COUNT(*) FROM visits;
```

### Unique visitors:
```sql
SELECT COUNT(DISTINCT visitor_id) FROM visits;
```

### First-time vs returning:
```sql
SELECT is_first_visit, COUNT(*)
FROM visits
GROUP BY is_first_visit;
```

### Which QR location got most scans:
```sql
SELECT location, COUNT(*) as scans
FROM visits
WHERE source = 'qr'
GROUP BY location
ORDER BY scans DESC;
```

### Track individual visitor journey:
```sql
SELECT *
FROM visits
WHERE visitor_id = 'abc-123-def'
ORDER BY timestamp;
```

## What Gets Tracked

For every visit, the system logs:
- `visitor_id` - Unique ID stored in browser localStorage
- `is_first_visit` - Boolean (true for first visit)
- `timestamp` - When they visited
- `source` - Where they came from (qr, facebook, google, etc.)
- `campaign` - Campaign identifier
- `ad_id` - Specific ad identifier
- `location` - QR code physical location
- `screen_size` - Device screen resolution
- `language` - Browser language
- `referrer` - Previous page URL
- `page_url` - Full URL they visited

## Privacy Notes

- No personal information is collected
- Visitor IDs are random UUIDs, not tied to identity
- Data clears if user clears browser data
- Consider adding a privacy policy to your site
