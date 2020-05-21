User.create!(
  name: "admin",
  email: "admin100@example.com",
  password: "admin@example.com",
  password_confirmation: "admin@example.com",
  admin: true,
)

Label.create!(name: '仕事')
Label.create!(name: 'プライベート')
Label.create!(name: '休暇')