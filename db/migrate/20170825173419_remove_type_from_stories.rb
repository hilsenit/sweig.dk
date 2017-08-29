class RemoveTypeFromStories < ActiveRecord::Migration[5.1]
  def change
  	remove_column :stories, :type, :string
  	add_column :stories, :story_type, :string
  end
end
