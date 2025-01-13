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
		spawn_group()

		can_spawn = false

func _on_timer_timeout() -> void:
	can_spawn = true

func spawn_group():
	var group: PeopleGroup = PeopleGroup.new()
	var num_people = randi_range(3, 5)

	group.move_size = Vector2(16.4, 16.4)
	group.first_row_many_column = 1
	group.max_column = 10
	group.add_column_per_row = 2
	group.position.x = randf_range(48, get_viewport().content_scale_size.x - 48)
	group.move_speed = 0

	var i = 0
	while i < num_people:

		var p: People = people_preset.instantiate()
		
		p.move_speed = 0
		p.get_node("Weapon").random_bullet_speed(slowest_bullet_speed, fastest_bullet_speed)
		p.position = Vector2.ZERO
		p.can_reposition = true
		# p.can_regroup = true

		group.add_child(p)
		group.add_member(p)

		await get_tree().create_timer(0.5).timeout

		i += 1

	group.move_speed = randf_range(100, 300)

	add_child(group)