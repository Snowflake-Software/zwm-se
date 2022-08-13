local drawUtils = require('.lib.utils.draw')
local buttonManager = require(".lib.ui.button")
local reader = require(".lib.registry.Reader"):new("user")
local events = require('.lib.events'):new()
local focusableEventManager = require('.lib.ui.focusableEventManager'):new()

local shutdown = buttonManager:new(3, 4, "Shutdown", function() 
  os.shutdown()
end, nil, nil, nil, {
  background = reader:get("Appearance.ShutdownMenu.ShutdownButton"),
  text = reader:get("Appearance.ShutdownMenu.ShutdownButtonText"),
  clicking = reader:get("Appearance.ShutdownMenu.ShutdownButtonText"),
})
local reboot = buttonManager:new(15, 4, "Reboot", function() 
  os.reboot()
end, nil, nil, nil, {
  background = reader:get("Appearance.ShutdownMenu.RebootButton"),
  text = reader:get("Appearance.ShutdownMenu.RebootButtonText"),
  clicking = reader:get("Appearance.ShutdownMenu.RebootButtonText"),
})
local cancel = buttonManager:new(9, 7, "Cancel", function() 
  _ENV.wm.killProcess(_ENV.wm.id)
end)

focusableEventManager:addButton(shutdown)
focusableEventManager:addButton(reboot)
focusableEventManager:addButton(cancel)
focusableEventManager:inject(events)

local function render()
  local w, h = term.getSize()
  term.setBackgroundColor(reader:get("Appearance.Application.ApplicationBackground"))
  term.clear()
  drawUtils.drawBorder(1, 1, w, h, reader:get("Appearance.Window.WindowFocused"), "1-box-outside")

  term.setCursorPos(1, 2)
  term.setTextColor(reader:get("Appearance.Application.ApplicationTextStrong"))
  drawUtils.writeCentered("Power Options", nil, 1)

  shutdown:render()
  reboot:render()
  cancel:render()
end

events:addListener("term_resize", render)

render()

events:listen()