
# Admin User
User.find_or_create_by!(email_address: "admin@cloughforsc.com") do |user|
  user.password = "CloughRocks!"
  user.admin = true
end

puts "Admin user: admin@cloughforsc.com"

# News
NewsArticle.destroy_all
NewsFeed.destroy_all

NewsArticle.create!([
  {
    title: "Andrew Clough Receives Key Endorsement from Local Business Leaders",
    body: "A group of prominent local business leaders have announced their endorsement of Andrew Clough for State House District 5...",
    external_url: "",
    source: "Rock Hill Herald",
    published_date: DateTime.now - 1.day,
    status: :published,
    featured: true
  },
  {
    title: "Clough Pledges to Fight for Lower Property Taxes",
    body: "At a town hall in York, Andrew Clough promised to make property tax relief a top priority if elected...",
    external_url: "",
    source: "York News-Times",
    published_date: DateTime.now - 3.days,
    status: :published,
    featured: false
  },
  {
    title: "Education Leaders Praise Clough\'s School Choice Plan",
    body: "Andrew Clough\'s detailed plan to expand school choice and empower parents has earned high marks from education reform advocates...",
    external_url: "",
    source: "SC Policy Council",
    published_date: DateTime.now - 5.days,
    status: :published,
    featured: false
  }
])

NewsFeed.create!([
  { name: "Rock Hill Herald", url: "https://www.heraldonline.com/news/local/rss.xml", active: true },
  { name: "York News-Times", url: "https://www.yorknewstimes.com/search/?f=rss&t=article&c=news&l=50&s=start_time&sd=desc", active: true },
  { name: "The Post and Courier", url: "https://www.postandcourier.com/search/?f=rss&t=article&c=news&l=50&s=start_time&sd=desc", active: true }
])

puts "News Articles: #{NewsArticle.count} total"
puts "News Feeds: #{NewsFeed.count} total"

# Volunteers
VolunteerSubmission.destroy_all
VolunteerInterest.destroy_all

interests = VolunteerInterest.create!([
  { name: "Phone Banking" },
  { name: "Canvassing" },
  { name: "Event Support" },
  { name: "Digital Outreach" },
  { name: "Yard Signs" },
  { name: "Data Entry" }
])

# Realistic volunteer submissions for SC District 5 (Rock Hill, York, Chester area)
submissions = VolunteerSubmission.create!([
  {
    name: "Sarah Johnson", email: "sarah.johnson@email.com", phone: "803-555-0142",
    area_code: "29730", message: "I've been active in local politics and want to help Andrew win!",
    submission_status: :confirmed, created_at: 6.days.ago
  },
  {
    name: "Mike Rodriguez", email: "mike.r@email.com", phone: "803-555-0198",
    area_code: "29732", message: "Happy to knock on doors in my neighborhood.",
    submission_status: :contacted, created_at: 5.days.ago
  },
  {
    name: "Jennifer Williams", email: "jwilliams@email.com", phone: "803-555-0215",
    area_code: "29745", message: "I work from home and have flexible hours for volunteering.",
    submission_status: :pending, created_at: 4.days.ago
  },
  {
    name: "Robert Chen", email: "rchen@email.com", phone: "803-555-0087",
    area_code: "29730", message: "I'm a teacher and care deeply about the education platform.",
    submission_status: :confirmed, created_at: 3.days.ago
  },
  {
    name: "Lisa Thompson", email: "lisa.t@email.com", phone: "803-555-0321",
    area_code: "29706", message: "Want to help with digital/social media outreach.",
    submission_status: :contacted, created_at: 2.days.ago
  },
  {
    name: "David Park", email: "dpark@email.com", phone: "803-555-0445",
    area_code: "29732", message: "Retired and ready to put in time for the campaign.",
    submission_status: :pending, created_at: 1.day.ago
  },
  {
    name: "Amanda Foster", email: "amanda.f@email.com", phone: "803-555-0567",
    area_code: "29745", message: "I have a truck and can help transport yard signs and materials.",
    submission_status: :pending, created_at: 12.hours.ago
  },
  {
    name: "James Carter", email: "jcarter@email.com", phone: "803-555-0698",
    area_code: "29706", message: "My family supports Andrew and we want to volunteer together.",
    submission_status: :confirmed, created_at: 6.hours.ago
  }
])

# Assign interests to submissions
submissions[0].interests << interests[0] << interests[1]  # Phone Banking, Canvassing
submissions[1].interests << interests[1] << interests[4]  # Canvassing, Yard Signs
submissions[2].interests << interests[2] << interests[5]  # Event Support, Data Entry
submissions[3].interests << interests[0] << interests[3]  # Phone Banking, Digital Outreach
submissions[4].interests << interests[3]                  # Digital Outreach
submissions[5].interests << interests[0] << interests[1] << interests[2]  # Phone Banking, Canvassing, Event Support
submissions[6].interests << interests[1] << interests[4]  # Canvassing, Yard Signs
submissions[7].interests << interests[1] << interests[2]  # Canvassing, Event Support

puts "Volunteer Interests: #{VolunteerInterest.count} total"
puts "Volunteer Submissions: #{VolunteerSubmission.count} total"
