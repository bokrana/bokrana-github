# == Schema Information
#
# Table name: photos
#
#  id            :integer          not null, primary key
#  passionate_id :integer
#  path          :string(255)
#  description   :text(65535)
#  visible       :boolean          default("1")
#  profile_photo :boolean          default("0")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Photo < ActiveRecord::Base

belongs_to :Passionate


end
