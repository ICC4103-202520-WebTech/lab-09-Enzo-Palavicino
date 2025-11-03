class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
      t.integer :cook_time
      t.string :difficulty

      t.timestamps
    end

    add_index :recipes, :title
    add_index :recipes, :difficulty
  end
end
