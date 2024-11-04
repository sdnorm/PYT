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
require "test_helper"

class PlayerTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @player = Player.new(
      first_name: "John",
      last_name: "Doe",
      dob: "2000-01-01",
      user: @user
    )
  end

  test "valid player" do
    assert @player.valid?
  end

  test "requires first_name" do
    @player.first_name = nil
    assert_not @player.valid?
    assert_includes @player.errors[:first_name], "can't be blank"
  end

  test "requires last_name" do
    @player.last_name = nil
    assert_not @player.valid?
    assert_includes @player.errors[:last_name], "can't be blank"
  end

  test "requires dob" do
    @player.dob = nil
    assert_not @player.valid?
    assert_includes @player.errors[:dob], "can't be blank"
  end

  test "requires user" do
    @player.user = nil
    assert_not @player.valid?
    assert_includes @player.errors[:user], "must exist"
  end

  test "sets minor status to true for players under 18" do
    travel_to Time.zone.local(2024, 1, 1) do
      @player.dob = "2010-01-01"
      @player.save
      assert @player.minor?
    end
  end

  test "sets minor status to false for players 18 and over" do
    travel_to Time.zone.local(2024, 1, 1) do
      @player.dob = "2005-01-01"
      @player.save
      assert_not @player.minor?
    end
  end
end
