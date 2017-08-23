class CreateMarks < ActiveRecord::Migration[5.1]
  def change
    create_table :marks do |t|
      t.string :title

      t.timestamps
    end
    add_index :marks, :title, unique: true
  end
end
