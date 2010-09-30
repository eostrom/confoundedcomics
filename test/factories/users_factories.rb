Factory.define(:user) do |user|
  user.name { Faker::Name.name }
  user.email_address { Faker::Internet.email }
end

Factory.define(:admin_user, :parent => :user) do |user|
  user.administrator true
end
