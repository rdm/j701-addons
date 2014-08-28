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
Z=: _1
wd 'pshow'
)

a_g_char=: verb define
k=. 0{sysdata
Z=: 2 <. Z + 0.1*'i'=k
Z=: _2 >. Z - 0.1*'o'=k
gl_paintx''
)

a_g_paint=: verb define
wh=. gl_qwh''
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
glOrtho _6 6 _6 6 _6 6
fog''
glMatrixMode GL_MODEL_VIEW
glLoadIdentity ''
glTranslate 0 0 , Z
glColor 1 0 0 1
sphere''
glFlush''
)

fog=: verb define
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glEnable GL_DEPTH_TEST
glDepthFunc GL_LEQUAL
glaLight GL_LIGHT0, GL_POSITION, 0 3 3 0
glLightModeli GL_LIGHT_MODEL_LOCAL_VIEWER, 0
glFrontFace GL_CW
glEnable GL_LIGHTING
glEnable GL_LIGHT0
glEnable GL_AUTO_NORMAL
glEnable GL_NORMALIZE
glEnable GL_FOG
glaFog GL_FOG_MODE,GL_EXP
glaFog GL_FOG_COLOR,0.5 0.5 0.5 1
glHint GL_FOG_HINT, GL_DONT_CARE
glClearColor 0.5 0.5 0.5 1
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glEnable GL_AUTO_NORMAL
glEnable GL_NORMALIZE
glEnable GL_FOG
glaFog GL_FOG_MODE,GL_EXP
glaFog GL_FOG_COLOR,0.5 0.5 0.5 1
glHint GL_FOG_HINT, GL_DONT_CARE
glClearColor 0.5 0.5 0.5 1
)

sphere=: verb define
obj=. 0 pick gluNewQuadric''
glaMaterial GL_FRONT,GL_AMBIENT, 0.1745 0.01175 0.01175 0
glaMaterial GL_FRONT,GL_DIFFUSE, 0.61424 0.04136 0.04136 0
glaMaterial GL_FRONT,GL_SPECULAR, 0.727811 0.626959 0.626959 0
glaMaterial GL_FRONT,GL_SHININESS, (0.6*128), 0 0 0
gluQuadricNormals obj,GLU_SMOOTH
gluQuadricDrawStyle obj,GLU_FILL
gluSphere obj,2 32 32
gluDeleteQuadric obj
)

a_help_button=: verb define
wdinfo 'OpenGL';'Press i o to move in and out of the fog.'
wd 'setfocus g'
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close
a_run''
