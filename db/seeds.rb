# Students
30.times do |i|
  User.create(
    username: "student-#{i}",
    email: "student-#{i}@example.com",
    password: 'asdqwe123',
    password_confirmation: 'asdqwe123',
    active: true
    )
end

# Lecturers
5.times do |i|
  User.create(
    username: "lecturer-#{i}",
    email: "lecturer-#{i}@example.com",
    password: 'asdqwe123',
    password_confirmation: 'asdqwe123',
    active: true,
    role: 'lecturer'
    )
end

# Courses
lecturer = User.where(role: 'lecturer').first

lecturer.courses.create(
  name: 'Introduction to Computer Science',
  code: 'cs-101'
  )
lecturer.courses.create(
  name: 'Programming Abstraction',
  code: 'cs-201'
  )
lecturer.courses.create(
  name: 'Programming Paradigms',
  code: 'cs-202'
  )