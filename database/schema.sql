-- Hotel Security Threat Detection
-- PostgreSQL / InsForge database schema
-- Import with: insforge db import database/schema.sql

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE IF NOT EXISTS public.portal_users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  full_name TEXT NOT NULL,
  username TEXT NOT NULL UNIQUE CHECK (username = lower(username)),
  password_hash TEXT NOT NULL,
  role TEXT NOT NULL CHECK (role IN ('admin', 'security')),
  created_by_username TEXT,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_portal_users_role
  ON public.portal_users (role);

CREATE INDEX IF NOT EXISTS idx_portal_users_active
  ON public.portal_users (is_active);

CREATE TABLE IF NOT EXISTS public.portal_password_reset_requests (
  id BIGSERIAL PRIMARY KEY,
  username TEXT NOT NULL,
  request_note TEXT,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'resolved', 'rejected')),
  requested_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  resolved_by_username TEXT,
  resolved_at TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_reset_requests_status_requested_at
  ON public.portal_password_reset_requests (status, requested_at DESC);

CREATE TABLE IF NOT EXISTS public.threat_intelligence_records (
  id BIGSERIAL PRIMARY KEY,
  category TEXT NOT NULL,
  incident_type TEXT NOT NULL,
  severity TEXT NOT NULL CHECK (severity IN ('high', 'medium', 'low')),
  location TEXT NOT NULL,
  zone TEXT,
  confidence NUMERIC(5,2) NOT NULL CHECK (confidence >= 0 AND confidence <= 100),
  status TEXT NOT NULL DEFAULT 'detected',
  detail TEXT,
  detected_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_threat_records_category_detected_at
  ON public.threat_intelligence_records (category, detected_at DESC);

CREATE INDEX IF NOT EXISTS idx_threat_records_status_detected_at
  ON public.threat_intelligence_records (status, detected_at DESC);
