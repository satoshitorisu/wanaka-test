require 'test_helper'

class TeamsControllerTest < ActionDispatch::IntegrationTest
  test "should get edit" do
    get teams_edit_url
    assert_response :success
  end

end
