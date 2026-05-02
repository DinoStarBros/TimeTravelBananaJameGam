extends Projectile
class_name Bananarang

func _ready() -> void:
	%spin.play()

func _physics_process(delta: float) -> void:
	_move(delta)
	%banana.rotation_degrees += 2000 * delta
