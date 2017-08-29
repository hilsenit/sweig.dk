class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.string :text
      t.string :type
      t.belongs_to :biblo

      t.timestamps
    end
  end
end
