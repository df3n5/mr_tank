/**
mr_tank - A tank game written with haXe    
Copyright (C) 2010 Jonathan Frawley

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
**/

package mrtank.factory;

import mrtank.gameview.IGameView;
import mrtank.gamelogic.IGameLogic;
import mrtank.gameview.TankHumanGameView;
import mrtank.gamelogic.TankGameLogic;

class TankFactory implements IFactory
{
	public function new()
	{
	}
	
	public function MakeLogic() : IGameLogic
	{
		var gameLogic : TankGameLogic;
		gameLogic = new TankGameLogic();
		if( ! gameLogic.Init() ) {
			return null;
		}
		return gameLogic;
	}
	
	public function MakeHumanGameView() : IGameView
	{
		var playerView : TankHumanGameView;
		playerView = new TankHumanGameView();
		if( ! playerView.Init() ) {
			return null;
		}
		return playerView;
	}
   
}