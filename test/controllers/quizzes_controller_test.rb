require "test_helper"

class QuizzesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get quizzes_new_url
    assert_response :success
  end

  test "should get create" do
    get quizzes_create_url
    assert_response :success
  end

  test "should get edit" do
    get quizzes_edit_url
    assert_response :success
  end

  test "should get destroy" do
    get quizzes_destroy_url
    assert_response :success
  end
end
