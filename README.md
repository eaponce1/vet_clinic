# Vet Clinic - Lab 8

Rails application for managing pets, owners, vets, appointments, and treatments.

This project includes:

- Devise authentication
- User roles with enum
- Active Storage for pet photo uploads
- Action Text for clinical notes
- Bootstrap responsive UI
- N+1 query optimizations

---

# Requirements

- Ruby 3.x
- Rails 8.x
- PostgreSQL
- libvips

---

# Setup Instructions

Clone the repository:

```bash
git clone <repository_url>
cd vet_clinic
````

Install gems:

```bash
bundle install
```

Create database and run migrations:

```bash
bin/rails db:create db:migrate
```

Load seed data:

```bash
bin/rails db:seed
```

Run the server:

```bash
bin/dev
```

Open in browser:

```text
http://localhost:3000
```

---

# Authentication

This project uses Devise for authentication.

Installed with:

```bash
bin/rails generate devise:install
bin/rails generate devise User
```

Features implemented:

* User registration
* Login / Logout
* Edit account
* Password recovery
* Protected routes
* Dynamic navbar

---

# User Roles

Users include an enum role system:

* owner
* vet
* admin

Implemented in:

```ruby
enum :role, {
  owner: 0,
  vet: 1,
  admin: 2
}
```

---

# Test Users

After running:

```bash
bin/rails db:seed
```

You can log in with:

## Admin

```text
Email: admin@vetclinic.com
Password: password123
```

## Vet

```text
Email: vet@vetclinic.com
Password: password123
```

## Owner

```text
Email: owner@vetclinic.com
Password: password123
```

---

# Active Storage

This project uses Active Storage for pet photo uploads.

Installed with:

```bash
bin/rails active_storage:install
```

Features:

* Photo uploads
* Image previews
* Image validation
* Responsive image rendering

---

# Action Text

This project uses Action Text for rich clinical notes in treatments.

Installed with:

```bash
bin/rails action_text:install
```

Features:

* Rich formatted text
* Medical notes
* HTML rendering
* Rich text editor

---

# Image Processing

This project uses the `image_processing` gem and `libvips` for image variants.

Install libvips:

## Ubuntu / WSL

```bash
sudo apt install libvips
```

## Windows

```bash
winget install libvips
```

---

# Performance Optimizations

N+1 query issues were fixed using:

```ruby
includes(...)
```

Examples:

* Owners with pets
* Pets with owners
* Appointments with pets and vets
* Treatments with Action Text preload

---

# Technologies Used

* Ruby on Rails 8
* PostgreSQL
* Bootstrap 5
* Devise
* Active Storage
* Action Text
* Turbo
* Stimulus

---

# Features

## Authentication

* Register users
* Login / Logout
* Edit account
* Password recovery
* Protected resources

## Pets

* Upload pet photos
* Photo previews
* Image validation

## Treatments

* Rich clinical notes
* HTML formatted content

## Appointments

* Upcoming appointments
* Past appointments
* Status enum support

---

# Seed Data

The project includes sample:

* Users
* Owners
* Pets
* Vets
* Appointments
* Treatments
* Pet photos
* Rich clinical notes

Run:

```bash
bin/rails db:seed
```