local sW,sH = guiGetScreenSize()
local switch = false
local choice, page, player
local players = {{},{},{}}
local name, surname, address
local selEditBox = 'none'
local editBoxes = {
	['name'] = '',
	['surname'] = '',
	['address'] = '',
	['page'] = '',
}

addEventHandler("onClientResourceStart", getRootElement(),
    function ()
		bindKey("mouse_wheel_up",   "down", scrollBase) 
		bindKey("mouse_wheel_down", "down", scrollBase)
	end
)
function scrollBase( button, state)
	if state == "down"  then
		if button == "mouse_wheel_up" and page ~= 0 then
			if page > 0 then 
				page = page - 1 
			end
		end
		if button == "mouse_wheel_down" and players[1][35]~="" and players[2][35]~="" and players[3][35]~="" then
			page = page + 1
		end
		triggerServerEvent("onReadPlayer", getRootElement())
		players[1][35] = ""
		players[2][35] = ""
		players[3][35] = ""
	end
end
function BDMassive( id, name, surname, address)
	if page < tonumber(id) then
		players[1][tonumber(id) - page] = name
		players[2][tonumber(id) - page] = surname
		players[3][tonumber(id) - page] = address
	end
end
function VisibleWindow()
	if switch == false then
		switch = true
		page = 0
		triggerServerEvent("onReadPlayer", getRootElement())
		addEventHandler("onClientRender",  getRootElement(),  dxDrawWindow   )
		addEventHandler("onClientClick" ,  getRootElement(),  dxClickWindow    )
		showCursor(true)
		showChat(false)
		setPlayerHudComponentVisible( "all", false )
	else
		switch = false
		removeEventHandler("onClientRender",  getRootElement(),  dxDrawWindow  )
		removeEventHandler("onClientRender",  getRootElement(),  dxDrawDelete  )
		removeEventHandler("onClientRender",  getRootElement(),  dxDrawMenu    )
		removeEventHandler("onClientClick" ,  getRootElement(),  dxClickWindow )
		removeEventHandler("onClientClick" ,  getRootElement(),  dxClickMenu   )
		showCursor(false)
		showChat(true)
		setPlayerHudComponentVisible( "all", true)
	end	
end
function dxClickWindow(button, state)
	if isMouseInPosition((sW / 2) - 380, (sH / 2) - 260, 767, 544) and (state == "down") then
		addEventHandler( 'onClientKey', getRootElement(), lockKeysEditBox )
		addEventHandler( 'onClientCharacter', getRootElement(), forEditBoxes )
		addEventHandler( 'onClientClick', getRootElement(), clickEditBox )
		addEventHandler("onClientRender",  getRootElement(),    dxDrawMenu   )
		addEventHandler("onClientClick" ,  getRootElement(),    dxClickMenu  )
		if (button == "middle")  then
			choice = 1
			editBoxes.name = ""
			editBoxes.surname = ""
			editBoxes.address = ""
			addEventHandler( 'onClientRender', getRootElement(), dxEditBox )
		end
		if (button == "left") then
			choice = 2
			editBoxes.name = players[1][player]
			editBoxes.surname = players[2][player]
			editBoxes.address = players[3][player]
			addEventHandler( 'onClientRender', getRootElement(), dxEditBox )
		end
		if (button == "right") then
			choice = 3
		end
		removeEventHandler("onClientRender",  getRootElement(), dxDrawWindow )
		removeEventHandler("onClientClick" ,  getRootElement(), dxClickWindow)
	end
end
function dxDrawWindow()
	dxDrawArea((sW / 2) - 400, (sH / 2) - 300, 800, 600, tocolor(0,0,0,200))
	dxDrawArea((sW / 2) - 383, (sH / 2) - 284, 767, 568, tocolor(0,0,0,255))
	dxDrawLine((sW / 2) - 375, (sH / 2) - 260, (sW / 2) + 375, (sH / 2) - 260, tocolor( 255, 255, 255))
	dxDrawLine((sW / 2) - 267, (sH / 2) - 278, (sW / 2) - 267, (sH / 2) + 278, tocolor( 255, 255, 255))
	dxDrawLine((sW / 2) - 117, (sH / 2) - 278, (sW / 2) - 117, (sH / 2) + 278, tocolor( 255, 255, 255))
	dxDrawText("                                                                      Прокрутка страницы на колесико мыши!", (sW / 2) - 400, (sH / 2) - 300, 800, 14, tocolor( 255, 255, 0, 255 ), 1.02, "default" )
	dxDrawText("Имя", (sW / 2) - 375, (sH / 2) - 276, sW, sH, tocolor( 255, 255, 255, 255 ), 1.02, "default" )
	dxDrawText("Фамилия", (sW / 2) - 260, (sH / 2) - 276, sW, sH, tocolor( 255, 255, 255, 255 ), 1.02, "default" )
	dxDrawText("Адрес", (sW / 2) - 110, (sH / 2) - 276, sW, sH, tocolor( 255, 255, 255, 255 ), 1.02, "default" )
	dxDrawText("     ЛКМ - Изменить                                                               СКМ - Создать                                                              ПКМ - Удалить", (sW / 2) - 400, (sH / 2) + 286, sW, 14, tocolor( 255, 255, 0, 255 ), 1.02, "default" )
	for i = 1,34,1 do
		if isMouseInPosition((sW / 2) - 380, (sH / 2) - 276 + (16 * i), 767, 16) then
			dxDrawRectangle ((sW / 2) - 380, (sH / 2) - 276 + (16 * i), 760, 16, tocolor(255,255,255,120))
			player = i + page
		end
		dxDrawText(players[1][i], (sW / 2) - 375, (sH / 2) - 276 + (16 * i), (sW / 2) - 270, (sH / 2) - 260 + (16 * i), tocolor( 255, 255, 255, 255 ), 1.02, "default", "left", "top", true)
		dxDrawText(players[2][i], (sW / 2) - 260, (sH / 2) - 276 + (16 * i), (sW / 2) - 120, (sH / 2) - 260 + (16 * i), tocolor( 255, 255, 255, 255 ), 1.02, "default", "left", "top", true )
		dxDrawText(players[3][i], (sW / 2) - 110, (sH / 2) - 276 + (16 * i), (sW / 2) + 380, (sH / 2) - 260 + (16 * i), tocolor( 255, 255, 255, 255 ), 1.02, "default", "left", "top", true )
	end
end
function dxDrawMenu()
	if choice == 3 then
		dxDrawArea((sW / 2) - 210, (sH / 2) - 75, 420, 150, tocolor(0,0,0,200))
		dxDrawArea((sW / 2) - 194, (sH / 2) - 61, 388, 122, tocolor(0,0,0,255))
	else
		dxDrawArea((sW / 2) - 400, (sH / 2) - 75, 800, 150, tocolor(0,0,0,200))
		dxDrawArea((sW / 2) - 383, (sH / 2) - 61, 767, 122, tocolor(0,0,0,255))
		dxDrawLine((sW / 2) - 383, (sH / 2) - 43, (sW / 2) + 383, (sH / 2) - 43, tocolor( 255, 255, 255))
		dxDrawText("Имя", (sW / 2) - 375, (sH / 2) - 40, sW, sH, tocolor( 255, 255, 255, 255 ), 1.02, "default" )
		dxDrawText("Фамилия", (sW / 2) - 375, (sH / 2) - 20, sW, sH, tocolor( 255, 255, 255, 255 ), 1.02, "default" )
		dxDrawText("Адрес", (sW / 2) - 375, (sH / 2), sW, sH, tocolor( 255, 255, 255, 255 ), 1.02, "default" )
		dxDrawRectangle((sW / 2) - 300, (sH / 2) - 39, 673, 14, tocolor(255,255,255,255))
		dxDrawRectangle((sW / 2) - 300, (sH / 2) - 19, 673, 14, tocolor(255,255,255,255))
		dxDrawRectangle((sW / 2) - 300, (sH / 2) +  1, 673, 14, tocolor(255,255,255,255))
	end
	dxDrawArea((sW / 2) - 180, (sH / 2) + 20, 170, 35,tocolor(0,0,0,255))
	dxDrawArea((sW / 2) +  10, (sH / 2) + 20, 170, 35,tocolor(0,0,0,255))
	if isMouseInPosition((sW / 2) - 180, (sH / 2) + 20, 170, 35) then
		dxDrawRectangle ((sW / 2) - 180, (sH / 2) + 20, 170, 35, tocolor(255,255,255,120))
	elseif isMouseInPosition((sW / 2) +  10, (sH / 2) + 20, 170, 35) then
		dxDrawRectangle ((sW / 2) +  10, (sH / 2) + 20, 170, 35, tocolor(255,255,255,120))
	end
	if choice == 1 then
		dxDrawText("Окно создания пользователя", (sW / 2) - 75, (sH / 2) - 58, sW, sH, tocolor( 255, 255, 255, 255 ), 1.02, "default" )
		dxDrawText("Создать" , (sW / 2) - 115, (sH / 2) + 30, sW, sH, tocolor( 0, 255, 0, 255 ), 1.02, "default" )
	end
	if choice == 2 then
		dxDrawText("Окно редактирования пользователя", (sW / 2) - 100, (sH / 2) - 58, sW, sH, tocolor( 255, 255, 255, 255 ), 1.02, "default" )
		dxDrawText("Изменить", (sW / 2) - 120, (sH / 2) + 30, sW, sH, tocolor( 0, 255, 0, 255 ), 1.02, "default" )
	end
	if choice == 3 then
		dxDrawText("Удалить?", (sW / 2) - 75, (sH / 2) - 40, sW, sH, tocolor( 255, 255, 255, 255 ), 3, "default" )
		dxDrawText("Подтвердить", (sW / 2) - 135, (sH / 2) + 30, sW, sH, tocolor( 0, 255, 0, 255 ), 1.02, "default" )
	else
		dxDrawText( editBoxes['name']   , (sW / 2) - 297, (sH / 2) - 39, (sW / 2) - 297 + 665, (sH / 2) - 23, tocolor( 0,0,0 ), 1.02, "default", "left", "top", true )
		dxDrawText( editBoxes['surname'], (sW / 2) - 297, (sH / 2) - 19, (sW / 2) - 297 + 665, (sH / 2) - 3, tocolor( 0,0,0 ), 1.02, "default", "left", "top", true )
		dxDrawText( editBoxes['address'], (sW / 2) - 297, (sH / 2) +  1, (sW / 2) - 297 + 665, (sH / 2) + 17, tocolor( 0,0,0 ), 1.02, "default", "left", "top", true )
	end
	dxDrawText("Отменить", (sW / 2) +  70, (sH / 2) + 30, sW, sH, tocolor( 255, 0, 0, 255 ), 1.02, "default" )
end
function dxClickMenu(button, state)
	if (button == "left") and (state == "down") and (isMouseInPosition((sW / 2) - 180, (sH / 2) + 20, 170, 35) or isMouseInPosition((sW / 2) +  10, (sH / 2) + 20, 170, 35)) then 
		removeEventHandler("onClientRender",  getRootElement(), dxDrawMenu     )
		removeEventHandler("onClientClick" ,  getRootElement(),  dxClickMenu   )
		if (choice == 1) and isMouseInPosition((sW / 2) - 180, (sH / 2) + 20, 170, 35) then
			triggerServerEvent("onCreatePlayer", getRootElement() , editBoxes['name'], editBoxes['surname'], editBoxes['address'] )
		elseif (choice == 2) and isMouseInPosition((sW / 2) - 180, (sH / 2) + 20, 170, 35) then
			triggerServerEvent("onUpdatePlayer", getRootElement() , editBoxes['name'], editBoxes['surname'], editBoxes['address'], player)
		elseif (choice == 3) and isMouseInPosition((sW / 2) - 180, (sH / 2) + 20, 170, 35) then 
			triggerServerEvent("onDeletePlayer", getRootElement() , player         )
		end
		for i = 1,3,1 do for j = 1,34,1 do players[i][j]="" end end 
		triggerServerEvent("onReadPlayer", getRootElement()                    )
		removeEventHandler( 'onClientKey', getRootElement(), lockKeysEditBox   )
		removeEventHandler( 'onClientCharacter', getRootElement(), forEditBoxes)
		removeEventHandler( 'onClientClick', getRootElement(), clickEditBox    )
		removeEventHandler( 'onClientRender', getRootElement(), dxEditBox      )
		addEventHandler("onClientRender" ,  getRootElement(),  dxDrawWindow    )
		addEventHandler("onClientClick" ,  getRootElement(),  dxClickWindow    )
	end
end
function dxEditBox ()
	if selEditBox == 'name' then
		dxDrawLine((sW / 2) - 300, (sH / 2) - 25, (sW / 2) + 373, (sH / 2) - 25, tocolor( 255,0,0,255 ))		
	elseif selEditBox == 'surname' then
		dxDrawLine((sW / 2) - 300, (sH / 2) -  5, (sW / 2) + 373, (sH / 2) -  5, tocolor( 255,0,0,255 ))			
	elseif selEditBox == 'address' then
		dxDrawLine((sW / 2) - 300, (sH / 2) + 15, (sW / 2) + 373, (sH / 2) + 15, tocolor( 255,0,0,255 ))			
	end
end
function clickEditBox ( button, state )
	if state == 'down' then return end
	if isMouseInPosition ( (sW / 2) - 300, (sH / 2) - 39, 673, 14 ) then
		selEditBox = 'name'
	elseif isMouseInPosition ( (sW / 2) - 300, (sH / 2) - 19, 673, 14 ) then
		selEditBox = 'surname'
	elseif isMouseInPosition ( (sW / 2) - 300, (sH / 2) +  1, 673, 14 ) then
		selEditBox = 'address'
	end
end
function forEditBoxes ( c )
	if selEditBox ~= 'none' then
		if utf8.len(editBoxes[selEditBox]) < 82 then
			editBoxes[selEditBox] = editBoxes[selEditBox] .. c
			print( editBoxes[selEditBox] )
		end
	end
end
function lockKeysEditBox ( button, press )
	if button == 'backspace' and press then
		if selEditBox ~= 'none' then
			editBoxes[selEditBox] = utf8.sub(editBoxes[selEditBox], 1,utf8.len(editBoxes[selEditBox])-1)
			print( editBoxes[selEditBox] )
		end
    else
        cancelEvent()
    end
end
addEvent("onBDMassive", true )
addEventHandler("onBDMassive", getRootElement(), BDMassive )