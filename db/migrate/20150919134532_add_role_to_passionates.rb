class AddRoleToPassionates < ActiveRecord::Migration
  def change
    add_column :passionates, :role, :string, :default => "standard" , :limit => 12
  end
end
