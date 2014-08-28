require 'gl2 jzopengl'
coinsert 'jgtk jgl3'

a_run=: verb define
window1=: gtk_window_new GTK_WINDOW_TOPLEVEL
box1=. gtk_vbox_new 0 0
canvas=: iOPENGL_jglcanvas_ glcanvas_jgl2_ 300 300;coname''

NB. create a menu-bar to hold the menus
menu_bar=. gtk_menu_bar_new ''
NB. mac look-and-feel, moved to the top of desktop
if. UNAME-:'Darwin' do. ((>libigemac),' ige_mac_menu_set_menu_bar >n x')&cd ::0: menu_bar end.

NB. another root menu inside menu-bar for help menu item
gtk_menu_shell_append menu_bar, root_menu=. gtk_menu_item_new_with_mnemonic <(gettext '_Help')
gtk_menu_item_set_submenu root_menu, menu=. gtk_menu_new ''

NB. Create a new menu-item with a name (without the _ character) and set an image to it
menu_item_help=. gtk_image_menu_item_new_with_label <(gettext 'help')
gtk_image_menu_item_set_image menu_item_help, gtk_image_new_from_stock 'gtk-help'; GTK_ICON_SIZE_MENU
gtk_menu_shell_append menu, menu_item_help

gtk_container_add window1, box1
gtk_box_pack_start box1, menu_bar, 0 0 2
gtk_box_pack_start box1, canvas, 1 1 0    NB. take up remaining space

consig window1;'destroy';'a_close'

consig menu_item_help;'activate';'a_help_button'

R=: 20 30 0
EYE=: 0 0 1
LR=: UD=: IO=: 0
UP=: 0 1 0
gtk_widget_show_all window1
)

a_g_char=: verb define
R=: 360 | R + 2 * 'xyz' = {.sysdata
LR=: LR + 0.01*'l' = {.sysdata
LR=: LR - 0.01*'r' = {.sysdata
gtk_widget_queue_draw canvas
)

a_g_paint=: verb define
wh=. wh__ogl
glViewport 0 0,wh
glMatrixMode GL_PROJECTION
glLoadIdentity''
gluPerspective 30, (%/wh),1 10
glClear GL_COLOR_BUFFER_BIT + GL_DEPTH_BUFFER_BIT
glEnable GL_DEPTH_TEST
glMatrixMode GL_MODELVIEW
glLoadIdentity''
gluLookAt EYE,LR,UD,IO,UP
glTranslate 0 0 _8
glRotate R ,. 3 3 $ 1 0 0 0
drawbox''
glFlush''
0
)

BLUE=: 0 0 1
GREEN=: 0 1 0
RED=: 1 0 0

drawbox=: verb define
p=. _1 ^ #: i.8
BLUE polygon 0 1 3 2{p
GREEN polygon 0 1 5 4{p
RED polygon 0 2 6 4{p
(RED+BLUE) polygon 4 5 7 6{p
(RED+GREEN) polygon 1 3 7 5{p
(BLUE+GREEN) polygon 2 3 7 6{p
)

polygon=: 4 : 0
glColor 4{.x,1
glBegin GL_POLYGON
glVertex y
glEnd ''
)

a_help_button=: verb define
mbox 1;'OpenGL';'Press l r to move. Press x y z to rotate.'
gtk_widget_grab_focus canvas
)

a_close=: 3 : 0
window1=: 0
0
)

a_run''
