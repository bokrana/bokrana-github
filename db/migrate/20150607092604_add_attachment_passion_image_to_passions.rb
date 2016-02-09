class AddAttachmentPassionImageToPassions < ActiveRecord::Migration
  def self.up
    change_table :passions do |t|
      t.attachment :passion_image
    end
  end

  def self.down
    remove_attachment :passions, :passion_image
  end
end
