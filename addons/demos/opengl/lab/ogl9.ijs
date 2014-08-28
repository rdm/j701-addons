NB. addons/demos/opengl/lab/ogl9.ijs

NB. =========================================================
gtkwidget_event=: 4 : 0
assert. 0<#y
evt=. >@{.y
syshandler=. 'gl3lab_handler'
sysevent=. 'gl3lab_g_', evt
sysdefault=. 'gl3lab_default'
if. 1=#y do.
wdd=. ;: 'syshandler sysevent sysdefault'
elseif. 2=#y do.
  sysdata=. ": >1{y
wdd=. ;: 'syshandler sysevent sysdefault sysdata'
elseif. 3=#y do.
  sysdata=. ": >1{y
  sysmodifiers=. ": >2{y
wdd=. ;: 'syshandler sysevent sysdefault sysdata sysmodifiers'
end.
wdqdata=. (wdd ,. ".&.>wdd)
evthandler wdqdata
0
)

gl3lab_run=: 3 : 0
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;'gl3lab'
canvas=: iOPENGL_jglcanvas_ glcanvas_jgl2_ 200 200;coname''
gtk_container_add window, canvas
consig window;'destroy';'window_destroy'
gtk_widget_show_all window
)

gl3lab_g_char =: 3 : 0
dorot 360 | R + 2 * 'xyz' = {.sysdata
gtk_widget_queue_draw canvas
)

R=: 0 0 0

dorot=: 3 : 0
R=: y
)

gl3lab_g_paint =: verb define
wh=. wh__ogl
glClearColor 0 0 1 0
glClear GL_COLOR_BUFFER_BIT
glOrtho 0 2 0 2 0 2   NB. view is a box, xyz coords of 0 to 2
glMatrixMode GL_MODELVIEW
drawtriangle ''
)

drawtriangle =: verb define
glTranslated 1 1 _1
glRotated R ,. 3 3 $ 1 0 0 0
glColor4d 1 0 0 0
glBegin GL_POLYGON
 glVertex 0.5 0.5 0.5                NB. add vertex
 glVertex  1 0 0 , 0 1 0 ,: _1 0 0   NB. triangle
glEnd ''
)
