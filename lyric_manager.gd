extends Label
class_name Lyric

var lyric:String
var stage = 0

func _ready():
	$AnimationPlayer.play("text_prepare")
	text = lyric

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
		play_active()
	if stage == 1:
		play_out()
	if stage == 2:
		play_remove()
	stage += 1
