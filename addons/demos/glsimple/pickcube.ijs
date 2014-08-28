require 'gl3'
coinsert 'jgl3'

A=: noun define
pc a;
menupop "&Help";
menu help "&Help" "" "" "";
menupopz;
xywh 0 0 150 150;cc g opengl rightmove bottommove;
pas 0 0;
rem form end;
)

a_run=: verb define
wd A
R1=: R2=: 20 30 0
S=: 1
wd 'pshow;'
)

a_g_char=: verb define
k=. 0{sysdata
if. S=1 do.
  R1=: 360 | R1 + 2 * 'xyz'=k end.
if. S=2 do.
  R2=: 360 | R2 + 2 * 'xyz'=k end.
gl_paintx''
)

a_g_paint=: verb define
wh=. gl_qwh''
glaSelectBuffer 100
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
gluPerspective 60, (%/wh),1 10
draw''
glFlush''
)

a_g_mbldown=: verb define
wh=. gl_qwh''
'w h'=. wh
'x y'=. 2{.".sysdata

len=. 5
select=. mema len*4     NB. allocate select buffer
((4*len)${.a.) memw select,0,(4*len),JCHAR NB. clear buffer to 0
glaSelectBuffer len,select
glRenderMode GL_SELECT

glInitNames''
glPushName _1
glMatrixMode GL_PROJECTION

glPushMatrix''
glLoadIdentity''
gluaPickMatrix x , (h-y) , 5 5 , 0 0 , w , h
gluPerspective 60, (w%h),1 10
draw''
glPopMatrix''
glFlush''
glRenderMode GL_RENDER
selbuf=. _2 ic memr select,0,(4*len),JCHAR
memf select            NB. free select buffer
S=: 3 { selbuf
)

BLUE=: 0 0 1
GREEN=: 0 1 0
RED=: 1 0 0

drawbox=: verb define
p=. _1 ^ #: i.8
BLUE polygon 0 1 3 2{p
GREEN polygon 0 1 5 4{p
RED polygon 0 2 6 4{p
(RED+BLUE) polygon 4 5 7 6{p
(RED+GREEN) polygon 1 3 7 5{p
(BLUE+GREEN) polygon 2 3 7 6{p
)

polygon=: 4 : 0
glColor 4{.x,1
glBegin GL_POLYGON
glVertex y
glEnd ''
)

draw=: verb define
glClearColor 1 1 1 0
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glEnable GL_DEPTH_TEST
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glTranslate 2 0 _8
glRotate R1 ,. 3 3 $ 1 0 0 0
glLoadName 1
drawbox ''
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glTranslate _2 0 _8
glRotate R2 ,. 3 3 $ 1 0 0 0
glLoadName 2
drawbox ''
)

a_help_button=: verb define
wdinfo 'OpenGL';'Rotate selected cube with x y z keys. Select cube with mouse click.'
wd 'setfocus g'
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close
a_run''
