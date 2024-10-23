class Tournament < ApplicationRecord
  belongs_to :account
  belongs_to :organization
end
