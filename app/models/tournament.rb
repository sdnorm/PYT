class Tournament < ApplicationRecord
  has_one :primary_account, as: :primary_entity, class_name: "Account"

  belongs_to :account
  belongs_to :organization, optional: true

  has_many :user_roles, as: :role, dependent: :destroy
  has_many :users, through: :user_roles
end
