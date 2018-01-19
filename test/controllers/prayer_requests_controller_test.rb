require 'test_helper'

class PrayerRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prayer_request = prayer_requests(:health)
  end

  test "should get index" do
    get prayer_requests_url, as: :json
    assert_response :success
  end

  test "should create prayer_request" do
    assert_difference('PrayerRequest.count') do
      post prayer_requests_url, params: { prayer_request: { description: @prayer_request.description, subject: @prayer_request.subject, user_id: @prayer_request.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show prayer_request" do
    get prayer_request_url(@prayer_request), as: :json
    assert_response :success
  end

  test "should update prayer_request" do
    patch prayer_request_url(@prayer_request), params: { prayer_request: { description: @prayer_request.description, subject: @prayer_request.subject, user_id: @prayer_request.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy prayer_request" do
    assert_difference('PrayerRequest.count', -1) do
      delete prayer_request_url(@prayer_request), as: :json
    end

    assert_response 204
  end
end
