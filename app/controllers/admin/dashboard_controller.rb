class Admin::DashboardController < Admin::BaseController
  def index
    # === ANALYTICS (top of page) ===
    @today_visits     = Ahoy::Visit.where(started_at: Time.current.beginning_of_day..).count
    @this_week_visits = Ahoy::Visit.where(started_at: 1.week.ago..).count
    @this_month_visits = Ahoy::Visit.where(started_at: 1.month.ago..).count
    @total_visits     = Ahoy::Visit.count

    # Page views (events are page views)
    @today_page_views     = Ahoy::Event.where(name: "$view", time: Time.current.beginning_of_day..).count
    @this_week_page_views = Ahoy::Event.where(name: "$view", time: 1.week.ago..).count
    @this_month_page_views = Ahoy::Event.where(name: "$view", time: 1.month.ago..).count

    # Chart data: daily visits for last 30 days
    @visits_by_day = Ahoy::Visit
      .where(started_at: 30.days.ago..)
      .group_by_day(:started_at)
      .count

    # Chart data: daily page views for last 30 days
    @page_views_by_day = Ahoy::Event
      .where(name: "$view", time: 30.days.ago..)
      .group_by_day(:time)
      .count

    # Top pages (last 30 days)
    @top_pages = Ahoy::Event
      .where(name: "$view", time: 30.days.ago..)
      .group("properties->>'url'")
      .count
      .sort_by { |_, v| -v }
      .first(10)

    # Top referrers (last 30 days)
    @top_referrers = Ahoy::Visit
      .where(started_at: 30.days.ago..)
      .where.not(referrer: [ nil, "" ])
      .group(:referrer)
      .count
      .sort_by { |_, v| -v }
      .first(5)

    # === EXISTING DASHBOARD DATA ===
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
