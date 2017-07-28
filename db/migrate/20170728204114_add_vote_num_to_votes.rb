class AddVoteNumToVotes < ActiveRecord::Migration[5.1]
  def change
    remove_column :votes, :vote, :integer
    add_column :votes, :vote_num, :integer
  end
end
