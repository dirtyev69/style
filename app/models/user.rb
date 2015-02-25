class User < ActiveRecord::Base
  acts_as_authentic

  attr_accessible :username, :email, :password, :crypted_password, :password_salt, :password_confirmation
end
