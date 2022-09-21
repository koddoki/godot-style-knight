extends KinematicBody2D

func _ready() -> void:
	$Sword.visible = false;
	

func preCorte():
	$Sword.visible = true;

func parteQueDoi():
	$Sword/Corta.set_collision_mask_bit(0, true);

func posCorte():
	$Sword/Corta.set_collision_mask_bit(0, false);
	$Sword.visible = false;


func _on_AreaDaRaiva_body_entered(body: Node) -> void:
	if position.x < body.position.x:
		scale.x = 1
	elif position.x > body.position.x:
		scale.x = -1

	$AnimationPlayer.play("Fatia");


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Fatia":
		$AnimationPlayer.play("RESET");


func _on_Corta_body_entered(body: Node) -> void:
	body.dor(position.x, position.y);


func _on_TextEdit_text_changed() -> void:
	$Sword.modulate = get_parent().get_node("player/Sprite").modulate
	$Sprite.modulate = get_parent().get_node("player/Sprite").modulate
