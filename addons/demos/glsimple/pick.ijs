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
wd 'pshow'
)

board=: 3 3 $ 0

a_g_paint=: verb define
wh=. gl_qwh''
glViewport 0 0 ,gl_qwh''
mm GL_PROJECTION
gluOrtho2D 0 3 0 3
mm GL_MODELVIEW
glaSelectBuffer 100
glClearColor 0 0 0 0
glClear GL_COLOR_BUFFER_BIT
drawsquares GL_RENDER
glFlush''
)

mm=: verb define
glMatrixMode y
glLoadIdentity''
)

drawsquares=: verb define
b=. y=GL_SELECT
i=. 0
while. i<3 do.
  if. b do. glLoadName i end.
  j=. 0
  while. j<3 do.
    if. b do. glPushName j end.
    glColor (i%3), (j%3) , (i{j{board) , 0
    glRect i,j, 1+i,j
    if. b do. glPopName'' end.
    j=. >:j
  end.
  i=. >:i
end.
)

a_g_mbldown=: verb define
wh=. gl_qwh''
'w h'=. wh
'x y'=. 2{.".sysdata

len=. 20  NB. max 4 selections, 5 values each
select=. mema len*4     NB. allocate select buffer
((4*len)${.a.) memw select,0,(4*len),JCHAR NB. clear buffer to 0
glaSelectBuffer len,select
glRenderMode GL_SELECT

glInitNames''
glPushName _1
glMatrixMode GL_PROJECTION

glPushMatrix''
glLoadIdentity''
gluaPickMatrix x , y , 5 5 , 0 0 , w , h
gluOrtho2D 0 3 0 3
drawsquares GL_SELECT
glPopMatrix''
glFlush''
glRenderMode GL_RENDER
selbuf=. _2 ic memr select,0,(4*len),JCHAR
memf select            NB. free select buffer

NB. we know each hit has 5 values (count, min, max, row, col)
selbuf=. _5[\ selbuf
selbuf=. selbuf #~ +./"1 selbuf ~: 0
selbuf=. _2 {."1 selbuf
wdinfo 'OpenGL';'selected cell(s) row,col',(,(":selbuf),.~LF)
)

a_help_button=: verb define
wd'mb OpenGL *Click mouse on square or at corners.'
wd 'setfocus g'
)

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close
a_run''
