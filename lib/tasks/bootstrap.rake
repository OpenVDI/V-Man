namespace :bootstrap do

  desc "create user"
  task :default_user => :environment do
    u = User.new
    u.email = "openvdi@github.com"
    u.password = 'openvdi@github.com'
    u.save!
  end

  task :all => [:default_user]

end
