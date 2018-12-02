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
3. run ruby with target movie filepath and dir_path
    ```bash
    bundle exec ruby ./lib/main.rb /path/to/a/movie.mp4 /path/to/pictures
    ```
