extends Node

# Exports

# OnReadys
@onready var question_box = %QuestionBox
@onready var stat_box = %StatBox
@onready var no_button = %NoButton
@onready var yes_button = %YesButton
@onready var bliss_bar = %BlissBar
@onready var ignorance_bar = %IgnoranceBar
@onready var next_button = %NextButton
@onready var third_button = %ThirdButton
@onready var exit = %Exit
@onready var complete_message = %CompleteMessage

# Packed Scenes
var main_menu = load("res://scenes/main.tscn")

# Constants
const CSV_FILE = "IgnoranceIsBlissQuestions.csv"
const QUESTION_IDX = 0
const YES_RESP_IDX = 1
const NO_RESP_IDX = 2
const THIRD_IDX = 3
const THIRD_RESP_IDX = 4
const YES_POINTS_IDX = 5
const NO_POINTS_IDX = 6
const THIRD_POINTS_IDX = 7
enum Button_States {
	YES,
	NO,
	THIRD
}

# Global Variables
var data
var question_counter : int = 1
var button_choice
var disable_next : bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	data = preload(CSV_FILE)
	# Setup the first question
	question_box.text = data.records[question_counter][QUESTION_IDX]
	stat_box.text = ""
	third_button.text = data.records[question_counter][THIRD_IDX]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_button_button_down():
	if disable_next:
		return
	if question_counter == data.records.size()-1: # if we are at the end of questions
		complete_message.visible = true
		return
	question_counter += 1
	question_box.text = data.records[question_counter][QUESTION_IDX]
	stat_box.text = ""
	third_button.text = data.records[question_counter][THIRD_IDX]
	disable_next = true
	match button_choice:
		Button_States.NO:
			bliss_bar.value += int(data.records[question_counter][NO_POINTS_IDX])
			ignorance_bar.value += int(data.records[question_counter][NO_POINTS_IDX])
		Button_States.YES:
			bliss_bar.value += int(data.records[question_counter][YES_POINTS_IDX])
			ignorance_bar.value += int(data.records[question_counter][YES_POINTS_IDX])
		Button_States.THIRD:
			bliss_bar.value += int(data.records[question_counter][THIRD_POINTS_IDX])
			ignorance_bar.value += int(data.records[question_counter][THIRD_POINTS_IDX])
	print("next")


func _on_no_button_button_down():
	stat_box.text = data.records[question_counter][NO_RESP_IDX]
	button_choice = Button_States.NO
	disable_next = false
	print("no")


func _on_yes_button_button_down():
	stat_box.text = data.records[question_counter][YES_RESP_IDX]
	button_choice = Button_States.YES
	disable_next = false
	print("yes")


func _on_third_button_button_down():
	stat_box.text = data.records[question_counter][THIRD_RESP_IDX]
	button_choice = Button_States.THIRD
	disable_next = false


func _on_exit_button_down():
	get_tree().change_scene_to_packed(main_menu)
