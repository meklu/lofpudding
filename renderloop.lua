-- this is löfpüdding's render loop
function love.draw()
	love.graphics.setColor(255, 255, 255, 255);
	love.graphics.setCanvas(world);
		world:clear();
		love.graphics.clear();
		if particle.active then
			love.graphics.draw(particle.p, 0, 0);
		end
		love.graphics.draw(gui.pud.l.img, w/3, h/2, 0, 1, 1, pud.width / 2, pud.height / 2);
		love.graphics.draw(gui.pud.r.img, w/3 * 2, h/2, 0, -1, 1, pud.width / 2, pud.height / 2);
		-- help window's background stuff to fix buggy rendering
		if gui.help.w ~= nil then
			love.graphics.setColor(160, 160, 200, 255);
			-- title bar
			love.graphics.rectangle("fill", gui.help.w:GetX(), gui.help.w:GetY(), gui.help.w:GetWidth(), 25);
			love.graphics.rectangle("fill", gui.help.w:GetX() + 5, gui.help.w:GetY() + 30, gui.help.w:GetWidth() - 10, gui.help.w:GetHeight() - 35);
		end
	love.graphics.setCanvas(ui);
		ui:clear();
		loveframes.draw();
		love.graphics.setColor(255, 255, 255, 255);
		love.graphics.setFont(font.plus);
		love.graphics.print("Press F1 for help.", 5, 5);
		love.graphics.setColor(0, 255, 255, 255);
		love.graphics.polygon("fill", mouseX, mouseY, mouseX, mouseY + 24, mouseX + 12, mouseY + 16);
		love.graphics.setColor(20, 20, 20, 200);
		love.graphics.setLineStyle("smooth");
		love.graphics.setLineWidth(1);
		love.graphics.line(mouseX, mouseY, mouseX, mouseY + 24);
		love.graphics.line(mouseX, mouseY, mouseX + 12, mouseY + 16);
		love.graphics.line(mouseX, mouseY + 24, mouseX + 12, mouseY + 16);
	love.graphics.setCanvas();
	love.graphics.setColor(255, 255, 255, 255);
	if shader_active then
		love.graphics.setShader( shader:get("test") );
		love.graphics.draw(world, 0, 0);
	else
		love.graphics.setShader();
		love.graphics.draw(world, 0, 0);
	end
	love.graphics.setShader();
	love.graphics.draw(ui, 0, 0);
end
