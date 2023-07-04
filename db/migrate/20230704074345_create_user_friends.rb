class CreateUserFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :user_friends do |t|
      t.references :user, null: false, foreign_key: true
      t.references :friend, null: false, foreign_key: true

      t.timestamps
    end
  end
end
