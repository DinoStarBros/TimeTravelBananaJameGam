extends Node

enum game_states {
	TITLE, COMBAT, DEAD
}

var camera : Camera
var player : Player
var arena : Arena
var current_game_state : game_states
var past_sprite : Sprite2D

const FALL_SPD_LIMIT : float = 2000

func _volume_handle() -> void:
	AudioServer.set_bus_volume_db(
		0,
		linear_to_db(SaveLoad.settings.master_volume)
	)
	AudioServer.set_bus_volume_db(
		1,
		linear_to_db(SaveLoad.settings.music_volume)
	)
	AudioServer.set_bus_volume_db(
		2,
		linear_to_db(SaveLoad.settings.sfx_volume)
	)

func _init() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _ready() -> void:
	_volume_handle()

func _process(delta: float) -> void:
	_volume_handle()
