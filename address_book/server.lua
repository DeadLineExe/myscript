dbSQL = dbConnect( "mysql", "host=db4free.net;port=3306;dbname=mta_players", "deadlineexe", "exeenildaed" )

function connectBaseSQL()
    if (not dbSQL) then
        outputDebugString("Ошибка: Соединение с БД не установлено!")
    else
        outputDebugString("Успешно: Соединение с БД установлено!")
		triggerEvent("onAutoIndex", getRootElement())
    end	
end

function indexPlayerSQL()
	dbExec ( dbSQL,
	[[UPDATE players
	  SET id = (SELECT @a:= @a + 1 FROM (SELECT @a:= 0) as id)
	  ORDER BY id
	]]
	)
end

function createPlayerSQL( name, surname, address)
	dbExec ( dbSQL,
    [[INSERT 
	  INTO players ( name, surname, address ) 
      VALUES ( ?, ?, ? );
	]]
	, name, surname, address )
	triggerEvent("onAutoIndex", getRootElement())
end

function readPlayerSQL()
	triggerEvent("onAutoIndex", getRootElement())
    dbQuery ( 
        function ( queryHandle )
            local resultTable, num, err = dbPoll( queryHandle, 0 ) 
            if resultTable then
                for rowNum, rowData in ipairs(resultTable) do 
					triggerClientEvent("onBDMassive", getRootElement(), rowData['id'], rowData['name'], rowData['surname'], rowData['address'])
                end 
            end
        end, 
        dbSQL,
        "SELECT id , name, surname, address FROM players"
    )
end

function updatePlayerSQL( name, surname, address, id)
	dbExec ( dbSQL,
	[[UPDATE players 
	  SET name = ? , surname = ? , address = ? 
	  WHERE  id = ?;
	]]
	, name, surname, address, id )
end

function deletePlayerSQL(id)
	dbExec ( dbSQL,
	[[DELETE FROM players
	  WHERE id = ?; 
	]]
	, id )
end

addEvent("onAutoIndex"   , true )
addEvent("onCreatePlayer", true )
addEvent("onReadPlayer"  , true )
addEvent("onUpdatePlayer", true )
addEvent("onDeletePlayer", true )

addEventHandler("onAutoIndex"    , getRootElement(), indexPlayerSQL  )
addEventHandler("onCreatePlayer" , getRootElement(), createPlayerSQL )
addEventHandler("onReadPlayer"   , getRootElement(), readPlayerSQL   )
addEventHandler("onUpdatePlayer" , getRootElement(), updatePlayerSQL )
addEventHandler("onDeletePlayer" , getRootElement(), deletePlayerSQL )

addEventHandler("onResourceStart", getRootElement(), connectBaseSQL)