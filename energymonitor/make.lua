local shell = require("shell")
local args, opts = shell.parse(...)

print("Building to floppy " .. args[1] .. "...")

os.execute("mkdir /mnt/" .. args[1] .. "/usr/bin")
os.execute("mkdir /mnt/" .. args[1] .. "/usr/lib")
os.execute("mkdir /mnt/" .. args[1] .. "/usr/man")

os.execute("cp monitor.lua /mnt/" .. args[1] .. "/usr/bin/energymonitor.lua")
os.execute("cp monitor_funcs.lua /mnt/" .. args[1] .. "/usr/lib/monitor_funcs/init.lua")
os.execute("cp drive_props.txt /mnt/" .. args[1] .. "/.prop")
os.execute("cp readme.txt /mnt/" .. args[1] .. "/usr/man/energymonitor")
print("Done!")