extends MarginContainer

@export var song:String
@export var album:String
@export var artist:String
@export var lyrics:String


signal button_pressed

# Called when the node enters the scene tree for the first time.
func _ready():
	%Song.text = song
	%Album.text = album
	%Artist.text = artist




func _on_button_pressed():
	button_pressed.emit(self)
