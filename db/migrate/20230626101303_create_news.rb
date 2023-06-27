class CreateNews < ActiveRecord::Migration[7.0]
  def change
    create_table :news do |t|
      t.text :content
      t.text :file_data
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
