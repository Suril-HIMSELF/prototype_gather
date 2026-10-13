extends Control

@onready var center_control: Control = $CenterControl
@onready var stone_quantity: Label = $Footer/HBoxContainer/StoneContainer/StoneQuantity
@onready var gold_quantity: Label = $Footer/HBoxContainer/GoldContainer/GoldQuantity
@onready var sapphire_quantity: Label = $Footer/HBoxContainer/SapphireContainer/SappphireQuantity
@onready var ruby_quantity: Label = $Footer/HBoxContainer/RubyContainer/RubyQuantity
@onready var emerald_quantity: Label = $Footer/HBoxContainer/EmeraldContainer/EmeraldQuantity
@onready var diamond_quantity: Label = $Footer/HBoxContainer/DiamondContainer/DiamondQuantity


const ore_effect_scene = preload("res://scenes/effects/ore/ore_effect.tscn")

var input: int = -1
var quantity: int = 0
var inventory: int = 0

var mine_items: = {
	"stone": 0.6,
	"gold_ore": 0.2,
	"sapphire_raw": 0.1,
	"ruby_raw": 0.06,
	"emerald_raw": 0.03,
	"diamond_raw": 0.01,
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
		
		var ore = roll_mine_item()
		collect_ore(ore, quantity)
	
	input = -1


func collect_ore(ore: ItemData, qty: int) -> void:
	play_ore(ore)
	
	GameManager.add_item(ore, qty)
	
	update_inventory()


func update_inventory() -> void:
	var stone_qty = GameManager.get_item_amount(Database.items["stone"])
	var gold_qty = GameManager.get_item_amount(Database.items["gold_ore"])
	var sapphire_qty = GameManager.get_item_amount(Database.items["sapphire_raw"])
	var ruby_qty = GameManager.get_item_amount(Database.items["ruby_raw"])
	var emerald_qty = GameManager.get_item_amount(Database.items["emerald_raw"])
	var diamond_qty = GameManager.get_item_amount(Database.items["diamond_raw"])
	
	stone_quantity.text = str(stone_qty) if stone_qty > 0 else "-"
	gold_quantity.text = str(gold_qty) if gold_qty > 0 else "-"
	sapphire_quantity.text = str(sapphire_qty) if sapphire_qty > 0 else "-"
	ruby_quantity.text = str(ruby_qty) if ruby_qty > 0 else "-"
	emerald_quantity.text = str(emerald_qty) if emerald_qty > 0 else "-"
	diamond_quantity.text = str(diamond_qty) if diamond_qty > 0 else "-"


func play_ore(ore: ItemData) -> void:
	var effect = ore_effect_scene.instantiate() as OreEffect
	
	effect.ore = ore
	
	center_control.add_child(effect)
	effect.play()



func roll_mine_item() -> ItemData:
	var total_weight: float = 0.0

	for weight in mine_items.values():
		total_weight += weight

	if total_weight <= 0.0:
		return null

	var roll = randf() * total_weight

	for item_id in mine_items:
		roll -= mine_items[item_id]

		if roll <= 0.0:
			return Database.items.get(item_id)

	return null


func _on_input_detected(type: InputManager.InputType) -> void:
	input = type


func _on_return_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn")
