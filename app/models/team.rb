class Team < ApplicationRecord
  belongs_to :organization

  has_many :user_roles, as: :role, dependent: :destroy
  has_many :users, through: :user_roles
end
