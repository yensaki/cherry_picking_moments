# CherryPickingMoments

This generates uniquish images from a movie file.

## Installation

1. Install python
    ```basb
    CONFIGURE_OPTS="--enable-shared" pyenv install 3.7.1
    ```
2. Install imagehash from pip
    ```bash
    pip install ImageHash
    ```

3. gem install this

Add this line to your application's Gemfile:

```ruby
gem 'cherry_picking_moments', github: 'yensaki/cherry_picking_moments'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cherry_picking_moments

# Usage

```ruby
require 'cherry_picking_moments'
CherryPickingMoments.uniquish!('/path/to/a/movie.mp4', '/path/to/pictures/dir')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cherry_picking_moments.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
