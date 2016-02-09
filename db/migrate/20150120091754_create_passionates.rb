class CreatePassionates < ActiveRecord::Migration
  def up
    create_table :passionates do |t|
      t.string "email" , :limit => 60 ,:null => false
      t.string "hashed_password"
      t.string "salt_password"
      t.string "name"  , :null => false
      t.text "description" 
      t.string "phone" , :limit => 20
      t.string "website"
      t.string "facebook_page"
      t.string "facebook_personal_profile"
      t.string "twitter"
      t.string "skype"
      t.string "youtube"
      t.boolean "lock" , :default =>  false
      t.boolean "activate" , :default => false
      t.string "activate_url"
      t.integer "recommend_num" , :default => 0
      t.integer "views_num" , :default => 0
      t.string "slug"
      t.timestamps null: false
    end
    add_index :passionates, :email, :unique => true
    add_index("passionates","slug")
  end

  def down
    drop_table :passionates
  end
end
