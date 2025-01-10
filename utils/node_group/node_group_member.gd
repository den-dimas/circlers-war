class_name NodeGroupMember
extends Area2D

@export
var in_group := false

var row: int
var column: int

@export
var move_smoothness: float = 10.0
var can_reposition: bool = false
var new_position: Vector2

func _process(delta: float) -> void:
	reposition(delta)

func reposition(delta: float) -> void:
	if can_reposition:
		position.x = lerp(position.x, new_position.x, delta * move_smoothness)
		position.y = lerp(position.y, new_position.y, delta * move_smoothness)

		if (position.distance_to(new_position) <= 0):
			can_reposition = false

func _on_area_entered(area: NodeGroupMember) -> void:
	if !in_group || get_parent().many_column_per_row < 1: return

	if in_group and area is NodeGroupMember and !area.in_group:
		get_parent().call_deferred("add_member", area)