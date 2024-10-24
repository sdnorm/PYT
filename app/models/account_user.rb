# == Schema Information
#
# Table name: account_users
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  account_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AccountUser < ApplicationRecord
  belongs_to :user
  belongs_to :account
end
