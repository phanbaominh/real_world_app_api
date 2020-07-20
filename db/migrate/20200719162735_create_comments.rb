class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :body
      t.references :user, foreign_key: false
      t.references :article, foreign_key: false

      t.timestamps
    end
    add_foreign_key :comments, :users, column: :user_id
    add_foreign_key :comments, :articles, column: :article_id
  end
end
