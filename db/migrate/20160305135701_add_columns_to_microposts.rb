class AddColumnsToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :title, :string
    add_column :microposts, :category, :string
  end
end
