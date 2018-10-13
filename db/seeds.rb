post = Post.create!(
  title: 'Great Scott!  We Must Get Back to the Future',
  body: 'My blog body',
  published: true
)

admin = Admin.new(email: 'admin@account.com')
admin.password = 'Password123!'
admin.save!
