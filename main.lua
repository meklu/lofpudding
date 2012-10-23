-- this is the main script of löfpüdding from which all the real logic is called
maxfps = 120;
function love.run()
	love.load(arg);

	local dt = 0;
   
	while true do
		local frametimestart = love.timer.getMicroTime();

		love.event.pump();

		for e,a,b,c,d in love.event.poll() do
			if e == "quit" then
					if not love.quit or not love.quit() then
						if love.audio then
							love.audio.stop();
						end
						return
					end
			end
			love.handlers[e](a,b,c,d);
		end

		love.timer.step();
		dt = love.timer.getDelta();

		love.update(dt);

		love.graphics.clear();
		love.draw();
		love.graphics.present();

		local frametimeend = love.timer.getMicroTime();
		local framedelta = frametimeend - frametimestart;

			if maxfps and maxfps > 0 then -- 0 is unlimited
			local max_dt = 1/maxfps;
			local sleeptime = max_dt - framedelta;

			if sleeptime >= 0.001 then -- love will truncate anything less than 1ms down to 0 internally
				love.timer.sleep(sleeptime);
			end
		else
			love.timer.sleep(0.001);
		end
	end
end

require "./libraries/loveframes/init";
require "./startup";
require "./shutdown";
require "./input";
require "./logicloop";
require "./renderloop";
