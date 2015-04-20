class CreateAttractionLog < ActiveRecord::Migration

  def up
    create_table :attraction_logs do |t|
      t.string :name
      t.integer :wait_time
      t.timestamps
    end
  end

  def down
    drop_table :attraction_logs
  end

end
