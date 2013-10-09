class AddCityStateToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :city, :string
    add_column :spaces, :state, :string
  end
end
