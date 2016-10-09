class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
    	t.string :title, null: false
    	t.text :description, null: false
    	t.integer :isbn, null: false
    	t.attachment :photo

    	t.timestamps null: false
    end
  end
end
