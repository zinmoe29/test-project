# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

30.times do
  c = Cab.find_or_create_by(
    model: Faker::Vehicle.model,
    plate_number: Faker::Vehicle.license_plate,
    mileage: Faker::Vehicle.mileage
  )
end
