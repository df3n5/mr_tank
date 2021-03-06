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

import MtStage;
import MtStageGraphics;
import MtBackgroundGraphics;
import MtEvent;
import MtEventListener;
import MtEventType;
import MtGameLoadedEvent;
import MtEventManager;
import MtTankGraphics;
import MtBulletGraphics;

class MtGraphicsHandler implements MtEventListener
{
//	private var m_StageRef : MtStage;
	private var m_BackgroundGraphics : MtBackgroundGraphics;
	private var m_StageGraphics : MtStageGraphics;
	private var m_MovieClip : flash.display.MovieClip;
	private var m_PlayerTank:MtTank;
	private var m_PlayerTankGraphics:MtTankGraphics;
	private var m_BulletGraphics:List<MtBulletGraphics>;
	private var m_EnemyTanksGraphics:List<MtTankGraphics>;
	private var m_HealthBarsGraphics:List<MtHealthBarGraphics>;
	private var m_ExplosionGraphics:List<MtExplosionGraphics>;
	private var m_IsEndScreen:Bool;
	private var m_IsPlayerDead:Bool;
 
	public function new()
	{
		m_BackgroundGraphics = new MtBackgroundGraphics();
		m_StageGraphics = new MtStageGraphics();
        m_MovieClip = flash.Lib.current;
		//m_StageRef=null;
		m_PlayerTankGraphics = new MtTankGraphics();
		m_BulletGraphics = new List<MtBulletGraphics>();
		m_EnemyTanksGraphics = new List<MtTankGraphics>();
		m_HealthBarsGraphics = new List<MtHealthBarGraphics>();
		m_ExplosionGraphics = new List<MtExplosionGraphics>();
		m_IsEndScreen = false;
		m_IsPlayerDead = false;
	}

	public function getName():String
	{
		return "GraphicsHandler";
	}

	public function init() : Bool
	{
//		MtEventManager.getInstance().addListener(this);
		m_BackgroundGraphics.init();
		return true;
	}

	public function display()
	{
		if( ! m_IsEndScreen )
		{
			m_BackgroundGraphics.draw(m_MovieClip);
			m_StageGraphics.draw(m_MovieClip);
			if(m_PlayerTankGraphics != null)
			{
				m_PlayerTankGraphics.draw(m_MovieClip);
			}
			for(bulletGraphics in m_BulletGraphics)
			{
				bulletGraphics.draw(m_MovieClip);
			}
			for(enemyTankGraphics in m_EnemyTanksGraphics)
			{
				enemyTankGraphics.draw(m_MovieClip);
			}
			for(healthBarGraphics in m_HealthBarsGraphics)
			{
				healthBarGraphics.draw(m_MovieClip);
			}
			for(explosionGraphics in m_ExplosionGraphics)
			{
				if( ! explosionGraphics.isFinished())
				{
					explosionGraphics.advance(0.2);
					explosionGraphics.draw(m_MovieClip);
				}
				else
				{
					m_ExplosionGraphics.remove(explosionGraphics);
				}
			}
		}
		else
		{
			m_BackgroundGraphics.draw(m_MovieClip);
		}
	}

	public function setEndScreen()
	{
		m_IsEndScreen = true;
	}

	public function setPlayerDead()
	{
		m_IsPlayerDead = true;
	}

	public function handleEvent(event:MtEvent):Bool
	{
		if(event.getType()==MT_EVENT_GAMELOADED)
		{
			var gameLoadedEvent : MtGameLoadedEvent = cast event;
//			m_StageRef = gameLoadedEvent.getStage();
			m_StageGraphics.init(gameLoadedEvent.getStage());
		}
		else if(event.getType()==MT_EVENT_TANKCREATED)
		{
			var tankCreatedEvent : MtTankCreatedEvent = cast event;
			m_PlayerTank = tankCreatedEvent.getTank();	
			m_PlayerTankGraphics.init(tankCreatedEvent.getTank());
		}
		else if(event.getType()==MT_EVENT_ENEMYTANKCREATED)
		{
			var event : MtEnemyTankCreatedEvent = cast event;
			var enemyTankGraphics = new MtTankGraphics();
			enemyTankGraphics.init(event.getTank());	
			m_EnemyTanksGraphics.add(enemyTankGraphics);
		}
		else if(event.getType()==MT_EVENT_BULLETCREATED)
		{
			var bulletCreatedEvent : MtBulletCreatedEvent = cast event;
			var bullet = bulletCreatedEvent.getBullet();
			var bulletGraphics = new MtBulletGraphics();
			bulletGraphics.init(bullet, m_PlayerTank);
			m_BulletGraphics.add(bulletGraphics);
		}
		else if(event.getType() == MT_EVENT_TANK_BULLET_COLLISION)
		{
			//TODO : Create cool explosion effect
/*
			var event : MtTankBulletCollisionEvent = cast event;
			var bullet : MtBullet = event.getBullet();
			var tank :MtTank = event.getTank();
			//TODO : Delete Tank and bullet
			//setEndScreen();
			if(tank.equals(m_PlayerTank))
			{
				m_PlayerTankGraphics = null;
			}
			else
			{
				for(enemyTankGraphics in m_EnemyTanksGraphics)
				{
					if(enemyTankGraphics.getTank().equals(tank))
					{
						m_EnemyTanksGraphics.remove(enemyTankGraphics);
					}
				}
			}
*/
		}
		else if(event.getType() == MT_EVENT_TANK_TANK_COLLISION)
		{
/*
			var event : MtTankTankCollisionEvent = cast event;
			var tank0 : MtTank = event.getTank0();
			var tank1 : MtTank = event.getTank1();
			//Set both tanks invisible
			
			if((tank0.getActorID() == m_PlayerTank.getActorID()) || ( tank1.getActorID() == m_PlayerTank.getActorID()))
			{
				setPlayerDead();
			}
			for(enemyTankGraphics in m_EnemyTanksGraphics)
			{
				if((enemyTankGraphics.getTank().getActorID() == tank0.getActorID())
				   || (enemyTankGraphics.getTank().getActorID() == tank1.getActorID()))
				{
					m_EnemyTanksGraphics.remove(enemyTankGraphics);
				}
			}
*/
		}
		else if(event.getType() == MT_EVENT_HEALTH_BAR_CREATED)
		{
			var event : MtHealthBarCreatedEvent = cast event;
//			if(event.getHealthBar().getTank().equals(m_PlayerTank))
//			{
				var graphics = new MtHealthBarGraphics(event.getHealthBar());
				graphics.init();
				m_HealthBarsGraphics.add(graphics);
//			}
		}
		else if(event.getType() == MT_EVENT_TANKDESTROYED)
		{
			var event : MtTankDestroyedEvent = cast event;
			var tank :MtTank = event.getTank();
			//TODO : Delete Tank and bullet
			//setEndScreen();
			if(tank.equals(m_PlayerTank))
			{
				m_PlayerTankGraphics = null;
			}
			else
			{
				for(enemyTankGraphics in m_EnemyTanksGraphics)
				{
					if(enemyTankGraphics.getTank().equals(tank))
					{
						m_EnemyTanksGraphics.remove(enemyTankGraphics);
					}
				}
			}
			for(healthbargraphics in m_HealthBarsGraphics)
			{
				if(healthbargraphics.getHealthBar().getTank() == tank)
				{
					m_HealthBarsGraphics.remove(healthbargraphics);
				}
			}
		}
		else if(event.getType() == MT_EVENT_BULLETDESTROYED)
		{
			var event : MtBulletDestroyedEvent = cast event;
			var bullet = event.getBullet();
			for(bulletGraphics in m_BulletGraphics)
			{
				if(bullet.equals(bulletGraphics.getBullet()))
				{
					m_BulletGraphics.remove(bulletGraphics);
					break;
				}
			}
			//Create explosion effect for bullet
			var explosionGraphics = new MtBulletExplosionGraphics();
			explosionGraphics.init(bullet);
			m_ExplosionGraphics.add(explosionGraphics);
			
		}
		return true;
	}
}


