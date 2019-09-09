-- Program lincensed under GPL-v3
print("Induction Matrix Energy Monitor v1.0")

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
setupMonitor(gpu, matrix)

-- Exit param
shouldExit = false

repeat

drawScreen()
shouldExit = checkForExit()

until shouldExit

cleanupMonitor()

gpu.setResolution(ow, oh)
print("Energy monitor terminated. Thanks for using this broken mess!")