# == Schema Information
#
# Table name: passions
#
#  id              :integer          not null, primary key
#  name            :string(120)      not null
#  description     :text(65535)
#  passionates_num :integer          default("0")
#  photo           :string(255)      default("no_image")
#  visible         :boolean          default("0")
#  slug            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#============================================

class Passion < ActiveRecord::Base
include ActiveModel::Validations

has_paper_trail

has_many :passion_passionates , :dependent => :destroy
has_many :passionates , :through => :passion_passionates
#======================================
 acts_as_url :name , :url_attribute => :slug
#=====================================
  has_attached_file :passion_image, :styles => { :medium => {:geometry => "220x160!" ,:quality => 100 ,:format => 'jpg'}, :thumb => "48x48!" ,:mini => "92x92!"}, :default_url => "/assets/no-passion-image.jpg" , :path => ":rails_root/public/system/:class/:id/:style/:basename.:extension" , :url => "/system/:class/:id/:style/:basename.:extension"
   validates :passion_image, attachment_presence: true
  validates_attachment_content_type :passion_image, :content_type => /^image\/(png|jpeg|jpg)/
  validates_attachment_size :passion_image, :less_than => 3.megabytes
  before_create :change_image_name
#=========================================

validates  :passion_image ,  :presence => true

validates :name,
            :presence => true,
            :uniqueness => true 
            
validates :description,
                  :length => { maximum: 2500 }


validates :description,:name ,
                      :words => {:message => nil}






protected

def self.search(search)
  if search
     search = search.downcase
     #scope :proname, where('lower(name) LIKE ?' , "%#{search}%")
    where('lower(name) LIKE ?' ,"%#{search}%")
  else    
      scoped  
  end
end



def self.autocomplete(search)
  if search
     search = search.downcase
     #scope :proname, where('lower(name) LIKE ?' , "%#{search}%")
    #where('lower(name) LIKE ? or description LIKE ?' ,"%#{search}%","%#{search}%")
  find_by_sql("select name ,id, passionates_num , passion_image_file_name  ,  'passion' as 'table' from passions where lower(name) like '%#{search}%' UNION ALL
                         select name , id , recommend_num , profile_image_file_name , 'passionate' as 'table' from passionates where lower(name) like '%#{search}%' LIMIT 10")|| ''
  else  
      scoped  
  end
end

private

def change_image_name
extension = File.extname(passion_image_file_name).downcase
    self.passion_image.instance_write(:file_name, "#{self.slug}#{extension}")
end

end
