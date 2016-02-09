class CreateDreams < ActiveRecord::Migration
  def change
    create_table :dreams do |t|
      t.text :name
      t.text :content
      t.string :date
      t.references :user, index: true, foreign_key: true
      t.references :micropost, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :dreams, [:user_id, :created_at]
  end
end
