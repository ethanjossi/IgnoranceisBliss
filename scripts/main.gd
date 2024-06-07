extends Node2D

# OnReadys
@onready var gt_button = $CanvasLayer/GTButton
@onready var ib_button = $CanvasLayer/IBButton

# Packed Scenes
var gtscene = load("res://scenes/give_or_take.tscn")
var ibscene = load("res://scenes/root.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Function to go to the Give or Take Scene
func _on_ib_button_button_down():
	get_tree().change_scene_to_packed(ibscene)


# Function to go to the Ignorance or Bliss Scene
func _on_gt_button_button_down():
	get_tree().change_scene_to_packed(gtscene)
