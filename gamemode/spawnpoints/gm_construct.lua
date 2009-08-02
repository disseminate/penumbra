MAP.ShadowSpawns = {
	Vector( 161.928619, -593.899536, -84.034210 ),
	Vector( -1916.034058, -617.825256, -84.018768 ),
	Vector( -1956.258057, 1362.646118, -82.741150 ),
	Vector( 24.360035, 1384.953491, -82.742081 )
}

--How to add a map.
--Make a [map].lua file in this spawnpoints directory. 
--Have it include the above - MAP.ShadowSpawns = {
--Inside, mimic the above statements. Vector( [x], [y], [z] ).
--You can get x y z from the 'getpos' console command.
-- eg 

--] getpos
-- setpos 1 2 3; setang 4 5 6
-- 1 2 3 = x y z
-- If your spawn file doesn't work, it doesn't look like the above MAP.ShadowSpawns.
-- Add me on SF at disseminate if you have any issues.