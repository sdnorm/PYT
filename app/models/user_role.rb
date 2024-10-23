class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :role, polymorphic: true

  validates :name, presence: true
  validates :name, uniqueness: { scope: [ :user_id, :role_type, :role_id ] }
end
