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
import MtEvent;
import MtEventType;

class MtTankBulletCollisionEvent extends MtEvent
{
	private var m_Tank : MtTank;
	private var m_Bullet : MtBullet;

	public function new(tank:MtTank, bullet:MtBullet)
	{
		m_Type = MT_EVENT_TANK_BULLET_COLLISION;
		m_Tank = tank;
		m_Bullet = bullet;
	}

	public function getTank():MtTank
	{
		return m_Tank;
	}

	public function getBullet():MtBullet
	{
		return m_Bullet;
	}
}
