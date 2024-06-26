extends Control

var i = 0

var result_scene = preload("res://songresult.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	DiscordRPC.app_id = 1255164075353309304 # Application ID
	DiscordRPC.details = "Making a cool thing in godot"
	DiscordRPC.state = "probably left it open by accident"
	DiscordRPC.large_image = "example_game" # Image key from "Art Assets"
	DiscordRPC.large_image_text = "Try it now!"
	DiscordRPC.small_image = "boss" # Image key from "Art Assets"
	DiscordRPC.small_image_text = "Fighting the end boss! D:"

	DiscordRPC.start_timestamp = int(Time.get_unix_time_from_system()) # "02:46 elapsed"
	# DiscordRPC.end_timestamp = int(Time.get_unix_time_from_system()) + 3600 # +1 hour in unix time / "01:00:00 remaining"

	DiscordRPC.refresh() # Always refresh after changing the values!

	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DiscordRPC.run_callbacks()


func _on_search_button_pressed():
	var error = %HTTPRequest.request("https://lrclib.net/api/search?q="+%Search_bar.text)
	if error != OK:
		push_error("bad things")
	else:
		%Searching_anim.visible = true
	


func _on_http_request_request_completed(result, response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())
	%Searching_anim.visible = false
	for song in response:
		var new_song = result_scene.instantiate()
		new_song.song = song["name"]
		new_song.album = song["albumName"]
		new_song.artist = song["artistName"]
		%ResultContainer.add_child(new_song)
