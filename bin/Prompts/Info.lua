--22x8

local nft = require("cc.image.nft")
local strings = require("cc.strings")
local buttons = require(".lib.ui.button")
local events = require(".lib.events")
local focusableEventManager = require(".lib.ui.focusableEventManager")

local manager = events:new()
local eventManager = focusableEventManager:new()
local x = nft.load("/bin/Assets/info.nft")
local w, h = term.getSize()

local str = _ENV.infoText or "No info text provided"

local ok = buttons:new{
  x = w - 5, 
  y = h - 1, 
  text = "OK", 
  callback = function()
    _ENV.wm.killProcess(_ENV.wm.id)
  end,
}

eventManager:inject(manager)
eventManager:addButton(ok)

local function render()
  w, h = term.getSize()
  term.setBackgroundColor(colors.white)
  term.setTextColor(colors.black)
  term.clear()
  local lines = strings.wrap(str, w - 8)

  for i, l in pairs(lines) do
    term.setCursorPos(8, 1 + i)
    term.write(l)
  end

  nft.draw(x, 2, 2)
  ok:render()
end

render()

manager:listen()