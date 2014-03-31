class AddSuperadminToUser < ActiveRecord::Migration
  def change
  	add_column :users, :superadmin, :boolean, :null => false, :default => false

  	User.create! do |r|
      r.email      = 'default@example.com'
      r.password   = 'password'
      r.superadmin = true
    end
  end
end
