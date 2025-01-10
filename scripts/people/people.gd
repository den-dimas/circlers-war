class_name People

extends Area2D

@onready var sprite: Sprite2D = $"Sprite2D"

@export var move_smoothness := 10.0
@export var move_speed := 100.0
@export var is_in_team := false

var what_row: int = 0
var what_column: int = 0

var can_reposition: bool = false
var new_position: Vector2

func _process(delta):
	if !is_in_team:
		position.y += move_speed * delta

	if can_reposition:
		position.x = lerp(position.x, new_position.x, delta * move_smoothness)
		position.y = lerp(position.y, new_position.y, delta * move_smoothness)

		if (position.distance_to(new_position) <= 0):
			can_reposition = false


func _on_area_entered(area: Area2D) -> void:
	if is_in_team and get_parent().many_column_per_row < get_parent().starting_column + 1 and get_parent().is_increase == -1: return

	if is_in_team and area is People and !area.is_in_team:
		area.call_deferred("join_team", get_parent())

		return

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func join_team(parent: Node2D) -> void:
		if is_in_team: return
		is_in_team = true

		reparent(parent)

		get_parent().adjust_position()

		what_row = get_parent().current_row
		what_column = get_parent().current_column

		get_parent().reposition()
