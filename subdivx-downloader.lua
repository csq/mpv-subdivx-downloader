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
function does_subtitle_exist_in_directory(directory)
    local file_names = io.popen('ls "'..directory..'"'):lines()
    local subtitle_extensions = {'.srt', '.sub', '.ass', '.ssa', '.idx'}

    for file_name in file_names do
        for _, extension in ipairs(subtitle_extensions) do
            if file_name:match(extension..'$') then
                local expected_subtitle_name = mp.get_property('filename'):match('(.*)%..*') .. extension
                if file_name == expected_subtitle_name then
                    return true
                end
            end
        end
    end

    return false
end

-- Function to scan external files
function scan_external_files()
    local message = 'Scanning for external subtitle'

    mp.msg.info(message)
    mp.osd_message(message)
    mp.commandv('rescan-external-files')
end

-- Function to find and download subtitles
function find_and_download_subtitle()
    local dir, fname = get_path_and_filename()

    if does_subtitle_exist_in_directory(dir) then
        local message = 'Subtitle already exists in directory'

        mp.msg.info(message)
        mp.osd_message(message)
        return
    end
    
    mp.msg.info('Searching for subtitles...')

    local sub = os.capture('subdivx-dl -f -odownloads -l', '"' .. dir .. '"', '"' .. fname .. '"')

    if sub:match('Subtitles not found') then
        local message = 'No subtitles found'
        mp.msg.info(message)
        mp.osd_message(message)
        return
    end

    if sub:find('Done!') then
        local message = 'Subtitle found'
        mp.msg.info(message)
        mp.osd_message(message)
        mp.commandv('rescan-external-files')
        return
    end
end

-- Register key binding
mp.add_key_binding('s', 'subdivx-get', find_and_download_subtitle)
mp.add_key_binding('c', 'scan-sub', scan_external_files)