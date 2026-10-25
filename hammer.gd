
extends RigidBody2D

@export var launch_power: float = 16.0
@export var max_drag_distance: float = 100.0
@export var max_spin: float = 4.0
@export var spin_strength: float = 0.08

var dragging := false
var start_pos: Vector2 = Vector2(200, 400)

func _ready():
	global_position = start_pos
	freeze = true
	lock_rotation = false

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and freeze:
				if global_position.distance_to(get_global_mouse_position()) < 50:
					dragging = true

			elif not event.pressed and dragging:
				dragging = false
				var pull = start_pos - global_position
				freeze = false
				linear_velocity = pull * launch_power
				angular_velocity = 0.0

	elif event is InputEventMouseMotion and dragging:
		var offset = get_global_mouse_position() - start_pos

		if offset.length() > max_drag_distance:
			offset = offset.normalized() * max_drag_distance

		global_position = start_pos + offset

func _physics_process(_delta):
	if not freeze:
		angular_velocity = clamp(
			linear_velocity.x * spin_strength,
			-max_spin,
			max_spin
		)

		if linear_velocity.length() < 5 and abs(angular_velocity) < 0.1:
			freeze = true
			start_pos = global_position
			linear_velocity = Vector2.ZERO
			angular_velocity = 0.0
