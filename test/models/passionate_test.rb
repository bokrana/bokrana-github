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
#

require 'test_helper'

class PassionateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
