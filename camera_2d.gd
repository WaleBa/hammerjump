extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mlot = get_parent().get_node("Hammer")
	if mlot:
		global_position.y = mlot.global_position.y
