class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.text :name
      t.text :content
      t.string :deadline
      t.references :user, index: true, foreign_key: true
      t.references :dream, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :goals, [:user_id, :created_at]
  end
end
