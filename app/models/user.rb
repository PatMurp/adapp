class User < ActiveRecord::Base
	has_many :projects, :dependent => :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_admin?
  	self.email && ENV['ADMIN_EMAILS'].to_s.include?(self.email)
	end
	
end
