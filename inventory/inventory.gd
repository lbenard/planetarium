extends Resource
class_name Inventory

export var slots: int;
export var slot_capacity: int;
var items: Dictionary = {};

func init(slots: int, slot_capacity: int):
	self.slots = slots;
	self.slot_capacity = slot_capacity;

func add(item: Item, quantity: int = 1) -> bool:
	var existing_quantity = 0;
	if item in items:
		existing_quantity = items[item];
	if existing_quantity + quantity > slot_capacity:
		return false;
	items[item] = existing_quantity + quantity;
	return true;
