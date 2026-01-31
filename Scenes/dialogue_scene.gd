extends CanvasLayer

@onready var text_label = $DialogueUI/TextBoxContainer/DialogueText
@onready var name_label = $DialogueUI/TextBoxContainer/NameTag

var lines = [
	{"name": "???", "text": "The cycle begins again..."},
	{"name": "You", "text": "I will find my way out."}
]
var current_line = 0

func _input(event):
	if event.is_action_pressed("ui_accept"):
		current_line += 1
		if current_line < lines.size():
			update_ui()
		else:
			get_tree().change_scene_to_file("res://Scenes/battle_arena.tscn")

func update_ui():
	name_label.text = lines[current_line]["name"]
	text_label.text = lines[current_line]["text"]
