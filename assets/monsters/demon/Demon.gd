extends KinematicBody2D
#onready var path_follow = get_parent();
export var speed = 150;
var velocity = Vector2();
var direction = Vector2();
var move_direction = 0;

func _physics_process(delta: float) -> void:
	movimento(delta);


func movimento(delta):
	velocity = direction.normalized() * speed;
	velocity = move_and_slide(velocity);
	if is_on_wall():
		direction.x *= -1;

func _on_Heart_body_entered(body: Node) -> void:
	$Timer.start();
	direction.y = -1;


func _on_Timer_timeout() -> void:
	direction.x = 1;
	direction.y = 0;

func process_class(a):
	var count = 0
	
	for  i in (a.size() - 1)/2:
		count+=1
		i+=count
		
		match a[i]:
			"color":
				var cor = validade_color(a[i+1])
				$Sprite.modulate = Color(cor[0],cor[1],cor[2])
				print($Sprite.modulate)
				
			"size":
				scale = Vector2(a[i+1],a[i+1])
				print("cor")
			_:
				break


func validade_color(color):
	match color:
		"red":
			return [1,0,0]
		"blue":
			return [0,0,1]
		"green":
			return [0,1,0]
		"yellow":
			return [1,1,0]
		_:
			return [1,1,1]


# O que sobrou do PathFollowing2D

#movement_loop(delta);
	#animation_loop();

#func movement_loop(delta):
#	var prepos = path_follow.get_global_position();
#	path_follow.set_offset(path_follow.get_offset()+ speed * delta)
#	var pos = path_follow.get_global_position();
#	move_direction = (pos.angle_to_point(prepos)/3.14)*180;


#func animation_loop():
#	if  move_direction >= -180 and move_direction < -90.045652:
#		$Sprite.set_flip_h(true);
#	elif  move_direction >= -90 and move_direction < 0:
#		$Sprite.set_flip_h(false);
#	elif  move_direction >= 0 and move_direction < 90:
#		$Sprite.set_flip_h(false);
#	elif  move_direction >= 90.045652 and move_direction < 180:
#		$Sprite.set_flip_h(true);



