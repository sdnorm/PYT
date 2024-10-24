# == Schema Information
#
# Table name: accounts
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Account < ApplicationRecord
  has_many :account_users, dependent: :destroy
  has_many :users, through: :account_users, dependent: :destroy

  has_many :tournaments, dependent: :destroy
  has_many :organizations, dependent: :destroy

  has_many :user_roles, dependent: :destroy
end
