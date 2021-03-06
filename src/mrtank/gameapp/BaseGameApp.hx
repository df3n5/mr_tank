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

package mrtank.gameapp;

import mrtank.factory.IFactory;
import mrtank.gamelogic.IGameLogic;
import mrtank.gameview.IGameView;
import mrtank.event.EventManager;

class BaseGameApp implements IGameApp
{
	private var m_GameLogic : IGameLogic;
	private var m_GameView : IGameView;
	private var m_Factory : IFactory;
	
	public function new()
	{
	}

	public function Init() : Bool
	{
		if( ! CreateFactory() ) {
			return false;
		}
		if( ! CreateGameLogicAndView()){
			return false;
		}
		return true;
	}

	private function CreateGameLogicAndView() : Bool
	{
		m_GameLogic = m_Factory.MakeLogic();
		m_GameView = m_Factory.MakeHumanGameView();
		m_GameLogic.OnAttach(m_GameView);
		return true;
	}

	private function CreateFactory() : Bool
	{
		return false;
	}

	public function MainLoop() : Bool
	{
		EventManager.GetInstance().Tick();
		m_GameLogic.OnUpdate();	
		m_GameView.OnRender();
		return true;
	}
}
