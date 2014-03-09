-- this handles the input

function love.keypressed(key, isrepeat)
	if key == 'r' then
		game.hero.setColor(0);
		game.update();
	elseif key == 'g' then
		game.hero.setColor(1);
		game.update();
	elseif key == 'b' then
		game.hero.setColor(2);
		game.update();
	elseif key == 'f1' then
		gui.helpOpen();
	elseif key == 'escape' then
		if gui.help.w ~= nil then
			gui.help.w:Remove();
			gui.help.w = nil;
			gui.help.active = false;
		end
	elseif key == 'q' then
		love.event.quit();
	elseif key == 's' then
		if shader_active then shader_active = false; else shader_active = true; end
	elseif key == 'v' then
		local mode = render.mode;
		if mode.vsync then
			mode.vsync = false;
			render.mode.vsync = false;
		else
			mode.vsync = true;
			render.mode.vsync = true;
		end
		if not love.window.setMode( mode.width, mode.height, mode.fullscreen, mode.vsync, mode.fsaa ) then
			print("Modeset failed :c");
		end
	elseif key == 'p' then
		if particle.active then
			particle.p:stop();
			particle.p:reset();
			particle.active = false;
		else
			particle.p:start();
			particle.active = true;
		end
	else
		print("No key bound to '" .. key .. "'");
	end
	loveframes.keypressed(key, isrepeat);
end

function love.keyreleased(key, isrepeat)
	loveframes.keyreleased(key);
end

function love.mousepressed(x, y, button)
	loveframes.mousepressed(x, y, button);
end

function love.mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button);
end
