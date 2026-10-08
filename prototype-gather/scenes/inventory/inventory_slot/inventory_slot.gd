class_name InventorySlot extends Button

@onready var slot_icon: TextureRect = $SlotIcon
@onready var slot_quantity: Label = $SlotQuantity

var inventory_index: int = -1

func setup(item: ItemData, amount: int) -> void:
	if item == null or amount <= 0:
		return
	
	slot_icon.texture = item.icon
	slot_quantity.text = str(amount)
