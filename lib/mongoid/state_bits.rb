require "mongoid/state_bits/version"

# class Post
#   include Mongoid::Document
#   include Mongoid::StateBits
#   state_bits %w{public commentable original}
# end
# =====================================

module Mongoid
  module StateBits
    
    extend ActiveSupport::Concern

    included do
      field :state_bits, type: Integer, default: 0
      index :state_bits => -1
    end
    
    module ClassMethods
      def state_bits(bits)
        bits.each_with_index do |bit, index|
          define_method "#{bit}=" do |bool|
            if bool
              self.state_bits |= 2**index
            else
              self.state_bits -= (self.state_bits & 2**index)
            end
          end
          define_method "#{bit}?" do
            self.state_bits & 2**index != 0
          end
          alias_method("#{bit}", "#{bit}?")
          # then define scopes
          scope bit, ->{ where("this.state_bits & #{2**index}")}
          scope "non#{bit}", ->{ where("this.state_bits & #{2**index} == 0")}
        end
      end
    end #ClassMethods

  end
end
