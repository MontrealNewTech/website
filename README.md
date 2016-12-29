# README
[![CircleCI](https://circleci.com/gh/MontrealNewTech/website/tree/master.svg?style=shield)](https://circleci.com/gh/MontrealNewTech/website/tree/master)
[![codecov](https://codecov.io/gh/MontrealNewTech/website/branch/master/graph/badge.svg)](https://codecov.io/gh/MontrealNewTech/website)
[![Code Climate](https://codeclimate.com/github/MontrealNewTech/website/badges/gpa.svg)](https://codeclimate.com/github/MontrealNewTech/website)
[![Dependency Status](https://gemnasium.com/badges/github.com/MontrealNewTech/website.svg)](https://gemnasium.com/github.com/MontrealNewTech/website)

# Read Me

This is the website for Montreal New Tech. It's still in development and everyone is welcome to contribute! The public-facing part shows our upcoming events, community news, and some information about what we do and who we are. Behind the scenes it allows for organizers to manage and plan events. Everybody is welcome and encouraged to contribute. This can be a great way to get your feet wet with contributing to a live open-source project! Feel free to [come out to our meetups](https://www.meetup.com/mtlnewtech/) if you have any questions, need some help getting started, or just want to meet some friendly people.

# Contributing

We love contributions! The first thing to check are the Issues with the [priority](https://github.com/MontrealNewTech/website/labels/priority) label. You can also optionally use [Zenhub](https://www.zenhub.com/) to see the development pipeline and issue boards and pick any issue from the "Next Up" column. When you start working on an issue, let everyone else know somehow (move the issue to the "In Progress" column in Zenhub, add the "in progress" label, or even just leave a comment saying "Got this one!"), so that we don't end up with two people developing the same feature at the same time.

Anybody is welcome to submit a pull request. See below on how to set up your machine for development and how our development process works. Once you have the app up and running, run the tests (`rspec`) and make sure they pass. Then write some specs and add your changes. Make the tests pass again. Then push to your fork and [submit a pull request](https://github.com/MontrealNewTech/website/compare/). Then, you'll be waiting on us. We try to at least comment on all pull requests within a couple of days. We might suggest some changes or improvements or alternatives. Some things you can do to increase the chances of your pull request being accepted are:
- Make sure everything is tested
- Follow the style and standards of the project
- Write a [good commit message](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)
- Discuss major features or changes before deciding on a final approach

Github also has tons of great guides ([like this one on working on your own fork of a repo](https://guides.github.com/activities/forking/)) about working with git and open source projects.

## Style Guides
This codebase is monitored by [hound CI](https://houndci.com/), which automatically comments on style violations. We follow community style guides for [ruby](https://github.com/bbatsov/ruby-style-guide), [Rails](https://github.com/bbatsov/rails-style-guide), [Sass](http://sass-lang.com/styleguide), [es6](https://github.com/airbnb/javascript#ecmascript-6-es-2015-styles), and [erb](https://github.com/thoughtbot/guides/tree/master/style/erb). If your pull request has some comments by the hound, please fix those to speed up the review process.

# Development Setup

Fork the repository and clone it to your machine then change directory into `website`. Rename it if you want to.
```bash
git clone git@github.com:***your-github-username***/website.git && cd website
```

## Database

This project uses Postgresql, a free and open-source database. Google the instructions on how to install it for your operating system if you run in to any problems.

On a mac you can run:
```bash
brew install postgresql
```

Or on linux distro:
```bash
apt-get install postgresql
```

There are also [various postgresql installers available for Windows](https://www.postgresql.org/download/windows/).

Background jobs are queued with Sidekiq, which uses Redis, a free and open-source NoSQL database to keep track of jobs. You'll need to install Redis. Google the installation instructions for your operating system if you run in to any problems.

On a mac you can run:
```bash
brew install redis
```

When installing Redis on Ubuntu, make sure the config file is installed in `/usr/local/etc/redis.conf` instead of the default location. Creating a symlink seems to work as well.

## Ruby version

The project currently uses ruby `2.3.2`. You can install many versions of Ruby on your machine with a ruby environment manager. Two common ones are [rbenv](https://github.com/rbenv/rbenv) and [rvm](https://rvm.io/).

### Libraries

External depenencies are managed with [bundler](http://bundler.io/). It will be installed when you run the `bin/setup` script, or if you're setting up your environment by yourself you can install it manually:
```ruby
gem install bundler
```

### Rails

The project is built with Rails, a stable and mature web framework. If you're unfamiliar with it there are tons of great tutorials out there, like [Michael Hartl's Rails tutorial](https://www.railstutorial.org/book), or you can check out the great documentation on [RailsGuides](http://guides.rubyonrails.org/).

## Setup the project

### Setting environment variables

We use cloudinary for image hosting. You can sign up for a [free cloudinary account](https://cloudinary.com/users/register/free) to get API keys for your local development and testing environments. You need to set the `CLOUDINARY_API_KEY` and `CLOUDINARY_API_SECRET` environment variables.

The community events are pulled from our community google calendar. You need to set the `GOOGLE_CALENDAR_API_KEY` environment variable. To access the google calendar api you need [a google api key, which you can get here](https://console.developers.google.com/apis/credentials).

Our events are pulled from eventbrite. You need to set the `EVENTBRITE_API_TOKEN` environment variable. To access eventbrite's api you need [an eventbrite api key, which you can get according to these instructions](https://www.eventbrite.com/support/articles/en_US/How_To/how-to-locate-your-eventbrite-api-user-key?lg=en_US#5).

Your environment variables should be the following:

```bash
CLOUDINARY_API_KEY=
CLOUDINARY_API_SECRET=
GOOGLE_CALENDAR_API_KEY=
EVENTBRITE_API_TOKEN=
```

This project uses the `dotenv` gem, so you just put these environment variables in a `.env` file in the root of the project and they will available to the Rails environment. Be sure to add this file to your `.gitignore` and never check it in to version control.

### Launch your database server

You need to start your postgres server, redis server, and Sidekiq worker (if you want to process background jobs in development). You can launch these services and leave them running on your machine, or automate the process for manually starting all of them with a tool like [foreman](https://github.com/ddollar/foreman).

### Setting up the project

Once you have the above dependencies installed and your database server is running, setup the project with

```bash
bin/setup
```

This script runs the following commands to set up your local development environment:
- install `bundler` for managing gem dependencies
- install all required gems
- create and setup your databse
- cleanup logs and temporary files

You can also run those steps manually.

### Starting your server

Start your local server. You can run a local server with:
```
rails server
```
Unless you configure a different local host the app will be available at [http://localhost:3000](http://localhost:3000).

## Developing a feature and submitting a pull request

In your pull request and in your branch name, specify the number of the issue you're working on. This way github will [automatically close the issue(s)](https://github.com/blog/1506-closing-issues-via-pull-requests) once the pull request has been merged.

## Testing

The app is tested with RSpec. You can run all the tests with
```bash
rspec
```

Run a single test file by passing only the test file, or a single test example by passing the test file with the line of the test you want to run:
```bash
rspec spec/path/to/your/spec.rb
rspec spec/path/to/your/spec.rb:8  # 8 is the line number of the test you want to run.
```

I recommend using [zeus](https://github.com/burke/zeus), an external gem, to pre-load the app so your tests run instantly.

# Bugs
If you find any bugs please [open an issue](https://github.com/MontrealNewTech/website/issues) in project's repo.

# License
This app is released under the [MIT License](https://github.com/pitonneux/website/blob/master/LICENSE).
