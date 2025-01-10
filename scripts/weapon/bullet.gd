class_name Bullet

extends RigidBody2D

@export var speed: float

var weapon: Weapon = null

func _physics_process(delta):
	move_and_collide(Vector2.UP * speed * delta)

func _on_visible_on_screen_notifier_2d_screen_exited():
	if weapon == null:
		printerr("WEAPON IS NULL")
		return

	weapon.bullet_pool.release_to_pool(self)
