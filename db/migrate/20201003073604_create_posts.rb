class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.text :body
      t.string :image_name

      t.timestamps
    end
  end
end
