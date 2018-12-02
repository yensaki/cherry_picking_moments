# Description

This generates uniquish images from a movie file.

# Usage

1. Install python
    ```basb
    CONFIGURE_OPTS="--enable-shared" pyenv install 3.7.1
    ```
2. Install imagehash from pip
    ```bash
    pip install ImageHash
    ```
3. gem install this
    ```
    # Gemfile
    gem 'cherry_picking_moments', github: 'yensaki/cherry_picking_moments'
    ```
    ```ruby
    bundle install
    ```
3.  in Ruby
    ```ruby
    require 'cherry_picking_moments'
    CherryPickingMoments.uniquish!('/path/to/a/movie.mp4', '/path/to/pictures/dir')
    ```
