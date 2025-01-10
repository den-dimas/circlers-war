class_name Controller
extends NodeGroup

@export var sprite_size_reference: Vector2 = Vector2(192, 192)
@export var sprite_scale: Vector2 = Vector2(0.2, 0.2)

@export var move_scale: float = 2.0
@export var move_smoothness: float = 1.0

var sprite_size: Vector2

var new_position = null

func _ready():
	sprite_size = sprite_size_reference * sprite_scale
	move_size = sprite_size / move_scale
	many_column_per_row = first_row_many_column

	var people_scene: PackedScene = load("res://scenes/entity/people.tscn")

	var player: People = people_scene.instantiate()

	add_child(player)
	add_member(player)

	player.position = Vector2.ZERO

func _process(delta):
	if new_position != null && position.distance_to(new_position) > 0.0:
		position.x = lerp(position.x, new_position.x, delta * move_smoothness)
