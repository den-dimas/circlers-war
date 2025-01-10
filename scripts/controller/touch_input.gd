extends Area2D

@onready var ctrl: Controller = $"../Controller"

func _input_event(_viewport, event, _shape_idx):
	if event is InputEventScreenDrag || event is InputEventScreenTouch:
		ctrl.new_position = event.position
		
		return
