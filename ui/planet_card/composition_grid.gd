extends GridContainer

onready var title: Label = $Composition;
onready var atmosphere: Label = $Atmosphere;
onready var atmosphere_content: Label = $AtmosphereContent;
onready var elements: Label = $Elements;
onready var elements_content: Label = $ElementsContent;

func update_planet(planet: Planet):
	var atmosphere_names = [];
	for element in atmosphere.keys():
		atmosphere_names.push_back(_get_element_name(element));
	atmosphere_content.text = PoolStringArray(atmosphere_names).join(", ");
	
	var elements_names = [];
	for element in elements.keys():
		elements_names.push_back(_get_element_name(element));
	elements_content.text = PoolStringArray(elements_names).join(", ");


func _get_element_name(element: Element) -> String:
	if element.short:
		return "%s (%s)" % [element.name, element.short];
	else:
		return element.name;
