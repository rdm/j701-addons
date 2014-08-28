
NB. =========================================================
make_win=: 3 : 0
window=: gtk_window_new 0
gtk_window_set_title window;'view'
consig3 window;'delete-event';'window_delete'
consig3 window;'key-press-event';'window_key_press'
if. Resize do.
  consig3 window;'configure_event';'window_configure'
else.
  gtk_window_set_resizable window,0
end.
image=: gtk_image_new_from_file <File
gtk_container_add window,image
gtk_widget_show_all window
)

NB. =========================================================
window_configure=: 3 : 0
e=. 1{y
wh=. _2 ic memr e,(GdkEventConfigure_xywh+8),8
if. Twh-:wh do. 0 return. end.
if. Twh-:0 do.
  Pwh=: wh
  gtk_widget_set_size_request window,0 0
else.
  rescale wh
end.
Twh=: wh
0
)

NB. =========================================================
window_delete=: 3 : 0
make_timer 0
gtk_main_quit''
gtk_widget_destroy window
1
)

NB. =========================================================
window_key_press=: 3 : 0
'w e p'=. y
'state key'=. gtkeventkey e
if. key~:GDK_Escape do. 0 return. end.
if. +:/ 0 2 { 2 2 2 #: state do.
  window_delete''
end.
)
