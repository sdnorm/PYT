# == Schema Information
#
# Table name: teams
#
#  id              :bigint           not null, primary key
#  organization_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Team < ApplicationRecord
  belongs_to :organization

  has_many :user_roles, as: :role, dependent: :destroy
  has_many :users, through: :user_roles
end
