require 'test_helper'

class ParticipatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get participates_index_url
    assert_response :success
  end

  test "should get create" do
    get participates_create_url
    assert_response :success
  end

  test "should get update" do
    get participates_update_url
    assert_response :success
  end

  test "should get destroy" do
    get participates_destroy_url
    assert_response :success
  end

end
