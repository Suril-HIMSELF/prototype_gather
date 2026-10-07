extends Control


@onready var menu: Control = $Menu
@onready var game_menu: Control = $Menu/GameMenu

@onready var game: Button = $Footer/VBoxContainer/FooterNavigation/HBoxContainer/Game


func _ready() -> void:
	for node in menu.get_children():
		node.visible = false
	
	
	game_menu.visible = true
	game.button_pressed = true
