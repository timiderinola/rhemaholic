class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :fan_id

      t.timestamps
    end
  end
end
