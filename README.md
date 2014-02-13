# Mongoid::StateBits

When making the database design, we often need to add a lot of Boolean type field, such as whether to open an article, whether to allow comments, whether original and so on. When only a Boolean field, direct statement of Boolean type is OK; When there are a lot of fields, it is clear eleven declarations harm than good, a waste of space and will bring a lot of duplicate code.

A common practice is to these boolean fields are integrated into an integer field, a binary bit represents a Boolean field. For an article, if 1 (the first bit) means open, 2 (second bit) means commentable, 4 means original, then an open, commentable, original article was marked as 7 (1 +2 +4), open, does not allow comments, original articles marked as 5 (1 +0 +4). Fields can be marked with an integer instead of multiple Boolean attributes, obviously it is good, but doing so will cause inconvenience on code management. For a programmer to deal directly with these flag bits will be a headache, and such code does not look elegant.

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid-state_bits'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-state_bits

## Usage
Use the follwing code:

    class Post
      include Mongoid::Document
      include Mongoid::StateBits
      state_bits %w{public commentable original}
    end

Then the Post model has three new fields
## Contributing

1. Fork it ( http://github.com/<my-github-username>/mongoid-state_bits/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
