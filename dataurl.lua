local mimetypes = require('mimetypes')

-- Lua 5.1+ base64 v3.0 (c) 2009 by Alex Kloss <alexthkloss@web.de>
-- licensed under the terms of the LGPL2

-- character table string
local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

-- encoding
local function enc(data)
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end

local htmlpath = arg[1] or 'index.html'
local outputpath = arg[2] or 'output.html'

local htmlfile = io.open(htmlpath, 'r') or error('HTML file not found: '..htmlpath)
local html = htmlfile:read('*all')
html = html:gsub('%b<>', function(a)
    return a:gsub('([\'\"])([^\'\"]+)([\'\"])', function(a, b, c)
        local result
        local ext = b:lower():match('^.+%.(.+)$')
        if ext then
            local mimetype = mimetypes[ext]
            if mimetype then
                local file = io.open(b, 'rb')
                if file then
                    local contents = file:read('*all')
                    result = a..'data:'..mimetype..';base64,'..enc(contents)..c..' download="'..b..'"'
                end
            end
        end
        return result
    end)
end)

local outputfile = io.open(outputpath, 'w')
outputfile:write(html)
