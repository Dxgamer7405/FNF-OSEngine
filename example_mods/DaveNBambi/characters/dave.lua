xx = 400;
yy = 500;
ofs = 50;
followchars = true;
dadzoom = 1.0

function opponentNoteHit()
    
    if followchars == true then
			setProperty('defaultCamZoom', dadzoom)
      if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
          triggerEvent('Camera Follow Pos',xx-ofs,yy)
      end
      if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
          triggerEvent('Camera Follow Pos',xx+ofs,yy)
      end
      if getProperty('dad.animation.curAnim.name') == 'singUP' then
          triggerEvent('Camera Follow Pos',xx,yy-ofs)
      end
      if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
          triggerEvent('Camera Follow Pos',xx,yy+ofs)
      end
      if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
          triggerEvent('Camera Follow Pos',xx-ofs,yy)
      end
      if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
          triggerEvent('Camera Follow Pos',xx+ofs,yy)
      end
      if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
          triggerEvent('Camera Follow Pos',xx,yy-ofs)
      end
      if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
          triggerEvent('Camera Follow Pos',xx,yy+ofs)
      end
      if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
          triggerEvent('Camera Follow Pos',xx,yy)
      end
      if getProperty('dad.animation.curAnim.name') == 'idle' then
          triggerEvent('Camera Follow Pos',xx,yy)
      end
    else
        triggerEvent('Camera Follow Pos','','')
    end
end