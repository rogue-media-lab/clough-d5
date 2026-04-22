require "test_helper"

class Admin::IssuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin_issue = admin_issues(:one)
  end

  test "should get index" do
    get admin_issues_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_issue_url
    assert_response :success
  end

  test "should create admin_issue" do
    assert_difference("Admin::Issue.count") do
      post admin_issues_url, params: { admin_issue: {} }
    end

    assert_redirected_to admin_issue_url(Admin::Issue.last)
  end

  test "should show admin_issue" do
    get admin_issue_url(@admin_issue)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_issue_url(@admin_issue)
    assert_response :success
  end

  test "should update admin_issue" do
    patch admin_issue_url(@admin_issue), params: { admin_issue: {} }
    assert_redirected_to admin_issue_url(@admin_issue)
  end

  test "should destroy admin_issue" do
    assert_difference("Admin::Issue.count", -1) do
      delete admin_issue_url(@admin_issue)
    end

    assert_redirected_to admin_issues_url
  end
end
