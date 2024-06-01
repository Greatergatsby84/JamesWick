extends Node2D


@onready var fireShoot = preload("res://audio/fireshoot.ogg")
@onready var fireHit = preload("res://audio/firehit.ogg")
@onready var ding = preload("res://audio/elevatording.wav")
@onready var oof = [preload("res://audio/oof.wav"),preload("res://audio/oof2.wav")]
@onready var ow = preload("res://audio/ow.wav")
@onready var hit = preload("res://audio/hit.wav")
@onready var deathchime = preload("res://audio/deathchime.ogg")
@onready var levelMusic = preload("res://audio/chipnese.ogg")
@onready var musicPlayer = $MusicPlayer

func play_sfx(sfx_name: String):
	var stream = null
	match(sfx_name):
		"fireShoot":
			stream = fireShoot
		"fireHit":
			stream = fireHit
		"ding":
			stream = ding
		"oof":
			stream = oof.pick_random()
		"deathchime":
			stream = deathchime
		"hit":
			stream = hit
		_:
			print("invalid sfx name")
	
	var asp = AudioStreamPlayer.new()
	asp.stream = stream
	asp.name = "SFX"
	add_child(asp)
	asp.play()
	await asp.finished
	asp.queue_free()

func stop_music():
	musicPlayer.stop()
	
func play_level_music():
	musicPlayer.stream = levelMusic
	musicPlayer.play()
