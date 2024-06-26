extends Label

var lyric:String

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
