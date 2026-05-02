extends Control
class_name TitleScreen

func _ready() -> void:
	%play.pressed.connect(_play_pressed)
	%quit.pressed.connect(_quit_pressed)
	get_tree().paused = false
	Global.current_game_state = Global.game_states.TITLE

func _play_pressed() -> void:
	SceneManager.change_scene("res://Screens/Arena/arena.tscn")

func _quit_pressed() -> void:
	get_tree().quit()
