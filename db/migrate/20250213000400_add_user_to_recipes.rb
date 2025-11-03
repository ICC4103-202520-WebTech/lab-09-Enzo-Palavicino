require "devise"

class AddUserToRecipes < ActiveRecord::Migration[8.0]
  class MigrationRecipe < ApplicationRecord
    self.table_name = "recipes"
  end

  class MigrationUser < ApplicationRecord
    self.table_name = "users"
  end

  def up
    add_reference :recipes, :user, null: true, foreign_key: true

    say_with_time "Backfilling recipes with an owner" do
      MigrationRecipe.reset_column_information

      MigrationUser.reset_column_information

      existing_user = MigrationUser.first

      user = existing_user || MigrationUser.create!(
        email: "placeholder@example.com",
        encrypted_password: Devise::Encryptor.digest(User, "changeme123")
      )

      MigrationRecipe.where(user_id: nil).update_all(user_id: user.id)
    end

    change_column_null :recipes, :user_id, false
  end

  def down
    remove_reference :recipes, :user, foreign_key: true
  end
end
