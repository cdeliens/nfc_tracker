class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.float :latitude
      t.float :longitude
      t.string :name
      t.string :ip
      t.integer :route_id

      t.timestamps
    end
  end
end
