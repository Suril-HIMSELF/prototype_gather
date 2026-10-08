extends Node

signal item_crafted


### Inventory ###

var inventory: Dictionary = {}

var coins = 0


func add_item(item: ItemData, amount: int) -> void:
	if item == null or amount <= 0:
		return
	
	if not inventory.has(item):
		inventory[item] = 0
	
	inventory[item] += amount


func remove_item(item: ItemData, amount: int) -> bool:
	if not has_item(item, amount):
		return false
	
	inventory[item] -= amount
	
	if inventory[item] <= 0:
		inventory.erase(item)
	
	return true


func has_item(item: ItemData, amount: int) -> bool:
	if item == null or amount <= 0:
		return false
	
	return inventory.get(item, 0) >= amount


func get_item_amount(item: ItemData) -> int:
	if item == null:
		return 0
	
	return inventory.get(item, 0)


func clear() -> void:
	inventory.clear()


func craft(recipe: RecipeData) -> bool:
	for ingredient in recipe.ingredients:
		var item_id = ingredient.item.id
		var quantity = GameManager.get_item_amount(Database.items[item_id])
		
		if quantity < ingredient.amount:
			return false
		else:
			GameManager.remove_item(Database.items[item_id], ingredient.amount)
	
	var output_id = recipe.output
	
	GameManager.add_item(output_id, recipe.output_amount)
	
	item_crafted.emit()
	
	return true
		
		
		
		
