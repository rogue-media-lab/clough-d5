class Admin::DashboardController < Admin::BaseController
  def index
    @post_count      = Post.count
    @published_count = Post.published.count
    @draft_count     = Post.drafts.count
    @recent_posts    = Post.order(created_at: :desc).limit(5)

    @issue_count       = Issue.count
    @active_issue_count  = Issue.active.count
    @draft_issue_count  = Issue.draft.count
    @recent_issues    = Issue.order(created_at: :desc).limit(5)
  end
end
