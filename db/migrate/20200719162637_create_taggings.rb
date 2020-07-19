class CreateTaggings < ActiveRecord::Migration[5.2]
  def change
    create_table :taggings do |t|
      t.references :tag, foreign_key: false
      t.references :article, foreign_key: false

      t.timestamps
    end
    add_foreign_key :taggings, :tags, column: :tag_id
    add_foreign_key :taggings, :articles, column: :article_id
  end
end
