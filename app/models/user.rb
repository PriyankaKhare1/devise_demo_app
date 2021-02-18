class User < ApplicationRecord
	attr_accessor :login
  has_many :user_roles
  has_many :roles, through: :user_roles
  after_create :set_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def isAdmin
  	self.admin == true ? true : false
  end


  def login
    @login || self.email || self.username
  end

  def set_role
    self.roles.create(name: "user")
  end

  def isActive
    self.active === true ? self.active = false : self.active = true
    self.save
  end

end
