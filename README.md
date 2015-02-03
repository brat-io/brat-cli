# Brat

[website](http://brat.io/brat-io/brat)

[![Gem Version](https://badge.fury.io/rb/brat.svg)](http://badge.fury.io/rb/brat) [![build status](http://ci.brat.io/projects/7/status.png?ref=master)](http://ci.brat.io/projects/7?ref=master)

Brat is a wrapper and CLI for [Brat.io](http://brat.io/brat-io/brat). We are currently in pre-release.

## Installation

Install it from rubygems:

```sh
gem install brat
```

Or add to a Gemfile:

```ruby
gem 'brat'
# gem 'brat', :git => 'http://brat.io/brat-io/brat.git'
```

## Usage

Rails Configuration example:

```ruby
Brat.configure do |config|
  config.private_token  = 'qEsq1pt6HJPaNciie3MG'       # user's private token, default: ENV['BRAT_API_PRIVATE_TOKEN']
  # Optional
  # config.endpoint     = 'http://brat.io/api/v3'      # API endpoint URL, default: 'http://brat.io/api/v3'
  # config.user_agent   = 'Custom User Agent'          # user agent, default: 'Brat Ruby Gem [version]'
  # config.sudo         = 'user'                       # username for sudo mode, default: nil
end
```

Usage examples:

```ruby
# set a user private token
Brat.private_token = 'qEsq1pt6HJPaNciie3MG'
# => "qEsq1pt6HJPaNciie3MG"

# list projects
Brat.projects(:per_page => 5)
# => [#<Brat::ObjectifiedHash:0x000000023326e0 @data={"id"=>1, "code"=>"brute", "name"=>"Brute", "description"=>nil, "path"=>"brute", "default_branch"=>nil, "owner"=>#<Brat::ObjectifiedHash:0x00000002331600 @data={"id"=>1, "email"=>"john@example.com", "name"=>"John Smith", "blocked"=>false, "created_at"=>"2012-09-17T09:41:56Z"}>, "private"=>true, "issues_enabled"=>true, "merge_requests_enabled"=>true, "wall_enabled"=>true, "wiki_enabled"=>true, "created_at"=>"2012-09-17T09:41:56Z"}>, #<Brat::ObjectifiedHash:0x000000023450d8 @data={"id"=>2, "code"=>"mozart", "name"=>"Mozart", "description"=>nil, "path"=>"mozart", "default_branch"=>nil, "owner"=>#<Brat::ObjectifiedHash:0x00000002344ca0 @data={"id"=>1, "email"=>"john@example.com", "name"=>"John Smith", "blocked"=>false, "created_at"=>"2012-09-17T09:41:56Z"}>, "private"=>true, "issues_enabled"=>true, "merge_requests_enabled"=>true, "wall_enabled"=>true, "wiki_enabled"=>true, "created_at"=>"2012-09-17T09:41:57Z"}>, #<Brat::ObjectifiedHash:0x00000002344958 @data={"id"=>3, "code"=>"brat", "name"=>"Brat", "description"=>nil, "path"=>"brat", "default_branch"=>nil, "owner"=>#<Brat::ObjectifiedHash:0x000000023447a0 @data={"id"=>1, "email"=>"john@example.com", "name"=>"John Smith", "blocked"=>false, "created_at"=>"2012-09-17T09:41:56Z"}>, "private"=>true, "issues_enabled"=>true, "merge_requests_enabled"=>true, "wall_enabled"=>true, "wiki_enabled"=>true, "created_at"=>"2012-09-17T09:41:58Z"}>]

# initialize a new client
g = Brat.client(:endpoint => 'https://brat.io/api/v3', private_token: 'qEsq1pt6HJPaNciie3MG')
# => #<Brat::Client:0x00000001e62408 @endpoint="https://brat.io/api/v3", @private_token="qEsq1pt6HJPaNciie3MG", @user_agent="Brat Ruby Gem 0.1.1">

# get a user
user = g.user
# => #<Brat::ObjectifiedHash:0x00000002217990 @data={"id"=>1, "email"=>"john@example.com", "name"=>"John Smith", "bio"=>nil, "skype"=>"", "linkedin"=>"", "twitter"=>"john", "dark_scheme"=>false, "theme_id"=>1, "blocked"=>false, "created_at"=>"2012-09-17T09:41:56Z"}>

# get a user's email
user.email
# => "john@example.com"

```

## CLI

Usage examples:

```sh
# set your private_token
# list users
brat users

# get current user
brat user

# get a user
brat user 2

# filter output
brat user --only=id,username

brat user --except=email,bio
```

## CLI Shell

Usage examples:

```sh
# start shell session
brat shell

# list available commands
brat> help

# list groups
brat> groups

# protect a branch
brat> protect_branch 1 master
```

## License

Released under the BSD 2-clause license. See LICENSE.txt for details.
