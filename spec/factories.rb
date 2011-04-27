Factory.define :user do |user|
  user.name                   "Lawrence Chang"
  user.email                  "lachang@yahoo.com"
  user.password               "j2ee123"
  user.password_confirmation  "j2ee123"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "Foo bar"
  micropost.association :user
end