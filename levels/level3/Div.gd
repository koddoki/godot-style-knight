extends Node

var containerSizeX = 1536
var containerSizeY = 900
var halfContainerX = containerSizeX/2
var halfContainerY = containerSizeY/2

onready var ray = get_node("RayCast2D")
onready var boxQuantidade = get_child_count() - 1

var offSetX
var offSetY

var boxSizeX = 57
var boxSizeY = 80

onready var boxSpaceX = boxSizeX * boxQuantidade
onready var boxSpaceY = boxSizeY * boxQuantidade
var boxList = []

var flexDirection = "row"
var functions = [
	"class",
	"justify-content","FILL",
	"align-items","FILL"
]


func _ready():
	get_container_size()
	add_boxes()
	set_up_boxes()
	sort_boxes()
	process_class(functions)


func get_container_size():
	$RayCast2D.cast_to = Vector2(-1536,0)
	ray.force_raycast_update()
	offSetX = $RayCast2D.global_transform.origin.distance_to($RayCast2D.get_collision_point())

	$RayCast2D.cast_to = Vector2(0,-1536)
	ray.force_raycast_update()
	offSetY = $RayCast2D.global_transform.origin.distance_to($RayCast2D.get_collision_point())

	$RayCast2D.cast_to = Vector2(1536,0)
	ray.force_raycast_update()
	var rigth = $RayCast2D.global_transform.origin.distance_to($RayCast2D.get_collision_point())
	
	$RayCast2D.cast_to = Vector2(0,1536)
	ray.force_raycast_update()
	var bottom = $RayCast2D.global_transform.origin.distance_to($RayCast2D.get_collision_point())
	
	containerSizeX = offSetX + rigth
	containerSizeY = offSetY + bottom
	halfContainerX = containerSizeX/2
	halfContainerY = containerSizeY/2
	
	offSetX -= boxSizeX/2
	offSetY -= boxSizeY/2
	
	remove_child(ray)
	ray.queue_free()


func process_class(a):
	var tempFunctions = ["class"]
	var count = 0
	
	for  i in (a.size() - 1)/2:
		count+=1
		i+=count
		
		match a[i]:
			"justify-content":
				tempFunctions.append_array([a[i],a[i+1]])
				justify_content(a[i+1])
				
			
			"align-items":
				tempFunctions.append_array([a[i],a[i+1]])
				align_items(a[i+1])
				
			
			"flex-direction":
				flexDirection = a[i+1]
				reload()
			
			_:
				break
		
		if not a[0] == "reset":
			functions = tempFunctions
	


func justify_content(parament):
	var local = 0
	var increment = 0
	
	match parament:
		"center":
			match flexDirection:
				"column":
					local = halfContainerY - boxSpaceY/2
					increment = boxSizeY
					basic_placement_y(local, increment, offSetY)
				
				"row-reverse":
					local = halfContainerX - boxSpaceX/2
					increment = boxSizeX
					basic_placement_x_reverse(local, increment, offSetX)
				
				"column-reverse":
					local = halfContainerY - boxSpaceY/2
					increment = boxSizeY
					basic_placement_y_reverse(local, increment, offSetY)
				
				_:
					local = halfContainerX - boxSpaceX/2
					increment = boxSizeX
					basic_placement_x(local, increment, offSetX)
		
		"flex-end":
			match flexDirection:
				"column":
					local = containerSizeY - boxSpaceY
					increment = boxSizeY
					basic_placement_y(local, increment, offSetY)
				
				"column-reverse":
					increment = boxSizeY
					basic_placement_y_reverse(local, increment, offSetY)
				
				"row-reverse":
					increment = boxSizeX
					basic_placement_x_reverse(local, increment, offSetX)
				
				_:
					local = containerSizeX - boxSpaceX
					increment = boxSizeX
					basic_placement_x(local, increment, offSetX)
		
		"space-between":
			match flexDirection:
				"column":
					increment = containerSizeY - boxSizeY
					increment /= boxQuantidade - 1
					basic_placement_y(local, increment, offSetY)
				
				"column-reverse":
					increment = containerSizeY - boxSizeY
					increment /= boxQuantidade - 1
					basic_placement_y_reverse(local, increment, offSetY)
				
				"row-reverse":
					increment = containerSizeX - boxSizeX
					increment /= boxQuantidade - 1
					basic_placement_x_reverse(local, increment, offSetX)
				
				_:
					increment = containerSizeX - boxSizeX
					increment /= boxQuantidade - 1
					basic_placement_x(local, increment, offSetX)
		
		"space-around":
			match flexDirection:
				"column":
					increment = containerSizeY - boxSpaceY
					increment = increment/(boxQuantidade * 2)
					increment += boxSizeY/2
					for box in boxList:
						local += increment
						box.position.y = local - (offSetY + boxSizeY/2)
						local += increment
				
				"column-reverse":
					increment = containerSizeY - boxSpaceY
					increment = increment/(boxQuantidade * 2)
					increment += boxSizeY/2
					for box in range(len(boxList) - 1, -1, -1):
						local += increment
						boxList[box].position.y = local - (offSetY + boxSizeY/2)
						local += increment
				
				"row-reverse":
					increment = containerSizeX - boxSpaceX
					increment = increment/(boxQuantidade * 2)
					increment += boxSizeX/2
					for box in range(len(boxList) - 1, -1, -1):
						local += increment
						boxList[box].position.x = local - (offSetX + boxSizeX/2)
						local += increment
				
				_:
					increment = containerSizeX - boxSpaceX
					increment = increment/(boxQuantidade * 2)
					increment += boxSizeX/2
					for box in boxList:
						local += increment
						box.position.x = local - (offSetX + boxSizeX/2)
						local += increment
		
		"space-evenly":
			match flexDirection:
				"column":
					increment = containerSizeY - boxSpaceY
					increment = increment/(boxQuantidade + 1)
					local += increment + boxSizeY/2
					for box in boxList:
						box.position.y = local - (offSetY + boxSizeY/2)
						local += increment + boxSizeY
				
				"column-reverse":
					increment = containerSizeY - boxSpaceY
					increment = increment/(boxQuantidade + 1)
					local += increment + boxSizeY/2
					for box in range(len(boxList) - 1, -1, -1):
						boxList[box].position.y = local - (offSetY + boxSizeY/2)
						local += increment + boxSizeY
				
				"row-reverse":
					increment = containerSizeX - boxSpaceX
					increment = increment/(boxQuantidade + 1)
					local += increment + boxSizeX/2
					for box in range(len(boxList) - 1, -1, -1):
						boxList[box].position.x = local - (offSetX + boxSizeX/2)
						local += increment + boxSizeX
				
				_:
					increment = containerSizeX - boxSpaceX
					increment = increment/(boxQuantidade + 1)
					local += increment + boxSizeX/2
					for box in boxList:
						box.position.x = local - (offSetX + boxSizeX/2)
						local += increment + boxSizeX
		
		_:
			match flexDirection:
				"column":
					increment = boxSizeY
					basic_placement_y(local, increment, offSetY)
				
				"column-reverse":
					local = containerSizeY - boxSpaceY
					increment = boxSizeY
					basic_placement_y_reverse(local, increment, offSetY)
				
				"row-reverse":
					local = containerSizeX - boxSpaceX
					increment = boxSizeX
					basic_placement_x_reverse(local, increment, offSetX)
				
				_:
					increment = boxSizeX
					basic_placement_x(local, increment, offSetX)


func align_items(parament):
	var local = 0
	var increment = 0
	
	match parament:
		"center":
			match flexDirection:
				"column":
					local = halfContainerX - boxSizeX/2
					for box in boxQuantidade:
						get_child(box).position.x = local - offSetX
				
				"column-reverse":
					local = halfContainerX - boxSizeX/2
					for box in boxQuantidade:
						get_child(box).position.x = local - offSetX
				
				_:
					local = halfContainerY - boxSizeY/2
					for box in boxQuantidade:
						get_child(box).position.y = local - offSetY
		
		"flex-end":
			match flexDirection:
				"column":
					local = containerSizeX - boxSizeX
					basic_placement_x(local, increment, offSetX)
				
				"column-reverse":
					local = containerSizeX - boxSizeX
					basic_placement_x(local, increment, offSetX)
				
				_:
					local = containerSizeY - boxSizeY
					basic_placement_y(local, increment, offSetY)
		
		_:
			match flexDirection:
				"column":
					basic_placement_x(local, increment, offSetX)
				
				"column-reverse":
					basic_placement_x_reverse(local, increment, offSetX)
				
				"row-reverse":
					basic_placement_y_reverse(local, increment, offSetY)
				
				_:
					basic_placement_y(local, increment, offSetY)


func add_boxes():
	for box in boxQuantidade:
		boxList.append(get_child(box))


func set_up_boxes():
	for box in boxList:
		box.containerSizeX = containerSizeX
		box.containerSizeY = containerSizeY
		box.offSetX = offSetX
		box.offSetY = offSetY


func sort_boxes():
	for i in boxQuantidade:
		for j in boxQuantidade - 1:
			if boxList[i].ordem < boxList[j].ordem:
				var temp = boxList[i]
				boxList[i] = boxList[j]
				boxList[j] = temp


func basic_placement_x(local, increment, offSet):
	for box in boxList:
		box.position.x = local - offSet
		local += increment


func basic_placement_y(local, increment, offSet):
	for box in boxList:
		box.position.y = local - offSet
		local += increment


func basic_placement_x_reverse(local, increment, offSet):
	for box in range(len(boxList) - 1, -1, -1):
		boxList[box].position.x = local - offSet
		local += increment


func basic_placement_y_reverse(local, increment, offSet):
	for box in range(len(boxList) - 1, -1, -1):
		boxList[box].position.y = local - offSet
		local += increment


func reload():
	process_class([
	"reset",
	"justify-content","FILL",
	"align-items","FILL"
	])
	process_class(functions)


