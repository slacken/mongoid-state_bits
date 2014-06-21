require 'mongoid'
require 'mongoid/state_bits'

class Post
  include Mongoid::Document
  include Mongoid::StateBits
  state_bits %w{deleted commentable original}
end

class User
  include Mongoid::Document
  include Mongoid::StateBits
  state_bits admin: true, deleted: false
end

describe Mongoid::StateBits do 
  it "should generate specified fields" do
    p = Post.new
    p.commentable.should be_false
    p.commentable = true
    p.commentable.should be_true
  end

  it "state_bits field sholud record state bits" do
    p = Post.new
    p.original = true
    p.commentable = false
    p.deleted = true
    p.state_bits.should eq(5)
  end

  it "supports default value definition" do
    u = User.new
    u.admin.should be_true
    u.deleted.should be_false
  end
end