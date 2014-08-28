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
FILL=: 0
STEPS=: 4
wd 'pshow'
)

a_g_char=: verb define
k=. 0{sysdata
STEPS=: 100 <. STEPS + 's' = k
STEPS=: 0 >. STEPS - 'a' = k
FILL=: ('f'=k) { FILL,-.FILL
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
light''
surface ''
glFlush''
)

b2dpts=: noun define
_1.5 _1.5  4
_0.5 _1.5  2
 0.5 _1.5 _1
 1.5 _1.5  2
_1.5 _0.5  1
_0.5 _0.5  3
 0.5 _0.5  0
 1.5 _0.5 _1
_1.5  0.5  4
_0.5  0.5  0
 0.5  0.5  3
 1.5  0.5  4
_1.5  1.5 _2
_0.5  1.5 _2
 0.5  1.5  0
 1.5  1.5 _1
)

surface=: verb define
x=. b2dpts
x=. ' ' ((x=LF)#i.#x)} x
points=: ".x
glClearColor 0 0 0 1
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glColor 1 1 1 1
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glaMap2 GL_MAP2_VERTEX_3,0 1 3 4 0 1 12 4, points
glEnable GL_MAP2_VERTEX_3
glEnable GL_AUTO_NORMAL
glMapGrid2d STEPS,0 1,STEPS,0 1
glEnable GL_DEPTH_TEST
glShadeModel GL_FLAT
glRotate 85 1 1 1
glEvalMesh2 (FILL{GL_LINE,GL_FILL),0,STEPS,0,STEPS
)

light=: verb define
if. FILL do.
  glaLight GL_LIGHT0, GL_AMBIENT, 0.1 0.1 0.1 1
  glaLight GL_LIGHT0, GL_DIFFUSE, 0.7 0.7 0.7 1
  glaLight GL_LIGHT0,GL_SPECULAR, 0.0 0.0 0.0 1
  glEnable GL_LIGHTING
  glEnable GL_LIGHT0
  glaMaterial GL_FRONT,GL_AMBIENT_AND_DIFFUSE, 1 0 0 1
else.
  glDisable GL_LIGHTING
end.
)

a_help_button=: verb define
wdinfo 'OpenGL';'Press a and s keys to changes steps, f key to toggle line and fill.'
wd 'setfocus g'
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close

a_run''
