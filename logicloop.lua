-- this function handles löfpüdding's game logic
local t = 0;
function love.update(dt)
	t = t + dt;
	shader.s:send("t", t);
	mouseX, mouseY = love.mouse.getPosition();
	if game.result == 0 then
		particle.p:setPosition(w/3 + gui.txt.l:GetWidth() / 2, h / 2 - pud.height / 1.5 + gui.txt.l:GetHeight() / 2);
	end
	if game.result == 2 then
		particle.p:setPosition(w/3 * 2 + gui.txt.r:GetWidth() / 2, h / 2 - pud.height / 1.5 + gui.txt.r:GetHeight() / 2);
	end
	if game.result == 1 or game.result == -1 then
		particle.p:setPosition(-300, -300);
	end
	particle.p:update(dt);
	local h = love.graphics.getHeight();
	local w = love.graphics.getWidth();
	local hf = h / 100;
	local wf = w / 100;
	loveframes.update(dt);
end
