class CreateCardReadLogs < ActiveRecord::Migration
  def change
    create_table :card_read_logs do |t|
      t.string :uid

      t.timestamps
    end
  end
end
