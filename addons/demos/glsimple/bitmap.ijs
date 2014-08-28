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
R=: 20 30 0
wd 'pshow'
)

a_g_paint=: verb define
wh=. gl_qwh''
glMatrixMode GL_PROJECTION
glLoadIdentity''
glPixelStorei GL_UNPACK_ALIGNMENT,1
glClearColor 1 1 1 1
glClear GL_COLOR_BUFFER_BIT
glColor 0 0 0 1
glRasterPos 20 20 0
glaBitmap 8 8 0 0 0 0 ;2#".'2b',32$'01'
glRasterPos 80 80 0
glaBitmap 8 8 0 0 0 0 ;_1 _1
glRasterPos 180 180 0
glaBitmap 8 8 2.5 2.5 2.5 2.5;_1 _1

glRasterPos 20 150 0
glPixelZoom 1 1
glaDrawPixels (20 20,GL_BLUE,GL_INT); 400 $ 2147482496

glPixelZoom 2 2
glRasterPos 0 200 0
glCopyPixels 0 0 100 100,GL_COLOR

NB. !!!remove ReadPixels for nonce
NB. glPixelZoom 1 1
NB. d=. glaReadPixels 0 0 100 100,GL_RGBA,GL_INT
NB. glRasterPos 200 0 0
NB. glaDrawPixels (100 100,GL_RGBA,GL_INT);d

glFlush''
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close
a_run''
