require 'gl3'
coinsert 'jgl3'

A=: noun define
pc a;
xywh 0 0 100 100;cc g opengl rightmove bottommove;
pas 0 0;
rem form end;
)

a_run=: verb define
wd A
wd 'pshow'
)

lighttext=: 3 : 0
glaLight GL_LIGHT0, GL_AMBIENT, 0.6 0.6 0.6 1
glaLight GL_LIGHT0, GL_DIFFUSE, 0.9 0.9 1 1
glaLight GL_LIGHT0, GL_SPECULAR, 1 1 1 1
glaLight GL_LIGHT0, GL_POSITION, 1 1 1.1 1
glaMaterial GL_FRONT_AND_BACK,GL_SPECULAR, 1 1 1 1
glaMaterial GL_FRONT_AND_BACK,GL_SHININESS, 128 0 0 1
)

a_close=: 3 : 0
wd 'pclose'
)

a_g_paint=: verb define
wh=. gl_qwh''
metrics=: ('arial';30) glaUseFontOutlines 32 95 32 0 0.3,WGL_FONT_POLYGONS
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
gluPerspective 30, (%/wh), 1 10
glOrtho 0 2 0 2 0 2
glClearColor 0 0 1 0
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glRotated 20 0 1 0
glEnable GL_LIGHTING
glEnable GL_LIGHT0
lighttext''
glTranslate _1.5 1 5
glColor 1 1 1 0
glRasterPos 0 1 0
glaCallLists 'ABC'
glFlush''
)

a_cancel=: a_close

a_run''
