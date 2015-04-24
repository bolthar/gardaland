class AddDataPoints < ActiveRecord::Migration

  def up
    create_table :data_points do |t|
      t.references :attraction, :index => :true
      t.datetime :date
      t.integer :wait_time
    end
  end

  def down
    drop_table :data_points 
  end

end
