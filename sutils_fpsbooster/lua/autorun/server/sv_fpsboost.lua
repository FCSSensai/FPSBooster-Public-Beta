util.AddNetworkString( "OpenMenuCheck" )

hook.Add( "PlayerInitialSpawn", "OpenMenuChecker", function ( ply )
     timer.Simple(2, function()
          net.Start( "OpenMenuCheck" ) 
          net.Send( ply )
     end)
end)