extends Control


@onready var player = $AnimationPlayer
@onready var elevator = $ElevatorTransition
@onready var level = preload("res://scenes/level_foyer.tscn")
var started = false
func _ready():
	print(get_tree())
	print(level)
	
func _process(_delta):
	if Input.is_key_pressed(KEY_ENTER):
		startLevel()


func _on_animation_player_animation_finished(anim_name):
	await get_tree().create_timer(1.0).timeout
	startLevel()

func startLevel():
	if started:
		return
	started = true
	elevator.visible = true
	await elevator.closeDoor()
	print(get_tree())
	print(level)
	get_tree().change_scene_to_packed(level)
