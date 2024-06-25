extends MarginContainer

@export var song:String
@export var album:String
@export var artist:String

# Called when the node enters the scene tree for the first time.
func _ready():
	%Song.text = song
	%Album.text = album
	%Artist.text = artist
