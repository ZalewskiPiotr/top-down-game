## It has a minimal script with exported variables to control the character’s speed, jump impulse, 
## and gravity. In this script, you can expose all the properties and functions you want 
## your states to access.
class_name Player extends CharacterBody2D

@export var speed_walk : float = 100.0
@export var speed_run : float = 200.0
