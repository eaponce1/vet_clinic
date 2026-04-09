puts "Creando datos..."

# 👤 Owners
owner1 = Owner.create(first_name: "Juan", last_name: "Perez", email: "juan@mail.com", phone: "123456", address: "Santiago")
owner2 = Owner.create(first_name: "Maria", last_name: "Lopez", email: "maria@mail.com", phone: "789101", address: "Providencia")
owner3 = Owner.create(first_name: "Pedro", last_name: "Gomez", email: "pedro@mail.com", phone: "111213", address: "Las Condes")

# 🐶 Pets
pet1 = owner1.pets.create(name: "Firulais", species: "Perro", breed: "Labrador", date_of_birth: "2020-01-01", weight: 20)
pet2 = owner1.pets.create(name: "Michi", species: "Gato", breed: "Siames", date_of_birth: "2021-03-10", weight: 5)
pet3 = owner2.pets.create(name: "Conejo", species: "Conejo", breed: "Mini Lop", date_of_birth: "2022-06-15", weight: 2)
pet4 = owner3.pets.create(name: "Rocky", species: "Perro", breed: "Bulldog", date_of_birth: "2019-08-20", weight: 25)
pet5 = owner2.pets.create(name: "Luna", species: "Gato", breed: "Persa", date_of_birth: "2020-11-11", weight: 4)

# 👨‍⚕️ Vets
vet1 = Vet.create(first_name: "Ana", last_name: "Diaz", email: "ana@vet.com", phone: "555", specialization: "General")
vet2 = Vet.create(first_name: "Carlos", last_name: "Rojas", email: "carlos@vet.com", phone: "666", specialization: "Cirugia")

# 📅 Appointments
app1 = Appointment.create(pet: pet1, vet: vet1, date: Time.now, reason: "Chequeo", status: 0)
app2 = Appointment.create(pet: pet2, vet: vet2, date: Time.now, reason: "Vacuna", status: 1)
app3 = Appointment.create(pet: pet3, vet: vet1, date: Time.now, reason: "Control", status: 2)
app4 = Appointment.create(pet: pet4, vet: vet2, date: Time.now, reason: "Cirugia", status: 3)
app5 = Appointment.create(pet: pet5, vet: vet1, date: Time.now, reason: "Revisión", status: 0)

# 💊 Treatments
app1.treatments.create(name: "Tratamiento A", medication: "Med1", dosage: "10mg", notes: "OK", administered_at: Time.now)
app2.treatments.create(name: "Tratamiento B", medication: "Med2", dosage: "5mg", notes: "OK", administered_at: Time.now)
app3.treatments.create(name: "Tratamiento C", medication: "Med3", dosage: "2mg", notes: "OK", administered_at: Time.now)
app4.treatments.create(name: "Tratamiento D", medication: "Med4", dosage: "1mg", notes: "OK", administered_at: Time.now)
app5.treatments.create(name: "Tratamiento E", medication: "Med5", dosage: "3mg", notes: "OK", administered_at: Time.now)

puts "Datos creados!"