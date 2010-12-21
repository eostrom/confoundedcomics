Factory.define(:administrator) do |administrator|
  administrator.email { Faker::Internet.email }
  administrator.password { Faker::Lorem.words(3).map(&:capitalize).join }
end
