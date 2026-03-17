# API notes

This project uses the InsForge REST database API directly from `index.html`.

## Required tables

The frontend expects these database tables to exist:

- `portal_users`
- `portal_password_reset_requests`
- `threat_intelligence_records`

Create them with:

- `database/schema.sql`
- `database/seed.sql`

## Endpoints used by the frontend

Base URL:

- `https://<appkey>.<region>.insforge.app`

Database record endpoints:

- `GET /api/database/records/portal_users`
- `POST /api/database/records/portal_users`
- `PATCH /api/database/records/portal_users`
- `DELETE /api/database/records/portal_users`
- `GET /api/database/records/portal_password_reset_requests`
- `POST /api/database/records/portal_password_reset_requests`
- `PATCH /api/database/records/portal_password_reset_requests`
- `GET /api/database/records/threat_intelligence_records`

## Authentication header

All requests use a bearer token header:

- `Authorization: Bearer <INSFORGE_API_KEY>`

## Important

Do **not** commit the real `.insforge/project.json` file.
It contains the live InsForge admin API key.
Use `insforge.project.example.json` in this repo as a safe template instead.
