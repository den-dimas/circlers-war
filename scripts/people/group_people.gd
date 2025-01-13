class_name PeopleGroup
extends NodeGroup

var move_speed: float

func _ready() -> void:
  var screen_notifier = VisibleOnScreenNotifier2D.new()
  add_child(screen_notifier)

  screen_notifier.connect("screen_exited", on_outside_screen)

func _process(delta):
  position.y += move_speed * delta

func on_outside_screen():
  queue_free()
