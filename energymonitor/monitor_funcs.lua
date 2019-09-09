local computer = require("computer")

-- Components
local gpu = nil
local matrix = nil
local keyboard = require("keyboard")

local w = 0
local h = 0

function setupMonitor(fGpu, fMatrix)
  gpu = fGpu
  matrix = fMatrix

  gpu.setBackground(0xFFFFFF)
  gpu.setForeground(0x000000)

  w, h = gpu.getResolution()
end

function drawStatusBar(x, y, title, value, max, w, h)
  local fill = value / max
  gpu.set(x, y, title .. ": " .. value .." ("  .. fill * 100 .. "%)")

  gpu.setBackground(0x000000)
  gpu.fill(x, y+1, w - x, 1, " ")
  gpu.setForeground(0xFFFFFF)
  gpu.fill(x, y+1, (w - x) * fill, 1, "-")
  gpu.setForeground(0x000000)
  gpu.setBackground(0xFFFFFF)
end

function drawScreen()
  --local w, h = gpu.getResolution()

  if gpu == nil or matrix == nil or keyboard == nil then
    print("Missing components. Did you forget to call setupMonitor()?")
  end 

   -- Clear screen
  gpu.fill(0, 0, w+1, h+1, " ")

  -- Draw program label
  gpu.set(1, 1, "Induction Matrix Energy Monitor v1.0")

  gpu.set(2, 3, "Input: " .. matrix.getInput())
  gpu.set(2, 4, "Output: " .. matrix.getOutput())

  drawStatusBar(2, 6, "Energy", matrix.getEnergy(), matrix.getMaxEnergy(), w, h)
  drawStatusBar(2, 10, "Stored Energy", matrix.getEnergyStored(), matrix.getMaxEnergyStored(), w, h)

  gpu.set(2, h, "Hold Ctrl+Q to exit")

  os.sleep(0.5)
end

-- Dunno why but it needs to be like this??
function checkForExit()
  if keyboard.isKeyDown(keyboard.keys.q) and keyboard.isControlDown() then
    return true
  else
    return false
  end
end

function cleanupMonitor()
  gpu.setBackground(0x000000)
  gpu.setForeground(0xFFFFFF)
end