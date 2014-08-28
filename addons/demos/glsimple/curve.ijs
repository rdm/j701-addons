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
R=: 0 0 0
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
if. </wh do.
  glOrtho _5 5,(_5 5*%%/wh), _5 5
else.
  glOrtho (_5 5*%/wh), _5 5 _5 5
end.
glClearColor 0 0 0 0
glClear GL_COLOR_BUFFER_BIT
bezier ''
glFlush''
)

bezier=: verb define
ctrlpoints=: _4 _4 0 _2 4 0 2 _4 0 4 4 0
glaMap1 GL_MAP1_VERTEX_3, 0, 1, 3,4, ctrlpoints
glEnable GL_MAP1_VERTEX_3
glColor 1 1 1 1
glBegin GL_LINE_STRIP
glEvalCoord1d"0 (i.30)%30
glEnd''
glPointSize 5
glColor 1 0 0 1
glBegin GL_POINTS
glVertex 4 3$ctrlpoints
glEnd''
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close

a_run''
