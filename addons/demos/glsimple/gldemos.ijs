NB. gldemos.ijs

require 'gl3'
coinsert 'jgl3'

GLHANDLERS=: <;._2 (0 : 0)
a_actrl_fkey
a_button
a_g_char
a_g_mbldown
a_g_paint
a_g_size
a_help_button
a_run
)

GLTITLES=: 3 : 0 ''
j=. 1!:0 <jpath '~addons/demos/glsimple/*.ijs'
j=. tolower each ({.~i.&'.') each {."1 j
j=. j -. 'gldemos';'build';'test';'manifest';'bitmap';'font';'font3d'
/:~ j
)

GLDEMOS=: 0 : 0
pc gldemos closeok;
bin hv;
xywh 8 8 110 10;cc s0 static rightmove;
xywh 8 18 62 87;cc files listbox ws_border ws_vscroll rightmove bottommove;
bin zv;
xywh 79 21 40 12;cc run button leftmove rightmove;cn "&Run";
xywh 79 36 40 12;cc view button leftmove rightmove;cn "&View";
xywh 79 84 40 12;cc cancel button leftmove rightmove;cn "Cancel";
bin szz;
pas 4 2;pcenter;
rem form end;
)

gldemos_run=: 3 : 0
wd GLDEMOS
wd 'set s0 *Select Demo:'
wd 'set files ', ;GLTITLES ,&.> LF
wd 'setselect files 0'
wd 'setfocus files'
wd 'pshow'
)

gldemos_close=: wd bind 'pclose'
gldemos_cancel=: gldemos_cancel_button=: gldemos_close

gldemos_run_button=: 3 : 0
file=. >(".files_select){GLTITLES
4!:55 GLHANDLERS
wd :: [ 'psel a;pclose'
0!:0 <jpath '~addons/demos/glsimple/',file,'.ijs'
wd 'pn *',file
)

gldemos_files_button=: gldemos_run_button

gldemos_view_button=: 3 : 0
file=. >(".files_select){GLTITLES
wdview 1!:1 <jpath '~addons/demos/glsimple/',file,'.ijs'
)

gldemos_run''
