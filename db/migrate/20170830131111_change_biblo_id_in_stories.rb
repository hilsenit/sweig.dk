class ChangeBibloIdInStories < ActiveRecord::Migration[5.1]
  def change
  	remove_column :stories, :biblo_id, :integer
  end
end
