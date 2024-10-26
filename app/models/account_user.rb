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

  has_many :user_roles, as: :role, dependent: :destroy

  # def has_role?(name)
  #   user.has_role?(name, account)
  # end

  def owner?
    has_role?(:owner)
  end

  def add_role(name, context = nil)
    user_roles.create!(
      name: name,
      role: context,
      account: account,
      user: user
    )
  end

  def remove_role(name, context = nil)
    user_roles.find_by(
      name: name,
      role: context
    )&.destroy
  end

  def has_role?(name, context = nil)
    # puts "Model"
    # puts name
    # puts self.account.inspect
    # puts user_roles.inspect
    user_roles.exists?(
      name: name
    )
  end

  def roles
    user_roles
  end

  def has_any_role?
    user_roles.exists?
  end

  def owner?
    has_role?(:owner)
  end
end
