require 'gl3'
coinsert 'jgl3'

A=: noun define
pc a;
xywh 0 0 150 150;cc g opengl rightmove bottommove;
pas 0 0;
rem form end;
)

a_run=: verb define
wd A
wd 'pshow'
)

a_g_paint=: verb define
wh=. gl_qwh''
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
glOrtho 0 1 0 1 _1 1
glEnable GL_BLEND
glBlendFunc GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA
glShadeModel GL_FLAT
glClearColor 0 0 0 0
glClear GL_COLOR_BUFFER_BIT

glColor 1 1 0 0.75
glRect 0 0 0.5 1

glColor 0 1 1 0.75
glRect 0 0 1 0.5

glColor 0 1 1 0.75
glRect 0.5 0.5 1 1

glColor 1 1 0 0.75
glRect 0.5 0.5 1 1

glFlush''
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close

a_run''
