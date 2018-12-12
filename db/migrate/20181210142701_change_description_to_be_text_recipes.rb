class ChangeDescriptionToBeTextRecipes < ActiveRecord::Migration[5.2]
  def change
  	change_column :recipes, :desciption, :text
  end
end
