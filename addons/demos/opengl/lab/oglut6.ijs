NB. addons/demos/opengl/lab/oglut6.ijs

cocurrent 'plab'
require 'gl2 opengl'
coinsert 'jgtk jzopenglutil'

NB. =========================================================
gtkwidget_event=: 4 : 0
assert. 0<#y
evt=. >@{.y
syshandler=. 'openglut_handler'
sysevent=. 'openglut_g_', evt
sysdefault=. 'openglut_default'
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

openglut_run=: 3 : 0
if. 0~:window_base_ do.
  gtk_window_present_with_time window,GDK_CURRENT_TIME
  gtk_widget_grab_focus canvas
  gtk_widget_queue_draw canvas
else.
  window_base_=: window=: gtk_window_new GTK_WINDOW_TOPLEVEL
  gtk_window_set_title window;'openglut'
  canvas=: iOPENGL_jglcanvas_ glcanvas_jgl2_ 400 300;coname''
  gtk_container_add window, canvas
  consig window;'destroy';'window_destroy'
  gtk_widget_show_all window
  wdmove window,_1 0   NB.! win32 requires wdmove after show
end.
)

window_destroy=: 3 : 0
'widget data'=. y
openglut_close''
0
)

openglut_close=: 3 : 0
gtk_widget_destroy ::0: window
window_base_=: 0
cbfree''
)

NB. =========================================================
DAT=: 1.25 * gsfit11 gsmakexyz (];];sin@*/~) steps _2 2 40

paint=: 3 : 0
gsinit GS_LIGHT
gsdrawsurface2 DAT
gsfini ''
)

openglut_g_paint=: paint
openglut_g_char=: gschar
openglut_default=: gsdefault

NB. =========================================================
gsetdefaults''
GS_COLOR=: PALEGREEN
GS_CLEARCOLOR=: SKYBLUE
GS_ROTXYZ=: _55 0 _25
openglut_run''
