class_name ObjectPool

var max_object: int

var object_recipe: PackedScene
var object_pool: Array[Node2D]

var parent: Node2D

func _init(max_count: int, recipe: PackedScene, spawn_point: Node2D):
	max_object = max_count
	object_recipe = recipe
	object_pool = []
	parent = spawn_point

func release_to_pool(obj: Node2D):
	var d = deactivate_obj(obj)

	object_pool.push_back(d)

	return d

func get_from_pool() -> Node2D:
	# If pool is empty, we want to spawn a new object
	# and put it to the pool
	if object_pool.is_empty():
		# Spawn the object
		var s: Node2D = object_recipe.instantiate()

		# Push to stack
		# This put the new spawned object into stack
		object_pool.push_back(activate_obj(s))

		# Pop and Return object from stack
		# This ensure the spawned and returned object is coming from the stack
		var newObj = object_pool.pop_back()

		parent.add_child(newObj)

		return newObj

	# If pool is not empty, simply take one from pool
	return activate_obj(object_pool.pop_back())

func activate_obj(obj: Node2D) -> Node2D:
	obj.set_process(true)
	obj.set_physics_process(true)
	obj.visible = true
	obj.position = Vector2.ZERO

	return obj

func deactivate_obj(obj: Node2D) -> Node2D:
	obj.set_process(false)
	obj.set_physics_process(false)
	obj.visible = false

	return obj
