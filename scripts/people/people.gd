class_name People
extends NodeGroupMember

@onready
var sprite: Sprite2D = $"Sprite2D"

@export
var move_speed := 100.0

func _ready():
	var screen_notifier = $"VisibleOnScreenNotifier2D"

	screen_notifier.connect("screen_exited", queue_free)

func _process(delta):
	if !in_group:
		position.y += move_speed * delta

	reposition(delta)

func _on_area_entered(area: NodeGroupMember) -> void:
	if !in_group || get_parent().many_column_per_row < 1: return

	if in_group and area is NodeGroupMember and get_parent() is Controller:
		get_parent().call_deferred("add_member", area)