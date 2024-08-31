extends Area2D

var currentTouchingFloors : Array;
signal turned_airborne;
signal turned_grounded;

func _ready():
	connect("body_entered", _on_touching_floor);
	connect("body_exited", _on_exiting_floor);

func _on_exiting_floor(floor : Node2D):
	currentTouchingFloors.erase(floor);
	if(currentTouchingFloors.size() == 0):
		emit_signal("turned_airborne");
	pass
func _on_touching_floor(floor : Node2D):
	if(currentTouchingFloors.has(floor)):
		return;
	currentTouchingFloors.append(floor);
	if(currentTouchingFloors.size() == 1):
		emit_signal("turned_grounded");
	pass
