class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.integer "passionate_id"
      t.string "path" 
      t.text "description"
      t.boolean "visible" , :default => true
      t.timestamps null: false
    end
     add_index("videos","passionate_id")
  end

  def down
     drop_table :videos
  end

end
