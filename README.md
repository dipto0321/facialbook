# Facialbook

[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> Facebook clone created using Ruby On Rails. [Live Demo](https://facials.herokuapp.com)

## Table of Contents

- [Facialbook](#facialbook)
  - [Table of Contents](#table-of-contents)
  - [Motivation](#motivation)
  - [Minimum features:](#minimum-features)
  - [Installation](#installation)
  - [Usage](#usage)
  - [API](#api)
  - [Maintainers](#maintainers)
  - [Contributing](#contributing)
  - [License](#license)

## Motivation

This project is our implementation of Facebook - the world's biggest social network.

We wanted to showcase our Ruby on Rails skills with this project. Soon, we intend to also incorporate React and NextJS to deal with the frontend (and server side rendering) while converting our backend to a simple API.

## Minimum features:

1. User signup and signin (with Remember Me) and creation of Profile (with Profile picture uploading)
2. Sending, Accepting, Cancelling and Deleting (Rejecting) Friend Requests
3. Removing Friends
4. Showing a user's friends and mutual friends with other users
5. Newsfeed and Timeline
6. Posting on the newsfeed, on one's own timeline and on a friend's timeline (allows image uploading)
7. Editing and Deleting authored posts
8. Commenting on posts or other comments
9. Editing and deleting comments
10. Liking and Unliking posts and comments
11. Showing Like count

## Installation

### System Requirements:

- Ruby version of at least 2.5.3
- Rails version of at least 5.2.3
- PostgreSQL version 9 above

After cloning:

In `Gemfile` change `ruby '2.6.3'` to correspond to your system's ruby version. For `rbenv` users, run the command in the terminal: `rbenv local <your system's ruby version>`.

Run `bundle update` to install the latest version of the gems in the `Gemfile`.

Run in the terminal:

```ruby
EDITOR="<your default code editor> --wait" rails credentials:edit
```

This will fire up a `XYZ.credentials.yml
file. In this file edit the following:

```ruby
pg_credentials:
  username: <your local postgreSQL username>
  password: <corresponding password>

fb_api:
  app_id: <your FB APP ID>
  app_secret: <your FB APP SECRET>
```

Then save and close this file. It will generate a `master.key` file.

Configure database by running `rails db:setup` -> creates the `development` and `test` databases and seeds the application.

## Usage

### Development Server:

```
rails server
```

Then goto `http:\\localhost:3000`

### Testing:

Simply run

```ruby
rspec
```

## Production

If using Heroku, make sure you have an existing heroku app for this or run:

```ruby
heroku create <app name>
```

to create an app in Heroku and add heroku as a remote.

In Heroku app settings click on Reveal Config Vars then add the following fields (along with their values in your credentials):

```
FB_APP_ID
FB_APP_SECRET
RAILS_MASTER_KEY
```

Then in your local terminal run:

```ruby
heroku run rails db:migrate && heroku run rails db:seed
```

## Maintainers

[@Ryan](https://github.com/rvvergara) and [@Dipto](https://github.com/dipto0321)

## Contributing

Contact maintainers for contribution instructions.

Small note: If editing the README, please conform to the [standard-readme](https://github.com/RichardLitt/standard-readme) specification.

## License

ryto © 2019 Ryan and Dipto
