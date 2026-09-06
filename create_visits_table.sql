-- Create visits tracking table
CREATE TABLE IF NOT EXISTS visits (
  id BIGSERIAL PRIMARY KEY,
  visitor_id UUID NOT NULL,
  is_first_visit BOOLEAN DEFAULT false,
  timestamp TIMESTAMPTZ DEFAULT NOW(),

  -- URL tracking parameters
  source TEXT,
  campaign TEXT,
  ad_id TEXT,
  location TEXT,

  -- Browser/device info
  screen_size TEXT,
  language TEXT,
  referrer TEXT,
  page_url TEXT,

  -- Index for common queries
  CONSTRAINT visits_visitor_id_timestamp_key UNIQUE (visitor_id, timestamp)
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_visits_visitor_id ON visits(visitor_id);
CREATE INDEX IF NOT EXISTS idx_visits_timestamp ON visits(timestamp);
CREATE INDEX IF NOT EXISTS idx_visits_source ON visits(source);
CREATE INDEX IF NOT EXISTS idx_visits_location ON visits(location);

-- Enable Row Level Security (RLS) but allow all inserts for now
ALTER TABLE visits ENABLE ROW LEVEL SECURITY;

-- Create policy to allow anonymous inserts
CREATE POLICY "Allow anonymous inserts" ON visits
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Create policy to allow reading all visits
CREATE POLICY "Allow reading all visits" ON visits
  FOR SELECT
  TO anon
  USING (true);
