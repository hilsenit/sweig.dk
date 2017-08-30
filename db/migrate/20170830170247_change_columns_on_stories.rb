class ChangeColumnsOnStories < ActiveRecord::Migration[5.1]
  def change
  	remove_column :stories, :fol_id, :fol_friendly_id
  	remove_column :stories, :work_id, :work_friendly_id
  	add_column :stories, :fol_friendly_id, :string
  	add_column :stories, :work_friendly_id, :string

  end
end
