--Physics library

local physics = require( "physics" )
physics.start()

-- Variables

scrollSpeed = 3

--The environment sprites
display.setDefault( "background", 20/255, 223/255, 255/255 )

local image = display.newImageRect( "Assets/tree.png", 700, 700 )
image.x = 160
image.y = 100

local image = display.newImageRect( "Assets/ground.png", 400, 200 )
image.x = 160
image.y = 425

--The fruit and bleach sprites
local orange = display.newImageRect("Assets/orange.png", 35, 35)
orange.x = 160
orange.y = 0 
orange.id = "orange"
physics.addBody( orange, "static", { 
    friction = 0.5, 
    bounce = 0 
    } )

--The basket and functionality sprites
local basket = display.newImageRect( "Assets/basket.png", 100, 100 )
basket.x = 160
basket.y = 425
basket.id = "basket"
physics.addBody( basket, "static", { 
    density = 3.0, 
    friction = 0.5, 
    bounce = 0 
    } )
basket.isFixedRotation = true

--Move the basket by dragging
local function basketTouch ( event )
	local self = event.target
	if ( event.phase == "began" ) then
        
 	
        -- Set touch focus
        display.getCurrentStage():setFocus( self )
        self.isFocus = true
        
        self.markX = self.x
    	
     
    elseif ( self.isFocus ) then
        if ( event.phase == "moved" ) then
            
 			
 			self.x = event.x - event.xStart + self.markX
      		
        elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
 
            -- Reset touch focus
            display.getCurrentStage():setFocus( nil )
            self.isFocus = nil
            
        end
    end

    return true
end

--Falling sprites

local function MoveImage(event)
    math.randomseed ( os.time() )

    orange.y = orange.y + scrollSpeed 
    
    if fruitCollision == true then
        orange.x = math.random (1, 320)
        orange.y = 0
    end
end

--TEST FUNCTIONS 

local function fruitCollision( self, event )
 
math.randomseed (os.time())

    if ( event.phase == "began" ) then
        print( self.id .. ": collision began with " .. event.other.id )
        event.phase = "ended" 
        if ( event.phase == "began" ) then
        print( self.id .. ": collision ended with " .. event.other.id )
            if event.other.id == "orange" then
                orange.x = math.random (1, 320)
                orange.y = 0
            end
        end
    end

end

--Event listeners
 
basket:addEventListener("touch", basketTouch)

Runtime:addEventListener("enterFrame", MoveImage)

basket.collision = fruitCollision
basket:addEventListener( "collision" )