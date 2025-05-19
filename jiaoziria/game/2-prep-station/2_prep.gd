extends Control

var dumpling_skin_active = false

var redF = false;
var twoF = false;
var threeF = false;
var fourF = false;
var fiveF = false;
var sixF = false;
var sevenF = false;
var eightF = false;
var nineF = false;
var tenF = false;
var anyF = false;
var multipleF = false;
var collide = false;
var none = false;
@onready var finishedDumplingButton = get_node("finishDumpling")
@onready var finishedDumplingImage = get_node("FinishedDumplingImage")
@onready var IngredientsSomething = get_node("Ingredients")
func filling_activate(tags):
	print(tags)
	
	if(tags == "redF"):
		redF = true
		if(anyF == true):
			multipleF = true;
		anyF = true;
	if(tags == "twoF"):
		twoF = true;
		print("roar")
		if(anyF == true):
			multipleF = true;
		anyF = true;
	if(tags == "threeF"):
		threeF = true;
		if(anyF == true):
			multipleF = true;
		anyF = true;
	if(tags == "fourF"):
		fourF = true;
		if(anyF == true):
			multipleF = true;
		anyF = true;
	if(tags == "fiveF"):
		fiveF = true;
		if(anyF == true):
			multipleF = true;
		anyF = true;
	if(tags == "sixF"):
		sixF = true;
		if(anyF == true):
			multipleF = true;
		anyF = true;
	if(tags == "sevenF"):
		sevenF = true;
		if(anyF == true):
			multipleF = true;
		anyF = true;
	if(tags == "eightF"):
		eightF = true;
		if(anyF == true):
			multipleF = true;
		anyF = true;
	if(tags == "nineF"):
		nineF = true;
		if(anyF == true):
			multipleF = true;
		anyF = true;
	if(tags == "tenF"):
		tenF = true;
		if(anyF == true):
			multipleF = true;
		anyF = true;
		print(anyF)
	if(tags == "none"):
		if(anyF == false):
			none = true;
		else:
			none = false;
	if(multipleF == true):
		anyF = false;
		redF = false;
		twoF = false;
		threeF = false;
		fourF = false;
		fiveF = false;
		sixF = false;
		sevenF = false;
		eightF = false;
		nineF = false;
		tenF = false;
		multipleF = false;
		finishedDumplingButton.visible = false;
	else:
		finishedDumplingButton.visible = true
	print(tags)
	# set up the order to the correct color things

func dumpling_activate():
	dumpling_skin_active = true

func _on_finish_dumpling_pressed() -> void:
	if ((anyF == true or none == true) and dumpling_skin_active == true):
		
		finishedDumplingImage.visible = true
		IngredientsSomething.visible = false
		finishedDumplingButton.visible = false
		
func aEntered(area: Area2D) -> void:
	print("meow");
	var thisTag = str(area.get_parent().get_groups())
	print(thisTag)
	var thisTag2 = thisTag.substr(3, thisTag.length() - 5) 
	print(thisTag2)
	filling_activate(thisTag2)
	print("meow");
