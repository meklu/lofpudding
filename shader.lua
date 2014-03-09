-- process include directives, etc.
local shader = {};
shader.res = {};

function shader:parseFile(path)
	local str = "";
	for line in love.filesystem.lines(path) do
		local v = line;
		if string.sub(v, 1, string.len("#include")) == "#include" then
			local incpath = string.sub(v, string.len("#include "));
			incpath = string.sub(incpath, 3, string.len(incpath) - 1);
			v = shader:parseFile(incpath);
		end
		str = str .. v .. "\n";
	end
	return str;
end

function shader:new(name, path)
	obj = love.graphics.newShader(self:parseFile(path));
	self.res[name] = obj;
end

function shader:get(name)
	if self.res[name] ~= nil then
		return self.res[name];
	else
		return nil;
	end
end

return shader;
