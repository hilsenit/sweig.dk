class AddMarkIdToWorks < ActiveRecord::Migration[5.1]
  def change
    add_reference :works, :mark, foreign_key: true
  end
end
