extends Control


@onready var menu: Control = $Menu

@onready var inventory: Inventory = $Menu/Inventory
@onready var game_menu: Control = $Menu/GameMenu
@onready var workshop: Control = $Menu/Workshop


@onready var game: Button = $Footer/VBoxContainer/FooterNavigation/HBoxContainer/Game


func _ready() -> void:
	for node in menu.get_children():
		node.visible = false
	
	
	game_menu.visible = true
	game.button_pressed = true


func _on_inventory_pressed() -> void:
	for node in menu.get_children():
		node.visible = false
	
	inventory.visible = true


func _on_game_pressed() -> void:
	for node in menu.get_children():
		node.visible = false
	
	game_menu.visible = true


func _on_workshop_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/workshop/workshop.tscn")
