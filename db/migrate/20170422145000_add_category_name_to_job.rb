class AddCategoryNameToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :category_name, :string, default: "IT工程师"
  end
end
