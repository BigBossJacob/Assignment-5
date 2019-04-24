--Physics library

local physics = require( "physics" )
physics.start() 
physics.setDrawMode( "hybrid" )   -- Shows collision engine outlines only

--Point variable

score = 0

-- Scrollspeeds
scrollSpeed1 = 3
scrollSpeed2 = 3.5
scrollSpeed3 = 2.5

--The environment sprites
display.setDefault( "background", 20/255, 223/255, 255/255 )

local image = display.newImageRect( "Assets/tree.png", 700, 700 )
image.x = 160
image.y = 100

local image = display.newImageRect( "Assets/ground.png", 400, 200 )
image.x = 160
image.y = 425

local barrier = display.newImageRect( "Assets/ground.png", 400, 200 )
barrier.x = 160
barrier.y = 600
barrier.id = "barrier"
physics.addBody( barrier, "static", { 
    friction = 0.5, 
    bounce = 0.3 
} )

--The fruit and bleach sprites
local orange = display.newImageRect("Assets/orange.png", 35, 35)
orange.x = math.random (1, 320)
orange.y = -30 
orange.id = "orange"
physics.addBody( orange, "static", { 
    friction = 0, 
    bounce = 0 
    } )

local apple = display.newImageRect("Assets/apple.png", 35, 35)
apple.x = math.random (1, 320)
apple.y = -50 
apple.id = "apple"
physics.addBody( apple, "static", { 
    friction = 0, 
    bounce = 0 
    } )

local banana = display.newImageRect("Assets/banana.png", 35, 35)
banana.x = math.random (1, 320)
banana.y = -70 
banana.id = "banana"
physics.addBody( banana, "static", { 
    friction = 0, 
    bounce = 0 
    } )

--The basket and functionality sprites
local basket = display.newImageRect( "Assets/basket.png", 100, 100 )
basket.x = 160
basket.y = 425
basket.id = "basket"
physics.addBody( basket, "dynamic", { 
    density = 0, 
    friction = 0, 
    bounce = 0 
    } )
basket.isFixedRotation = true

--Point Counter
points = display.newText( "Points: " .. score, 40, -25, native.systemFont, 15 )
points:setFillColor( 255/255, 255/255, 255/255 )

--Instructional text

prompt = display.newText( "Drag the basket!", 160, 0, native.systemFont, 30 )
prompt:setFillColor( 255/255, 255/255, 255/255 )

prompt = display.newText( "Catch the fruit!", 160, 30, native.systemFont, 30 )
prompt:setFillColor( 255/255, 255/255, 255/255 )

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
 
local function MoveImage1(event)
    orange.y = orange.y + scrollSpeed1 
end

local function MoveImage2(event)
   apple.y = apple.y + scrollSpeed2 
end

local function MoveImage3(event)
   banana.y = banana.y + scrollSpeed3 
end
--Collision Functions 

local function fruitCollision1( self, event )
 
math.randomseed = (os.time())

    if ( event.phase == "began" ) then
      
        if event.other.id == "basket" then
            score = score + 1
            points.text = ("Points: ".. score)
            timer.performWithDelay(1, function() 
            orange.x = math.random (1,320)
            orange.y = -30
        end
        )
    elseif ( event.phase == "ended" ) then
        
    end
end
end

local function fruitCollision2( self, event )
 
math.randomseed = (os.time())

    if ( event.phase == "began" ) then
       
        if event.other.id == "basket" then
            score = score + 1
            points.text = ("Points: ".. score)
            timer.performWithDelay(1, function() 
            apple.x = math.random (1,320)
            apple.y = -50
        end
        )
    elseif ( event.phase == "ended" ) then
       
    end
end
end

local function fruitCollision3( self, event )
 
math.randomseed = (os.time())

    if ( event.phase == "began" ) then
        
        if event.other.id == "basket" then
            score = score + 1
            points.text = ("Points: ".. score)
            timer.performWithDelay(1, function() 
            banana.x = math.random (1,320)
            banana.y = -70
        end
        )
    elseif ( event.phase == "ended" ) then
        
    end
end
end

--Event listeners
basket:addEventListener("touch", basketTouch)

Runtime:addEventListener("enterFrame", MoveImage1)

Runtime:addEventListener("enterFrame", MoveImage2)

Runtime:addEventListener("enterFrame", MoveImage3)

orange.collision = fruitCollision1
orange:addEventListener( "collision" )

apple.collision = fruitCollision2
apple:addEventListener( "collision" )

banana.collision = fruitCollision3
banana:addEventListener( "collision" )

--TEST FUNCTIONS
