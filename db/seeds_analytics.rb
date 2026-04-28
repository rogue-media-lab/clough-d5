puts "Seeding analytics data..."

pages = ["/", "/issues", "/about", "/volunteer", "/events", "/news", "/issues/1", "/issues/2", "/issues/3"]
referrers = [nil, nil, nil, "https://google.com", "https://facebook.com", "https://twitter.com", "https://cloughforsc5.com"]

30.downto(0) do |days_ago|
  date = days_ago.days.ago
  base_visits = [3, 5, 8, 10, 12][[days_ago / 6, 4].min]
  visit_count = [base_visits + rand(-2..4), 1].max

  visit_count.times do
    visit = Ahoy::Visit.create!(
      visit_token: SecureRandom.uuid,
      visitor_token: SecureRandom.uuid,
      started_at: date + rand(0..86399).seconds,
      landing_page: pages.sample,
      referrer: referrers.sample,
      user_agent: "Mozilla/5.0 (Seed Data)",
      ip: "#{rand(1..223)}.#{rand(0..255)}.#{rand(0..255)}.#{rand(0..255)}"
    )

    rand(1..4).times do
      Ahoy::Event.create!(
        visit: visit,
        name: "$view",
        time: visit.started_at + rand(0..300).seconds,
        properties: { url: pages.sample }
      )
    end
  end
end

total_visits = Ahoy::Visit.count
total_views = Ahoy::Event.where(name: "$view").count
puts "Created #{total_visits} visits with #{total_views} page views"
