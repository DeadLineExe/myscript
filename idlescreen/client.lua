local sW,sH = guiGetScreenSize()
local img = dxCreateTexture("logo.png")
local switch = false
local w = 370
local h = 105
local m = 5
local x = math.random(0,sW/2- w)
local y = math.random(0,sH - h)
local x1 = math.random(sW/2,sW - w)
local y1 = math.random(0,sH - h)

addEventHandler("onClientResourceStart", getRootElement(),
    function ()
        bindKey("F3", "down", VisibleIdleScreen)
	end
)

function VisibleIdleScreen()
	if switch == false then
		switch = true
		showChat(false)
		setPlayerHudComponentVisible( "all", false)
		addEventHandler	  ("onClientRender", getRootElement(), Draw )
		addEventHandler   ("onClientRender", getRootElement(), dxIdleScreen1 )
		addEventHandler	  ("onClientRender", getRootElement(), dxIdleScreen2 )
		x = math.random(0,sW/2- w)
		x1 = math.random(sW/2,sW - w)
		y = math.random(0,sH - h)
		y1 = math.random(0,sH - h)
		color = tocolor(math.random(0,255),math.random(0,255),math.random(0,255),255)
		color1 = tocolor(math.random(0,255),math.random(0,255),math.random(0,255),255)
	else
		switch = false
		showChat(true)
		setPlayerHudComponentVisible( "all", true)
		removeEventHandler("onClientRender", getRootElement(), Draw )
		removeEventHandler("onClientRender", getRootElement(), dxIdleScreen1)
		removeEventHandler("onClientRender", getRootElement(), dxIdleScreen2)
	end
end

function dxIdleScreen1()
	if (x <= 0) or (x >= (sW/2) - w) then
		V = change(V)
		color = tocolor(math.random(0,255),math.random(0,255),math.random(0,255),255)
	end
	if (y <= 0) or (y >= sH - h) then
		H = change(H)
		color = tocolor(math.random(0,255),math.random(0,255),math.random(0,255),255)
	end
	x = x + incDec(V)
	y = y + incDec(H)
	dxDrawImage( x, y, w, h, img, 0, 0, 0,color)
end

function dxIdleScreen2()
	if (x1 <= sW/2) or (x1 >= sW - w) then
		V1 = change(V1)
		color1 = tocolor(math.random(0,255),math.random(0,255),math.random(0,255),255)
	end
	if (y1 <= 0) or (y1 >= sH - h) then
		H1 = change(H1)
		color1 = tocolor(math.random(0,255),math.random(0,255),math.random(0,255),255)
	end
	x1 = x1 + incDec(V1)
	y1 = y1 + incDec(H1)
	dxDrawImage( x1, y1, w, h, img, 0, 0, 0,color1)
end

function change( param )
	if param == true then
		return false
	else
		return true
	end
end

function incDec( param )
	if param == true then
		return m
	else
		return -m
	end
end

function Draw()
	dxDrawRectangle(0,0,sW,sH,tocolor(0,0,0,220))
end