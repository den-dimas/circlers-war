class_name NodeGroup
extends Node2D

@export var move_size: Vector2

@export var first_row_many_column: int
@export var max_column: int
@export var add_column_per_row: int

var current_row := 0
var current_column := 0
var many_column_per_row := 1

var move_column_step := 0.0
var move_row_step := 0.0

var is_increase := 1

var table: Array[NodeGroupMember]

func add_member(member: NodeGroupMember):
	member.row = current_row
	member.column = current_column
	member.in_group = true
	member.reparent(self)
	
	table.push_back(member)

	reposition()
	adjust_group_index()

# Has bugs in adjusting column and rows after a new member is added in new row
# Suspect is because there is an overlapping between member in the same group
func adjust_group_index():
	current_column += 1

	if current_column >= many_column_per_row:
		if current_column > max_column: is_increase *= -1
		
		current_column = 0
		current_row += 1
		
		many_column_per_row += (add_column_per_row * is_increase)

		move_row_step = -(current_row / 2.0)
	
	if is_increase == -1 and many_column_per_row < first_row_many_column:
		many_column_per_row = 0

	move_column_step = -(current_column / 2.0)

func reposition():
	for entry in table:
		if (entry.row == current_row):
			entry.new_position.x = (entry.column + move_column_step) * (move_size.x)
		entry.new_position.y = (entry.row + move_row_step) * (move_size.y)

		entry.can_reposition = true
	pass
