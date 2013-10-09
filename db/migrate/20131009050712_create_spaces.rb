class CreateSpaces < ActiveRecord::Migration
  def change
    create_table :spaces do |t|
      t.string :name
      t.string :type
      t.string :address
      t.string :hours
      t.string :phone
      t.string :email
      t.string :website
      t.text :description

      t.timestamps
    end
  end
end
