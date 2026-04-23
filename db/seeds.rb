
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