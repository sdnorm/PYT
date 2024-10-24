# == Schema Information
#
# Table name: user_roles
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  role_type  :bigint           not null
#  role_id    :bigint           not null
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  account_id :bigint           not null
#
require "test_helper"

class UserRoleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
