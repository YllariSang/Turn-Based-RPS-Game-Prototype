extends Node2D

@onready var anim = $AnimationPlayer
@onready var visuals = $Visuals
@onready var hit_spark = $HitSpark

var clash_tween: Tween
var original_position: Vector2
var attack_tween: Tween

func _ready():
	original_position = global_position

func play_attack(stance_index):
	if attack_tween: attack_tween.kill()
	attack_tween = create_tween()
	var stance_names = ["HEAVEN", "EARTH", "MAN"]
	var anim_name = "attack_" + stance_names[stance_index]
	
	if anim.has_animation(anim_name):
		if attack_tween: attack_tween.kill()
		attack_tween = create_tween()
		
		attack_tween.tween_property(visuals, "scale", Vector2(1.2, 0.8), 0.05)
		attack_tween.tween_callback(anim.play.bind(anim_name))
		attack_tween.tween_property(visuals, "scale", Vector2(1.0, 1.0), 0.1)

func play_clash():
	if anim.has_animation("clash") and anim.current_animation != "clash":
		anim.play("clash")
	
	if clash_tween:
		clash_tween.kill()
	
	clash_tween = create_tween().set_loops()
	clash_tween.tween_property(visuals, "position", Vector2(randf_range(-3, 3), randf_range(-1, 1)), 0.07)
	clash_tween.tween_property(visuals, "position", Vector2.ZERO, 0.07)

func stop_clash_effects():
	if clash_tween:
		clash_tween.kill()
	visuals.position = Vector2.ZERO # Reset position

func take_hit():
	print(name + " took damage!")
	hit_spark.emitting = true
	
	if anim.has_animation("take_hit"):
		anim.play("take_hit")
	
	var tween = create_tween()
	tween.tween_property(visuals, "modulate", Color.RED, 0.1)
	tween.tween_property(visuals, "modulate", Color.WHITE, 0.1)
	
	await anim.animation_finished 
	anim.play("idle")

func play_mash_jolt():
	var t = create_tween()
	t.tween_property(visuals, "scale", Vector2(1.1, 1.1), 0.05)
	t.tween_property(visuals, "scale", Vector2(1.0, 1.0), 0.05)

func approach_target(target_pos: Vector2, duration: float = 0.2):
	var tween = create_tween().set_parallel(true)
	# Move toward the center/target
	tween.tween_property(self, "global_position", target_pos, duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	return tween

func return_to_start(duration: float = 0.3):
	var tween = create_tween()
	tween.tween_property(self, "global_position", original_position, duration).set_trans(Tween.TRANS_SINE)
