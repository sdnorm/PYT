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
  has_many :teams, through: :user_roles, source: :role, source_type: "Team"

  has_one :owned_account, class_name: "Account"

  def add_role(name, context = nil, account)
    user_roles.create(
      name: name,
      role: context,
      account: account
    )
  end

  def remove_role(name, context = nil, account)
    user_roles.find_by(
      name: name,
      role: context,
      account: account
    )&.destroy
  end

  def has_role?(name, context = nil, account)
    user_roles.exists?(
      name: name,
      role: context,
      account: account
    )
  end

  def roles_for_account(account)
    user_roles.where(account: account)
  end

  def all_roles
    user_roles.includes(:account, :role).group_by(&:account).transform_values do |roles|
      roles.map { |role| { name: role.name, context: role.role } }
    end
  end
end
