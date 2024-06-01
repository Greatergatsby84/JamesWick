extends Control

@onready var elevator = $CanvasLayer/ElevatorTransition
func _on_button_pressed():
	await elevator.closeDoor()
	get_tree().change_scene_to_file("res://scenes/level_foyer.tscn")
