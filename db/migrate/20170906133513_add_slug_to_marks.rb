class AddSlugToMarks < ActiveRecord::Migration[5.1]
  def change
    add_column :marks, :slug, :string
    add_index :marks, :slug, unique: true
  end
end
