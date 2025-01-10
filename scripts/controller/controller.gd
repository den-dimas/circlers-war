class_name Controller

extends Node2D

@export var sprite_size_reference := Vector2(192, 192)
@export var sprite_scale := Vector2(0.2, 0.2)

@export var move_smoothness := 1.0
@export var starting_column := 1

var sprite_size: Vector2

var new_position = null

const MAX_COLUMN = 8

var current_row = 0
var current_column = 0
var many_column_per_row = 1

var move_column_step := 0.0
var move_row_step := 0.0

var is_increase := 1

func _ready():
	many_column_per_row = starting_column
	sprite_size = sprite_size_reference * sprite_scale

func _process(delta):
	if new_position != null && position.distance_to(new_position) > 0.0:
		position.x = lerp(position.x, new_position.x, delta * move_smoothness)

func adjust_position():
	current_column += 1

	if current_column >= many_column_per_row:
		if current_column >= MAX_COLUMN: is_increase *= -1
		
		current_column = 0
		current_row += 1
		
		many_column_per_row += (1 * is_increase)

		move_row_step = -(current_row / 2.0)

	move_column_step = -(current_column / 2.0)


func reposition():
	var peoples: Array[Node] = get_children()

	for people in peoples:
		if people is not People:
			continue
		
		if (people.what_row == current_row):
			people.new_position.x = (people.what_column + move_column_step) * (sprite_size.x / 2.0)
		people.new_position.y = (people.what_row + move_row_step) * (sprite_size.y / 2.0)

		people.can_reposition = true

		pass
