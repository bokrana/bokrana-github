class AddAttachmentProfileImageToPassionates < ActiveRecord::Migration
  def self.up
    change_table :passionates do |t|
      t.attachment :profile_image
    end
  end

  def self.down
    remove_attachment :passionates, :profile_image
  end
end
