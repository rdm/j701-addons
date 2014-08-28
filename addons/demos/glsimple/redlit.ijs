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
light''
drawbox ''
glFlush''
)

light=: verb define
glaLight GL_LIGHT0, GL_AMBIENT, 0.1 0.1 0.1 1
glaLight GL_LIGHT0, GL_DIFFUSE, 0.7 0.7 0.7 1
glaLight GL_LIGHT0,GL_SPECULAR, 0.0 0.0 0.0 1
glEnable GL_LIGHTING
glEnable GL_LIGHT0
glaMaterial GL_FRONT,GL_AMBIENT_AND_DIFFUSE, 1 0 0 1
)

BLUE=: 0 0 1
GREEN=: 0 1 0
RED=: 1 0 0

drawbox=: verb define
p=. _1 ^ #: i.8

n0=. 1 0 0
n1=. 0 1 0
n2=. 0 0 1
n3=. _1 0 0
n4=. 0 0 _1
n5=. 0 _1 0

glaMaterial GL_FRONT,GL_AMBIENT_AND_DIFFUSE, 1 0 0 1
glColor 1 0 0 1
n0 polygonnormal 0 1 3 2{p
n1 polygonnormal 0 1 5 4{p
n2 polygonnormal 0 2 6 4{p
n3 polygonnormal 4 5 7 6{p
n4 polygonnormal 1 3 7 5{p
n5 polygonnormal 2 3 7 6{p
)

polygonnormal=: 4 : 0
glBegin GL_POLYGON
glNormal x
t=. y
while. #t do.
  glVertex 3{.t
  t=. 3}.t
end.
glEnd''
)

a_help_button=: verb define
wdinfo 'OpenGL';'Press the x y and z keys to rotate the cube.'
wd 'setfocus g'
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close

a_run''
