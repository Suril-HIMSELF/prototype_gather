extends Control

@onready var center_control: Control = $CenterControl

@onready var stone_quantity: Label = $Footer/HBoxContainer/StoneContainer/StoneQuantity
@onready var iron_quantity: Label = $Footer/HBoxContainer/IronContainer/IronQuantity
@onready var copper_quantity: Label = $Footer/HBoxContainer/CopperContainer/CopperQuantity
@onready var bronze_quantity: Label = $Footer/HBoxContainer/BronzeContainer/BronzeQuantity
@onready var silver_quantity: Label = $Footer/HBoxContainer/SilverContainer/SilverQuantity


const ore_effect_scene = preload("res://scenes/effects/ore/ore_effect.tscn")

var input: int = -1
var quantity: int = 0
var inventory: int = 0

var quarry_items: = {
	"stone": 0.4,
	"iron_ore": 0.3,
	"copper_ore": 0.2,
	"bronze_ore": 0.1,
	"silver_ore": 0.05
}


func _ready() -> void:
	InputManager.input_detected.connect(_on_input_detected)
	
	update_inventory()


func _process(delta: float) -> void:
	if input != -1:
		match input:
			0:
				quantity = GameManager.stats[Data.STAT.GAIN_TAP]
			1:
				quantity = GameManager.stats[Data.STAT.GAIN_HOLD]
			2,3,4,5:
				quantity = GameManager.stats[Data.STAT.GAIN_HOLD]
		
		var rdm_crit = randf()
		
		if rdm_crit <= GameManager.stats[Data.STAT.CRITICAL_CHANCE]:
			quantity += quantity * GameManager.stats[Data.STAT.CRITICAL_POWER]
		
		var ore = roll_quarry_item()
		collect_ore(ore, quantity)
	
	input = -1


func collect_ore(ore: ItemData, qty: int) -> void:
	play_ore(ore)
	
	GameManager.add_item(ore, qty)
	
	update_inventory()


func update_inventory() -> void:
	var stone_qty = GameManager.get_item_amount(Database.items["stone"])
	var iron_qty = GameManager.get_item_amount(Database.items["iron_ore"])
	var copper_qty = GameManager.get_item_amount(Database.items["copper_ore"])
	var bronze_qty = GameManager.get_item_amount(Database.items["bronze_ore"])
	var silver_qty = GameManager.get_item_amount(Database.items["silver_ore"])
	
	stone_quantity.text = str(stone_qty) if stone_qty > 0 else "-"
	iron_quantity.text = str(iron_qty) if iron_qty > 0 else "-"
	copper_quantity.text = str(copper_qty) if copper_qty > 0 else "-"
	bronze_quantity.text = str(bronze_qty) if bronze_qty > 0 else "-"
	silver_quantity.text = str(silver_qty) if silver_qty > 0 else "-"


func play_ore(ore: ItemData) -> void:
	var effect = ore_effect_scene.instantiate() as OreEffect
	
	effect.ore = ore
	
	center_control.add_child(effect)
	effect.play()

func _on_input_detected(type: InputManager.InputType) -> void:
	input = type


func roll_quarry_item() -> ItemData:
	var total_weight: float = 0.0

	for weight in quarry_items.values():
		total_weight += weight

	if total_weight <= 0.0:
		return null

	var roll = randf() * total_weight

	for item_id in quarry_items:
		roll -= quarry_items[item_id]

		if roll <= 0.0:
			return Database.items.get(item_id)

	return null


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
