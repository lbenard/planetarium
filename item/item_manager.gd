extends Node

#export var hydrogen: Resource = Item.from_name("Hydrogen");
#export var helium: Resource = Item.from_name("Helium");
#export var oxygen: Resource = Item.from_name("Oxygen");
#export var carbon: Resource = Item.from_name("Carbon");
#export var neon: Resource = Item.from_name("Neon");
export var iron_ingot: Resource = Item.from_name("Iron ingot");
#export var nitrogen: Resource = Item.from_name("Nitrogen");
#export var silicon: Resource = Item.from_name("Silicon");
#export var magnesium: Resource = Item.from_name("Magnesium");
#export var sulfur: Resource = Item.from_name("Sulfur");

var set: Array = [];

func _init():
	self.set = [
		#hydrogen,
		#helium,
		#oxygen,
		#carbon,
		#neon,
		iron_ingot,
		#nitrogen,
		#silicon,
		#magnesium,
		#sulfur
	];
