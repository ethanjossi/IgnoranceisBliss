extends Node

# Exports
@export var testdisplay : Label

# OnReadys
@onready var question_box = %QuestionBox
@onready var stat_box = %StatBox
@onready var no_button = %NoButton
@onready var yes_button = %YesButton
@onready var bliss_bar = %BlissBar
@onready var ignorance_bar = %IgnoranceBar
@onready var next_button = %NextButton
@onready var third_button = %ThirdButton

# Constants
const CSV_FILE = "IgnoranceIsBlissQuestions.csv"
const QUESTION_IDX = 0
const YES_RESP_IDX = 1
const NO_RESP_IDX = 2
const THIRD_IDX = 3
const THIRD_RESP_IDX = 4

# Global Variables
var data
var question_counter : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	data = preload(CSV_FILE)
	# Setup the first question
	question_box.text = data.records[question_counter][QUESTION_IDX]
	stat_box.text = ""
	third_button.text = data.records[question_counter][THIRD_IDX]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_next_button_button_down():
	if question_counter == data.length()-1: # if we are at the end of questions
		return
	question_counter += 1
	question_box.text = data.records[question_counter][QUESTION_IDX]
	stat_box.text = ""
	third_button.text = data.records[question_counter][THIRD_IDX]
	print("next")


func _on_no_button_button_down():
	stat_box.text = data.records[question_counter][NO_RESP_IDX]
	bliss_bar.value -= 5
	ignorance_bar.value -= 5
	print("no")


func _on_yes_button_button_down():
	stat_box.text = data.records[question_counter][YES_RESP_IDX]
	bliss_bar.value += 5
	ignorance_bar.value += 5
	print("yes")


func _on_third_button_button_down():
	stat_box.text = data.records[question_counter][THIRD_RESP_IDX]
	bliss_bar.value += 5
	ignorance_bar.value += 5


