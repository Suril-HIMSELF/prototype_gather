class_name RecipeData
extends Resource


enum RECIPE_TYPE {
	SAWMILL,
	FORGE
}


@export var id: String
@export var display_name: String
@export var type: RECIPE_TYPE

@export_category("Ingredients")
@export var ingredients: Array[RecipeIngredient] = []

@export_category("Output")
@export var output: ItemData
@export var output_amount: int = 1

@export_category("Crafting")
@export var craft_time: float = 0.0
