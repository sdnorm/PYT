# == Schema Information
#
# Table name: accounts
#
#  id           :bigint           not null, primary key
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  account_type :integer
#
class Account < ApplicationRecord
  has_many :account_users, dependent: :destroy
  has_many :users, through: :account_users, dependent: :destroy

  has_many :tournaments, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :user_roles, dependent: :destroy

  # enum :account_type, { club: 0, league: 1, tournament: 2 }

  validates :name, presence: true
  # validates :account_type, presence: true
end
