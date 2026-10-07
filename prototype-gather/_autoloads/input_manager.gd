extends Node


enum InputType {
	TAP,
	HOLD,
	SWIPE_UP,
	SWIPE_DOWN,
	SWIPE_LEFT,
	SWIPE_RIGHT
}


signal input_detected(type: InputType)


@export_category("Input Settings")
@export var hold_duration: float = 0.5
@export var swipe_min_distance: float = 100.0
@export var tap_max_distance: float = 30.0


var _input_active: bool = false
var _hold_triggered: bool = false
var _input_time: float = 0.0

var _start_position: Vector2
var _current_position: Vector2


func _process(delta: float) -> void:
	if not _input_active:
		return

	_input_time += delta

	if _hold_triggered:
		return

	if _input_time >= hold_duration:
		var distance := _current_position.distance_to(_start_position)

		if distance < swipe_min_distance:
			_hold_triggered = true
			input_detected.emit(InputType.HOLD)


func _input(event: InputEvent) -> void:

	# Touch
	if event is InputEventScreenTouch:
		if event.pressed:
			_start_input(event.position)
		else:
			_end_input(event.position)

	elif event is InputEventScreenDrag:
		if _input_active:
			_current_position = event.position

	# Mouse
	elif event is InputEventMouseButton:
		if event.button_index != MOUSE_BUTTON_LEFT:
			return

		if event.pressed:
			_start_input(event.position)
		else:
			_end_input(event.position)

	elif event is InputEventMouseMotion:
		if _input_active and Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			_current_position = event.position


func _start_input(position: Vector2) -> void:
	_input_active = true
	_hold_triggered = false
	_input_time = 0.0

	_start_position = position
	_current_position = position


func _end_input(position: Vector2) -> void:
	if not _input_active:
		return

	_current_position = position

	var delta := _current_position - _start_position
	var distance := delta.length()

	_input_active = false

	# Un HOLD ne déclenche rien d'autre.
	if _hold_triggered:
		return

	# SWIPE
	if distance >= swipe_min_distance:
		_detect_swipe(delta)
		return

	# TAP
	if distance <= tap_max_distance:
		input_detected.emit(InputType.TAP)


func _detect_swipe(delta: Vector2) -> void:

	if abs(delta.x) > abs(delta.y):

		if delta.x > 0:
			input_detected.emit(InputType.SWIPE_RIGHT)
		else:
			input_detected.emit(InputType.SWIPE_LEFT)

	else:

		if delta.y > 0:
			input_detected.emit(InputType.SWIPE_DOWN)
		else:
			input_detected.emit(InputType.SWIPE_UP)


static func input_type_to_string(type: InputType) -> String:
	match type:
		InputType.TAP:
			return "TAP"

		InputType.HOLD:
			return "HOLD"

		InputType.SWIPE_UP:
			return "SWIPE UP"

		InputType.SWIPE_DOWN:
			return "SWIPE DOWN"

		InputType.SWIPE_LEFT:
			return "SWIPE LEFT"

		InputType.SWIPE_RIGHT:
			return "SWIPE RIGHT"

	return "UNKNOWN"
