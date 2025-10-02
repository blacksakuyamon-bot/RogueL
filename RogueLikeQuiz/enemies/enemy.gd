extends Area2D

var health = 3

func take_damage(amount):
	health -= amount
	if health <= 0:
		queue_free() # The enemy disappears when defeated