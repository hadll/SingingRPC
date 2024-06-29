extends Control

var lyric = preload("res://lyric.tscn")

var lyrics = {}
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
	print(time)
	if line < lyrics.size():
		var time_to_add = string_to_seconds(lyrics.keys()[line])
		$Timer.start(time_to_add-time)
		time += time_to_add-time
		
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

func restart_song():
	line = -1
	time = 0
	$Timer.stop()
	_on_timer_timeout()
	for item in %Lyric_bar.get_children():
		if item is Lyric:
			item.queue_free()
	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system())
	DiscordRPC.end_timestamp = Time.get_unix_time_from_system()+string_to_seconds(lyrics.keys()[lyrics.size()-1])
	DiscordRPC.refresh()
	%active_bar_anim.play("slide_in")

func _process(delta):
	$Label.text = str($Timer.time_left)
	


func _on_close_button_pressed():
	$Timer.stop()
	for item in %Lyric_bar.get_children():
		if item is Lyric:
			item.queue_free()
	DiscordRPC.details = "Picking a song"
	DiscordRPC.end_timestamp = -1
	DiscordRPC.start_timestamp = Time.get_unix_time_from_system()
	DiscordRPC.refresh()
	%active_bar_anim.play("slide_out")


func _on_pause_button_pressed():
	pass # Replace with function body.
