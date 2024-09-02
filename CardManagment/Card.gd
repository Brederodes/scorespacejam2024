class_name Card extends Node2D

var is_ready : bool = false;
@export var card_timer : Timer;

var player : Player;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start_ready_timer(cooldown : float) -> void:
	card_timer.one_shot = true;
	card_timer.connect("timeout", _make_card_ready);
	card_timer.start(cooldown);
	pass
func _make_card_ready():
	is_ready = true;
func do_ability() -> void:
	pass;
