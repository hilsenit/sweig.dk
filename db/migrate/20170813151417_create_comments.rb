class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
	t.text :text
	t.references :question, index: true, foreign_key: true
      t.timestamps
    end
  end
end
