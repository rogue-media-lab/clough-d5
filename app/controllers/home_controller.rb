class HomeController < ApplicationController
  skip_before_action :require_authentication, raise: false
  before_action :set_default_meta_tags

  def index
    @featured_issues = Issue.active.where(featured: true).order(:position)
    @active_issues = Issue.active.order(:position)

    set_meta_tags(
      title: "Andrew Clough for Congress — People Over Politics | SC District 5",
      description: "Andrew Clough is running for Congress in South Carolina's 5th District. A proud stepfather, airline worker, and community advocate putting People Over Politics.",
      canonical: root_url,
      og: {
        title: "Andrew Clough for Congress — People Over Politics",
        description: "Courage. Compassion. Clough. Andrew Clough is running for Congress in South Carolina's 5th District.",
        url: root_url,
        type: "website"
      }
    )
  end

  def volunteer
    @volunteer_submission = VolunteerSubmission.new
    @interests = VolunteerInterest.order(:name)

    set_meta_tags(
      title: "Volunteer with Andrew Clough — Join the Movement",
      description: "Join the movement to put People Over Politics. Volunteer with Andrew Clough's campaign for Congress in SC District 5 — phone banking, canvassing, events, and more.",
      canonical: volunteer_url,
      og: {
        title: "Volunteer with Andrew Clough",
        description: "Join the movement to put People Over Politics in SC District 5.",
        url: volunteer_url
      }
    )
  end

  def create_volunteer_submission
    @volunteer_submission = VolunteerSubmission.new(volunteer_submission_params)
    if @volunteer_submission.save
      redirect_to volunteer_path, notice: "Thank you for volunteering! We'll be in touch soon."
    else
      @interests = VolunteerInterest.order(:name)
      render :volunteer, status: :unprocessable_entity
    end
  end

  def about
    set_meta_tags(
      title: "Meet Andrew Clough — Stepfather, Airline Worker, Community Advocate",
      description: "Meet Andrew Clough — a proud stepfather, longtime airline worker, and community advocate running for Congress in South Carolina's 5th District.",
      canonical: about_url,
      og: {
        title: "Meet Andrew Clough — SC District 5 Candidate",
        description: "A proud stepfather, dedicated airline worker, and community advocate. Not a career politician — one of us.",
        url: about_url
      }
    )
  end

  def issues
    @issues = Issue.active.order(:position)

    set_meta_tags(
      title: "The Issues — Tax Relief, Jobs, Healthcare, Education | Clough for SC5",
      description: "Andrew Clough's platform for SC District 5: Tax relief & fairness, jobs & wages, healthcare that works, public education, immigration reform, democracy, infrastructure, and term limits.",
      canonical: issues_url,
      og: {
        title: "The Issues — Clough for Congress",
        description: "Tax relief, jobs, healthcare, education, immigration, democracy, infrastructure, and term limits.",
        url: issues_url
      }
    )
  end

  def show_issue
    @issue = Issue.active.find(params[:id])

    set_meta_tags(
      title: "#{@issue.title} — Andrew Clough for SC District 5",
      description: @issue.tagline.presence || "Andrew Clough's position on #{@issue.title} for South Carolina's 5th Congressional District.",
      canonical: issue_url(@issue),
      og: {
        title: "#{@issue.title} — Clough for SC5",
        description: @issue.tagline.presence || "Andrew Clough's position on #{@issue.title}.",
        url: issue_url(@issue)
      }
    )
  end

  def news
    @featured_article = NewsArticle.published.find_by(featured: true)
    @articles = NewsArticle.published.where.not(id: @featured_article&.id).order(published_date: :desc)

    set_meta_tags(
      title: "In The News — Latest Coverage of Clough for Congress",
      description: "Latest news coverage and articles about Andrew Clough's campaign for Congress in South Carolina's 5th District.",
      canonical: news_url,
      og: {
        title: "In The News — Clough for Congress",
        description: "Latest news coverage of Andrew Clough's campaign for SC District 5.",
        url: news_url
      }
    )
  end

  def events
    @next_event = Event.upcoming.first
    @remaining_upcoming = Event.upcoming.offset(1)
    @past_events = Event.past.limit(8)

    set_meta_tags(
      title: "Upcoming Events — Clough for Congress 2026",
      description: "Join Andrew Clough at upcoming campaign events in South Carolina's 5th District. Town halls, community gatherings, and volunteer opportunities.",
      canonical: events_url,
      og: {
        title: "Upcoming Events — Clough for Congress",
        description: "Join Andrew Clough at campaign events in SC District 5.",
        url: events_url
      }
    )
  end

  def show_event
    @event = Event.find(params[:id])

    event_desc = @event.description.presence || "Join Andrew Clough at #{@event.title} in #{@event.location}."
    set_meta_tags(
      title: "#{@event.title} — Clough for Congress",
      description: event_desc.to_s.truncate(160),
      canonical: event_url(@event),
      og: {
        title: "#{@event.title} — Clough for SC5",
        description: event_desc.to_s.truncate(160),
        url: event_url(@event)
      }
    )
  end

  private

  def set_default_meta_tags
    set_meta_tags(
      site: "Clough for SC5",
      title: "Andrew Clough for Congress — SC District 5",
      description: "Andrew Clough is running for Congress in South Carolina's 5th District. People Over Politics.",
      keywords: "Andrew Clough, SC-5, Congress, South Carolina, 2026, election, People Over Politics",
      reverse: true,
      separator: " | ",
      og: {
        site_name: "Clough for SC5",
        image: "/og-image.jpg",
        type: "website"
      },
      twitter: {
        card: "summary_large_image",
        site: "@cloughforsc5",
        image: "/og-image.jpg"
      }
    )
  end

  def volunteer_submission_params
    params.expect(volunteer_submission: [ :name, :last_name, :email, :phone, :message, :area_code, interest_ids: [] ])
  end
end
