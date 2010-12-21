Given 'I am logged in' do
  Factory.create(:administrator,
    :email => 'admin@example.com', :password => 'Admin1')

  And 'I go to the login page'
  And 'I fill in "Email" with "admin@example.com"'
  And 'I fill in "Password" with "Admin1"'
  And 'I press "Sign in"'
end
