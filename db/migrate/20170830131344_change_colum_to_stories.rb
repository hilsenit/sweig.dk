class ChangeColumToStories < ActiveRecord::Migration[5.1]
  def change
  	add_column :stories, :fol_id, :integer
  	add_column :stories, :fol_username, :string
  end
end
