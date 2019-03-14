# Facialbook

[![standard-readme compliant](https://img.shields.io/badge/standard--readme-OK-green.svg?style=flat-square)](https://github.com/RichardLitt/standard-readme)

> Facebook clone created using Ruby On Rails. [Live Demo](https://facials.herokuapp.com)

## Table of Contents

- [Facialbook](#facialbook)
  - [Table of Contents](#table-of-contents)
  - [Minimum features:](#minimum-features)
  - [Security](#security)
  - [Background](#background)
  - [Install](#install)
  - [Usage](#usage)
  - [API](#api)
  - [Maintainers](#maintainers)
  - [Contributing](#contributing)
  - [License](#license)

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

## Security

## Background

Database used: Postgresql
Test Suite used: RSpec

Other major gems used:

- Devise
- Bootstrap for the frontend
- SASS for custom styles
- Faker for generating fake data (user, posts, comments, likes)
- Simple form for all forms
- Carrierwave for image uploading feature
- FactoryBot for generating spec data

## Install

- After cloning, run:

```
touch config/application.yml
```

- And then inside this newly created file include the following lines:

```
DB_USERNAME: <type your own username here>
DB_PASSWORD: <type your corresponding password here>
```

## Usage

```

```

## API

## Maintainers

[@Ryan](https://github.com/rvvergara) and [@Dipto](https://github.com/dipto0321)

## Contributing

[Ryan](https://github.com/rvvergara) and [Dipto](https://github.com/dipto0321)

Small note: If editing the README, please conform to the [standard-readme](https://github.com/RichardLitt/standard-readme) specification.

## License

ryto © 2019 Ryan and Dipto
