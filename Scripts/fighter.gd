extends Node2D

@onready var anim = $AnimationPlayer
@onready var visuals = $Visuals
@onready var hit_spark = $HitSpark

func play_attack(stance_index):
	var stance_names = ["HEAVEN", "EARTH", "MAN"]
	var anim_name = "attack_" + stance_names[stance_index]
	
	if anim.has_animation(anim_name):
		# Create a quick "transition" effect
		var t = create_tween()
		# Briefly squash the character down before the new frame appears
		t.tween_property(visuals, "scale", Vector2(1.2, 0.8), 0.05)
		t.tween_callback(anim.play.bind(anim_name)) # Change frame mid-squash
		t.tween_property(visuals, "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_ELASTIC)

func take_hit():
	print(name + " took damage!")
	
	hit_spark.emitting = true
	
	# Simple flash red effect
	var tween = create_tween()
	tween.tween_property(visuals, "modulate", Color.RED, 0.1)
	tween.tween_property(visuals, "modulate", Color.WHITE, 0.1)
