class CreateSavedWorks < ActiveRecord::Migration[5.1]
  def change
    create_table :saved_works do |t|

      t.timestamps
    end
  end
end
