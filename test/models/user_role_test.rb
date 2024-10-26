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
require "test_helper"

class UserRoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
