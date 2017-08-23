class CreateMarkings < ActiveRecord::Migration[5.1]
  def change
    create_table :markings do |t|
    	t.belongs_to :work
    	t.belongs_to :mark
      t.timestamps
    end
  end
end
