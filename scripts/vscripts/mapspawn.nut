if (!("Entities" in this)) return;

IncludeScript("ppmod")
IncludeScript("PCapture-Lib")

// Deletes entities not received yet
function DeleteEntity(entity_name) {
	for (local ent; ent = Entities.FindByClassname(ent, entity_name); )
	{
		ent.Destroy();
	}
}

// Delete Cubes not received yet
function DeleteCube(cube_model) {
	for (local ent; ent = ppmod.get(cube_model, ent); )
	{
		ent.Destroy();
	}
}

// When entering map send that info so we can delete entities
function PrintMapName() {
	printl("map_name:" + GetMapName());
}

//Not used
function PrintEntities() {
	local entity = Entities.First()
	while (entity != null) {
		local class_name = entity.GetClassname();
		if (class_name == "trigger_once") {
			printl("Trigger entity | name: " + entity.GetName())
			printl(entity.GetCenter())
		} else {
			printl(class_name + " entity | name: " + entity.GetName())
		}
		entity = Entities.Next(entity)
	}
}

// Send complete check
function PrintMapComplete() {
    printl("map_complete:" + GetMapName());
}

// Hook complete send on map completion
function CreateCompleteLevelAlertHook() {
    local cl = Entities.FindByName(null, "@transition_from_map");
    if (cl) {
        cl.ConnectOutput("OnTrigger", "PrintMapComplete")
        printl("Connected level complete hook")
    } else {
        printl("No @transition_from_map found")
    }
}

// We don't have entities until the map is fully loaded. Delay the script a bit.
Entities.First().ConnectOutput("OnUser1", "PrintMapName")
DoEntFire("worldspawn", "FireUser1", "", 0.0, null, null)