extends CanvasLayer

signal answer_selected(is_correct)

@onready var question_label = $Panel/VBoxContainer/QuestionLabel
@onready var answers_container = $Panel/VBoxContainer/AnswersContainer

var current_question

func _ready():
	# Connect all buttons to the same function
	for button in answers_container.get_children():
		button.pressed.connect(_on_answer_button_pressed.bind(button))

func show_question(question_data):
	current_question = question_data
	question_label.text = current_question.question

	var answers = current_question.answers
	for i in range(answers_container.get_child_count()):
		var button = answers_container.get_child(i)
		if i < answers.size():
			button.text = answers[i]
			button.visible = true
		else:
			button.visible = false

	self.visible = true
	get_tree().paused = true

func _on_answer_button_pressed(button):
	var buttons = answers_container.get_children()
	var selected_index = buttons.find(button)

	var is_correct = (selected_index == current_question.correct)

	emit_signal("answer_selected", is_correct)

	self.visible = false
	get_tree().paused = false