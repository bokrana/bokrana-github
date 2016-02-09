class CreatePassionPassionates < ActiveRecord::Migration
  def up
    create_table :passion_passionates do |t|
      t.references :passion
      t.references :passionate
      t.integer "price_from" , :limit => 8 , :default => 0
      t.integer "price_to" , :limit => 8 , :default => 0
      t.integer "discount" , :limit => 4 , :default => 0
      t.text "note"
      t.timestamps null: false
    end
    add_index :passion_passionates , ["passion_id","passionate_id"], :unique => true
  end

def down
     drop_table :passion_passionates
  end



end
