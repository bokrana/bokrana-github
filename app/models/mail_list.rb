class MailList < ActiveRecord::Base

EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

validates :email,     :presence => true,
                      :length => {:within => 6..60},
                      :uniqueness => true,
                      :format => {:with => EMAIL_REGEX}  

end
