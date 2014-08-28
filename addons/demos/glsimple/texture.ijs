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
gluPerspective 60 1 1 30
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glTranslate 0 0 _3.6
texture ''
glFlush''
)

w=. 8 8$_1
b=. 8 8$0
pattern=: ,64 64$, (8 64$,w,.b),8 64$,b,.w

NB. note GL_RGBA so that pattern is 1 integer per texel
texture=: verb define
glClearColor 0 0 0 0
glEnable GL_DEPTH_TEST
glDepthFunc GL_LEQUAL
glPixelStorei GL_UNPACK_ALIGNMENT, 1

glaTexImage GL_TEXTURE_2D, 0 3 64 64 0, GL_RGBA, GL_UNSIGNED_BYTE,pattern

glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_WRAP_S,GL_CLAMP
glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_WRAP_T,GL_CLAMP
glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER,GL_NEAREST
glTexParameteri GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER,GL_NEAREST

glTexEnvi GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL
glEnable GL_TEXTURE_2D
glShadeModel GL_FLAT

glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glBegin GL_QUADS

glTexCoord4d 0 0 0 1
glVertex _2 _1 0

glTexCoord4d 0 1 0 1
glVertex _2 1 0

glTexCoord4d 1 1 0 1
glVertex 0 1 0

glTexCoord4d 1 0 0 1
glVertex 0 _1 0


glTexCoord4d 0 0 0 1
glVertex 1 _1 0

glTexCoord4d 0 1 0 1
glVertex 1 1 0

glTexCoord4d 1 1 0 1
glVertex 2.41421 1 _1.41421

glTexCoord4d 1 0 0 1
glVertex 2.41421 _1 _1.41421

glEnd''
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close

a_run''
