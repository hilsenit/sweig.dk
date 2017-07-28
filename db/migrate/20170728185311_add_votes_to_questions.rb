class AddVotesToQuestions < ActiveRecord::Migration[5.1]
	def change
	  create_table :votes do |t|
	    t.references :question, foreign_key: true
	    t.integer :vote, default: 0
	    t.timestamps
	  end
	end
end


