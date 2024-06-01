extends CharacterBody2D
class_name Projectile

@export var speed = 300
@export var direction = Vector2.RIGHT

@onready var bullet_coll = $CollisionShape2D
@onready var area_coll = $Area2D/CollisionShape2D
@onready var sprite = $Sprite2D
@onready var light = $PointLight2D

func _ready():	
	rotation = 90
	
func _physics_process(_delta):
	move_and_slide()
	
	
func set_direction(new_direction: Vector2):
	velocity = new_direction * speed


func _on_timer_timeout():
	queue_free()


func _on_area_2d_body_entered(body):
	if body is Enemy && body.isDead:
		return
	AudioManager.play_sfx("fireHit")
	queue_free()

func disable_bullet():
	bullet_coll.disabled = true
	area_coll.disabled = true
	sprite.visible = false
	light.enabled = false
