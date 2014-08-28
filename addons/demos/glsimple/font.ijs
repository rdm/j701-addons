NB. note glaUseFontBitmaps supported in Windows only

require 'gl3'
coinsert 'jgl3'

A=: noun define
pc a;
xywh 0 0 300 78;cc g opengl rightmove bottommove;
pas 0 0;
rem form end;
)

a_run=: verb define
wd A
TEXT=: 'Type stuff here: '
wd 'pshow'
)

a_g_char=: verb define
TEXT=: TEXT,{.sysdata
gl_paintx''
)

a_g_paint=: verb define
wh=. gl_qwh''
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
glOrtho 0 2 0 2 0 2
glClearColor 1 1 1 0
glClear GL_COLOR_BUFFER_BIT
glColor 1 0 0 1
glMatrixMode GL_MODELVIEW
glLoadIdentity ''
glRasterPos 0 1 0
('arial';30) glaUseFontBitmaps 32 95 32
glaCallLists TEXT
glFlush''
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close

a_run''
