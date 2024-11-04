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

  # Let's temporarily comment out encryption to test the basic functionality
  # encrypts :dob

  after_create :set_minor

  validates :first_name, :last_name, :dob, presence: true

  private

  def set_minor
    return unless dob.present?
    update_column(:minor, dob.to_date > (Date.current - 18.years))
  end
end
