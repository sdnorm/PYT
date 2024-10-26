# == Schema Information
#
# Table name: tournaments
#
#  id         :bigint           not null, primary key
#  name       :string
#  account_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class TournamentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
