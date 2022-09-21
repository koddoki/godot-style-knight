extends StaticBody2D

export(String, "blue","green","red","yellow","") var corInicio
export (NodePath) var player_path = "../../player"
onready var player = get_node(player_path)


func _ready() -> void:
	player.connect("color_change", self, "update_collision")
	corzinhaBonitinha();


func corzinhaBonitinha():
	match corInicio:
		"red":
			$Sprite.modulate = Color(1,0,0)
			$Label.text = "#magicwall{color:red;}"
		"blue":
			$Sprite.modulate = Color(0,0,1)
			$Label.text = "#magicwall{color:blue;}"
		"green":
			$Sprite.modulate = Color(0,1,0)
			$Label.text = "#magicwall{color:green;}"
		"yellow":
			$Sprite.modulate = Color(1,1,0)
			$Label.text = "#magicwall{color:yellow;}"
		"":
			$Sprite.modulate = Color(1,1,1)
			$Label.text = "#magicwall{}"
	
	update_collision()


func update_collision():
	if player.get_node("Sprite").modulate == $Sprite.modulate:
		set_collision_mask_bit(0,0);
	else:
		set_collision_mask_bit(0,1);

	if get_parent().get_parent().get_node("Moidy/Sprite").modulate == $Sprite.modulate:
		set_collision_mask_bit(1,0);
	else:
		set_collision_mask_bit(1,1);


func dor(_x,_y):
	pass
