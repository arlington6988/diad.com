class Cart < ActiveRecord::Base
  has_many :cartitems
  serialize :items
end
