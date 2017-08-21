class CreateFoelgers < ActiveRecord::Migration[5.1]
  def change
    create_table :foelgers do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    add_index :foelgers, :follower_id
    add_index :foelgers, :followed_id
    add_index :foelgers, [:follower_id, :followed_id], unique: true 
  end
end
