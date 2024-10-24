# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email_address   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  first_name      :string
#  last_name       :string
#
class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true

  has_many :account_users, dependent: :destroy
  has_many :accounts, through: :account_users

  has_many :user_roles, dependent: :destroy

  def add_role(role_name, account)
    user_roles.create!(role_type: role_name.to_sym, name: role_name.to_s, account: account)
  end

  def remove_role(role_name, account)
    user_roles.find_by(role_type: role_name, account: account)&.destroy
  end

  def has_role?(role_name, account)
    user_roles.exists?(role_type: role_name, account: account)
  end
end
