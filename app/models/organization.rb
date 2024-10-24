# == Schema Information
#
# Table name: organizations
#
#  id         :bigint           not null, primary key
#  name       :string
#  account_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Organization < ApplicationRecord
  belongs_to :account

  has_many :teams, dependent: :destroy
  has_many :tournaments, dependent: :destroy
end
