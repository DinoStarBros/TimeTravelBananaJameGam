extends State

func enter() -> void:
	p.has_banana = false
	p.velocity = -p.dir_to_mouse * p.boomerang_throw_recoil
	state_duration = p.boomerang_throw_duration
	
	%rang_throw.pitch_scale = 1.5 + randf_range(-.1, .1)
	%rang_throw.play()
	
	_spawn_bananarang()

func physics_update(delta: float) -> void:
	state_duration = max(state_duration - delta, 0)
	if state_duration <= 0:
		state_machine.change_state("walkdle")

func exit() -> void:
	pass

func _spawn_bananarang() -> void:
	var bananarang : Bananarang = References.bananarang_scn.instantiate()
	Global.arena.add_child(bananarang)
	bananarang.global_position = p.global_position
	
	bananarang.velocity = p.dir_to_mouse * p.bananarang_speed
