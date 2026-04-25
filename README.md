# Clough for SC District 5

A campaign website for Andrew Clough's South Carolina District 5 race, built with Rails 8. The site features a public-facing campaign platform with issue positions, volunteer signups, news aggregation, event management, and an admin dashboard for the campaign team.

Built by [Rogue Media Lab](https://roguemedialab.com).

## Features

**Public Site**
- Campaign homepage with hero section, candidate bio, and featured issues
- Issue platform pages with rich text content, taglines, and summaries
- Volunteer signup form with interest area selection (Canvassing, Phone Banking, Yard Signs, Social Media, House Parties, Events & Rallies)
- Events listing page
- News aggregation page
- About page with candidate story and family

**Admin Dashboard**
- Issue CMS with WYSIWYG editor (Trix) for creating and editing platform positions
- Volunteer submission management with status tracking
- Volunteer interest area management
- Campaign statistics dashboard

## Tech Stack

- **Framework:** Ruby on Rails 8
- **Language:** Ruby 3.4.1
- **Database:** PostgreSQL
- **CSS:** Tailwind CSS
- **Frontend:** Hotwire (Turbo + Stimulus)
- **Rich Text:** Action Text with Trix editor
- **Auth:** Rails built-in authentication

## Requirements

- Ruby 3.4.1
- PostgreSQL
- Node.js (for Importmap/Stimulus)

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

## License

Proprietary — built by Rogue Media Lab for the Clough for SC campaign.
