class CreateAttractions < ActiveRecord::Migration

  def up
    create_table :attractions do |t|
      t.string :name
      t.integer :opened_from
    end
  end

  def down
    drop_table :attractions 
  end

end
