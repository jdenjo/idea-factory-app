# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Idea.destroy_all
User.destroy_all
Review.destroy_all

PASSWORD = "supersecret"

30.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD,
    is_admin?: false,
  )
end

User.create(
  first_name: "Dean",
  last_name: "Enjo",
  email: "jdenjo@gmail.com",
  password: "a",
  is_admin?: false,
)

users = User.all

50.times do
  created_at = Faker::Date.backward(365 * 5)
  q = Idea.create(
    title: Faker::Cannabis.strain,
    body: Faker::Hipster.paragraph,
    created_at: created_at,
    updated_at: created_at,
    user: users.sample,
  )

  if q.valid?
    q.reviews = rand(0..15).times.map do
      Review.new(body: Faker::GreekPhilosophers.quote, user: users.sample)
    end
  end
end
