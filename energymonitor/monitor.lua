-- Program lincensed under GPL-v3
print("Induction Matrix Energy Monitor v1.1")

-- Global requires
require("monitor_funcs")
local computer = require("computer")
local component = require("component")

-- Components
local matrix = component.induction_matrix
local gpu = component.gpu

-- DEBUG: list functions provided by the induction matrix
for key, value in pairs(matrix) do
  print(key)
end

-- Original GPU params to reset on exit
ow, oh = gpu.getResolution()
gpu.setResolution(50, 16)

-- Pass components to the monitor program
local success = setupMonitor(gpu, matrix)
if not success then
  gpu.setResolution(ow, oh)
  os.exit()
end

-- Exit param
shouldExit = false

repeat
  drawScreen()
  shouldExit = checkForExit()
  os.sleep(0.5)
until shouldExit

cleanupMonitor()

gpu.setResolution(ow, oh)
os.execute("clear")
print("Energy monitor terminated. Thanks for using this broken mess!")