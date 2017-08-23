class ChangeTagArrayToString < ActiveRecord::Migration[5.1]
  def change
  	remove_column :works, :all_tags, :all_tags
  	add_column :works, :all_tags_in_s, :string
  end
end
