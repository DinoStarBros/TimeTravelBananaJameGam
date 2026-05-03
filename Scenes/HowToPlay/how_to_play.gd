extends Control
class_name HowToPlay

var current_page : int = 0
@onready var pages : Array = [
	%p1,%p2,%p3,%p4,%p5
	
]
@onready var vids : Array = [
	%vid1,%vid2,%vid3,%vid4,%vid5
]

@onready var page_no: Label = %page_no

func _ready() -> void:
	current_page = 0
	_update_page()

func _on_close_pressed() -> void:
	hide()


func _on_left_pressed() -> void:
	page_change(-1)


func _on_right_pressed() -> void:
	page_change(1)

func page_change(step: int) -> void:
	current_page += step
	_update_page()

func _update_page() -> void:
	var ndex : int = -1
	for page in pages:
		page.hide()
		ndex += 1
		if ndex == current_page:
			page.show()
	
	for video in vids:
		var vid_par = video.get_parent().get_parent()
		
		if vid_par.visible:
			video.play()
		else:
			video.stop()
func _process(delta: float) -> void:
	page_no.text = str(current_page + 1, " / ", pages.size())
