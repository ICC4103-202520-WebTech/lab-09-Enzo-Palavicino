# This file seeds data required for the application to run in any environment.
# The operations below are idempotent so running `bin/rails db:seed` multiple
# times will not create duplicate records.

admin_email = ENV.fetch("ADMIN_EMAIL", "admin@example.com")
admin_password = ENV.fetch("ADMIN_PASSWORD", "password123")

User.find_or_create_by!(email: admin_email) do |user|
  user.password = admin_password
  user.password_confirmation = admin_password
  user.role = :admin
end

puts "Seeded admin user #{admin_email}"
