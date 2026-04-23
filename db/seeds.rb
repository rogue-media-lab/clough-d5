
# Events
Event.destroy_all
Event.create!([
  {
    title: "Campaign Kickoff Rally",
    description: "Join us for the official campaign kickoff! Food, drinks, and conversation.",
    date: DateTime.now + 15.days,
    location: "Rock Hill Convention Center",
    status: :upcoming
  },
  {
    title: "Town Hall Meeting",
    description: "An open town hall where you can ask Andrew anything about his platform.",
    date: DateTime.now + 22.days,
    location: "York County Library",
    status: :upcoming
  },
  {
    title: "Community Picnic",
    description: "Bring the family for a casual afternoon of food and fellowship.",
    date: DateTime.now + 42.days,
    location: "Chester State Park",
    status: :upcoming
  },
  {
    title: "Coffee with Clough",
    description: "Casual coffee shop meetup. Come say hi and learn more about the campaign.",
    date: DateTime.now + 49.days,
    location: "Brew & Bloom, Rock Hill",
    status: :upcoming
  },
  {
    title: "Campaign Announcement",
    description: "Andrew officially announced his candidacy for SC District 5.",
    date: DateTime.now - 10.days,
    location: "Fountain Park, Rock Hill",
    status: :past
  }
])
puts "Events: #{Event.count} total"