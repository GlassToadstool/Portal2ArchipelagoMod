
function CreateLPP() {
	local lpp = ppmod.get("logic_playerproxy", null);
	// Some levels don't have a player proxy so create one?
	if (!ppmod.validate(lpp)) {
		lpp = ppmod.create("logic_playerproxy");
		printl("Created logic_playerproxy");
	}
}

function MotionBlurTrap() {
	local blur_name = "disable blur";
	// If a blur already exists destroy it and make a new one
	local old_blur = ppmod.get(blur_name, null)
	if (old_blur) {
		old_blur.Kill();
	}

	// Blur screen
	local lpp = ppmod.get("logic_playerproxy", null);
	lpp.SetMotionBlurAmount(1);
	// Unblur after some time
	ppmod.wait(function () {
		local lpp = ppmod.get("logic_playerproxy", null);
		lpp.SetMotionBlurAmount(0);
	}, 20, blur_name);
}

function FizzlePortalTrap() {
	ppmod.forent("prop_portal", function (portal) {
		portal.Fizzle()
	})
}

function ButterFingersTrap() {
	local bf_disable = "disable butter fingers";
	local bf_interval = "butter fingers";
	// If a butterfingers trap already exists destroy it and make a new one
	local old_bf_disable = ppmod.get(bf_disable, null)
	if (old_bf_disable) {
		old_bf_disable.Kill();
		old_bf_disable.Destroy();
	}
	local old_bf_interval = ppmod.get(bf_interval, null)
	if (old_bf_interval) {
		old_bf_interval.Kill();
	}

	// Start the trap
	ppmod.interval(function() {
		SendToConsole("+use");
		ppmod.wait(function () {
			SendToConsole("-use");
		}, 0.5);
	}, 2.5, bf_interval);

	// Kill the function after a time
	ppmod.wait(function ():(bf_interval) {
		local bf = ppmod.get(bf_interval, null);
		bf.Kill();
	}, 30, bf_disable)
}

::text_options <- ["THE CAKE IS A LIE!THE CAKE IS A LIE!THE CAKE IS A LIE!\nTHE CAKE IS A LIE!THE CAKE IS A LIE!THE CAKE IS A LIE!\nTHE CAKE IS A LIE!THE CAKE IS A LIE!THE CAKE IS A LIE!\nTHE CAKE IS A LIE!THE CAKE IS A LIE!THE CAKE IS A LIE!\nTHE CAKE IS A LIE!THE CAKE IS A LIE!THE CAKE IS A LIE!\nTHE CAKE IS A LIE!THE CAKE IS A LIE!THE CAKE IS A LIE!\nTHE CAKE IS A LIE!THE CAKE IS A LIE!THE CAKE IS A LIE!\nTHE CAKE IS A LIE!THE CAKE IS A LIE!THE CAKE IS A LIE!"]

function DialogTrap() {
	local text = text_options[0];
	local dt = ppmod.text(text, 0.2, 0.1);
	dt.SetColor("250 0 0");
	dt.SetSize(5);
	dt.SetFade(0.1, 0.1);
	dt.Display(15);
}
::colors <- ["255 0 0", "0 255 0", "0 0 255", "255 255 0", "255 0 255", "0 255 255"];
function CubeConfettiTrap() {
	// Spawn a bunch of multicolored cubes under the player
	ppmod.give({ prop_weighted_cube = 20 }).then(function (ents) {
		for (local i = 0; i < ents.prop_weighted_cube.len(); i++)
		{
			local cube = ents.prop_weighted_cube[i];
			cube.Color(colors[RandomInt(0, 5)]);
			ppmod.fire(cube, "Dissolve", "", 3, null, null);
		}
	});
}