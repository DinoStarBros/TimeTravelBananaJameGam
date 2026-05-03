extends State

var positions : Array
var past_position_idx : int = 0

func enter() -> void:
	state_duration = p.rewind_duration
	p.velocity = Vector2.ZERO
	p.enable_gravity = false
	p.hurtbox.disabled = true
	past_position_idx = 0
	p.clock_juice.enabled = true
	
	for trail_sprite in p.position_history_trail._trail_sprites:
		positions.append(trail_sprite.global_position)
	
	%rewind.play()
	%rewind2.play()
	%clock.pitch_scale = 2
	%clock.play()
	%rewind_step.pitch_scale = 0.1
	
	Global.camera.screen_shake(5, 1)


func physics_update(delta: float) -> void:
	state_duration = max(state_duration - delta, 0)
	past_position_idx = min(past_position_idx + 1, p.position_history_trail._trail_sprites.size())
	p.global_position = positions[past_position_idx - 1]
	%rewind_step.play()
	%rewind_step.pitch_scale += 0.05
	
	if state_duration <= 0: 
		state_machine.change_state("PastExplode")
		_spawn_clock_boom()

func exit() -> void:
	p.hurtbox.disabled = false
	p.clock_juice.enabled = false
	%clock.stop()
	%rewind2.stop()

func _spawn_clock_boom() -> void:
	var clock_boom : ClockBoom = References.clock_boom_scn.instantiate()
	Global.arena.add_child(clock_boom)
	clock_boom.global_position = p.global_position
	
	%explode.play()
