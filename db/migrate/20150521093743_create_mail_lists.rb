class CreateMailLists < ActiveRecord::Migration
  def up
    create_table :mail_lists do |t|
       t.string "email" , :limit => 60 ,:null => false
       t.boolean "active" , :default => true
      t.timestamps null: false
    end
   add_index :mail_lists, :email, :unique => true
  end

def down
    drop_table :mail_lists
  end


end
