

require('goo.gui')
require('goo.button')
require('goo.label')
require('goo.textbox')
require('goo.viewport')

AvatarGUI = Class("AvatarGUI", GUI)

function AvatarGUI:initialize(x,y,avatar)
	self.x = x
	self.y = y
	self.avatar = avatar
	GUI.initialize(self)
end

function AvatarGUI:initializeLayout()
	
	self:setSize(300,100)
	
	self.lblOne = GUILabel(self)
	self.lblOne.text = "This is a label"
	self.lblOne:setPosition(70,40)
	
	self.viewport = GUIViewport(self, self.avatar.ship, self.avatar)
	self.viewport:setBounds(10,40,50,50)
end