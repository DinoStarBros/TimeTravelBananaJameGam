extends CanvasLayer
class_name PauseUI

@onready var settings_menu: Settings = %settingsMenu

var sure_quit : bool = false

func _ready() -> void:
	%resume.pressed.connect(on_resume)
	%quit.pressed.connect(func():%sure.visible=!%sure.visible)
	%sure.pressed.connect(func():
		SceneManager.change_scene("res://Screens/TitleScreen/title_screen.tscn")
		settings_menu._save()
		)
	
	%Pause.pressed.connect(
		func():
			if Global.current_game_state == Global.game_states.COMBAT:
				pause_or_resume()
	)

func pause_or_resume() -> void:
	get_tree().paused = not get_tree().paused
	if get_tree().paused:
		# Pause
		settings_menu.on_pause()
		%sure.hide()
	else:
		# Resume
		settings_menu.on_resume()

func _process(delta: float) -> void:
	visible = get_tree().paused

	if (Input.is_action_just_pressed("esc") and 
		Global.current_game_state == Global.game_states.COMBAT
		):
			pause_or_resume()
	
	if Global.current_game_state == Global.game_states.DEAD:
		hide()
		settings_menu.hide()

func on_resume() -> void:
	get_tree().paused = false
	%settingsMenu._save()
	%sure.hide()
