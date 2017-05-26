class AddUserIdToSavedWorks < ActiveRecord::Migration[5.1]
  def change
  	add_column :saved_works, :user_id, :integer
  	add_column :works, :saved_work_id, :integer
  end
end
