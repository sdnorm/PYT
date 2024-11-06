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
      first_name: "MyString",
      last_name: "MyString",
      dob: Date.new(2010, 1, 1),
      user: @user
    )
  end

  test "valid player" do
    assert @player.valid?, "Player should be valid, but has errors: #{@player.errors.full_messages.join(', ')}"
    assert @player.save, "Player should save successfully"

    # Verify we can read it back from the database with encryption working
    saved_player = Player.find(@player.id)
    assert_equal Date.new(2010, 1, 1), saved_player.dob.to_date
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

  test "dob is stored in encrypted form" do
    original_date = Date.new(2000, 1, 1)
    player = Player.create!(
      first_name: "Test",
      last_name: "User",
      dob: original_date,
      user: users(:one)
    )

    # Get raw database value
    raw_result = ActiveRecord::Base.connection.execute(
      "SELECT dob FROM players WHERE id = #{player.id}"
    ).first["dob"]

    # Basic encryption checks
    assert_not_equal original_date.to_s, raw_result, "DOB should be encrypted in database"
    assert_not_nil raw_result, "Encrypted DOB should not be nil"

    # Verify we can read it back correctly through the model
    reloaded_player = Player.find(player.id)
    assert_equal original_date, reloaded_player.dob.to_date
  end
end
