extends Node2D

@onready
var spawn_timer = $"Timer"
@onready
var people_preset: PackedScene = load("res://scenes/entity/people.tscn")

@export
var slowest_bullet_speed: float = 1000.0
@export
var fastest_bullet_speed: float = 1600.0

var people_pool: ObjectPool

var can_spawn := false

func _ready():
	people_pool = ObjectPool.new(100, people_preset, self)

func _process(_delta):
	if (can_spawn):
		var p: People = people_preset.instantiate()

		add_child(p)

		p.position.x = randf_range(48, get_viewport().content_scale_size.x - 48)
		p.move_speed = randf_range(100, 300)
		p.get_node("Weapon").random_bullet_speed(slowest_bullet_speed, fastest_bullet_speed)

		can_spawn = false

func _on_timer_timeout() -> void:
	can_spawn = true