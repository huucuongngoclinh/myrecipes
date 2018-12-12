class ChangeEmailToDescriptionRecipe < ActiveRecord::Migration[5.2]
  def change
  	rename_column :recipes, :email, :desciption
  end
end
