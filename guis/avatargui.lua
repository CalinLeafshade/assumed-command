

require('goo.gui')
require('goo.button')
require('goo.label')
require('goo.textbox')

AvatarGUI = Class("AvatarGUI", GUI)

function AvatarGUI:initialize(x,y,avatar)
	GUI.initialize(self)
	self.x = x
	self.y = y
	self.avatar = avatar
end

function AvatarGUI:initializeLayout()
	self.lblOne = GUILabel(self)
	self.lblOne.text = "This is a label"
	self.lblOne:setPosition(10,50)
	self:setSize(300,100)
end