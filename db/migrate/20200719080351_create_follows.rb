# typed: true
class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.belongs_to :following, foreign_key: false
      t.belongs_to :follower, foreign_key: false

      t.timestamps
    end
    add_foreign_key :follows, :users, column: :following_id
    add_foreign_key :follows, :users, column: :follower_id
  end
end
