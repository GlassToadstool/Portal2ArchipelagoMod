if (!("Entities" in this)) return;

IncludeScript("ppmod")
IncludeScript("PCapture-Lib")
IncludeScript("textqueue")

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

// Make fizzlers deadly
function CreateMurderFizzlers() {
	local fiz = null;
	while (fiz = ppmod.get("trigger_portal_cleanser", fiz)) {
		// Make it red
		// Currently can't do this unless we create a box in the space with a colour
		// which we will do later

		// Make it kill the player
		ppmod.addscript(fiz, "OnStartTouch", function () {
			local player = GetPlayer();
			if (activator == player) {
				SendToConsole("kill");
			}
		})
	}
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

function ListEntities() {
	local ent = null;
	while (ent = Entities.Next(ent)) {
		printl(ent);
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

::text_queue <- TextQueue();
function AddToTextQueue(text) {
	text_queue.AddToQueue(text);
}

// When world loads tell archipelago client
ppmod.onauto(async(function () {
	PrintMapName();
	ppmod.interval(function () {
			text_queue.DisplayQueueMessage();
		}, text_queue.display_time + 1);
}), true);