class AddLatLongGmapToSpaces < ActiveRecord::Migration
  def change
    add_column :spaces, :latitude,  :float
    add_column :spaces, :longitude, :float
    add_column :spaces, :gmaps, :boolean
  end
end
