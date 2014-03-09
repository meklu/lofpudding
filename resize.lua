function love.resize(width, height)
	-- set globals too
	w = width;
	h = height;
	gui.btn.r:SetSize(w/5, h/30);
	gui.btn.r:SetPos(w/5 * 0.9, h - 4 * h/30);
	gui.btn.g:SetSize(w/5, h/30);
	gui.btn.g:SetPos(w/5 * 2, h - 4 * h/30);
	gui.btn.b:SetSize(w/5, h/30);
	gui.btn.b:SetPos(w/5 * 3.1, h - 4 * h/30);
	gui.txt.l:SetPos(w/3, h / 2 - pud.height / 1.5);
	gui.txt.r:SetPos(w/3 * 2, h / 2 - pud.height / 1.5);
end
