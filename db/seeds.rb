puts "Creating data..."

# CLEAN DB
Treatment.destroy_all
Appointment.destroy_all
Pet.destroy_all
Vet.destroy_all
Owner.destroy_all
User.destroy_all

# ======================
# USERS
# ======================

admin_user = User.create!(
  first_name: "Admin",
  last_name: "User",
  email: "admin@vetclinic.com",
  password: "password123",
  password_confirmation: "password123",
  role: :admin
)

vet_user = User.create!(
  first_name: "Vet",
  last_name: "User",
  email: "vet@vetclinic.com",
  password: "password123",
  password_confirmation: "password123",
  role: :vet
)

owner_user = User.create!(
  first_name: "Owner",
  last_name: "User",
  email: "owner@vetclinic.com",
  password: "password123",
  password_confirmation: "password123",
  role: :owner
)

puts "Users created successfully!"

# ======================
# OWNERS
# ======================

owner1 = Owner.create!(
  first_name: "Juan",
  last_name: "Perez",
  email: "juan@mail.com",
  phone: "123456",
  address: "Santiago"
)

owner2 = Owner.create!(
  first_name: "Maria",
  last_name: "Lopez",
  email: "maria@mail.com",
  phone: "789101",
  address: "Providencia"
)

owner3 = Owner.create!(
  first_name: "Pedro",
  last_name: "Gomez",
  email: "pedro@mail.com",
  phone: "111213",
  address: "Las Condes"
)

# ======================
# PETS
# ======================

pet1 = owner1.pets.create!(
  name: "Firulais",
  species: "dog",
  breed: "Labrador",
  date_of_birth: Date.new(2020, 1, 1),
  weight: 20
)

pet2 = owner1.pets.create!(
  name: "Michi",
  species: "cat",
  breed: "Siamese",
  date_of_birth: Date.new(2021, 3, 10),
  weight: 5
)

pet3 = owner2.pets.create!(
  name: "Conejo",
  species: "rabbit",
  breed: "Mini Lop",
  date_of_birth: Date.new(2022, 6, 15),
  weight: 2
)

# ======================
# ATTACH PHOTOS
# ======================

pets = [pet1, pet2, pet3]
files = ["dog.jpg", "cat.jpg", "rabbit.jpg"]

pets.each_with_index do |pet, index|

  path = Rails.root.join("db/seeds/pets/#{files[index]}")

  if File.exist?(path)

    content_type =
      case File.extname(files[index]).downcase
      when ".jpg", ".jpeg"
        "image/jpeg"
      when ".png"
        "image/png"
      when ".webp"
        "image/webp"
      end

    pet.photo.attach(
      io: File.open(path),
      filename: files[index],
      content_type: content_type
    )

    pet.save!

    puts "Photo attached to #{pet.name}"

  else
    puts "⚠️ File not found: #{path}"
  end
end

# ======================
# VETS
# ======================

vet1 = Vet.create!(
  first_name: "Ana",
  last_name: "Diaz",
  email: "ana@vet.com",
  specialization: "General"
)

vet2 = Vet.create!(
  first_name: "Carlos",
  last_name: "Rojas",
  email: "carlos@vet.com",
  specialization: "Surgery"
)

# ======================
# APPOINTMENTS
# ======================

app1 = Appointment.create!(
  pet: pet1,
  vet: vet1,
  date: Time.current + 1.day,
  reason: "General Checkup",
  status: :scheduled
)

app2 = Appointment.create!(
  pet: pet2,
  vet: vet2,
  date: Time.current - 2.days,
  reason: "Dental Control",
  status: :completed
)

app3 = Appointment.create!(
  pet: pet3,
  vet: vet1,
  date: Time.current + 2.days,
  reason: "Vaccination",
  status: :in_progress
)

# ======================
# TREATMENTS + ACTION TEXT
# ======================

t1 = app1.treatments.create!(
  name: "Vaccination",
  administered_at: Time.current
)

t1.clinical_notes = <<~HTML
  <h3>General Check</h3>
  <ul>
    <li>Healthy</li>
    <li>No issues detected</li>
  </ul>
HTML

t1.save!

t2 = app2.treatments.create!(
  name: "Dental Cleaning",
  administered_at: Time.current
)

t2.clinical_notes = <<~HTML
  <strong>Teeth cleaned successfully</strong><br>
  Follow-up in 6 months.
HTML

t2.save!

t3 = app3.treatments.create!(
  name: "Antibiotic Treatment",
  administered_at: Time.current
)

t3.clinical_notes = <<~HTML
  <h4>Medication</h4>
  <ul>
    <li>Amoxicillin</li>
    <li>Dosage: 5mg daily</li>
  </ul>
HTML

t3.save!

puts "Data created successfully!"