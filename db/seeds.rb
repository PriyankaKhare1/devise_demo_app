# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(email: 'admin@mailinator.com', password: '12345678')
role_one = Role.create(name: 'admin')
# role_two = Role.create(name: 'user')
UserRole.create(user: user, role: role_one)