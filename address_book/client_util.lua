addEventHandler("onClientResourceStart", getRootElement(),
    function ()
        bindKey("F2", "down", VisibleWindow)
	end
)

function dxDrawArea(posX, posY, posW, posH, color)
	dxDrawRectangle(posX, posY, posW, posH, color)
	dxDrawLine(posX		, posY		, posX+posW, posY	  , tocolor( 255, 255, 255))
	dxDrawLine(posX		, posY		, posX	   , posY+posH, tocolor( 255, 255, 255))
	dxDrawLine(posX		, posY+posH , posX+posW, posY+posH, tocolor( 255, 255, 255))
	dxDrawLine(posX+posW, posY		, posX+posW, posY+posH, tocolor( 255, 255, 255))
end

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
    local sx, sy = guiGetScreenSize ( )
    local cx, cy = getCursorPosition ( )
    local cx, cy = ( cx * sx ), ( cy * sy )
    if ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) then
        return true
    else
        return false
    end
end