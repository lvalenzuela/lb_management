namespace :user do
  desc "Rebuild Auth-Tokens"
  task :define_system_role => :environment do
    User.transaction do
      User.all.each { |u|
        u.set_system_role
        u.save!
      }
    end
  end
end