require "mongoid/state_bits/version"

# class Post
#   include Mongoid::Document
#   include Mongoid::StateBits
#   state_bits %w{public commentable original}
#or state_bits public: true, commentable: false
# end
# =====================================

module Mongoid
  module StateBits
    extend ActiveSupport::Concern

    included do      
      index :state_bits => -1
    end
    
    module ClassMethods
      def state_bits(params)
        if params.is_a? Array
          bits = params
          default = 0
        elsif params.is_a? Hash
          bits = params.keys
          default = bits.each_with_index.inject(0){|sum, vi| sum + (params[vi[0]] ? 2**vi[1] : 0)}
        else
          raise "Invalid state_bits params: should be Array or Hash"
        end
        # declare the field
        field :state_bits, type: Integer, default: default
        # define methods
        bits.each_with_index do |bit, index|
          define_method "#{bit}=" do |bool|
            if bool
              self.state_bits |= 2**index
            else
              self.state_bits -= (self.state_bits & 2**index)
            end
          end
          define_method bit do
            self.state_bits & 2**index != 0
          end
          alias_method "#{bit}?", "#{bit}"
          # then define scopes
          scope bit, ->{ where("this.state_bits & #{2**index}")}
          scope "non#{bit}", ->{ where("this.state_bits & #{2**index} == 0")}
        end
      end
    end #ClassMethods

  end
end
