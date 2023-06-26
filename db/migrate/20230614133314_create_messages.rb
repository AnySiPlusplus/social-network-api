class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.references :user, null: false, foreign_key: true
      t.text :text
      t.text :file_data
      t.integer :to_whom, null: false

      t.timestamps
    end
  end
end
