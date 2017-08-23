class AddAllTagsToWorks < ActiveRecord::Migration[5.1]
  def change
    add_column :works, :all_tags, :string, array: true, default: []
  end
end
