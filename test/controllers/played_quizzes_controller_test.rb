require "test_helper"

class PlayedQuizzesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get played_quizzes_create_url
    assert_response :success
  end

  test "should get destroy" do
    get played_quizzes_destroy_url
    assert_response :success
  end
end
