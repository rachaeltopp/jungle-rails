class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  validates_presence_of :first_name, :last_name, :email, :password
  
end
