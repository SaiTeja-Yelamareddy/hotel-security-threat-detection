-- Hotel Security Threat Detection
-- Seed data for local/demo InsForge database usage
-- Import after schema.sql: insforge db import database/seed.sql

INSERT INTO public.portal_users (
  full_name,
  username,
  password_hash,
  role,
  created_by_username,
  is_active
)
VALUES
  (
    'Chief Admin',
    'admin',
    '7676aaafb027c825bd9abab78b234070e702752f625b752e55e55b48e607e358',
    'admin',
    'system',
    TRUE
  ),
  (
    'Security Member 1',
    'sec01',
    'cb2685eb67bb2cf2eeff83e3f1e2133bc96631758bc5282be531657b5833e131',
    'security',
    'admin',
    TRUE
  ),
  (
    'Security Member 2',
    'sec02',
    'cb2685eb67bb2cf2eeff83e3f1e2133bc96631758bc5282be531657b5833e131',
    'security',
    'admin',
    TRUE
  )
ON CONFLICT (username) DO UPDATE SET
  full_name = EXCLUDED.full_name,
  password_hash = EXCLUDED.password_hash,
  role = EXCLUDED.role,
  created_by_username = EXCLUDED.created_by_username,
  is_active = EXCLUDED.is_active;

INSERT INTO public.threat_intelligence_records (
  category,
  incident_type,
  severity,
  location,
  zone,
  confidence,
  status,
  detail,
  detected_at
)
VALUES
  (
    'Unauthorized Staff Login',
    'Unauthorized Access Attempt',
    'high',
    'Staff Corridor',
    'lobby',
    96.40,
    'detected',
    'Badge spoofing attempt flagged during after-hours access.',
    NOW() - INTERVAL '45 minutes'
  ),
  (
    'Loitering Near Gate',
    'Loitering Detected',
    'medium',
    'Main Gate',
    'gate',
    92.15,
    'reviewing',
    'Subject remained near perimeter gate for more than three minutes.',
    NOW() - INTERVAL '38 minutes'
  ),
  (
    'Aggressive Guest Behavior',
    'Aggressive Motion Pattern',
    'high',
    'Lobby',
    'lobby',
    88.20,
    'detected',
    'Posture analysis flagged escalation risk near front desk.',
    NOW() - INTERVAL '27 minutes'
  ),
  (
    'Suspicious Bag Detection',
    'Unattended Bag',
    'medium',
    'Lobby',
    'lobby',
    90.00,
    'resolved',
    'Bag was isolated and later claimed by verified guest.',
    NOW() - INTERVAL '20 minutes'
  ),
  (
    'Fire Incident Threat',
    'Smoke and Thermal Spike',
    'high',
    'Kitchen',
    'lobby',
    97.35,
    'detected',
    'Thermal camera and smoke pattern crossed alert threshold.',
    NOW() - INTERVAL '12 minutes'
  ),
  (
    'Parking Misuse',
    'Unauthorized Vehicle Presence',
    'low',
    'Parking Lot A',
    'parking',
    81.10,
    'reviewing',
    'Vehicle remained in guest-reserved zone without check-in match.',
    NOW() - INTERVAL '6 minutes'
  );
