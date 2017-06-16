class AddViewsToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :views, :integer
  end
end
