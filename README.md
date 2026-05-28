# Vet Clinic - Lab 9

Rails application for managing pets, owners, vets, appointments, and treatments.

This version implements authentication and authorization using Devise and Pundit.

---

# Features

## Authentication

Implemented with Devise.

Features:

- Login
- Logout
- Password recovery
- Protected resources
- Dynamic navigation based on user role

User registration has been disabled.

---

## Authorization

Implemented with Pundit.

Authorization is enforced through:

- Policies
- Policy scopes
- Role-based permissions
- Controller authorization checks

Users can only access resources allowed by their role.

Unauthorized access redirects the user with an error message.

---

# User Roles

The application includes three user roles:

```ruby
enum :role, {
  owner: 0,
  vet: 1,
  admin: 2
}
```

---

# Authorization Matrix

| Resource | Admin | Owner | Vet |
|-----------|--------|--------|--------|
| Owners Index | ✅ | ❌ | ✅ |
| Owner Profile | ✅ | Own Only | ✅ |
| Create Owner | ✅ | ❌ | ❌ |
| Edit Owner | ✅ | Own Only | ❌ |
| Delete Owner | ✅ | ❌ | ❌ |
| Pets Index | ✅ | Own Only | ✅ |
| Pet Details | ✅ | Own Only | ✅ |
| Create Pet | ✅ | ✅ | ❌ |
| Edit Pet | ✅ | Own Only | ❌ |
| Delete Pet | ✅ | ❌ | ❌ |
| Vets Index | ✅ | ✅ | ✅ |
| Vet Details | ✅ | ✅ | ✅ |
| Create Vet | ✅ | ❌ | ❌ |
| Edit Vet | ✅ | Own Profile | ❌ |
| Delete Vet | ✅ | ❌ | ❌ |
| Appointments Index | ✅ | Own Pets Only | Assigned Only |
| Appointment Details | ✅ | Own Pets Only | Assigned Only |
| Create Appointment | ✅ | ✅ | ✅ |
| Edit Appointment | ✅ | ❌ | Assigned Only |
| Delete Appointment | ✅ | ❌ | Assigned Only |
| Treatments | ✅ | Own Pets Only | Assigned Only |

---

# Requirements

- Ruby 3.x
- Rails 8.x
- PostgreSQL
- libvips

---

# Installation

Clone repository:

```bash
git clone <repository_url>
cd vet_clinic
```

Install dependencies:

```bash
bundle install
```

Create database:

```bash
bin/rails db:create
bin/rails db:migrate
```

Load seed data:

```bash
bin/rails db:seed
```

Run server:

```bash
bin/dev
```

Open:

```text
http://localhost:3000
```

---

# Test Users

After running:

```bash
bin/rails db:seed
```

Use the following credentials.

## Admin

```text
Email: admin@vetclinic.com
Password: password123
```

Capabilities:

- Full access to all resources

---

## Vet

```text
Email: vet@vetclinic.com
Password: password123
```

Capabilities:

- View assigned appointments
- Manage assigned treatments
- View owners and pets
- Update own veterinarian profile

---

## Owner

```text
Email: owner@vetclinic.com
Password: password123
```

Capabilities:

- View own owner profile
- View own pets
- Create pets
- View appointments for own pets
- View treatments for own pets

---

# Pundit Policies

The application uses the following policies:

- OwnerPolicy
- PetPolicy
- VetPolicy
- AppointmentPolicy
- TreatmentPolicy

Each policy defines:

- Authorization rules
- Role permissions
- Resource visibility
- Scope restrictions

---

# Active Storage

Used for pet photo uploads.

Features:

- Photo uploads
- Image validation
- Image previews

---

# Action Text

Used for treatment clinical notes.

Features:

- Rich text editing
- Formatted clinical notes
- HTML content rendering

---

# Performance Optimizations

N+1 query problems were addressed using:

```ruby
includes(...)
```

Examples:

- Owners with pets
- Pets with owners
- Appointments with pets and vets
- Treatments with Action Text

---

# Technologies Used

- Ruby on Rails 8
- PostgreSQL
- Bootstrap 5
- Devise
- Pundit
- Active Storage
- Action Text
- Turbo
- Stimulus

---

# Seed Data

The project includes:

- Users
- Owners
- Pets
- Veterinarians
- Appointments
- Treatments
- Pet photos
- Clinical notes

Load sample data:

```bash
bin/rails db:seed
```