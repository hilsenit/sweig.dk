class AddWorkToSavedWorks < ActiveRecord::Migration[5.1]
  def change
    add_reference :saved_works, :work, foreign_key: true
  end
end
