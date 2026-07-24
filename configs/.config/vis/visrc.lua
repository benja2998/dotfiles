-- load standard vis module, providing parts of the Lua API
require('vis')

local function dailynote()
    local year = os.date("%Y")
    local today = os.date("%d-%m-%Y")

    local home = os.getenv("HOME") or ""
    local dir = home .. "/Documents/Notes/" .. year
    local path = dir .. "/" .. today .. ".md"

    os.execute("mkdir -p '" .. dir .. "'")

    vis:command("e '" .. path .. "'")

    local win = vis.win
    local file = win.file
    
    if file.size == 0 then
        file:insert(0, "# " .. today .. "\n\n")
        win.selection.pos = file.size
        vis:feedkeys('j')
    end
end

local function todonote()
    local home = os.getenv("HOME") or ""
    vis:command("e '" .. home .. "/Documents/Notes/todo.md'")
end

local function togglecheckbox()
    local win = vis.win
    local file = win.file
    local pos = win.selection.pos

    local line_start = pos
    while line_start > 0 do
        if file:content(line_start - 1, 1) == "\n" then break end
        line_start = line_start - 1
    end
    
    local line_end = pos
    local size = file.size
    while line_end < size do
        if file:content(line_end, 1) == "\n" then break end
        line_end = line_end + 1
    end

    local length = line_end - line_start
    if length <= 0 then return end
    local line = file:content(line_start, length)

    if line:match("%[ %]") then
        local new_line = line:gsub("%[ %]", "[x]", 1)
        file:delete(line_start, length)
        file:insert(line_start, new_line)
        win.selection.pos = pos
    elseif line:match("%[x%]") then
        local new_line = line:gsub("%[x%]", "[ ]", 1)
        file:delete(line_start, length)
        file:insert(line_start, new_line)
        win.selection.pos = pos
    end
end

vis.events.subscribe(vis.events.INIT, function()
    -- Your global configuration options
    vis:map(vis.modes.NORMAL, ' j', togglecheckbox)
    vis:map(vis.modes.NORMAL, ' n', dailynote)
    vis:map(vis.modes.NORMAL, ' t', todonote)
    vis:command('set theme ansi16')
end)

vis.events.subscribe(vis.events.WIN_OPEN, function(win) -- luacheck: no unused args
    -- Your per window configuration options e.g.
    -- vis:command('set number')
    vis:command('set relativenumber')
--    vis:command('set cursorline')
    vis:command('set autoindent')
    vis:command('set tabwidth 4')
    vis:map(vis.modes.INSERT, '<Tab>', '    ')
end)
