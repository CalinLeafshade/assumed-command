
require('goo.gui')
require('goo.button')
require('goo.label')

TestGUI = Class("TestGUI", GUI)

function TestGUI:initializeLayout()
	self.text = "Test GUI"
	self:setBounds(50,50,600,500)
	--label 
	self.lblOne = GUILabel(self)
	self.lblOne.text = "This is a label"
	self.lblOne:setPosition(10,50)
	--button
	self.btnOne = GUIButton(self)
	self.btnOne:setBounds(10,80,100,50)
	self.btnOne.text = "0"
	self.btnOne:subscribe("Click", function(self)
			self.text = tostring(tonumber(self.text) + 1)
		end)
end