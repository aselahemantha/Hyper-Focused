HyperFocused Home Inspection (MVP)
1. Project Summary

Goal: Build a lightweight, inspector-focused Spectora competitor that is faster, simpler, 
and more affordable. The MVP targets independent inspectors and provides a cross-platform 
mobile app (Flutter), an Inspector web app (Next.js), a Super Admin console (Next.js), 
and a unified backend (NestJS + PostgreSQL). Deliver secure report generation (PDF), 
payments (Stripe), and an affiliate system. Design for modular expansion and SaaS scaling.




1. Architecture Rules (Mandatory)

Use Clean Architecture everywhere:

Presentation Layer → UI / Controllers

Domain Layer → Entities + UseCases

Data Layer → Repositories + Local/Remote Data Sources

Presentation layer must never access data layer directly.

Use cases must contain all business logic.

Repositories must have abstract interfaces in the domain layer; implementations live in the data layer.

All features must be modular and organised into feature folders.

Mobile Rules (Flutter)

Must follow Clean Architecture with this structure:

/presentation → UI, pages, widgets, state management

/domain → entities, repository interfaces, use cases

/data → repository impls, remote data sources, local data sources

/core → common utils, error handling

Use Riverpod or Bloc (be consistent across entire project).

Offline-first approach:

Use SQLite/Drift or Sembast for local caching.

Data must sync with backend via a sync queue.

No API calls allowed directly from UI.

All function flows must go:
UI → ViewModel → UseCase → Repository → Data Source

All images/photos must be compressed before upload.

Write tests for use cases and critical widgets.