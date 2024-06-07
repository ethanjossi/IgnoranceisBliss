extends Node

# OnReadys
@onready var give_button = %Give
@onready var take_button = %Take
@onready var give_text = %GiveText
@onready var take_text = %TakeText
@onready var progress = %Progress
@onready var exit = %Exit
@onready var win_message = %WinMessage
@onready var over_take_message = %OverTakeMessage
@onready var over_give_messaage = %OverGiveMessaage

# Packed Scenes
var main_menu = load("res://scenes/main.tscn")

# Constants
const CSV_FILE = "GiveorTakeQuestions.csv"
const GIVE_Q_IDX = 0
const GIVE_POINTS_IDX = 1
const TAKE_Q_IDX = 2
const TAKE_POINTS_IDX = 3

# Global Variables
var data
var card_counter : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	data = preload(CSV_FILE)
	# Setup the first card
	take_text.text = data.records[card_counter][TAKE_Q_IDX]
	give_text.text = data.records[card_counter][GIVE_Q_IDX]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_give_button_down():
	if card_counter == data.records.size()-1: # if we are at the end of questions
		win_message.visible = true
		return
	progress.value += int(data.records[card_counter][GIVE_POINTS_IDX])
	if check_score():
		return
	card_counter += 1
	take_text.text = data.records[card_counter][TAKE_Q_IDX]
	give_text.text = data.records[card_counter][GIVE_Q_IDX]


func _on_take_button_down():
	if card_counter == data.records.size()-1: # if we are at the end of questions
		return
	progress.value += int(data.records[card_counter][TAKE_POINTS_IDX])
	if check_score():
		return
	card_counter += 1
	take_text.text = data.records[card_counter][TAKE_Q_IDX]
	give_text.text = data.records[card_counter][GIVE_Q_IDX]


func _on_exit_button_down():
	get_tree().change_scene_to_packed(main_menu)


func check_score():
	if progress.value >= 100:
		over_take_message.visible = true
		return true
	elif progress.value <= -100:
		over_give_messaage.visible = true
		return true
	return false
