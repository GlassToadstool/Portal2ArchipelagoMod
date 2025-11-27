if (!("Entities" in this)) return;

IncludeScript("ppmod")
IncludeScript("PCapture-Lib")

// Deletes entities not received yet can be done by class, name or model
function DeleteEntity(entity_name) {
	local ent = null;
	while (ent = ppmod.get(entity_name, ent)) {
		ent.Destroy()
	}
}

// Disable the portal gun working with left and/or right click
function DisablePortalGun(blue, orange) {
	if (blue) {
		ppmod.keyval("weapon_portalgun", "CanFirePortal1", false);
	}
	if (orange) {
		ppmod.keyval("weapon_portalgun", "CanFirePortal2", false);
	}
}

// Disable pickup of entity by class, name or model?
function DisableEntityPickup(entity_name) {
	ppmod.keyval(entity_name, "PickupEnabled", false)
}

//GetWheatleyMonitorDestructionCount()

// When entering map send that info so we can delete entities
function PrintMapName() {
	printl("map_name:" + GetMapName());
}

//Not used
function PrintTriggers() {
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

// When world loads tell archipelago client
ppmod.onauto(async(function () {
	PrintMapName();
}));