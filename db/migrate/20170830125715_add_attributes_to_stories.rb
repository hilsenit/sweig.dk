class AddAttributesToStories < ActiveRecord::Migration[5.1]
  def change
  	remove_column :stories, :text, :string
    add_column :stories, :user_id, :integer
    add_column :stories, :user_username, :string
    add_column :stories, :work_id, :integer
    add_column :stories, :work_title, :string
  end
end
