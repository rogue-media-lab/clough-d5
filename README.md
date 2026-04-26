# Clough for SC District 5

![Ruby](https://img.shields.io/badge/ruby-3.4.1-CC342D?logo=ruby&logoColor=white)
![Rails](https://img.shields.io/badge/rails-8.1-CC0000?logo=rubyonrails&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/postgresql-16-336791?logo=postgresql&logoColor=white)
![Tailwind CSS](https://img.shields.io/badge/tailwindcss-3.4-06B6D4?logo=tailwindcss&logoColor=white)
![Heroku](https://img.shields.io/badge/heroku-deployed-430098?logo=heroku&logoColor=white)
![License](https://img.shields.io/badge/license-proprietary-gray)

A campaign website for Andrew Clough's South Carolina District 5 race, built with Rails 8. The site features a public-facing campaign platform with issue positions, volunteer signups, news aggregation, event management, and an admin dashboard for the campaign team.

Built by [Rogue Media Lab](https://roguemedialab.com).

## Features

**Public Site**
- Campaign homepage with hero section, candidate bio, and featured issues
- Issue platform pages with rich text content, taglines, and summaries
- Volunteer signup form with interest area selection (Canvassing, Phone Banking, Yard Signs, Social Media, House Parties, Events & Rallies)
- Events listing page with upcoming and past event separation
- News aggregation page with external article links
- About page with candidate story and family
- Public news article pages with:
  - Article summary and image
  - "Andrew's Take" — campaign commentary/reflection on external articles
  - Related issues linking (campaign positions connected to the article)
  - Related articles from the same source

**Admin Dashboard**
- Comprehensive statistics dashboard with:
  - Active issues count and totals
  - News article counts (published + fetched from RSS)
  - Volunteer statistics (total, new this week, pending, confirmed)
  - Upcoming events count
  - Recent activity widgets for all entities
  - Volunteers by interest breakdown with visual bar chart
  - This week's events preview
- Issue CMS with WYSIWYG editor (Trix) for creating and editing platform positions
- News Article management:
  - Create, edit, publish, and delete articles
  - Bulk operations (publish, unpublish, delete multiple)
  - RSS feed aggregation with automatic fetching
  - Open Graph image fetching for articles
  - Link articles to campaign issues
  - Add "reflection" commentary to articles
- RSS Feed management:
  - Add/remove external news feeds
  - Toggle feeds active/inactive
  - Configure feed names and URLs
- Volunteer management:
  - Full signup management with status workflow (pending → contacted → confirmed → inactive)
  - Interest area tracking per volunteer
  - Welcome email sent tracking
  - Filter and review submissions
- Events management (CRUD):
  - Create/edit/delete events
  - Event status (upcoming/past)
  - Date, time, and location tracking
- Site Settings:
  - Key-value configuration store for site-wide settings

## Tech Stack

- **Framework:** Ruby on Rails 8
- **Language:** Ruby 3.4.1
- **Database:** PostgreSQL
- **CSS:** Tailwind CSS
- **Frontend:** Hotwire (Turbo + Stimulus)
- **Rich Text:** Action Text with Trix editor
- **Auth:** Rails built-in authentication
- **RSS Parsing:** RSS gem for feed aggregation

## Requirements

- Ruby 3.4.1
- PostgreSQL

## Local Setup

```bash
# Clone the repository
git clone git@github.com:rogue-media-lab/clough-d5.git
cd clough-d5

# Install dependencies
bundle install

# Setup the database
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

# Start the development server
bin/dev
```

The app will be available at `http://localhost:3000`.

## Seed Data

The seed file populates the database with:
- Initial volunteer interest areas
- Sample campaign issues with content

To reload issue content from the reference source:

```bash
bin/rails runner db/seeds_issues.rb
```

## Deployment

This application is deployed on Heroku.

```bash
# Create the Heroku app (first time only)
heroku create clough-d5

# Add PostgreSQL
heroku addons:create heroku-postgresql:essential-0

# Set environment variables
heroku config:set RAILS_MASTER_KEY=$(cat config/master.key)

# Deploy
git push heroku main

# Run migrations
heroku run bin/rails db:migrate

# Seed production data
heroku run bin/rails db:seed
```

## Project Structure

This project follows the Rogue Media Lab studio pattern:

```
Rogue-Media-Lab/
├── RML-Clough/clough/     # Rails application (this repo)
└── Projects/Andrew-Clough/ # Planning documents and sprint tracking
```

## Consider Improvements

1. Complex Controller Logic ("Fat Controllers")
  The Admin::NewsArticlesController#fetch_feeds method is quite large (~100 lines) and performs complex network I/O and XML parsing.
   - Recommendation: Move this logic into a Service Object (e.g., NewsArticleFetcher) or, better yet, a Background Job
     (FetchNewsFeedsJob). Performing network requests in a controller action can lead to timeouts and a poor user experience.

  2. Missing Test Implementation
  While the test/ directory is well-organized with many files, many of them are empty placeholders.
   - Recommendation: Prioritize implementing tests for:
       - Models: Validations (especially the custom unique_position in Issue) and scopes.
       - System/Integration: The volunteer submission flow and admin dashboard actions.
       - Logic: The RSS feed parsing logic (once moved to a service/job).

  3. Redundant Testing Frameworks
  The project contains both a spec/ (RSpec) and a test/ (Minitest) folder.
   - Recommendation: Commit to one framework to reduce confusion and maintain a cleaner codebase. Given that most files are in test/,
     removing the empty spec/ folder is recommended.

  4. Redundant Join Tables
  There are two join tables for volunteer interests: volunteer_interests_volunteer_submissions (likely for HABTM) and
  volunteer_submission_interests (for has_many :through).
   - Recommendation: Standardize on has_many :through with volunteer_submission_interests as it is more flexible and matches the
     current model associations. Remove the unused table.

  5. Error Handling & Robustness
  In the fetch_feeds action, the rescue block is quite broad (rescue => e).
   - Recommendation: Handle specific network errors (e.g., Timeout::Error, Errno::ECONNREFUSED) to provide better logging and
     potentially retry logic in a background job.

## Built With AI

This project was both designed and developed with the assistance of AI. The entire application — from database schema to Tailwind styling to admin dashboard — was built collaboratively between a human developer and an AI coding agent using Rails 8.

No code was blindly generated. Every feature was reviewed, tested, and refined through conversation. The AI handled boilerplate, migrations, and component structure while the human directed architecture decisions, verified designs against mockups, and shaped the final product.

This is what modern Rails development looks like: a skilled developer with an AI copilot, moving fast without cutting corners.

**AI Agent:** Hermes Agent — an open-source CLI AI assistant built for software development.

---

Proprietary — built by Rogue Media Lab for the Clough for SC campaign.
