class_name  FloorDetector extends Area2D

signal left_floor;
signal touched_floor(body : Node2D);

var collidingPlatforms : Array = Array();
func remove_ground_from_array(body : Node2D) -> void:
	collidingPlatforms.erase(body);
	pass

func add_ground_to_array(body : Node2D) -> void:
	var isNewFloor : bool = collidingPlatforms.is_empty();
	collidingPlatforms.append(body);
	if(isNewFloor):
		emit_signal("touched_floor", body);
	pass

func _ready():
	self.connect("body_entered", add_ground_to_array);
	self.connect("body_exited", remove_ground_from_array);
