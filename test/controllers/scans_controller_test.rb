require "test_helper"

class ScansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scan = scans(:one)
  end

  test "should get index" do
    get scans_url
    assert_response :success
  end

  test "should get new" do
    get new_scan_url
    assert_response :success
  end

  test "should create scan" do
    assert_difference("Scan.count") do
      post scans_url, params: { scan: { accessibility_issues: @scan.accessibility_issues, flagged_words: @scan.flagged_words, last_crawled_on: @scan.last_crawled_on, misspellings: @scan.misspellings, overall_score: @scan.overall_score, pages: @scan.pages, site_id: @scan.site_id } }
    end

    assert_redirected_to scan_url(Scan.last)
  end

  test "should show scan" do
    get scan_url(@scan)
    assert_response :success
  end

  test "should get edit" do
    get edit_scan_url(@scan)
    assert_response :success
  end

  test "should update scan" do
    patch scan_url(@scan), params: { scan: { accessibility_issues: @scan.accessibility_issues, flagged_words: @scan.flagged_words, last_crawled_on: @scan.last_crawled_on, misspellings: @scan.misspellings, overall_score: @scan.overall_score, pages: @scan.pages, site_id: @scan.site_id } }
    assert_redirected_to scan_url(@scan)
  end

  test "should destroy scan" do
    assert_difference("Scan.count", -1) do
      delete scan_url(@scan)
    end

    assert_redirected_to scans_url
  end
end
