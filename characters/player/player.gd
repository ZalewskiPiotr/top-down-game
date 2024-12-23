## It has a minimal script with exported variables to control the character’s speed, jump impulse, 
## and gravity. In this script, you can expose all the properties and functions you want 
## your states to access.
class_name Player extends CharacterBody2D

#region Zmienne - parametry postaci
@export var speed_walk : float = 100.0
@export var speed_run : float = 200.0
#endregion

#region Zmienne - animacje i grafiki
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var sprites_idle: Node2D = $Sprites/Idle
@onready var sprites_run: Node2D = $Sprites/Run
@onready var sprites_walk: Node2D = $Sprites/Walk
#endregion

#region Zmienne - inne
@onready var lbl_current_state: Label = $Informations/CurrentState
@onready var state_machine: StateMachine = $StateMachine
var character_flip : bool = false
#endregion


# Pokazujemy w jakim stanie jest postać gracza
func _process(_delta: float) -> void:
	lbl_current_state.text = state_machine.state.name

#region Widoczność sprite-ów
func turn_on_idle() -> void:
	sprites_idle.visible = true
	sprites_run.visible = false
	sprites_walk.visible = false
	

func turn_on_walk() -> void:
	sprites_idle.visible = false
	sprites_run.visible = false
	sprites_walk.visible = true
	
	
func turn_on_run() -> void:
	sprites_idle.visible = false
	sprites_run.visible = true
	sprites_walk.visible = false
#endregion

#region Obracanie postaci lewo-prawo
func flip_walk() -> void:
	for sprite_node: Sprite2D in sprites_walk.get_children():
		sprite_node.flip_h = self.character_flip

		
func flip_idle() -> void:
	for sprite_node: Sprite2D in sprites_idle.get_children():
		sprite_node.flip_h = self.character_flip

func flip_run() -> void:
	for sprite_node: Sprite2D in sprites_run.get_children():
		sprite_node.flip_h = self.character_flip
#endregion
