require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  # setup do
  #   @user = users(:one)
  #   @player = Player.create!(
  #     first_name: "Test",
  #     last_name: "Player",
  #     dob: "2005-01-01",
  #     user: @user
  #   )
  #   sign_in_as(@user)
  # end

  # test "should get index" do
  #   get players_url
  #   assert_response :success
  # end

  # test "should get new" do
  #   get new_player_url
  #   assert_response :success
  # end

  # test "should create player" do
  #   assert_difference("Player.count") do
  #     post players_url, params: { player: { dob: @player.dob, first_name: @player.first_name, last_name: @player.last_name, user_id: @player.user_id } }
  #   end

  #   assert_redirected_to player_url(Player.last)
  # end

  # test "should show player" do
  #   get player_url(@player)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get edit_player_url(@player)
  #   assert_response :success
  # end

  # test "should update player" do
  #   patch player_url(@player), params: { player: { dob: @player.dob, first_name: @player.first_name, last_name: @player.last_name, user_id: @player.user_id } }
  #   assert_redirected_to player_url(@player)
  # end

  # test "should destroy player" do
  #   assert_difference("Player.count", -1) do
  #     delete player_url(@player)
  #   end

  #   assert_redirected_to players_url
  # end
end
