extends Label
class_name Lyric

var lyric:String
var stage = 0

func _ready():
	text = lyric

func play_prepare():
	$AnimationPlayer.play("text_prepare")

func play_active():
	$AnimationPlayer.play("text_current")

func play_out():
	$AnimationPlayer.play("text_out")

func play_remove():
	$AnimationPlayer.play("text_remove")

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "text_remove":
		queue_free()

func play_next():
	if stage == 0:
		play_prepare()
	elif stage == 1:
		DiscordRPC.state = lyric
		DiscordRPC.refresh()
		play_active()
	elif stage == 2:
		play_out()
	elif stage == 3:
		play_remove()
	stage += 1
