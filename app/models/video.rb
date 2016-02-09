# == Schema Information
#
# Table name: videos
#
#  id            :integer          not null, primary key
#  passionate_id :integer
#  path          :string(255)
#  description   :text(65535)
#  visible       :boolean          default("1")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Video < ActiveRecord::Base

belongs_to :Passionate





end

