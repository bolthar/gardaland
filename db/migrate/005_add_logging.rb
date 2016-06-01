class AddLogging < ActiveRecord::Migration

  def up
    create_table :user_logs do |t|
      t.string :route
      t.string :ip
      t.timestamps
    end
  end

  def down
    drop_table :user_logs
  end

end
