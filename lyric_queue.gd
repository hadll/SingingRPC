extends Control

var lyric = preload("res://lyric.tscn")

var lyrics = {"0:1.00":"Wawa", "0:3.0":"wewo", "0:4.0":"testing"}
var line = -1
var time = 0

func create_line(text:String):
	var new_line = lyric.instantiate()
	new_line.lyric = text
	%Lyric_bar.add_child(new_line)

func _ready():
	_on_timer_timeout()

func _on_timer_timeout():
	line += 1
	if line < lyrics.size():
		var time_to_add = string_to_seconds(lyrics.keys()[line])
		$Timer.start(time_to_add-time)
		time += time_to_add
		
		create_line(lyrics.values()[line])
	for item in %Lyric_bar.get_children():
		if item is Lyric:
			item.play_next()

func string_to_seconds(time_string: String) -> float:
	var parts = time_string.split(":")
	var minutes = parts[0].to_int()
	var seconds_and_milliseconds = parts[1].split(".")
	var seconds = seconds_and_milliseconds[0].to_int()
	var milliseconds = seconds_and_milliseconds[1].to_int()
	var total_seconds = minutes * 60 + seconds + milliseconds / 1000.0
	return total_seconds

