class CreatePassions < ActiveRecord::Migration
  def up
    create_table :passions do |t|
      t.string "name", :limit => 120 , :null => false
      t.text "description"
      t.integer "passionates_num" , :limit => 8 , :default => 0
      t.boolean "visible" , :default => false
      t.string "slug"
      t.string "created_by"
      t.timestamps null: false
    end
    add_index :passions, :name, :unique => true
    add_index("passions","slug")
  end

   def down
      drop_table :passions
   end

end
