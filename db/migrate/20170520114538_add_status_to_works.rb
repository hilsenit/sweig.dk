class AddStatusToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :status, :integer, unique: true, default: 0
  end
end
