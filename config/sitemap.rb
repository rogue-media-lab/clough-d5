# frozen_string_literal: true

# Sitemap configuration for Clough for SC5
# Run: rails sitemap:generate
# This creates public/sitemap.xml

SitemapGenerator::Sitemap.default_host = "https://cloughforsc5.com"
SitemapGenerator::Sitemap.compress = false
SitemapGenerator::Sitemap.create do
  # Static pages — highest priority
  add root_path, changefreq: "daily", priority: 1.0
  add about_path, changefreq: "monthly", priority: 0.9
  add issues_path, changefreq: "weekly", priority: 0.9
  add volunteer_path, changefreq: "monthly", priority: 0.8
  add events_path, changefreq: "weekly", priority: 0.8
  add news_path, changefreq: "daily", priority: 0.8

  # Individual issue pages
  Issue.active.find_each do |issue|
    add issue_path(issue), changefreq: "weekly", priority: 0.8
  end

  # Individual event pages
  Event.find_each do |event|
    add event_path(event), changefreq: "monthly", priority: 0.6
  end

  # Published news articles
  NewsArticle.published.find_each do |article|
    add news_article_path(article), changefreq: "monthly", priority: 0.6
  end

  # Blog posts
  Post.published.find_each do |post|
    add post_path(post), changefreq: "monthly", priority: 0.5
  end
end
