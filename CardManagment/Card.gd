class_name Card extends Node2D

signal card_used(card: Card);
@export var use_button: Button;

@export var Slot:int = 0; #slots {0, 1, 2} on the hand
var isReady:bool = true;
 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	use_button.connect("pressed",getUsed);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func getUsed():
	get_parent().Use_card(self);
	return

func makeReady() -> void:
	self.isReady == true
	pass
	
func doAbility() -> void:
	card_used.emit(self);
	pass;
