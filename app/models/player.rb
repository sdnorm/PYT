# == Schema Information
#
# Table name: players
#
#  id         :bigint           not null, primary key
#  first_name :string
#  last_name  :string
#  dob        :datetime
#  minor      :boolean
#  user_id    :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Player < ApplicationRecord
  belongs_to :user

  encrypts :dob

  after_initialize :set_minor

  validates :first_name, :last_name, :dob, presence: true

  def set_minor
    self.minor = true if self.dob.present? && self.dob > 18.years.ago
  end
end
