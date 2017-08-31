class ChangeColumnNamesOnStories < ActiveRecord::Migration[5.1]
  def change
  	rename_column :stories, :user_username, :action_username
  end
end
