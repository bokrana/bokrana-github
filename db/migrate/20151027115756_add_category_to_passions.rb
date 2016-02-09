class AddCategoryToPassions < ActiveRecord::Migration
  def change
    add_column :passions, :category, :string
    add_column :passions, :view_num, :integer , :default => 0
  end
end
