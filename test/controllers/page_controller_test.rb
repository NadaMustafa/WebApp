require 'test_helper'

class PageControllerTest < ActionController::TestCase
  test "should get image" do
    get :image
    assert_response :success
  end

end
