local io = require 'io'

-- this plugin is used to get a subtitle from subdivx.com
-- use: mpv --script=/home/{user}/.config/mpv/scripts/subdivx-get.lua

-- Function to capture command line response
function os.capture(cmd, ...)
    local args = table.concat({...}, ' ')
    local handle = io.popen(cmd .. ' ' .. args)
    local result = handle:read('*a')
    handle:close()
    return result
end

-- Function to get directory of file and filename
function get_path_and_filename()
    local dir = mp.get_property('working-directory', ' ')
    local fname = mp.get_property('filename', ' ')
	return dir, fname
end

-- Function to check if subtitle exists in directory
function exist_subtitle_in_dir(directory)
    local files = io.popen('ls "'..directory..'"'):lines()
    local formats_subtitles = {'.srt', '.sub', '.ass', '.ssa', 'idx'}

    for file in files do
        for _, format in ipairs(formats_subtitles) do
            if file:match(format..'$') then
                return true
            end
        end
    end
    
    return false
end


-- Function to find and download subtitles
function get_subtitle()
    local dir, fname = get_path_and_filename()

    if exist_subtitle_in_dir(dir) then
        mp.msg.info('Subtitle already exists')
        return
    end
    
    mp.msg.info('Searching for subtitles...')

    local sub = os.capture('subdivx-dl -f -odownloads -l', '"' .. dir .. '"', '"' .. fname .. '"')

    if string.match(sub, 'Subtitles not found') ~= nil then
        mp.msg.info('Subtitle not found')
        return
    end

    if string.match(sub, 'Done') ~= nil then
        mp.msg.info('Subtitle downloaded')
        mp.osd_message('Subtitle found', 4)
        mp.commandv('sub-add', sub)
        return
    end

end

-- Register event
mp.register_event('start-file', get_subtitle)