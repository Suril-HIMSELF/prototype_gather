extends Control


@onready var recipes_container: VBoxContainer = $ScrollContainer/RecipesContainer

const RECIPE_SCENE = preload("res://scenes/recipe/recipe.tscn")

func _ready() -> void:
	for data in Database.get_recipes_by_type(RecipeData.RECIPE_TYPE.SAWMILL):
		var recipe = RECIPE_SCENE.instantiate()
		
		recipe.setup(data)
		
		recipes_container.add_child(recipe)
