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
R=: 0
WIRES=: 2
wd 'pshow'
)

a_g_char=: verb define
R=: 360 | R + 2 * 'xyz' = 0 { sysdata
gl_paintx''
)

a_g_paint=: verb define
wh=. gl_qwh''
wires ''
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
gluPerspective 30, (%/wh),1 10
glClearColor 0 0 0 0
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glEnable GL_DEPTH_TEST
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glTranslate 0 0 _8
glRotate R ,. 3 3 $ 1 0 0 0
glCallList WIRES
glFlush''
)

wires=: verb define
obj=. 0 pick gluNewQuadric''
glNewList WIRES,GL_COMPILE
gluQuadricDrawStyle obj,GLU_LINE
gluSphere obj,0.5 32 32
glTranslate _1 0 0
gluSphere obj,0.2 8 8
glTranslate 2 0 0
gluCylinder obj,0.2 0.4 1 8 8
glEndList''
gluDeleteQuadric obj
)

a_help_button=: verb define
wdinfo 'OpenGL';'Press x y z to rotate.'
wd 'setfocus g'
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close

a_run''
