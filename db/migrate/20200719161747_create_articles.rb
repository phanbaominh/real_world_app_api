# typed: true
class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :description
      t.text :body
      t.references :author, foreign_key: false

      t.timestamps
    end
    add_foreign_key :articles, :users, column: :author_id
  end
end
