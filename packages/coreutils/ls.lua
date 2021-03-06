local argv = { ... }
local dir = shell.dir()
local args = {}
if #argv > 0 then
  if argv[1]:sub(1,1) == "-" then
    args = argv[1]
  else
    dir = argv[1]
  end
  if #argv == 2 then
    dir = argv[2]
  end
end
local allFiles = false
local more = false
for i = 2, #args do
  if args:sub(i, i) == "a" then
    allFiles = true
  end
  if args:sub(i, i) == "l" then
    more = true
  end
end
dir = fs.normalizePath(dir)
files = fs.list(dir)
local maxlen = 0
local tmp
for i = 1, #files do
  tmp = string.len(files[i])
  if tmp > maxlen then
    maxlen = tmp
  end
end
local isDir = "-"
local isLink = ""
local flag = false
for i = 1, #files do
  if (files[i]:sub(1, 1) ~= ".") or allFiles then
    flag = true
    if fs.isDir(dir .. "/" .. files[i]) then
      if term.isColor() then
        term.setTextColor(colors.blue)
      end
      isDir = "d"
    end
    if fs.getInfo(dir .. "/" .. files[i]).linkto then
      if term.isColor() then
        term.setTextColor(colors.cyan)
      end
    end
    if more then
      write(files[i])
      for j = string.len(files[i]), maxlen do
        write(" ")
      end
      if fs.getInfo(dir .. "/" .. files[i]).linkto then
        isLink = " -> " .. fs.getInfo(dir .. "/" .. files[i]).linkto
        isDir = "l"
      else
        isLink = ""
      end
      print(isDir, table.concat(fsd.normalizePerms(fsd.getInfo(dir .. "/" .. files[i]).perms), ""), " ", 
          users.getUsernameByUID(fsd.getInfo(dir .. "/" .. files[i]).owner), isLink)
    else
      write(files[i] .. " ")
    end
    if term.isColor() then
      term.setTextColor(colors.white)
    end
    isDir = "-"
    isLink = ""
  end
end
if flag then print() end
