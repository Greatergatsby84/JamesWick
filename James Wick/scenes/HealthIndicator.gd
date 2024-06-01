extends CanvasLayer

@onready var health1 =$health1
@onready var health2 =$health2
@onready var health3 =$health3
@onready var healthPool = [health1,health2,health3]
@onready var dmgFlash = $dmgFlash/AnimationPlayer


func updateHealth(healthAmount):
	healthPool[healthAmount].play("extinguish")
	dmgFlash.play("flash")

