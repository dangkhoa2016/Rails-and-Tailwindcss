email = 'admin@admin.admin'
password = 'adminadmin'
user = User.find_by(email: email)
if user.present?
  puts "Admin user with email: #{email} already exists"
  return
end

user = User.create({
  email: email,
  password: password,
  password_confirmation: password,
  first_name: 'Admin',
  last_name: 'Admin',
  role: 'admin',
  active: true
})

if user.persisted?
  puts "Admin user created with email: #{email} and password: #{password}"
else
  puts "Failed to create admin user with email: #{email} and password: #{password}: #{user.errors.full_messages.join(', ')}"
end
