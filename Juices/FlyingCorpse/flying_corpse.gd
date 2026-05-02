extends Projectile
class_name FlyingCorpse

@onready var sprite: Sprite2D = %Eneme
@onready var timer: Timer = %Timer

var sprite_texture : Texture2D
var dir_to_attack : Vector2

func _ready() -> void:
	sprite.texture = sprite_texture
	_spawn_hitspark()
	_spawn_big_cleave()
	
	velocity = -dir_to_attack * 1000
	play_sfx()
	%Timer.timeout.connect(func(): queue_free())
	
	velocity.y -= 500

func _physics_process(delta: float) -> void:
	
	_move(delta)
	
	sprite.rotation += randf_range(3,5) * PI * delta
	velocity.y += 1000 * delta

func _spawn_hitspark() -> void:
	var hitspark : Hitspark = References.hitspark_scn.instantiate()
	hitspark.global_position = global_position
	Global.arena.add_child(hitspark)
	hitspark.look_at(dir_to_attack + global_position)
	hitspark.rotation += PI

func _spawn_big_cleave() -> void:
	var big_cleave : BigCleave = References.big_cleave_scn.instantiate()
	big_cleave.global_position = global_position
	Global.arena.add_child(big_cleave)
	big_cleave.look_at(dir_to_attack + global_position)


func play_sfx() -> void:
	
	%death.pitch_scale = 0.5 + randf_range(-.2, .2)
	%death2.pitch_scale = 1 + randf_range(-.2, .2)
	%death3.pitch_scale = 1.2 + randf_range(-.2, .2)
	%death.play()
	%death2.play()
	%death3.play()
