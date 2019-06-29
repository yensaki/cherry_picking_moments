# CherryPickingMoments

[![Build Status](https://travis-ci.org/yensaki/cherry_picking_moments.svg?branch=master)](https://travis-ci.org/yensaki/cherry_picking_moments)

This generates uniquish images from a movie file.

## Installation

1. Install ffmpeg
1. Install python
    ```
    $ CONFIGURE_OPTS="--enable-shared" pyenv install 3.7.1
    ```
1. Install imagehash from pip
    ```
    $ pip install ImageHash
    ```

1. gem install this
Add this line to your application's Gemfile:
    ```ruby
    gem 'cherry_picking_moments', github: 'yensaki/cherry_picking_moments'
    ```
And then execute:
```
$ bundle
```

Or install it yourself as:

    $ gem install cherry_picking_moments

# Usage

You can get sliced images of a movie.  
Their images have hamming_distance compared with next index image.

```ruby
movie = CherryPickingMoments.movie('/path/to/a/movie.mp4')
images = movie.images
images.map(&:following_distance)
# => [12, 6, 8, 18, 14, 20, 26, 20, 20, 26, 8, nil]
images.map(&:filepath)
# =>  ['/path/to/0001.png', '/path/to/0002.png', '/path/to/0003.png', ..., '/path/to/0012.png']
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/cherry_picking_moments.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
