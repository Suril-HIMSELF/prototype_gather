extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_wood_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_wood/game_wood.tscn")


func _on_stone_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_stone/game_stone.tscn")


func _on_mine_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/game_mine/game_mine.tscn")
