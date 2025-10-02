extends CanvasLayer

@onready var hearts_container = $HBoxContainer

func set_health(health_value):
	var hearts = hearts_container.get_children()
	for i in range(hearts.size()):
		if i < health_value:
			hearts[i].visible = true
		else:
			hearts[i].visible = false