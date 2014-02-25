
require('goo.gui')
require('goo.button')
require('goo.label')
require('goo.textbox')

TestGUI = Class("TestGUI", GUI)

function TestGUI:initialize(x,y)
	GUI.initialize(self)
	self.x = x
	self.y = y
end

function TestGUI:initializeLayout()
	self.text = "Test GUI"
	self:setSize(300,250)
	--label 
	self.lblOne = GUILabel(self)
	self.lblOne.text = "This is a label"
	self.lblOne:setPosition(10,50)
	--button
	self.btnOne = GUIButton(self)
	self.btnOne:setBounds(10,80,100,30)
	self.btnOne.text = "0"
	self.btnOne:subscribe("Click", function(self)
			self.text = tostring(tonumber(self.text) + 1)
		end)
	
	self.txtOne = GUITextBox(self)
	self.txtOne:setBounds(10,120,200,30)
end