# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string           not null
#
class Team < ApplicationRecord
  belongs_to :account

  has_many :user_roles, as: :role, dependent: :destroy
  has_many :users, through: :user_roles

  validates :name, presence: true
  validates :age_group, presence: true

  def self.roles
    UserRole.names.keys
  end

  def add_user_role(user, role_name)
    user_roles.create(user: user, name: role_name, account: account)
  end

  def remove_user_role(user, role_name)
    user_roles.find_by(user: user, name: role_name)&.destroy
  end

  def users_with_role(role_name)
    user_roles.where(name: role_name).includes(:user).map(&:user)
  end
end
