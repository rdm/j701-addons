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
glClearColor 0 0 0 1
glaMaterial GL_FRONT,GL_DIFFUSE, 0.7 0.7 0.7 1
glaMaterial GL_FRONT,GL_SPECULAR, 1 1 1 1
glaMaterial GL_FRONT,GL_SHININESS, 100 0 0 0
glEnable GL_LIGHTING
glEnable GL_LIGHT0
glDepthFunc GL_LESS
glEnable GL_DEPTH_TEST
glEnable GL_AUTO_NORMAL
glEnable GL_NORMALIZE
nurb=. {.gluNewNurbsRenderer ''
gluNurbsProperty nurb;GLU_SAMPLING_TOLERANCE;25
gluNurbsProperty nurb;GLU_DISPLAY_MODE;GLU_FILL
glMatrixMode GL_PROJECTION
glLoadIdentity ''
gluPerspective 45 1 3 8
glMatrixMode GL_MODELVIEW
glLoadIdentity''
glTranslate 0 0 _5
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glPushMatrix''
glRotate 330 1 0 0
glScale 0.5 0.5 0.5
gluBeginSurface <nurb
gluNurbsSurface nurb;8;knots;8;knots;12;3;(,nurbpts'');4;4;GL_MAP2_VERTEX_3
gluEndSurface <nurb
glPopMatrix''
gluDeleteNurbsRenderer <nurb
glFlush''
)

nurbpts=: verb define
pts=. ''
u=. 0
while. u<4 do.
  v=. 0
  while. v<4 do.
    pts=. pts,2*u-1.5
    pts=. pts,2*v-1.5
    if. ((+./u=1 2) *. +./v=1 2) do.
      pts=. pts,3
    else.
      pts=. pts,_3
    end.
    v=. >:v
  end.
  u=. >:u
end.
pts
)

knots=: 0 0 0 0 1 1 1 1

a_close=: 3 : 0
wd 'pclose'
)

a_cancel=: a_close
a_run''
