class_name CardManager extends Control

@export var player : Player;
@export_category("iteration values")
@export var card_cooldown: float;
enum ABILITY_TYPES {JUMP, DASH, PORTAL, GRAPPLE, CARPET, SHIELD, GRAVITY, WATER};
#4 = Common, 2 = Uncommon, 1 = Rare
var Probability:Dictionary = {ABILITY_TYPES.JUMP : 4,
							  ABILITY_TYPES.DASH : 4,
							  ABILITY_TYPES.PORTAL : 4,
							  ABILITY_TYPES.GRAPPLE : 2,
							  ABILITY_TYPES.CARPET : 2,
							  ABILITY_TYPES.SHIELD : 2,
							  ABILITY_TYPES.GRAVITY : 1,
							  ABILITY_TYPES.WATER : 1}
							#Total = 20 pls update if changing rarites
var TotalWeight:int = 20;
var JumpCardScene = load("res://CardManagment/Abilites/Scenes/jump_card.tscn")
var DashCardScene = load("res://CardManagment/Abilites/Scenes/dash_card.tscn")
var PortalCardScene = load("res://CardManagment/Abilites/Scenes/portal_card.tscn")
var GrappleCardScene = load("res://CardManagment/Abilites/Scenes/grapple_card.tscn")
var CarpetCardScene = load("res://CardManagment/Abilites/Scenes/carpet_card.tscn")
var ShieldCardScene = load("res://CardManagment/Abilites/Scenes/shield_card.tscn")
var GravityCardScene = load("res://CardManagment/Abilites/Scenes/gravity_card.tscn")
var WaterCardScene = load("res://CardManagment/Abilites/Scenes/water_card.tscn")

var Cooldown:float = 0; #start testing at 0

var hand_cards : Array = Array();

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hand_cards.append(null);
	hand_cards.append(null);
	hand_cards.append(null);
	draw_new_card(0);
	draw_new_card(1);
	draw_new_card(2);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func random_ability() -> int:
	randomize()
	var random_value: int = randi_range(0, TotalWeight - 1);
	var cumulative_weight: int = 0;

	for ability in Probability.keys():
		cumulative_weight += Probability[ability]
		if random_value < cumulative_weight:
			return ability
	
	print("Ajeita o TotalWeight nerd");
	return -1
	
func create_random_card()-> Card:
	var newCard_Ability:int = random_ability();
	var newCard : Card;
	match newCard_Ability:
		ABILITY_TYPES.JUMP:
			newCard = JumpCardScene.instantiate();
		ABILITY_TYPES.DASH:
			newCard = DashCardScene.instantiate();
		ABILITY_TYPES.PORTAL:
			newCard = PortalCardScene.instantiate();
		ABILITY_TYPES.GRAPPLE:
			newCard = GrappleCardScene.instantiate();
		ABILITY_TYPES.CARPET:
			newCard = CarpetCardScene.instantiate();
		ABILITY_TYPES.SHIELD:
			newCard = ShieldCardScene.instantiate();
		ABILITY_TYPES.GRAVITY:
			newCard = GravityCardScene.instantiate();
		ABILITY_TYPES.WATER:
			newCard = WaterCardScene.instantiate();
	add_child(newCard);
	newCard.player = player;
	return newCard;
	
func draw_new_card(slot: int) -> void:
	var newCard:Card = create_random_card();
	newCard.is_ready = false;
	newCard.start_ready_timer(card_cooldown);
	newCard.position = Vector2(slot * 32 - 32, 100)
	hand_cards[slot] = newCard;
	pass

func delete_card_in_slot(slot:int) -> void:
	hand_cards[slot].queue_free();;
	hand_cards[slot] = null;
	pass

func use_card_in_slot(slot : int) -> void:
	var used_card : Card = hand_cards[slot];
	if(! used_card.is_ready):
		return;
	used_card.do_ability();
	delete_card_in_slot(slot);
	draw_new_card(slot);
	pass
func _input(event):
	if(event.is_action_pressed("ui_left")):
		use_card_in_slot(0);
	if(event.is_action_pressed("ui_up") or event.is_action_pressed("ui_down")):
		use_card_in_slot(1);
	if(event.is_action_pressed("ui_right")):
		use_card_in_slot(2);
