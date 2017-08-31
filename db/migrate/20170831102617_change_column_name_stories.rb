class ChangeColumnNameStories < ActiveRecord::Migration[5.1]
  def change
  	rename_column :stories, :fol_username, :t_other_username
  	rename_column :stories, :fol_friendly_id, :t_other_friendly_id
  end
end
