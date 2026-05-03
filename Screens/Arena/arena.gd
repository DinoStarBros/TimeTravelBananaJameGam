extends Node2D
class_name Arena

@onready var camera: Camera = %Camera
@onready var enemy_spawner: EnemySpawner = %EnemySpawner
@onready var path_follow_2d: PathFollow2D = %PathFollow2D
@onready var spawn_timer: Timer = %SpawnTimer

var cam_desire_pos : Vector2
var screen_half : Vector2
var enemy_spawn_amount : int = 1

const base_enemy_spawn_cooldown : float = 4.0

func _ready() -> void:
	screen_half = get_viewport_rect().size / 2
	Global.arena = self
	Global.past_sprite = %past_sprite
	spawn_timer.timeout.connect(spawn_enemy)

func _process(delta: float) -> void:
	
	cam_desire_pos = (Global.player.global_position + screen_half + Vector2(0, -300)) / 2
	camera.global_position.x = lerp(camera.global_position.x, cam_desire_pos.x, 15.0 * delta)

func spawn_enemy() -> void:
	path_follow_2d.progress_ratio = randf()
	enemy_spawner.spawn_enemy()
	spawn_timer.start(
		get_enemy_spawn_time(Global.time_passed)
	)

func get_enemy_spawn_time(time_passed: float) -> float:
	return base_enemy_spawn_cooldown * (
		Scalings.linear_scaling(
		get_current_minute(time_passed),
		0.4,
		false
		)
	)

func get_current_minute(time_passed: float) -> int:
	return int(time_passed / 60)
