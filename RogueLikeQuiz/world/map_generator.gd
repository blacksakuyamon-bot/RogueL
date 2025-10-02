extends Node2D

@onready var tile_map = $TileMap
@onready var player = $Player
@onready var player_hud = $PlayerHUD

const EnemyScene = preload("res://enemies/enemy.tscn")
const DoorScene = preload("res://world/interactables/door.tscn")

const MAP_WIDTH = 50
const MAP_HEIGHT = 30
const ROOM_MIN_SIZE = 8
const ROOM_MAX_SIZE = 12

func _ready():
	# Connect player health to HUD
	player.health_changed.connect(player_hud.set_health)
	# Set initial health on the HUD
	player_hud.set_health(player.health)

	generate_room()

func generate_room():
	# Clear previous map content
	tile_map.clear()
	for child in get_children():
		if child is Area2D and child != player:
			child.queue_free()

	# Random room size and position
	var room_width = randi_range(ROOM_MIN_SIZE, ROOM_MAX_SIZE)
	var room_height = randi_range(ROOM_MIN_SIZE, ROOM_MAX_SIZE)
	var start_x = (MAP_WIDTH - room_width) / 2
	var start_y = (MAP_HEIGHT - room_height) / 2

	# Create room
	for y in range(start_y, start_y + room_height):
		for x in range(start_x, start_x + room_width):
			if y == start_y or y == start_y + room_height - 1 or x == start_x or x == start_x + room_width - 1:
				tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 1)) # Wall
			else:
				tile_map.set_cell(0, Vector2i(x, y), 0, Vector2i(0, 0)) # Floor

	# Place Door
	var door_pos = Vector2i(start_x + room_width / 2, start_y)
	tile_map.set_cell(0, door_pos, 0, Vector2i(0, 0))
	var door = DoorScene.instantiate()
	door.position = tile_map.map_to_local(door_pos)
	add_child(door)

	# Place Enemy
	var enemy = EnemyScene.instantiate()
	var enemy_pos = Vector2i(start_x + room_width / 2, start_y + room_height / 2 + 1)
	enemy.position = tile_map.map_to_local(enemy_pos)
	add_child(enemy)

	# Position player
	var player_pos = Vector2i(start_x + room_width / 2, start_y + room_height - 2)
	player.global_position = tile_map.map_to_local(player_pos)