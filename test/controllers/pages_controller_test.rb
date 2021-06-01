require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "compare_currency" do
    get "/api/compare_currency", params: { to_currency: "USD" }

    assert_response :success

    response = json_response["results"]
    assert response.has_key?("amount")
    assert response.has_key?("base")
    assert response.has_key?("start_date")
    assert response.has_key?("end_date")
    assert response.has_key?("rates")

    assert_equal "BRL", response["base"]
    assert response["rates"].is_a?(Array)
  end

  test "compare_currency returns bad_request if to_currency params is not present" do
    get "/api/compare_currency"

    assert_response :bad_request
    response = json_response
    assert response.has_key?("error")
    assert_equal "Missing Required param to_currency.", response["error"]
  end
end
