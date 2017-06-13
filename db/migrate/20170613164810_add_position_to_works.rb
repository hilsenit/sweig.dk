class AddPositionToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :position, :integer
  end
end
