<<<<<<< HEAD
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar")



20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
  	 email: email,
              password:              password,
              password_confirmation: password)


end
=======
>>>>>>> 667b39de0afd25af9b94bb9b6ff35f27d65fafa9
