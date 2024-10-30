# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_type :integer
#  owner_id     :bigint
#
class Account < ApplicationRecord
  has_many :account_users, dependent: :destroy
  has_many :users, through: :account_users, dependent: :destroy
  has_many :tournaments, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :user_roles, dependent: :destroy

  belongs_to :owner, class_name: "User"

  # enum :account_type, { club: 0, league: 1, tournament: 2 }

  validates :name, presence: true
  validates :owner, presence: true

  def owner?(user)
    owner_id == user.id
  end
end
