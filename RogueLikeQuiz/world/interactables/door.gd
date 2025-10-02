extends Area2D

var is_locked = true

func unlock():
	if is_locked:
		is_locked = false
		# Here we would change the sprite to an "open" door
		# For now, we'll just make it disappear
		queue_free()