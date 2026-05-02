extends Projectile
class_name FlyingCorpse

@onready var sprite: Sprite2D = %Eneme

var sprite_texture : Texture2D
var dir_to_attack : Vector2

func _ready() -> void:
	sprite.texture = sprite_texture
	_spawn_hitspark()

func _physics_process(delta: float) -> void:
	
	_move(delta)
	
	velocity.y += 1000 * delta

func _spawn_hitspark() -> void:
	var hitspark : Hitspark = References.hitspark_scn.instantiate()
	hitspark.global_position = global_position
	Global.arena.add_child(hitspark)
	hitspark.look_at(dir_to_attack)
	hitspark.rotation += PI
