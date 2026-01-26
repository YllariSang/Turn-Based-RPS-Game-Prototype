extends Node2D

@onready var anim = $AnimationPlayer
@onready var visuals = $Visuals
@onready var hit_spark = $HitSpark

func play_attack(stance_index):
	
	var stance_names = ["HEAVEN", "EARTH", "MAN"]
	var anim_name = "attack_" + stance_names[stance_index]
	
	if anim.has_animation(anim_name):
		anim.play(anim_name)
	else:
		var tween = create_tween()
		var direction = 1 if name == "Player" else -1

		tween.tween_property(visuals, "position:x", 50 * direction, 0.1).set_trans(Tween.TRANS_CUBIC)
		tween.tween_property(visuals, "position:x", 0, 0.2)

func take_hit():
	print(name + " took damage!")
	
	hit_spark.emitting = true
	
	# Simple flash red effect
	var tween = create_tween()
	tween.tween_property(visuals, "modulate", Color.RED, 0.1)
	tween.tween_property(visuals, "modulate", Color.WHITE, 0.1)
