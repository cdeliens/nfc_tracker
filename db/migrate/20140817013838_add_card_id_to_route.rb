class AddCardIdToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :card_id, :string
  end
end
