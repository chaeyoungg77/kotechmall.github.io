require 'test_helper'

class PortalControllerTest < ActionController::TestCase
  test "should get auth" do
    get :auth
    assert_response :success
  end

  test "should get login" do
    get :login
    assert_response :success
  end

end
