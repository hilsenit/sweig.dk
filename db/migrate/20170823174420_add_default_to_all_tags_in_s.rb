class AddDefaultToAllTagsInS < ActiveRecord::Migration[5.1]
	def change
	  change_column :works, :all_tags_in_s, :string, default: ""
	end
end
