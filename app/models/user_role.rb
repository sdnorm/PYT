# == Schema Information
#
# Table name: user_roles
#
#  id            :bigint           not null, primary key
#  user_id       :bigint           not null
#  role_id       :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  account_id    :bigint
#  name          :integer          not null
#  role_type     :string
#  team_id       :bigint
#  tournament_id :bigint
#
class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :account, optional: true
  belongs_to :team, optional: true
  belongs_to :tournament, optional: true
  belongs_to :role, polymorphic: true, optional: true
  belongs_to :account_user, optional: true

  enum :name, {
    owner: 0,
    admin: 1,
    user: 2,
    coach: 3,
    guardian: 4,
    player: 5,
    volunteer: 6
  }

  validates :user_id, uniqueness: {
    scope: [ :role_type, :role_id, :name, :account_id ],
    message: "User already has this role for this specific context in the account"
  }

  scope :for_account, ->(account) {
    where(account: account)
  }

  scope :for_team, ->(team) {
    where(role_type: "Team", role_id: team.id)
  }

  scope :for_tournament, ->(tournament) {
    where(role_type: "Tournament", role_id: tournament.id)
  }
end
