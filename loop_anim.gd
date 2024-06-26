extends TextureRect

@export var player:AnimationPlayer
@export var animation:String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	restart_anim()
	player.connect("animation_finished", restart_anim)

func restart_anim() -> void:
	player.play(animation)
