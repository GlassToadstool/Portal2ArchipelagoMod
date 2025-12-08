if (!("Entities" in this)) return;

IncludeScript("ppmod")
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

// Make fizzlers deadly - Not used at the moment
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

function DeleteCoreOnOutput(core_name, target_name, output) {
    printl(core_name + " Destroy output being set")
    local delay = 5;
    if (core_name == "@core01") {
        ppmod.addscript(target_name, output, function () {
            printl("@core01 being Deleted")
            DeleteEntity("@core01");
        }, delay)
    }
    else if (core_name == "@core02") {
        ppmod.addscript(target_name, output, function () {
            printl("@core02 being Deleted")
            DeleteEntity("@core02");
        }, delay)
    }
    else if (core_name == "@core03") {
        ppmod.addscript(target_name, output, function () {
            printl("@core03 being Deleted")
            DeleteEntity("@core03");
        }, delay)
    }
}

//GetWheatleyMonitorDestructionCount() can be used for checking those advancements by seeing difference before at after map finish?

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

// Fire complete send on map completion
function CreateCompleteLevelAlertHook() {

    local transition_script = ppmod.get("@transition_script", null)
    if (transition_script) {
        printl("transition script found, complete level hook created")
    }
    ppmod.hook(transition_script, "RunScriptCode", PrintMapComplete, 1)

    // For final level
    if (GetMapName() == "sp_a4_finale4"){
        transition = ppmod.get("ending_relay", null);
        transition.ConnectOutput("OnTrigger", "PrintMapComplete")
    }
}

::sent_death_link <- false;
function AttachDeathTrigger() {
    // Create interval that checks player's current health, if it hits 0 then send deathlink
    ppmod.interval(function() {
        local player = ppmod.get("player", null); // probably should make global ::player <- XXX
        local player_hp = player.GetHealth()
        if (player_hp <= 0 && !sent_death_link) {
            sent_death_link = true;
            printl("send deathlink")
        }
    })
}

::text_queue <- TextQueue();
function AddToTextQueue(text) {
	text_queue.AddToQueue(text);
}

::connected <- false;

// When world loads tell archipelago client and check if is connected
ppmod.onauto(async(function () {
	PrintMapName();
	ppmod.interval(function () {
			text_queue.DisplayQueueMessage();
		}, text_queue.display_time + 1);


}), true);