class RemoveQuestionsCommentsVotes < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :comments, :questions
    remove_foreign_key :comments, :users
    remove_foreign_key :votes, :questions
    remove_foreign_key :votes, :users
    drop_table :questions
    drop_table :comments
    drop_table :votes
  end
end
