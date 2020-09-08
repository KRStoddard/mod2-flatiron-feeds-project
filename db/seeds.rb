# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Post.destroy_all
Comment.destroy_all
Group.destroy_all 
GroupMember.destroy_all

puts "Starting Seed"

Group.create(name: "Cohort for 08/03/20 Software Engineering", description: "Welcome new Software Engineers!", code: "080320SE")
Group.create(name: "Struggle Bus", description: "Help!!!")

Cohort.create(code: "080320SE")
Cohort.create(code: "090820CS")

puts "Complete!"