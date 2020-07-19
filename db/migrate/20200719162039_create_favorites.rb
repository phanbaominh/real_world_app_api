class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.references :user, foreign_key: false
      t.references :article, foreign_key: false

      t.timestamps
    end
    add_foreign_key :favorites, :users, column: :user_id
    add_foreign_key :favorites, :articles, column: :article_id
  end
end
