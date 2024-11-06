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
  attribute :dob, :datetime

  validates :first_name, :last_name, :dob, presence: true

  before_save :set_minor, if: :dob_changed?

  def minor?
    return false unless dob.present?
    dob.to_date > (Date.current - 18.years)
  end

  private

  def set_minor
    return unless dob.present?
    self.minor = minor?
  end
end
