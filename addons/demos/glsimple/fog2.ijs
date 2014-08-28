require 'gl3'
coinsert 'jgl3'

A=: noun define
pc a;
menupop "&Help";
menu help "&Help" "" "" "";
menupopz;
xywh 0 0 250 100;cc g opengl rightmove bottommove;
pas 0 0;
rem form end;
)

a_run=: verb define
wd A
MODE=: GL_EXP
wd 'pshow'
)

a_g_char=: verb define
MODE=: (1 i.~'123'={.sysdata){GL_EXP,GL_EXP2,GL_LINEAR,MODE
gl_paintx''
)

a_g_paint=: verb define
wh=. gl_qwh''
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
wh=. \:~wh
glOrtho _2.5 2.5,(_2.5*%~/wh),(2.5*%~/wh),_10 10
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glClearColor 0.5 0.5 0.5 1
glClear GL_COLOR_BUFFER_BIT+GL_DEPTH_BUFFER_BIT
fog''
sphere''
3 : 'glCallList SPHERE[glTranslate y[glLoadIdentity$0'"1] (i:2),.0,.->:i.5
glFlush''
)

fog=: verb define
glEnable GL_DEPTH_TEST
glaLight GL_LIGHT0, GL_POSITION, 0.5 0.5 3 0
glEnable GL_LIGHTING
glEnable GL_LIGHT0

glEnable GL_FOG
glaFog GL_FOG_MODE, MODE
glaFog GL_FOG_COLOR,0.5 0.5 0.5 1
glaFog GL_FOG_DENSITY,0.35
glHint GL_FOG_HINT, GL_DONT_CARE
glaFog GL_FOG_START, 1
glaFog GL_FOG_END, 5
)

sphere=: verb define
obj=. 0 pick gluNewQuadric''
glNewList (SPHERE=: 1 pick glGenLists 1),GL_COMPILE
glaMaterial GL_FRONT,GL_AMBIENT, 0.1745 0.01175 0.01175 0
glaMaterial GL_FRONT,GL_DIFFUSE, 0.61424 0.04136 0.04136 0
glaMaterial GL_FRONT,GL_SPECULAR, 0.727811 0.626959 0.626959 0
glaMaterial GL_FRONT,GL_SHININESS, (0.6*128), 0 0 0
gluQuadricNormals obj,GLU_SMOOTH
gluQuadricDrawStyle obj,GLU_FILL
gluSphere obj,0.4 32 32
glEndList''
gluDeleteQuadric obj
)

a_help_button=: verb define
wdinfo 'OpenGL';'Press 1, 2, and 3 to switch between fog functions.'
wd 'setfocus g'
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close
a_run''
