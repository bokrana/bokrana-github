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
#

require 'test_helper'

class PassionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
