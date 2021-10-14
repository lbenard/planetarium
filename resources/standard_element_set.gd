extends ElementSet
class_name StandardElementSet

export var hydrogen: Resource = Element.from_name("Hydrogen", "H");
export var helium: Resource = Element.from_name("Helium", "He");
export var oxygen: Resource = Element.from_name("Oxygen", "O");
export var carbon: Resource = Element.from_name("Carbon", "C");
export var neon: Resource = Element.from_name("Neon", "Ne");
export var iron: Resource = Element.from_name("Iron", "Fe");
export var nitrogen: Resource = Element.from_name("Nitrogen", "N");
export var silicon: Resource = Element.from_name("Silicon", "Si");
export var magnesium: Resource = Element.from_name("Magnesium", "Mg");
export var sulfur: Resource = Element.from_name("Sulfur", "S");

func _init():
	self.set = [
		hydrogen,
		helium,
		oxygen,
		carbon,
		neon,
		iron,
		nitrogen,
		silicon,
		magnesium,
		sulfur
	];
