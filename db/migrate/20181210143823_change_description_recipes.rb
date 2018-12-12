class ChangeDescriptionRecipes < ActiveRecord::Migration[5.2]
  def change
  	rename_column :recipes, :desciption, :description
  	change_column :recipes, :description, :text
  end
end
