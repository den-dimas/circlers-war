extends Node2D

@onready var spawn_timer = $"Timer"
@onready var people_preset: PackedScene = load("res://scenes/entity/people.tscn")

var can_spawn := false

func _process(_delta):
	if (can_spawn):
		var p: People = people_preset.instantiate()

		add_child(p)

		p.position.x = randf_range(48, get_viewport().content_scale_size.x - 48)
		p.move_speed = randf_range(100, 300)

		can_spawn = false

func _on_timer_timeout() -> void:
	can_spawn = true