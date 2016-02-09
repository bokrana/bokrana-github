# == Schema Information
#
# Table name: passionates
#
#  id                        :integer          not null, primary key
#  email                     :string(80)       not null
#  hashed_password           :string(255)
#  salt_password             :string(255)
#  name                      :string(255)      not null
#  description               :text(65535)
#  phone                     :string(20)
#  website                   :string(255)
#  facebook_page             :string(255)
#  facebook_personal_profile :string(255)
#  twitter                   :string(255)
#  skype                     :string(255)
#  youtube                   :string(255)
#  price                     :integer
#  discount                  :integer
#  lock                      :boolean          default("0")
#  activate                  :boolean          default("0")
#  activate_url              :string(255)
#  recommend_num             :integer          default("0")
#  views_num                 :integer          default("0")
#  slug                      :string(255)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null

#=========================================

class Passionate < ActiveRecord::Base
include ActiveModel::Validations

#=========================================
   has_paper_trail
   
   has_many :photos
   has_many :videos
   has_many :passion_passionates
   has_many :passion , :through => :passion_passionates

   attr_accessor :password
   EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i


   acts_as_url :name , :url_attribute => :slug
   

#========================================
  has_attached_file :profile_image, :styles => { :medium => "300x300>", :thumb => "48x48>" ,:mini => "92x92"}, :default_url => "/assets/no-profile-image.jpg"
  validates_attachment_content_type :profile_image, :content_type => /^image\/(png|jpeg|jpg)/
validates_attachment_size :profile_image, :less_than => 2.megabytes
#=========================================
validates :name ,  :presence => true , 
                           :words => {:message => nil}, 
                            :length => {:within => 2..120}

validates :email,     :presence => true,
                      :length => {:within => 6..60},
                      :uniqueness => {case_sensitive: false},
                      :format => {:with => EMAIL_REGEX}       

validates :password,  :presence => true,
                      :length => {:within => 6..60},
                      :confirmation => true,
                    :if => :password_required?

validates  :twitter,:facebook_personal_profile,:facebook_page,:youtube,:website,
                      :allow_blank => true , 
                      :format => URI::regexp(%w(http https))

validates :description,
                      :words => {:message => nil},
                     :length => { maximum: 2500 }
 

  before_save :encrypt_new_password
  after_save :clear_password
  

#=================================================

def self.authenticate(email, password)
  passionate = find_by_email(email)
  return passionate if passionate && passionate.authenticated?(password)
end

def authenticated?(password)
  self.hashed_password == Passionate.encrypt(password,salt_password)
end

#===============================================
#protected method --- Aiman
protected
def encrypt_new_password
  return if password.blank?
  self.salt_password = Passionate.make_salt(email) if salt_password.blank?
  self.hashed_password = Passionate.encrypt(password,salt_password)
end

def password_required?
  hashed_password.blank? || password.present?
end

def self.make_salt(email="")
  Digest::SHA1.hexdigest("use #{email} with #{Time.now} to make salt")
end

def self.encrypt(password="",salt="")
  Digest::SHA1.hexdigest("put #{salt} on the #{password}")
end

def clear_password
  self.password = nil
end


def self.search(search)
  if search
     search = search.downcase
     #scope :proname, where('lower(name) LIKE ?' , "%#{search}%")
    where('lower(name) LIKE ?' ,"%#{search}%")
  else    
      scoped  
  end
end


end
