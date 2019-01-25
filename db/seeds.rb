puts 'Seeding database...'
admin = Admin.new(email: 'admin@account.com')
admin.password = 'Password123!'
admin.author = true
admin.save!

Post.create!(
  title: 'Great Scott! We Must Get Back to the Future',
  body: 'My blog body',
  published: true,
  author: admin
)

(2..500).each do |i|
  admin = Admin.new(email: "admin_#{i}@account.com")
  admin.password = 'Password123!'
  admin.author = true if i < 10
  admin.save!
end
