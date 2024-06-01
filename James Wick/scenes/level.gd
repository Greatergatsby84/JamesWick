extends Node2D
class_name Level
@export var next_level : PackedScene
@onready var elevatorTransition = $ElevatorTransition
var isLevelOver = false
# Called when the node enters the scene tree for the first time.
func _ready():
	AudioManager.play_level_music()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func win():
	isLevelOver = true

func isOver():
	return isLevelOver

func go_to_next_level():
	if next_level != null:
		await elevatorTransition.closeDoor()
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_packed(next_level)
	else:
		print("win")

func die():
	await elevatorTransition.closeDoor()
	await get_tree().create_timer(0.5).timeout
	get_tree().reload_current_scene()
