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
R=: 20 30 0
wd 'pshow'
)

t1=: 2 2 _5 ; 3 2 _5 ; 2.5 3 _5
t2=: 2 7 _5 ; 3 7 _5 ; 2.5 8 _5
t3=: 2 2 0 ; 3 2 0 ; 2.5 3 0
t4=: 2 2 _2 ; 3 2 _2 ; 2.5 3 _2

mm=: verb define
glMatrixMode y
glLoadIdentity''
)

a_g_paint=: verb define
wh=. gl_qwh''
glDepthFunc GL_LEQUAL
glEnable GL_DEPTH_TEST
glShadeModel GL_FLAT
glaSelectBuffer 100
glViewport 0 0 ,wh
glClearColor 0 0 0 0
glClear GL_COLOR_BUFFER_BIT+GL_DEPTH_BUFFER_BIT
drawscene''
glFlush''
)

drawscene=: verb define
mm GL_PROJECTION
gluPerspective 40 1 0.01 100
mm GL_MODELVIEW
gluLookAt 7.5 7.5 12.5 2.5 2.45 _5 0 1 0
glColor 0 1 0 0
drawtriangle t1
glColor 1 0 0 0
drawtriangle t2
glColor 1 1 0 0
drawtriangle t3
drawtriangle t4
drawviewvolume 0 5 0 5 0 10
)

drawtriangle=: verb define
glBegin GL_TRIANGLES
glVertex >y
glEnd''
)

drawviewvolume=: verb define
'x1 x2 y1 y2 z1 z2'=. y
glColor 1 1 1 0
glBegin GL_LINE_LOOP
glVertex x1,y1,-z1
glVertex x2,y1,-z1
glVertex x2,y2,-z1
glVertex x1,y2,-z1
glEnd''

glBegin GL_LINE_LOOP
glVertex x1,y1,-z2
glVertex x2,y1,-z2
glVertex x2,y2,-z2
glVertex x1,y2,-z2
glEnd''

glBegin GL_LINES
glVertex x1,y1,-z1
glVertex x1,y1,-z2
glVertex x1,y2,-z1
glVertex x1,y2,-z2
glVertex x2,y1,-z1
glVertex x2,y1,-z2
glVertex x2,y2,-z1
glVertex x2,y2,-z2
glEnd''
)

selectobjects_z_=: verb define
wd 'psel a'
wh=. gl_qwh''
'w h'=. wh
len=. 15  NB. 3 selections, 5 values each
select=. mema len*4     NB. allocate select buffer
((4*len)${.a.) memw select,0,(4*len),JCHAR NB. clear buffer to 0
glaSelectBuffer len,select
glRenderMode GL_SELECT
glInitNames ''
glPushName 0
glPushMatrix ''
mm GL_PROJECTION
glOrtho 0 5 0 5 0 5
mm GL_MODELVIEW
glLoadName 1
drawtriangle t1
glLoadName 2
drawtriangle t2
glLoadName 3
drawtriangle t3
glPushName 4
drawtriangle t4
glPopMatrix''
glFlush''
glRenderMode GL_RENDER
selbuf=. _2 ic memr select,0,(4*len),JCHAR
memf select            NB. free select buffer
_5[\selbuf
)

feedback=: verb define
glFeedbackBuffer 1000, GL_3D_COLOR
glRenderMode GL_FEEDBACK
mm GL_PROJECTION
glOrtho 0 5 0 5 0 5
mm GL_MODELVIEW
drawtriangle t1
glPassThrough 3.3
drawtriangle t2
drawtriangle t3
drawtriangle t4
glFlush''
glRenderMode GL_RENDER
)

a_help_button=: verb define
wdinfo 'OpenGL';'Run selectobjects_jdemos_'''' in ijx window.'
wd 'setfocus g'
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close
a_run''
