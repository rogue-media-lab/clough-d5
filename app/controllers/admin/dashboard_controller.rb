class Admin::DashboardController < Admin::BaseController
  def index
    # Issues
    @issue_count       = Issue.count
    @active_issue_count = Issue.active.count
    @draft_issue_count = Issue.draft.count
    @recent_issues     = Issue.order(created_at: :desc).limit(5)

    # News/Posts
    @post_count      = Post.count
    @published_count = Post.published.count
    @draft_count     = Post.drafts.count
    @recent_posts    = Post.order(created_at: :desc).limit(5)

    # Volunteers
    @volunteer_count          = VolunteerSubmission.count
    @new_this_week            = VolunteerSubmission.where(created_at: 1.week.ago..).count
    @pending_count            = VolunteerSubmission.pending.count
    @confirmed_count          = VolunteerSubmission.confirmed.count
    @recent_volunteers        = VolunteerSubmission.order(created_at: :desc).limit(5)

    # Volunteer breakdown by interest
    @interest_breakdown = VolunteerInterest.all.map do |interest|
      [ interest.name, interest.submissions.count ]
    end.sort_by { |_, count| -count }

    # News Articles
    @news_article_count  = NewsArticle.count
    @published_news_count = NewsArticle.published.count
    @fetched_news_count  = NewsArticle.fetched.count
    @recent_articles     = NewsArticle.recent.limit(5)

    # Events
    @event_count       = Event.count
    @upcoming_count    = Event.upcoming.count
    @this_week_events  = Event.this_week
  end
end
