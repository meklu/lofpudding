-- this is the grand initialization of löfpüdding
function love.load()
	print("Setting up some canvases.");
	ui = love.graphics.newCanvas();
	world = love.graphics.newCanvas();
	love.graphics.setBlendMode("alpha");
	render = {};
	local width, height, fullscreen, vsync, fsaa = love.graphics.getMode()
	render.mode = {};
	render.mode.width = width;
	render.mode.height = height;
	render.mode.fullscreen = fullscreen;
	-- untrustable
	--render.mode.vsync = vsync;
	render.mode.vsync = false;
	render.mode.fsaa = fsaa;
	render.mode.default = render.mode;
	print("Setting the font.");
	font = {};
	font.small = love.graphics.newFont(10);
	font.default = love.graphics.newFont(12);
	font.plus = love.graphics.newFont(14);
	font.big = love.graphics.newFont(18);
	font.huge = love.graphics.newFont(24);
	love.graphics.setFont(font.default);
	print("Setting the background color.");
	love.graphics.setBackgroundColor(69, 69, 69);
	print("Setting up a particle system.");
	particle = {};
	particle.img = {};
	particle.img.test = love.graphics.newImage("images/particle.png");
	particle.p = love.graphics.newParticleSystem(particle.img.test, 1024);
	particle.p:setSizes(0.6, 0.5, 0.3, 0);
	particle.p:setSizeVariation(0);
	particle.p:setPosition(0, 0);
	particle.p:setDirection(1);
	particle.p:setEmissionRate(200);
	particle.p:setLifetime(0.2);
	particle.p:setParticleLife(0.3, 0.5);
	particle.p:setSpeed(80, 130);
	particle.p:setSpread(6);
	particle.p:setGravity(0);
	particle.p:setRotation(0);
	particle.p:setSpin(1);
	particle.p:setSpinVariation(0);
	particle.p:stop();
	particle.active = true;
	print("Grabbing window info.");
	w = love.graphics.getWidth();
	h = love.graphics.getHeight();
	print("Setting up (some) game logic.");
	game = {
		getHeroWins = function()
			return game.hero.wins;
		end;
		getVillainWins = function()
			return game.villain.wins;
		end;
		reset = function()
			game.hero.wins = 0;
			game.hero.setColor(-1);
			game.villain.wins = 0;
			game.villain.setColor(-1);
			game.result = -1;
		end;
		crunchResult = function()
			if game.hero.color == game.villain.color then
				game.result = 1;
			elseif game.villain.color - game.hero.color == -2 then
				game.result = 0;
			elseif game.hero.color - game.villain.color == -1 then
				game.result = 0;
			elseif game.hero.color - game.villain.color == -2 then
				game.result = 2;
			elseif game.villain.color - game.hero.color == -1 then
				game.result = 2;
			else
				game.result = -1;
			end
		end;
		givePoints = function()
			if game.result == 0 then
				game.hero.wins = game.hero.wins + 1;
			elseif game.result == 2 then
				game.villain.wins = game.villain.wins + 1;
			end
		end;
		drawScores = function()
			gui.txt.l:SetText({{255, 255, 255, 255}, game.hero.wins});
			gui.txt.r:SetText({{255, 255, 255, 255}, game.villain.wins});
		end;
		update = function()
			local color = math.random(0, 2);
			game.villain.setColor(color);
			game.crunchResult();
			game.givePoints();
			game.drawScores();
			particle.p:start();
		end;
		result = -1;
		hero = {
			wins = 0;
			color = -1;
			getColor = function()
				return game.hero.color;
			end;
			setColor = function(color)
				for k,v in pairs(pud) do
					if type(v) == "table" and v.val == color then
						gui.pud.l = v;
						break;
					end
				end
				game.hero.color = color;
			end;
		};
		villain = {
			wins = 0;
			color = -1;
			getColor = function()
				return game.villain.color;
			end;
			setColor = function(color)
				for k,v in pairs(pud) do
					if type(v) == "table" and v.val == color then
						gui.pud.r = v;
						break;
					end
				end
				game.villain.color = color;
			end;
		};
	};
	print("Setting up the puddings.");
	pud = {
		width = 320;
		height = 320;
		w = {
			val = -1;
			img = love.graphics.newImage("images/püdding.png");
		},
		r = {
			val = 0;
			img = love.graphics.newImage("images/red.png");
		},
		g = {
			val = 1;
			img = love.graphics.newImage("images/green.png");
		},
		b = {
			val = 2;
			img = love.graphics.newImage("images/blue.png");
		},
	};
	print("Setting up GUI stuff.");
	gui = {
		help = {
			active = false;
		},
		helpOpen = function()
			if not gui.help.active then
				gui.help.w = loveframes.Create("frame");
				local ww = w/2.7;
				local wh = h/2;
				gui.help.w:SetSize(ww, wh);
				gui.help.w:Center();
				gui.help.w:SetName("Help");
				gui.help.w.OnClose = function(object)
					gui.help.active = false;
					gui.help.w = nil;
				end;
				gui.help.active = true;
				local list = loveframes.Create("list", gui.help.w);
				list:SetPos(5, 30);
				list:SetSize(ww - 10, wh - 35);
				list:SetDisplayType("vertical");
				list:SetPadding(5);
				list:SetSpacing(5);
				local text = {};
				for line in love.filesystem.lines("help.txt") do
					local obj = loveframes.Create("text");
					obj:SetText(line);
					obj:SetPos(0, 0);
					if line:find("^\t\t") ~= nil then
						obj:SetFont(font.small);
					elseif line:find("^\t") ~= nil or line == "" then
						obj:SetFont(font.default);
					else
						obj:SetFont(font.big);
					end
					table.insert(text, obj);
					obj = nil;
				end
				for i,v in ipairs(text) do
					list:AddItem(v);
				end
			end
		end;
		btn = {
			r = loveframes.Create("button");
			g = loveframes.Create("button");
			b = loveframes.Create("button");
		},
		txt = {
			l = loveframes.Create("text");
			r = loveframes.Create("text");
		},
		pud = {
			l = pud.w;
			r = pud.w;
		},
	};
	gui.btn.r:SetSize(w/5, h/30);
	gui.btn.r:SetPos(w/5 * 0.9, h - 4 * h/30);
	gui.btn.r:SetText("Red");
	gui.btn.r.OnClick = function(object)
		game.hero.setColor(0);
		game.update();
	end;
	gui.btn.g:SetSize(w/5, h/30);
	gui.btn.g:SetPos(w/5 * 2, h - 4 * h/30);
	gui.btn.g:SetText("Green");
	gui.btn.g.OnClick = function(object)
		game.hero.setColor(1);
		game.update();
	end;
	gui.btn.b:SetSize(w/5, h/30);
	gui.btn.b:SetPos(w/5 * 3.1, h - 4 * h/30);
	gui.btn.b:SetText("Blue");
	gui.btn.b.OnClick = function(object)
		game.hero.setColor(2);
		game.update();
	end;
	gui.txt.l:SetFont(font.huge);
	gui.txt.l:SetPos(w/3, h / 2 - pud.height / 1.5);
	gui.txt.r:SetFont(font.huge);
	gui.txt.r:SetPos(w/3 * 2, h / 2 - pud.height / 1.5);
	game.update();
	game.reset();
	game.drawScores();
	print("Setting initial mouse coordinates.");
	mouseX = -300;
	mouseY = -300;
	print("Setting the mouse to be invisible.");
	love.mouse.setVisible(false);
	print("Doing some fragment shader stuff I guess.");
	shader = {};
	shader.active = true;
	-- test thingamagic
	shader.s = love.graphics.newPixelEffect( love.filesystem.read("glsl/test.frag") );
end
