namespace :db do
  desc "Make admin in database: 'admin@example.com', 'foobar8'"
  task :make_admin => :environment do
    admin = User.create!(
                         :email => "admin@example.com",
                         :password => "foobar8",
                         :password_confirmation => "foobar8",
                         )
    admin.update_attribute(:role, "admin")
  end
end