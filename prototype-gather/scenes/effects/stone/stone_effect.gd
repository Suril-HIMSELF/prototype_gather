class_name StoneEffect
extends Node2D

@onready var stone_sprite: Sprite2D = $StoneSprite


func _ready() -> void:
	stone_sprite.visible = false


func play() -> void:
	stone_sprite.visible = true

	stone_sprite.position = Vector2.ZERO
	stone_sprite.rotation = 0.0
	stone_sprite.scale = Vector2(0.5, 0.5)
	stone_sprite.modulate.a = 1.0

	var tween := create_tween()

	# Projection en diagonale vers le haut-droite
	tween.tween_property(
		stone_sprite,
		"position",
		Vector2(120, -100),
		0.35
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	# Rotation
	tween.parallel().tween_property(
		stone_sprite,
		"rotation",
		deg_to_rad(30.0),
		0.35
	)

	# Grossissement
	tween.parallel().tween_property(
		stone_sprite,
		"scale",
		Vector2(0.85, 0.85),
		0.20
	).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	# Disparition
	tween.parallel().tween_property(
		stone_sprite,
		"modulate:a",
		0.0,
		0.50
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)

	# Cette instance est détruite uniquement quand SON animation est terminée
	tween.tween_callback(queue_free)
