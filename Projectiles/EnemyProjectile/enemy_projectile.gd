extends Projectile
class_name EnemyProjectile

var direction : Vector2

func _ready() -> void:
	velocity = direction * 500
	%Reflecto.area_entered.connect(_reflecto_area)

func _physics_process(delta: float) -> void:
	_move(delta)

func _reflecto_area(area: Area2D) -> void:
	if area is HitboxComponent:
		_spawn_reflected_projectile()
		queue_free()

func _spawn_reflected_projectile() -> void:
	var reflected_projectile : ReflectedProjectile = References.reflected_projectile_scn.instantiate()
	reflected_projectile.direction = -direction
	Global.arena.add_child(reflected_projectile)
	reflected_projectile.global_position = global_position
