extends Control

var lyric = preload("res://lyric.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func create_line(text:String):
	var new_line = lyric.instantiate()
	