class User < ActiveRecord::Base

  has_secure_password

  has_many :reviews

  validates_presence_of :first_name, :last_name, :email, :password, :password_confirmation
  validates :password, length: { minimum: 4 }
  validates :email, :uniqueness => {:case_sensitive => false}

  def self.authenticate_with_credentials(email,password)
    user = User.find_by_email(email.downcase.strip)
    if user && user.authenticate(password)
      @user = user
    else
      nil
    end
  end
  
end
