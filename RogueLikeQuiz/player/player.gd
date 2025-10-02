extends CharacterBody2D

signal health_changed(new_health)
signal player_died

const SPEED = 150.0

@onready var animated_sprite = $AnimatedSprite2D
@onready var interaction_area = $InteractionArea

var health = 3
var quiz_ui = null
var interactable = null

func _ready():
	interaction_area.area_entered.connect(_on_interaction_area_entered)
	interaction_area.area_exited.connect(_on_interaction_area_exited)
	player_died.connect(func(): get_tree().reload_current_scene())

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and interactable != null:
		var question = QuestionDB.get_random_question()
		if question:
			if quiz_ui == null:
				quiz_ui = get_tree().root.get_node("World/QuizUI")
			quiz_ui.show_question(question)
			if not quiz_ui.answer_selected.is_connected(_on_quiz_answered):
				quiz_ui.answer_selected.connect(_on_quiz_answered)

func take_damage(amount):
	health -= amount
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("player_died")

func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = direction.normalized() * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	update_animation()

func update_animation():
	var direction = "down"
	if velocity.length() > 0:
		if abs(velocity.x) > abs(velocity.y):
			direction = "side"
			animated_sprite.flip_h = velocity.x < 0
		else:
			direction = "up" if velocity.y < 0 else "down"
		animated_sprite.play("walk_" + direction)
	else:
		if "side" in animated_sprite.animation:
			direction = "side"
		elif "up" in animated_sprite.animation:
			direction = "up"
		animated_sprite.play("idle_" + direction)

func _on_interaction_area_entered(area):
	interactable = area

func _on_interaction_area_exited(area):
	if interactable == area:
		interactable = null

func _on_quiz_answered(is_correct):
	if interactable == null: return

	if is_correct:
		if interactable.is_in_group("enemy"):
			interactable.take_damage(1)
		elif interactable.is_in_group("door"):
			interactable.unlock()
	else:
		take_damage(1)

	interactable = null