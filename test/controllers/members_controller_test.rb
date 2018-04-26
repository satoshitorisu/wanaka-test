require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  test "should get invite" do
    get members_invite_url
    assert_response :success
  end

  test "should get apply" do
    get members_apply_url
    assert_response :success
  end

end
