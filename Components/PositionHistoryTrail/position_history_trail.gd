extends Node2D
class_name PositionHistoryTrail

@export var trail_length: int = 30
@export var trail_spacing: float = 0.2  ## seconds between each trail point
@export var trail_sprite: PackedScene  ## Assign a Sprite2D scene (circle, banana, etc)
@export var _history_node: Node

var _trail_sprites: Array[Sprite2D] = []

func _ready():
	if not _history_node:
		print("ERROR: PositionTrail needs a PositionHistoryRecorder node on the same parent")
		return
	
	# Create trail sprites
	for i in range(trail_length):
		var sprite = trail_sprite.instantiate()
		add_child(sprite)
		var alpha = 1.0 - (float(i) / float(trail_length))
		sprite.modulate = Color(1, 1, 1, alpha)
		_trail_sprites.append(sprite)

func _process(delta):
	if not _history_node:
		return
	
	for i in range(trail_length):
		var time_ago = float(i + 1) * trail_spacing
		var past_pos = _history_node.get_position_from_past(time_ago)
		
		if past_pos != Vector2.ZERO and i < _trail_sprites.size():
			_trail_sprites[i].global_position = past_pos
