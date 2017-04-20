class AddCompanyInfoToJob < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :company, :string
    add_column :jobs, :location, :string
  end
end
