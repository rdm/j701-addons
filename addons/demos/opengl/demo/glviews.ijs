NB. Standalone version of opengl demo.
NB.
NB. This text can be cut and pasted into a single script.

require 'gl2 jzopengl'
cocurrent 'gldemo'
coinsert 'jgtk jgl3 jzopenglutil'

3 : 0''
if. -.IFGTK do. gtkinit_jgtk_'' end.
)

gsetdefaults''

NB. =========================================================
make_main_window=: 3 : 0
window=: gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;(gettext 'OpenGL')
box1=. gtk_vbox_new 0 0
canvas=: iOPENGL_jglcanvas_ glcanvas_jgl2_ 400 300;coname''

gtk_container_add window, box1
gtk_box_pack_start box1, canvas, 1 1 0    NB. take up remaining space

consig window;'destroy';'opengl_destroy'         NB. window destroyed
consig3 window;'key-press-event';'opengl_g_char'     NB. key down
)

NB. =========================================================
opengl_destroy=: 3 : 0
'widget data'=. y
gtk_widget_destroy^:(0~:]) gledit
if. -.IFGTK do. gtk_main_quit'' end.
cbfree''
0
)

NB. =========================================================
opengl_run=: 3 : 0
make_main_window''
gtk_widget_show_all window
if. -.IFGTK do. gtk_main'' end.
)

NB. =========================================================
gtkwidget_event=: 4 : 0
assert. 0<#y
evt=. >@{.y
syshandler=. 'opengl_handler'
sysevent=. 'opengl_g_', evt
sysdefault=. 'opengl_default'
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

NB. =========================================================
opengl_g_paint=: paint
opengl_g_char=: gschar

NB. =========================================================
opengl_run''
