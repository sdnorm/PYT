# == Schema Information
#
# Table name: user_roles
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  role_type  :bigint           not null
#  role_id    :bigint           not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
class UserRole < ApplicationRecord
  belongs_to :account
  belongs_to :user
  belongs_to :role, polymorphic: true

  validates :name, presence: true
  validates :name, uniqueness: { scope: [ :user_id, :role_type, :role_id ] }

  # enum "role_type" => {
  #   owner: 0,
  #   admin: 1,
  #   user: 2,
  #   coach: 3,
  #   parent: 4,
  #   player: 5,
  #   volunteer: 6
  # }

  enum :role_type, [ :owner, :admin, :user, :coach, :parent, :player, :volunteer ]
end
