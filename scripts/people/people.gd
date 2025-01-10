class_name People
extends NodeGroupMember

@onready
var sprite: Sprite2D = $"Sprite2D"

@export
var move_speed := 100.0

func _process(delta):
	if !in_group:
		position.y += move_speed * delta

	reposition(delta)
	

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
