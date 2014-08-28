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
R=: 20 30 0
wd 'pshow'
)

a_g_char=: verb define
R=: 360 | R + 2 * 'xyz' = 0 { sysdata
gl_paintx''
)

a_g_paint=: verb define
wh=. gl_qwh''
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
gluPerspective 30, (%/wh),1 10
glClearColor 1 1 1 0
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glEnable GL_DEPTH_TEST
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glTranslate 0 0 _8
glRotate R ,. 3 3 $ 1 0 0 0
drawbox ''
glFlush''
)

BLUE=: 0 0 1
GREEN=: 0 1 0
RED=: 1 0 0

drawbox=: verb define
p=. _1 ^ #: i.8
RED polygon 0 1 3 2{p
RED polygon 0 1 5 4{p
RED polygon 0 2 6 4{p
RED polygon 4 5 7 6{p
RED polygon 1 3 7 5{p
RED polygon 2 3 7 6{p
)

polygon=: 4 : 0
glColor 4{.x,1
glBegin GL_POLYGON
glVertex y
glEnd ''
)

a_help_button=: verb define
wdinfo 'OpenGL';'Missing visual clues. Press the x y and z keys to rotate the cube.'
wd 'setfocus g'
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close

a_run''
