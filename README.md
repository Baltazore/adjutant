# Adjutant

Simply gem that helps to parse git patch data and find 'usefull' comments.

## Installation

Add this line to your application's Gemfile:

    gem 'adjutant'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install adjutant

## Usage

This gem consists of 4 simple parts:

- ```Parser``` that parse all patch data for commits, pusher nickname, and repository name
- ```FileParser``` to find comments in commited patch data for file
- ```Line``` and ```Comment``` classes to store and get comments data

Example of simple usage:
```ruby
@parser = Adjutant::Parser.new(payload_patch_data)
@parser.repo_name             #=> 'adjutant'
@parser.commiter_nickname     #=> 'Baltazore'
@parser.commits_sha           #=> [ 'asdw23a', 'qwes12e', ... ]

commited_changes_per_files do |file|
  comments = Adjutant::FileParser.new(file).detect_comments
  comments          #=> [ '@Baltazore pay more attention to this changes', ... ]
end
```

## Contributing

1. Fork it ( http://github.com/Baltazore/adjutant/fork )
2. Create your feature branch (`git checkout -b feature/awesome-stuff`)
3. Commit your changes (`git commit -am 'Add awesome feature'`)
4. Push to the branch (`git push origin feature/awesome-stuff`)
5. Create new Pull Request
