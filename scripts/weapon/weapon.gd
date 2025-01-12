class_name Weapon

extends Node2D

@onready var bullet_spawn_point: Node2D = $"/root/Main/BulletSpawnPoint"
@onready var shoot_timer: Timer = $"Timer"

@export var bullet_blueprint: PackedScene = null
@export var max_bullet_count := 100
@export var bullet_speed := 1000.0

var bullet_pool: ObjectPool

var can_shoot := true

func _ready():
	if bullet_spawn_point == null: printerr("Spawn point is NULL!")
	if bullet_blueprint == null: printerr("Bullet Blueprint is NULL!")
	
	bullet_pool = ObjectPool.new(max_bullet_count, bullet_blueprint, bullet_spawn_point)

func _process(_delta):
	if get_parent() is not People || !get_parent().in_group:
		return

	if can_shoot:
		can_shoot = false

		var bullet: Bullet = bullet_pool.get_from_pool()
		bullet.weapon = self
		bullet.speed = bullet_speed

		# Put the bullet into player position
		bullet.position = get_parent().global_position

func _on_timer_timeout() -> void:
	can_shoot = true

func random_bullet_speed(limit_1: float, limit_2: float):
	if limit_1 > limit_2:
		bullet_speed = randf_range(limit_2, limit_1)
		return
	else:
		bullet_speed = randf_range(limit_1, limit_2)
		return