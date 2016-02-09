class CreatePhotos < ActiveRecord::Migration
  def up
    create_table :photos do |t|
      t.integer "passionate_id"
      t.string "path" 
      t.text "description"
      t.boolean "visible" , :default => true
      t.boolean "profile_photo" , :default => false
      t.timestamps null: false
    end
    add_index("photos","passionate_id")
  end

  def down
   drop_table :photos
  end
 
end
