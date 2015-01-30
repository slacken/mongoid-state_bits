# Mongoid::StateBits

When making the database design, we often need to add a lot of Boolean type field, such as whether to open an article, whether to allow comments, whether original and so on. When only a Boolean field, direct statement of Boolean type is OK; When there are a lot of field, it is clear eleven declarations harm than good, a waste of space and will bring a lot of duplicate code.

A common solution is that these boolean field are integrated into an integer field, a binary bit represents a Boolean field. For an article, if 1 (the first bit) means open, 2 (second bit) means commentable, 4 means original, then an open, commentable, original article was marked as 7 (1 +2 +4), open, does not allow comments, original articles marked as 5 (1 +0 +4). field can be marked with an integer instead of multiple Boolean attributes, obviously it is good, but doing so will cause inconvenience on code management. For a programmer, dealing directly with these flag bits will be a headache, and such code does not look elegant.

Mongoid::StateBits provides an elegant way to manage such situation.

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
      state_bits %w{deleted commentable original}
    end

Three state_bits statement of three boolean field will generate three methods for each one,  commentable()/commentable?()/commentable=() in `commentable` case, and also generate a `scope` corresponding to each field.

If you need to add field, just push it on to the end of this array %w{deleted commentable original}, the default value of all field ​​is false(Boolean).

Now(v0.2.0) it supports default values:

    class Post
      include Mongoid::Document
      include Mongoid::StateBits
      state_bits deleted:false, commentable: true,  original: true
    end

v0.3.0 supports multiple selector:
    
    Post.state(deleted: true, original: false)

## Contributing

1. Fork it ( http://github.com/Slacken/mongoid-state_bits/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
