class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
    	t.float :rating, null: false
    	t.text :content, null: false
    	t.belongs_to :book, foreign_key: true, index: true, null: false

    	t.timestamps null: false
    end
  end
end
