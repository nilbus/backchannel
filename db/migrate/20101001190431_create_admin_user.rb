class CreateAdminUser < ActiveRecord::Migration
  def self.up
    u = User.new :admin => true,
                 :login => 'admin',
                 :password => 'admin1',
                 :password_confirmation => 'admin1',
                 :email => 'admin@example.com',
                 :name => 'Admin'
    u.admin = true
    u.save
  end

  def self.down
    User.find_by_login('admin').try :destroy
  end
end
