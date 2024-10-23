class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  belongs_to :account

  has_many :user_roles, dependent: :destroy

  def add_role(role_name, role_object)
    user_roles.create(name: role_name, role: role_object)
  end

  def remove_role(role_name, role_object)
    user_roles.find_by(name: role_name, role: role_object).destroy
  end

  def has_role?(role_name, role_object)
    user_roles.exists?(name: role_name, role: role_object)
  end
end
