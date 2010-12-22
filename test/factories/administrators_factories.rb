Factory.define(:administrator) do |administrator|
  administrator.email { Faker::Internet.email }
  administrator.password do
    Faker::Lorem.words(3).map(&:capitalize).join.first(20)
  end
end
