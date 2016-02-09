class PassionPassionate < ActiveRecord::Base
include ActiveModel::Validations

belongs_to :passion
belongs_to :passionate
#========================================= 

validates_uniqueness_of :passion, :scope => :passionate , :message => "you are aleady join this passion" 

validates :discount ,
                      :allow_blank => true ,
                      :length => {:within => 0..2} ,
                      :format => {:with => /(\A[0-9])([0-9]?)\z/ }
 













end
