if (!("Entities" in this)) return;

IncludeScript("ppmod")
IncludeScript("textqueue")
IncludeScript("traphandling")

function ItemInList(item, list) {
	foreach (i, value in list)
	{
		if (value == item) {
			return true;
		}
	}
	return false;
}

::scripted_fling_levels <- ["sp_a3_03", "sp_a3_bomb_flings", "sp_a3_transition01", "sp_a3_speed_flings", "sp_a3_end", "sp_a4_jump_polarity"];
// Deletes entities not received yet can be done by class, name or model
function DeleteEntity(entity_name) {
	if (entity_name == "trigger_catapult" && ItemInList(GetMapName(), scripted_fling_levels)) {
		printl("not removing trigger_catapult");
		return;
	}

	local ent = null;
	while (ent = ppmod.get(entity_name, ent)) {
		ent.Destroy()
	}
}

::portalgun_2_disabled <- false;
// Disable the portal gun working with left and/or right click
function DisablePortalGun(blue, orange) {
	if (GetMapName() == "sp_a3_01") {
		//wait for animation to finish then remove the portal gun
		ppmod.wait(function () {
			ppmod.keyval("weapon_portalgun", "CanFirePortal2", false);
		}, 13, "disable_portalgun2_sp_a3_01")
	}

	if (GetMapName() == "sp_a2_intro") {
		portalgun_2_disabled = true;
	}

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

function ListEntities() {
	local ent = null;
	while (ent = Entities.Next(ent)) {
		printl(ent);
	}
}

function PrintMapCompleteNoExit() {
    printl("map_complete:" + GetMapName());
}

::transition_script_count <- 0;
// Send complete check and exit map
function PrintMapComplete() {
	if (transition_script_count > 0) {
		transition_script_count -= 1;
		return;
	}
    printl("map_complete:" + GetMapName());
	// Quit out after a delay
	ppmod.wait(ExitToMenu, 2, "return_to_menu")
}

function ExitToMenu() {
	SendToConsole("disconnect;startupmenu force");
}

::two_trigger_levels <- ["sp_a1_intro1", "sp_a4_finale1", "sp_a4_finale3"];
::non_elevator_maps <- ["sp_a1_intro1", "sp_a1_wakeup", "sp_a2_turret_intro", "sp_a2_bts1", "sp_a2_bts2", "sp_a2_bts3", "sp_a2_bts4", "sp_a2_bts5", "sp_a2_bts6", "sp_a2_core", "sp_a3_00", "sp_a3_01", "sp_a4_laser_platform", "sp_a4_finale1", "sp_a4_finale2", "sp_a4_finale3", "sp_a4_finale4"];
// Fire complete send on map completion
function CreateCompleteLevelAlertHook() {
	local map = GetMapName();
	// Some levels use transition script more than once
	if (ItemInList(map, two_trigger_levels)) {
		transition_script_count = 1;
	}

	// For final level
    if (map == "sp_a4_finale4"){
        local transition = ppmod.get("ending_relay", null);
        transition.ConnectOutput("OnTrigger", "PrintMapCompleteNoExit");
    }
	else if (ItemInList(map, non_elevator_maps) ) {
		local transition_script = ppmod.get("@transition_script", null);
		ppmod.hook(transition_script, "RunScriptCode", PrintMapComplete, 1);
	}
    else {
        local cl = Entities.FindByName(null, "@transition_from_map");
        if (cl) {
            cl.ConnectOutput("OnTrigger", "PrintMapComplete")
            printl("Connected @transition_from_map trigger")
        } else {
            printl("No @transition_from_map found")
        }
        DeleteEntity("@exit_teleport");
    }
}

function DoMapSpecificSetup() {
    local current_map = GetMapName();
    if (current_map == "sp_a1_intro3") {
        // portalgun pickup trigger here doesn't have a name so will have to use Vector search
        ppmod.addscript(ppmod.get(Vector(25, 1958, -299), 2, "trigger_once"), "OnStartTouch", function(){
            printl("item_collected:Portal Gun");
        }, 2);
    }
    else if (current_map == "sp_a2_intro") {
        ppmod.addscript(ppmod.get("player_near_portalgun", null), "OnStartTouch", function(){
            DisablePortalGun(false, portalgun_2_disabled);
            printl("item_collected:Portal Gun Upgrade");
        }, 0.25);
    }
}

::sent_death_link <- false;
function AttachDeathTrigger() {
    // Create interval that checks player's current health, if it hits 0 then send deathlink
    ppmod.interval(function() {
        if (player.GetHealth() <= 0 && !sent_death_link) {
            sent_death_link = true;
            printl("send_deathlink");
			SendToConsole("restart");
        }
    }, 1)
    printl("DeathLink active")
}

::text_queue <- TextQueue();
function AddToTextQueue(text, color = null) {
	text_queue.AddToQueue(text, color);
}

::connected <- false;
// TODO: function called by client on reception of map name to set connected to true
// Then Delayed function in the below onauto that checks if connected or displays message that client is not connected

// When world loads tell archipelago client and check if is connected
ppmod.onauto(async(function () {
	PrintMapName();
	ppmod.interval(function () {
			text_queue.DisplayQueueMessage();
		}, text_queue.display_time + 1);
    CreateCompleteLevelAlertHook();
	AttachDeathTrigger();
    DoMapSpecificSetup();
    CreateLPP();
}), true);