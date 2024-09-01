class_name CardManager extends Node2D


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

var HandState:Dictionary = {0: false,
							1: false,
							2: false}# true if there is a card in that slot false otherwise

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Random_Ability() -> int:
	randomize()
	var random_value: int = randi_range(0, TotalWeight - 1);
	var cumulative_weight: int = 0;

	for ability in Probability.keys():
		cumulative_weight += Probability[ability]
		if random_value < cumulative_weight:
			return ability
	
	print("Ajeita o TotalWeight nerd");
	return -1
	
func Create_Random_Card()-> Card:
	var newCard_Ability:int = Random_Ability();
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
	return newCard;
	
func Draw_new_card(slot: int) -> void:
	var newCard:Card = Create_Random_Card();
	newCard.Slot = slot;
	newCard.isReady = false;
	$Timer.connect("timeout",newCard.makeReady);
	$Timer.start(Cooldown);
	newCard.position = Vector2(100 + slot * 32, 100)
	HandState[slot] = true;
	pass

func Delete_card(card: Card) -> void:
	card.queue_free()
	HandState[card.Slot] = false;
	pass

func Use_card(card: Card) -> void:
	var freedSlot = card.Slot;
	card.doAbility();
	Delete_card(card);
	Draw_new_card(freedSlot);
	pass

func _on_card_card_used(card: Card) -> void:
	Use_card(card);
	pass
