require 'pack'

coclass 'jdebug'
coinsert 'jgtk'

3 : 0''
if. 0~:nc <'jdebug_jdebug_' do. jdebug=: 0 end.
if. 0~:nc <'jdbscut_jdebug_' do. jdbscut=: 0 end.
EMPTY
)
jdb_dlb=: }.~ =&' ' i. 0:
jdb_dtb=: #~ ([: +./\. ' '&~:)
jdb_isexplicit=: (<,':')"_ -: {.@>@(5!:1)@<
jdb_issparse=: 512&[ < 3!:0
jdb_splitind=: ('__'&E. i. 1:) ({. ; 2: }. }.) ]
jdb_takeafter=: [: ] (#@[ + E. i. 1:) }. ]
jdb_taketo=: [: ] (E. i. 1:) {. ]
jdb_tolist=: }.@;@:((10{a.)&,@,@":&.>)

jdb_boxopen=: boxopen f.
jdb_boxxopen=: boxxopen f.
jdb_empty=: empty f.
jdb_expand=: expand f.
jdb_datatype=: datatype f.
jdb_smoutput=: 0 0&$@(1!:2&2)
jdb_wd=: 0:
jdb_smselact=: 0:
jdb_smfocus=: 0:
jdb_smprompt=: 0:

jdb_wdqformx=: '0 0 0 0'"_
jdb_wdptop=: 0:
jdb_wdpactive=: 0:
jdb_dbs=: 13!:1
jdb_dbsq=: 13!:2
jdb_dbss=: 13!:3
jdb_dbsig=: 13!:8
jdb_dberm=: 13!:12
jdb_dbstk=: 13!:13
jdb_dbtrace=: 13!:16

jdb_imxq=: 9!:26
jdb_imxs=: 9!:27
jdb_imxsq=: 9!:28
jdb_imxss=: 9!:29
NAMECHRS=: '_',a.{~(,(i.10)+a.i.'0'),,(i.26) +/ a.i.'Aa'
jdb_getleftsepndx=: 0: i.~ e. & NAMECHRS
jdb_getrightsepndx=: 0: i.~ e. & (NAMECHRS,'.:')
jdb_codelines=: [: I. ('NB.'&-: @ (3&{.) +: [: *./ ' '&=)&>
jdb_cutopen=: 3 : 0
y jdb_cutopen~ (' ',LF) {~ LF e. ,y
:
if. L. y do. y return. end.
if. 1 < #$y do. <"_1 y return. end.
(<'') -.~ (y e.x) <;._2 y=. y,1{.x
)
jdb_edit=: 3 : 0
jdb_lxsoff''
jdb_stopread''
jdb_dbss''
if. _1 = s=. 4!:4 boxopen y do.
  jdb_info 'Unable to open definition of ',":>y
else.
  open s{4!:3 ''
end.
jdb_stopwrite''
jdb_lxson''
)
jdb_flatten=: 3 : 0
dat=. ": y
select. # $ dat
case. 1 do.
case. 2 do.
  }. , LF ,. dat
case. do.
  dat=. 1 1}. _1 _1}. ": < dat
  }: (,|."1 [ 1,.-. *./\"1 |."1 dat=' ')#,dat,.LF
end.
)
jdb_fullname=: 3 : 0
LOCALE jdb_fullname y
:
if. 2=#jdb_boxopen y do. y return. end.

x=. > x
y=. > y

if. '_' = {: y do.
  ndx=. (}:y) i: '_'
  j=. (ndx+1) }. }: y
  loc=. j, (0=#j) # 'base'
  (ndx {. y) ; loc
else.
  y ; x
end.
)
jdb_getcursorline=: 3 : 0
insert=. i. ITERSIZE
mark=. gtk_text_buffer_get_insert y
gtk_text_buffer_get_iter_at_mark y;insert;mark
bgn=. gtk_text_iter_get_offset <insert
linesbuf=. get_textview_text y
line=. +/ LF = bgn {. linesbuf
)
jdb_getcursoroffset=: 3 : 0
insert=. i. ITERSIZE
mark=. gtk_text_buffer_get_insert y
gtk_text_buffer_get_iter_at_mark y;insert;mark
bgn=. gtk_text_iter_get_offset <insert
)
jdb_getselect=: 3 : 0
insert=. i. ITERSIZE
mark=. gtk_text_buffer_get_insert y
gtk_text_buffer_get_iter_at_mark y;insert;mark
bgn=. gtk_text_iter_get_offset <insert
mark=. gtk_text_buffer_get_selection_bound y
gtk_text_buffer_get_iter_at_mark y;insert;mark
end=. gtk_text_iter_get_offset <insert
/:~bgn,end
)
jdb_setselect=: 4 : 0
'x0 x1'=. x
insert=. i. ITERSIZE
bound=. i. ITERSIZE
gtk_text_buffer_get_start_iter y;insert
gtk_text_iter_set_offset insert;x0
gtk_text_buffer_get_start_iter y;bound
gtk_text_iter_set_offset bound;x1
gtk_text_buffer_select_range y;insert;bound
)
jdb_getdefs=: (#~ _2: < 4!:0) @ ;:
jdb_getdefs=: 3 : 0
y=. ;: y
if. 1 e. msk=. (1: e. '__'&E.) &> y do.
  bal=. (-.msk) # y
  msk=. (_2 < 4!:0 bal) (I. -.msk)} msk
  msk # y
else.
  y #~ _2 < 4!:0 y
end.
)
jdb_getfontsize=: 13 : '{.1{._1 -.~ _1 ". y'
jdb_getlogpixelsy=: 3 : 0
96
)
jdb_getnameat=: 4 : 0

txt=. y
sel=. x

'px py'=. sel

rtx=. |. px{.txt
rnd=. jdb_getleftsepndx rtx
beg=. |. rnd {. rtx
bps=. px - rnd
mid=. (py-px) {. px }. txt
etx=. py }. txt

end=. jdb_getrightsepndx etx
bit=. beg, mid, end {. etx

if. 0=#bit-.' ' do.
  name=. ''
else.
  wds=. ;:bit
  len=. # &> }:wds
  ndx=. 0 i.~ (#beg) >: +/\ len
  name=. ndx >@{ wds
  off=. +/ ; ndx {. len
  fnd=. 1 i.~ name E. off }. bit
  sel=. bps+off+fnd
end.

name=. jdb_validname name

if. #name do.
  hit=. {.sel
  ndx=. hit + 0, #name
  ndx;name
else.
  '';''
end.
)
jdb_getnamesat=: 4 : 0
'bgn end'=. x
txt=. bgn }. end {. y
nms=. jdb_getdefs txt
nms=. nms -. MNUVXY
if. #nms do.
  bgn=. bgn + 2 + txt i. ']'
  (bgn,end) ; < nms
else.
  '';''
end.
)
jdb_getnoneheight=: 3 : 0
h=. 40
h + 20
)
jdb_getsmfont=: 3 : 0
if. 0 = 4!:0 <'SMFONT' do.
  SMFONT
else.
  FixFont_jgtkide_
end.
)
jdb_firsterr=: }.~ 0: i.~ 0: = [: > 1: {"1 ]
jdb_getstack=: jdb_firsterr f. @ (13!:13)
jdb_indices=: '['"_ , ": , '] '"_
jdb_indexit=: ([: jdb_indices &.> [: i. #) ,&.> ]
jdb_info=: 3 : 0
'a b'=. _2 {. jdb_boxopen y
if. 0 = #a do. a=. 'Debug' end.
if. 2=#$b=. ":b do. b=. }.,LF,.b end.
empty mbinfo a;b
)
jdb_listboxed=: }. @; @: (LF&, &.>)
jdb_listmatrix=: [: }. [: , LF&,.
jdb_lxsoff=: 13!:15 @ (''"_)
jdb_lxson=: 3 : 0
13!:15 'jdb_debug_jdebug_ coname$0'
if. 0 = 13!:17'' do. 13!:0 [ 1 end.
)
jdb_minsize=: 3 : 0
a=. 0 ". jdb_wdqformx''
jdb_wd 'pmovex ', ": a
)
jdb_pack=: [: /:~ [: (, ,&< ".) &> ;: ::]
jdb_nextline=: 3 : 0
if. 0 e. #CODELINES do. 0 return. end.
if. y=0 do.
  ((i.<./) |CODELINES - MOVELINE) { CODELINES
else.
  ndx=. CODELINES i. MOVELINE
  ndx=. 0 >. (_1 + #CODELINES) <. ndx + y
  ndx { CODELINES
end.
)
jdb_ppget=: 3 : 0
EMPTY
)
jdb_ppset=: 3 : 0
EMPTY
)
jdb_selstack=: 3 : 0
a=. 2 }. jdb_dbstk''
if. 0=#a do. return. end.
b=. ({."1 a) i. jdb_boxopen y
if. b=#a do. return. end.
b { a
)
jdb_shiver=: 3 : 0
EMPTY
)
jdb_shortname=: 3 : 0
if. '_' = {: y do.
  y {.~ (}:y) i: '_'
else.
  y
end.
)
jdb_validname=: 3 : 0
if. 0=#y do. '' return. end.
if. 1 e. b=. '__' E. }: y do.
  if. 1 ~: +/b do.
    '' return.
  else.
    ndx=. I. b
  end.
  if. _2 e. 4!:0 (ndx{.y);(ndx+2)}.y do.
    ''
  else.
    y
  end.
else.
  if. _2 = 4!:0 <y do.
    ''
  else.
    y
  end.
end.
)
get_textview_text=: 3 : 0
m1=. i.ITERSIZE [ m2=. i.ITERSIZE
gtk_text_buffer_get_start_iter y;m1
gtk_text_buffer_get_end_iter y;m2
txt=. memr 0 _1,~ g=. gtk_text_buffer_get_text y;m1;m2;1
g_free g
txt
)
clrback=. 5
clrtext=. 8
COLORS=: ": clrtext,clrback,clrback
ERM_j_=: ''

ERRORS=: '';(9!:8''),<'Unknown Error'
ERRORCODES=: (i.#ERRORS) -. 0 18

HWNDP=: 0
MINWIDTH=: 431
MINHEIGHT=: 300
NONEHEIGHT=: jdb_getnoneheight''

MNUV=: ;: 'm n u v m. n. u. v.'
MNUVXY=: ;: 'm n u v x y m. n. u. v. x. y.'
NVX=: ;: 'n v x n. v. x.'

PTOP=: 1

SMFONT=: jdb_getsmfont''
SMFONTSIZE=: jdb_getfontsize SMFONT

NULL=: $0

PPP=: 72 % jdb_getlogpixelsy ''
RPP=: PPP % SMFONTSIZE

STACKPOS=: 0

SMBOTH=: 0
STOPNONE=: '';0;0;NULL;NULL
SHOWWID=: 80
jdb_vSHOWWID=: SHOWWID"_

TYPES=: 'acv'

STOPNONE=: '';0;0;NULL;NULL
TYPES=: 'acv'
jdb_debuginit=: 3 : 0
STOPS=: i.0 5
STOPLAST=: ''
jdb_debugreset''
)
jdb_debugreset=: 3 : 0
CODELINES=: ''
CURRENTLINE=: 0
ERRMSG=: ''
ERRNUM=: 0
GDEFS=: ''
HWNDPX=: 0
LDEFS=: ''
LOCALE=: <'base'
LOCALNAMES=: ''
LOCALVALS=: ''
LXS=: ''
MOVELINE=: 0
NAME=: ''
NUMLINES=: 0
SCROLL=: 0
STACK=: i.0 8
SMNAMES=: i.0 2
SMLOCALE=: ''
SSTACKS=: ''
SSNAMES=: ''
STACKLOCALS=: ''
STATE=: 0
STOPLAST=: ''
WATCH=: ''
)
jdebug_browse=: 3 : 0
j=. STACKPOS + y
STACKPOS=: 0 >. j <. <: #STACK
jdb_lexwin1 ''
)
jdb_restore=: 3 : 0
jdb_ppset''
jdb_lxson ''
jdb_imxs 'jdb_imxhandler_jdebug_ 1'
jdb_imxss 1
)
jdb_imxhandler=: 3 : 0
if. 1 >: # 13!:13'' do. jdb_clear'' end.
empty''
)
jdb_inactive=: 3 : '0 e. #NAME'
jdb_selact=: jdb_smfocus @ jdb_smselact
jdb_clear=: 3 : 0
hx=. HWNDPX
jdb_debugreset''
if. 0~: jdebug do.
  jdb_wd 'psel jdebug'
  jdb_swap i_jdbnone
end.
if. hx do.
  jdb_wd :: jdb_selact 'psel ', ":hx
else.
  jdb_selact ''
end.
13!:0 [ 1
jdb_lxson''
)
jdb_close=: 3 : 0
r=. jdb_wd :: 0: 'psel ',": HWNDP
if. -. r -: 0 do.
  pos=. 0 ". jdb_wdqformx''
  if. TABCURRENT = i_jdbnone do.
    pos=. (3 {. pos), {: FORMX
  end.
  pos=. pos >. 0 0, MINWIDTH,MINHEIGHT
  pos wpsave_j_ :: ] 'jdebug'
  jdb_wd 'pclose'
end.
jdb_lxsoff ''
jdb_imxss 0
jdb_imxs ''
jdb_debuginit''
jdebug=: jdbscut=: 0
13!:0 [ 0
)
jdb_open=: 3 : 0
jdb_debuginit''
ERM_j_=: ''
if. #jdb_getstack'' do.
  jdb_debug ''
else.
  jdb_ppget 0
  jdebug_run 0
  jdb_restore''
end.
)
j=. 0 : 0
Enter             !single step over
F5~~~~~~~~        !run
Ctrl+Shift+F5     !run from next sentence
F6~~~~~~~~        !single step into
F7~~~~~~~~        !single step over
F8~~~~~~~~        !step out of current definition
F9~~~~~~~~        !toggle stop on cursor line
Ctrl+F9           !toggle stops on current definition
Ctrl+Shift+F9     !remove all stops
Ctrl+T            !toggle topmost attribute
Ctrl+W            !write current line to session
)

SHORTCUTS=: ' ' (I. j='~') } TAB (I. j='!')} j
jdbscut_run=: 3 : 0
jdb_info 'Debug Shortcuts';SHORTCUTS
)
jdb_f5_fkey=: jdebug_run_button
jdb_f5ctrlshift_fkey=: jdebug_runjdb_next
jdb_f6_fkey=: jdebug_stepinto_button
jdb_f7_fkey=: jdebug_stepover_button
jdb_f8_fkey=: jdebug_stepout_button
jdb_f9_fkey=: jdbmain_stopline_button
jdb_f9ctrlshift_fkey=: jdebug_clearstops
jdb_f12_fkey=: jdebug_browse @ 1:
jdb_f12shift_fkey=: jdebug_browse @ _1:

jdb_swapfkey=: 3 : 0
if. TABCURRENT = i_jdbmain do.
  jdebug_f5_fkey=: jdb_f5_fkey
  jdebug_f6_fkey=: jdb_f6_fkey
  jdebug_f7_fkey=: jdb_f7_fkey
  jdebug_f8_fkey=: jdb_f8_fkey
  jdebug_f9_fkey=: jdb_f9_fkey
  jdebug_f5ctrlshift_fkey=: jdb_f5ctrlshift_fkey
  jdebug_f9ctrlshift_fkey=: jdb_f9ctrlshift_fkey

  jdebug_f12_fkey=: jdb_f12_fkey
  jdebug_f12shift_fkey=: jdb_f12shift_fkey
else.
  jdebug_f5_fkey=: ]
  jdebug_f6_fkey=: ]
  jdebug_f7_fkey=: ]
  jdebug_f8_fkey=: ]
  jdebug_f9_fkey=: ]
  jdebug_f5ctrlshift_fkey=: ]
  jdebug_f9ctrlshift_fkey=: ]
end.
0
)
jdb_debug=: 3 : 0
jdb_lxsoff''

stack=. jdb_getstack''
if. 0 e. #stack do.
  jdb_lxson'' return.
end.
stack=. {. stack

jdb_ppget 0

if. #y do.
  LOCALE=: y
else.
  LOCALE=: <'base'
end.
ERM_j_=: jdb_dberm''
'NAME ERRNUM CURRENTLINE'=: 3 {. stack
MOVELINE=: CURRENTLINE
MOVELINES=: ,MOVELINE
ERRMSG=: (ERRNUM <. <:#ERRORS) >@{ ERRORS
jdb_lexwin ''
jdb_restore ''
)
jdb_lexwin=: 3 : 0
if. 0 e. #NAME do. '' return. end.

jdb_stopread''
STACK=: jdb_getstack''
jdb_lexwin1 ''
)
jdb_lexwin1=: 3 : 0

j=. (MOVELINE ; ERRMSG) jdb_stackrep STACK

if. 0 = L. j do. return. end.

'lines stack values'=. j

mrg=. '>' CURRENTLINE} NUMLINES # ' '

if. MOVELINE ~: CURRENTLINE do.
  mrg=. ('-+' {~ MOVELINE > CURRENTLINE) MOVELINE} mrg
end.

stp=. jdb_stopget''
lines=. (<"1 stp,.mrg) ,&.> lines
lines=. jdb_dtb &.> lines

jdebug_run 1

1 jdb_writelines lines
gtk_text_buffer_set_text stack_buffer; e; #e [ e=. jdb_listboxed stack
gtk_text_buffer_set_text value_buffer; e; #e [ e=. jdb_listboxed values
jdb_minsize''
jdb_wdpactive''

)
EX2=: '1234' ;&,&> ':'
EX0=: EX2 ,. < ,'0'
EX1=: EX2 ,. < ,'('
jdb_boxrep=: 4 : 0

'tac nmc'=. x
if. tac do.
  rep=. SUBTC (I.y=LF) } y
  nmc;2$<<rep return.
end.
hdr=. ;: LF jdb_taketo y
if. 1 e. , b=. EX0 E."1 hdr do.
  cls=. >: (+./"1 b) i. 1
  rep=. }. }: <;._2 y,LF
elseif. 1 e. , b=. EX1 E."1 hdr do.
  cls=. >: (+./"1 b) i. 1
  bgn=. 3 + 1 i.~ +./ b
  hdr=. bgn }. hdr
  hdr=. ; (hdr i. <,')') {. hdr
  try.
    rep=. ". hdr
  catch.
    rep=. hdr
  end.
elseif. 1 e. , b=. EX2 E."1 hdr do.
  cls=. >: (+./"1 b) i. 1
  ndx=. 2 + 1 i.~ +./ b
  try.
    rep=. ". ndx >@{ hdr
  catch.
    rep=. }. }: ndx >@{ hdr
  end.
elseif. do.
  cls=. _1
  rep=. y
end.
rep=. jdb_boxxopen rep
ind=. rep i. < ,':'
if. ind < #rep do.
  cls ; (ind {. rep) ; < (1+ind) }. rep
else.
  cls ; rep ; < rep
end.
)
j=. SHOWWID & {.
jdb_curtail=: ]`(j f.) @. (jdb_vSHOWWID < #)
j=. (SHOWWID-3) & {. , '...'"_
jdb_curtailed=: ]`(j f.) @. (jdb_vSHOWWID < #)
jdb_getdrep=: 3 : 0
'name loc'=. y

if. 0 e. $name do. '' return. end.

bloc=. <loc

if. 1 e. '__' E. }: name do.
  j=. jdb_splitind name
  if. 2 ~: #j do. '' return. end.
  'a b'=. j
  if. 0 ~: nc <b do. '' return. end.
  c=. (b,'_',loc,'_')~
  if. 1 ~: L. c do. '' return. end.
  18!:4 c
  nc=. 4!:0 :: _2: <a
  18!:4 <'jdebug'
  if. -. nc e. 1 2 3 do. '' return. end.
else.
  18!:4 bloc
  nc=. 4!:0 :: _2: <name
  18!:4 <'jdebug'
  if. -. nc e. 1 2 3 do. '' return. end.
end.

18!:4 bloc
def=. 5!:5 <name
18!:4 <'jdebug'

def
)
jdb_fixdef=: 4 : 0
type=. 'acvu' {~ 1 2 3 i. x
type,' ',jdb_subchars y
)
jdb_fixnoun=: 3 : 0

shape=. $y
len=. */shape

if. 0 = L. y do.
  y=. jdb_fixopen y

else.

  if. 1 = L. y do.
    if. 1 = len do.
      y=. '<',jdb_fixopen >{.y
    else.
      y=. jdb_curtail ,y
      ben=. */ @ $ S: 0 y
      if. 1000 < +/ ben do.
        y=. '{boxed}'
      else.
        y=. }. ; (',(<'&, @ (,&')')) &.> jdb_fixopen &.> y
      end.
    end.
  else.
    y=. '{boxed}'
  end.
  y=. (jdb_repshape shape), y

end.

r=. jdb_curtailed 'n ',jdb_subchars y

)
jdb_fixopen=: 3 : 0

shape=. $y
len=. */shape
rsh=. jdb_repshape shape

if. jdb_issparse y do.
  if. 1000 < len do.
    rsh, '{sparse}' return.
  else.
    t=. $. ^:_1 y
  end.
else.
  t=. y
end.

if. 0=#shape do.
  ":t
else.
  t=. jdb_curtail ,t
  jdb_curtailed rsh,jdb_quoteme t
end.
)
jdb_leaves=: ([: ; <@":@, S: 0) ^: (L. > 0:)
a=. ''''
jdb_quote=: (a&,@(,&a))@ (#~ >:@(=&a))
jdb_quoteme=: ":`jdb_quote @. (2&=@(3!:0))
jdb_repshape=: (0: < #) # ": , '$'"_
SUBTC=: 1{a.
jdb_subtc=: SUBTC & (I. @ (e.&(9 10 12 13{a.)) @] })
jdb_remzero=: -. & ({.a.)
jdb_subchars=: jdb_remzero @: jdb_subtc
jdb_viewname=: 4 : 0
max=. 50000
shape=. $y
scalar=. 0=#shape
type=. jdb_datatype y

dat=. jdb_flatten y
if. max < #dat do.
  dat=. (max {. dat),LF,'...'
end.

tag=. type
tag=. tag, scalar >@{ (' shape ',":shape);' scalar'

if. type -: 'boxed' do.
  tag=. tag, ' depth ',":L. y
end.

dat=. x,LF,LF,tag,LF,LF,dat

jdbview_run dat
)
TIDS=: ' ' ,. 'nacvd' ,. ' '
jdb_addlocale=: 4 : 0
if. ('_' ~: _1 {. y) > 1 e. '__' E. y do.
  if. '_' ~: _1 {. x do.
    t=. '_',(>x),'_'
  else.
    t=. x
  end.
  y,t
else.
  y
end.
)
jdb_showglobals=: 4 : 0
if. 0 e. $y do. '' return. end.

ind=. (1: e. '__'&E.) @: }: &> y
18!:4 x
nmc=. 4!:0 :: _2: "0 y
18!:4 <'jdebug'
nmc=. nmc - ind *. nmc=_1

msk=. nmc = 0
val=. msk # y
med=. nmc > 0
def=. med # y
GDEFS=: GDEFS, def

18!:4 x
if. #val do. val=. ". &.> val end.
if. #def do. def=. <@(5!:5) "0 def end.
18!:4 <'jdebug'

val=. jdb_fixnoun &.> val
def=. (med # nmc) jdb_fixdef &.> def

res=. (#msk) # <'{undefined}'
res=. (<'{unknown}') (I. nmc=_2)} res
res=. val (I. msk)} res
res=. def (I. med)} res
)
jdb_stackrep=: 3 : 0
'' jdb_stackrep y
:

if. 0 = #y do. y=. jdb_getstack'' end.
if. 0 = #y do. '' return. end.
LOCALVALS=: 7 {"1 y
y=. 7 {."1 y

STACKLOCALS=: {."1 &.> LOCALVALS
LOCALVALS=: {:"1 > {. LOCALVALS
LOCALNAMES=: > {. STACKLOCALS

'NAME ERRNUM CURRENTLINE'=: 3 {. {. y
if. 0 e. #NAME do. '' return. end.

LDEFS=. GDEFS=. ''
if. #x do.
  'linenum errmsg'=. x
else.
  linenum=. CURRENTLINE
  errmsg=. (ERRNUM <. <:#ERRORS) >@{ ERRORS
end.
nms=. 0{"1 y
lns=. linenum , }. ; 2{"1 y
nmc=. ; 3{"1 y
rps=. 4{"1 y
arglen=. # &> 6{"1 y
val=. (#nmc) # _1
if. 1 e. b=. nmc=3 do.
  val=. (<: b # arglen) (I. b)} val
end.
if. 1 e. b=. (nmc~:3) *. (1: e. MNUV&e.) &> STACKLOCALS do.
  sel=. (<'x')&e. &> b # STACKLOCALS
  val=. sel (I. b)} val
end.
nmc=. nmc + (nmc=3) *. val=1
tac=. 0 = # &> STACKLOCALS
brp=. (>: 0 >. val) >@{ &.> (<"1 tac,.nmc) jdb_boxrep &.> rps
bln=. # &> brp

if. 0=#brp do.
  jdb_info 'Unable to display Debug stack'
  '' return.
end.

if. 0={.bln do.
  jdb_info 'Unable to display top of stack'
  '' return.
end.

if. 0 e. bln do.
  brp=. (<'display not available') (I. bln)} brp
end.
'nam lnm typ'=. (<0;0 2 3) { y
dep=. 0 >@{ brp
LINES=: jdb_dtb &.> dep

dax=. jdb_indices &.> i.#dep
lines=. dax ,&.> dep

NUMLINES=: #lines
CODELINES=: jdb_codelines dep
VALENCE=: {. val
NMC=: {.nmc
lns=. lns <. bln
exl=. ;lns ({ ,& (<'{unknown}')) &.> brp
ind=. jdb_indices &.> lns
stack=. nms ,&.> ind ,&.> exl

st0=. errmsg
if. ERRNUM e. ERRORCODES do.
  erm=. <;._2 ERM_j_
  if. (3=#erm) *. linenum=CURRENTLINE do.
    st0=. st0,LF,NAME,'[',(":linenum),'] ',jdb_dlb }.1 >@{ erm
    stack=. }.stack
  end.
end.

stack=. st0 ; stack
wat=. jdb_cutopen WATCH
dfs=. jdb_getdefs 0 >@{ exl
dfs=. dfs -. MNUVXY
dfs=. ~. wat, ((MNUVXY e. LOCALNAMES)#MNUVXY), dfs
ndx=. LOCALNAMES i. dfs
msk=. ndx = #LOCALNAMES
lcs=. jdb_fixnoun &.> ((-.msk)#ndx) { LOCALVALS
glb=. LOCALE jdb_showglobals msk#dfs
vls=. (/:/:msk) { lcs,glb
values=. dfs ,&.> ' ' ,&.> vls
lines;stack;<values
)
a=. , ';'"_ -. {:
b=. i.&':' ({. ; }.@}.) ]
c=. i.&' ' ({. ; b @ }.@}.) ]
d=. c @ jdb_dlb
jdb_stopcut=: ([: d ;._2 a) f.
jdb_stopget=: 3 : 0
jdb_stopgetone NAME;'';VALENCE;NUMLINES;CODELINES
)
jdb_stopgetone=: 3 : 0
'name dummy valence numlines codelines'=. y
'astop ustop'=. jdb_stopson name;valence;codelines
astop=. (astop < numlines) # astop
ustop=. (ustop < numlines) # ustop
'*' ustop} '|' astop} numlines # ' '
)
jdb_stopread=: 3 : 0
sq=. 13!:2 ''
if. sq -: STOPLAST do. STOPS return. end.
if. 0 = #sq do.
  STOPS=: i.0 5
  return.
end.
stp=. /:~ jdb_stopcut sq
nms=. ~. {."1 stp
res=. nms ,"0 1 }. STOPNONE
for_i. 1 2 do.
  col=. i {"1 stp
  msk=. col = <,'*'
  if. 1 e. msk do.
    ndx=. ~. nms i. msk # nms
    res=. (<1) (<ndx;i) } res
  end.
  if. 0 e. msk do.
    mon=. 0 ". each (-.msk) # col
    bal=. (-.msk) # nms
    ndx=. nms i. ~.bal
    res=. (bal <@; /. mon) (<ndx;i+2) } res
  end.
end.
STOPS=: res
)
jdb_stoponall=: 4 : 0
nam=. {. jdb_boxxopen y
jdb_stopread ''
sel=. x
if. sel=2 do.
  sel=. -. (nam,1;1) e. 3 {."1 STOPS
end.
STOPS=: STOPS #~ nam ~: {."1 STOPS
if. sel do.
  STOPS=: STOPS, nam,1;1;'';''
end.
jdb_stopwrite ''
)
jdb_stopset=: 3 : '13!:3 STOPLAST=: y'
jdb_stopsetline=: 3 : 0
'' jdb_stopsetline y
:
x jdb_stopsetone NAME;VALENCE;y
jdb_stopwrite ''
)
jdb_stopsetone=: 3 : 0
'' jdb_stopsetone y
:
'name val line'=. y
if. (name;1;1) e. 3 {."1 STOPS do. return. end.

msk=. ({."1 STOPS) = <name
stp=. msk # STOPS
bal=. (-.msk) # STOPS
if. SMBOTH do. val=. 0 1 end.
if. 0 = #stp do.
  if. -. x -: 0 do.
    stp=. name;0;0;(0 1 e. val) {'';line
  end.
else.
  stp=. {. stp
  for_v. val do.
    'all sel'=. (val + 1 3) { stp
    select. x
    case. 0 do.
      if. all do.
        sel=. i.NUMLINES
        all=. 0
      end.
      sel=. sel -. line
    case. 1 do.
      if. -. all do.
        sel=. ~. line, sel
      end.
    case. do.
      if. line e. sel do.
        if. all do.
          sel=. i.NUMLINES
          all=. 0
        end.
        sel=. sel -. line
      else.
        sel=. line, sel
      end.
    end.
    stp=. (all;sel) (val + 1 3) } stp
  end.
end.

STOPS=: stp, bal
)
jdb_stopson=: 3 : 0
'name valence codelines'=. y
val=. 2 | valence
nms=. {."1 STOPS
x=. (nms i. <,name) { STOPS, STOPNONE
'all line'=. (val + 1 3) { x
as=. (1 e. all) # codelines
ls=. /:~ ~. line
as ; ls
)
jdb_stopwrite=: 3 : 0
if. 0 e. #STOPS do. jdb_stopset '' return. end.
STOPS=: (-. (}.STOPNONE) (-:}.)"1 STOPS) # STOPS
if. 0 e. #STOPS do. jdb_stopset '' return. end.
STOPS=: /:~ ~. STOPS
nms=. {."1 STOPS
mon=. ": each 3 {"1 STOPS
mon=. (<'*') (I. ;1 {"1 STOPS) } mon
dyd=. ": each 4 {"1 STOPS
dyd=. (<'*') (I. ;2 {"1 STOPS) } dyd
jdb_stopset ; (nms,.mon,.dyd) ,each "1 ' :;'
)
jdb_swap=: 3 : 0
'' jdb_swap y
:

jdb_lxsoff''

new=. y
old=. TABCURRENT

if. new = old do. return. end.

if. -. new e. TABLOADED do.
  ((new{::tabgroup),'_run')~ 0
  TABLOADED=: TABLOADED,new
end.

if. #old do.
  ((old{::tabgroup),'_dun')~ 0
end.

gtk_notebook_set_current_page notebook1, new

TABCURRENT=: new

((new{::tabgroup),'_ini')~ x

jdb_shiver''
jdb_tbenable''
jdb_swapfkey''
)
tabgroup=: ;:'jdbnone jdbmain jdbstop jdbwatch'
'i_jdbnone i_jdbmain i_jdbstop i_jdbwatch'=: i.4

makejdebug=: 3 : 0
window=. gtk_window_new GTK_WINDOW_TOPLEVEL
gtk_window_set_title window;(gettext 'Debug')
gtk_window_set_default_size window, 520 30
box1=. gtk_vbox_new 0 0
toolbar1=. gtk_toolbar_new ''
gtk_toolbar_set_icon_size toolbar1, GTK_ICON_SIZE_SMALL_TOOLBAR
gtk_toolbar_set_style toolbar1,GTK_TOOLBAR_ICONS
notebook1=: gtk_notebook_new ''
gtk_notebook_set_show_tabs notebook1, 0
jdbnone=: gtk_vbox_new 0 0
jdbmain=: gtk_vbox_new 0 0
jdbstop=: gtk_vbox_new 0 0
jdbwatch=: gtk_vbox_new 0 0
btnrun=: gtk_tool_button_new_from_stock <'gtk-media-play'
btnstepinto=: gtk_tool_button_new_from_stock <'gtk-go-down'
btnstepover=: gtk_tool_button_new_from_stock <'gtk-media-forward'
btnstepout=: gtk_tool_button_new_from_stock <'gtk-go-up'
btnruncursor=: gtk_tool_button_new_from_stock <'gtk-jump-to'
btncutback=: gtk_tool_button_new_from_stock <'gtk-goto-top'
btnback=: gtk_tool_button_new_from_stock <'gtk-go-back'
btnrefresh=: gtk_tool_button_new_from_stock <'gtk-refresh'
btnforward=: gtk_tool_button_new_from_stock <'gtk-go-forward'
btnstopname=: gtk_tool_button_new_from_stock <'gtk-media-pause'
btnstopwin=: gtk_tool_button_new_from_stock <'gtk-media-stop'
btnwatchwin=: gtk_tool_button_new_from_stock <'gtk-zoom-in'
btneditdef=: gtk_tool_button_new_from_stock <'gtk-open'
btnstack=: gtk_tool_button_new_from_stock <'gtk-properties'
btnclear=: gtk_tool_button_new_from_stock <'gtk-clear'
btnhelp=: gtk_tool_button_new_from_stock <'gtk-help'

gtk_widget_set_tooltip_text btnrun; gettext 'Run'
gtk_widget_set_tooltip_text btnstepinto; gettext 'Step into'
gtk_widget_set_tooltip_text btnstepover; gettext 'Step over'
gtk_widget_set_tooltip_text btnstepout; gettext 'Step out'
gtk_widget_set_tooltip_text btnruncursor; gettext 'Run to cursor'
gtk_widget_set_tooltip_text btncutback; gettext 'Cut back'
gtk_widget_set_tooltip_text btnback; gettext 'Back'
gtk_widget_set_tooltip_text btnrefresh; gettext 'Refresh'
gtk_widget_set_tooltip_text btnforward; gettext 'Forward'
gtk_widget_set_tooltip_text btnstopname; gettext 'Stop name at cursor'
gtk_widget_set_tooltip_text btnstopwin; gettext 'Stop Manager'
gtk_widget_set_tooltip_text btnwatchwin; gettext 'Watch Manager'
gtk_widget_set_tooltip_text btneditdef; gettext 'Edit definition'
gtk_widget_set_tooltip_text btnstack; gettext 'View stack'
gtk_widget_set_tooltip_text btnclear; gettext 'Clear'
gtk_widget_set_tooltip_text btnhelp; gettext 'Help'

gtk_container_add window, box1

gtk_box_pack_start box1, toolbar1, 0 0 0
gtk_box_pack_start box1, notebook1, 1 1 0
gtk_toolbar_insert toolbar1,  btnrun, _1
gtk_toolbar_insert toolbar1, _1,~ gtk_separator_tool_item_new ''
gtk_toolbar_insert toolbar1,  btnstepinto, _1
gtk_toolbar_insert toolbar1,  btnstepover, _1
gtk_toolbar_insert toolbar1,  btnstepout, _1
gtk_toolbar_insert toolbar1, _1,~ gtk_separator_tool_item_new ''
gtk_toolbar_insert toolbar1,  btnruncursor, _1
gtk_toolbar_insert toolbar1,  btncutback, _1
gtk_toolbar_insert toolbar1, _1,~ gtk_separator_tool_item_new ''
gtk_toolbar_insert toolbar1,  btnback, _1
gtk_toolbar_insert toolbar1,  btnrefresh, _1
gtk_toolbar_insert toolbar1,  btnforward, _1
gtk_toolbar_insert toolbar1, _1,~ gtk_separator_tool_item_new ''
gtk_toolbar_insert toolbar1,  btnstopname, _1
gtk_toolbar_insert toolbar1,  btnstopwin, _1
gtk_toolbar_insert toolbar1,  btnwatchwin, _1
gtk_toolbar_insert toolbar1,  btneditdef, _1
gtk_toolbar_insert toolbar1, _1,~ gtk_separator_tool_item_new ''
gtk_toolbar_insert toolbar1,  btnstack, _1
gtk_toolbar_insert toolbar1, _1,~ gtk_separator_tool_item_new ''
gtk_toolbar_insert toolbar1,  btnclear, _1
gtk_toolbar_insert toolbar1, _1,~ gtk_separator_tool_item_new ''
gtk_toolbar_insert toolbar1,  btnhelp, _1
gtk_notebook_append_page notebook1, jdbnone, 0
gtk_notebook_append_page notebook1, jdbmain, 0
gtk_notebook_append_page notebook1, jdbstop, 0
gtk_notebook_append_page notebook1, jdbwatch, 0
consig window;'destroy';'window_destroy'
consig3 window;'key-press-event';'window_key_press'

consig btnrun;'clicked';'jdebug_run_button'
consig btnstepinto;'clicked';'jdebug_stepinto_button'
consig btnstepover;'clicked';'jdebug_stepover_button'
consig btnstepout;'clicked';'jdebug_stepout_button'
consig btnruncursor;'clicked';'jdebug_runcursor_button'
consig btncutback;'clicked';'jdebug_cutback_button'
consig btnback;'clicked';'jdebug_back_button'
consig btnrefresh;'clicked';'jdebug_refresh_button'
consig btnforward;'clicked';'jdebug_forward_button'
consig btnstopname;'clicked';'jdebug_stopname_button'
consig btnstopwin;'clicked';'jdebug_stopwin_button'
consig btnwatchwin;'clicked';'jdebug_watchwin_button'
consig btneditdef;'clicked';'jdebug_editdef_button'
consig btnstack;'clicked';'jdebug_stack_button'
consig btnclear;'clicked';'jdebug_clear_button'
consig btnhelp;'clicked';'jdebug_help_button'

window
)
jdebug_run=: 3 : 0

name=. (y-:1) { i_jdbnone,i_jdbmain

if. 0~:jdebug do.
  
  jdb_wdpactive jdebug
  jdb_swap name

else.
  TABLOADED=: i.0
  TABCURRENT=: _1

  HWNDP=: jdebug=: makejdebug''

  gtk_widget_show_all jdebug
  jdb_wd 'setshow tabs 0'
  gtk_window_move jdebug, 0 0

  jdb_swap name
  FORMX=: jdb_wdqformx jdebug

end.

jdb_wdptop jdebug,PTOP
EMPTY
)
jdebug_clearstops=: 3 : 0
jdb_lxsoff''
jdb_dbss''
jdb_lexwin''
jdb_lxson''
)
jdebug_runnext=: 3 : 0
jdb_restore''
if. MOVELINE=CURRENTLINE do.
  13!:5 ''
else.
  13!:7 MOVELINE
end.
)
jdebug_hctrl_fkey=: 3 : 0
if. 0~: jdbscut do.
  jdb_wdpactive jdbscut
else.
  jdbscut_run''
end.
)
jdebug_wctrl_fkey=: 3 : 0
jdb_lxsoff''
jdb_smprompt '   ',jdb_dlb MOVELINE >@{ LINES
jdb_smfocus jdb_smselact ''
jdb_lxson''
)
jdebug_tctrl_fkey=: 3 : 0
jdb_lxsoff''
PTOP=: -. PTOP
jdb_wdptop jdebug,PTOP
jdb_lxson''
)
jdebug_tctrlshift_fkey=: jdb_stopsview

jdebug_enter=: ]
window_destroy=: 3 : 0
'widget data'=. y
jdb_close''
0
)
window_key_press=: 3 : 0
'widget event data'=. y
'state key'=. _2 ic memr event, GdkEventKey, 8 ,JCHAR
'shift lock control mod1 mod2 mod3 mod4 mod5 button1 button2 button3 button4 button5'=. 13{. state=. |.(32#2) #: GDK_MODIFIER_MASK (17 b.) state
'super hyper meta'=. 26 27 28{state
if. key = GDK_F1 + <:12 do.
  if. 0 0 0 -: control, shift, meta do.
    aboutbox''
    1 return.
  end.
end.
0
)
quit_activate=: 3 : 0
'widget data'=. y
0
)
syslastfocus=: ''
makejdbmain=: 3 : 0
lines=: gtk_text_view_new ''
lines_buffer=: gtk_text_view_get_buffer lines
stack=: gtk_text_view_new ''
stack_buffer=: gtk_text_view_get_buffer stack
value=: gtk_text_view_new ''
value_buffer=: gtk_text_view_get_buffer value

gtk_text_view_set_editable lines,0
gtk_text_view_set_editable stack,0
gtk_text_view_set_editable value,0
gtk_box_pack_start jdbmain, lines, 1 1 1
gtk_box_pack_start jdbmain, stack, 1 1 1
gtk_box_pack_start jdbmain, value, 1 1 1
consig3 lines;'focus-in-event';'jdbmain_lines_focus'
consig3 stack;'focus-in-event';'jdbmain_stack_focus'
consig3 value;'focus-in-event';'jdbmain_value_focus'

gtk_widget_show_all jdbmain
)
jdbmain_dun=: ]
jdbmain_ini=: ]
jdbmain_run=: 3 : 0
makejdbmain''
setfont lines;SMFONT
setfont stack;SMFONT
setfont value;SMFONT
)
jdbmain_editdef_button=: 3 : 0
jdb_lxsoff''


sf=. syslastfocus

if. sf -: 'lines' do.
  nam=. 1 >@{ (jdb_getselect lines_buffer) jdb_getnameat get_textview_text lines_buffer
elseif. sf -: 'stack' do.
  nam=. 1 >@{ (jdb_getselect stack_buffer) jdb_getnameat get_textview_text stack_buffer
elseif. sf -: 'value' do.
  nam=. 1 >@{ (jdb_getselect value_buffer) jdb_getnameat get_textview_text value_buffer
elseif. do.
  jdb_info 'No name selected' return.
end.

if. 0 e. #nam do.
  jdb_edit LOCALE jdb_addlocale NAME
else.
  if. (<nam) e. LOCALNAMES do.
    nam jdb_viewname > (LOCALNAMES i. <nam) { LOCALVALS
  else.
    nameloc=. LOCALE jdb_addlocale nam
    select. 4!:0 <nameloc
    case. 1;2;3 do.
      jdb_edit nameloc
    case. 0 do.
      nam jdb_viewname ".nameloc
    case. do.
      jdb_info 'Unable to view: ',nam
    end.
  end.
end.

jdb_lxson''
0
)
jdbmain_stopline_button=: 3 : 0
if. NUMLINES=1 do.
  jdbmain_stopall_button''
else.
  jdb_lxsoff''
  line=. jdb_getcursorline lines_buffer
  opt=. (line e. CODELINES) >@{ 0;''
  opt jdb_stopsetline line
  jdb_lxson''
end.
0
)

jdbmain_stopname_button=: 3 : 0
jdb_lxsoff''

'ndx name'=. jdbmain_getname''
if. #name do.
  1 jdb_stoponall name
  ndx jdb_setselect lines_buffer
end.
jdb_lxson''
0
)
jdbmain_stopwin_button=: 3 : 0
jdb_lxsoff''
'ndx name'=. jdbmain_getname''
smoutput ndx;name
name jdb_swap i_jdbstop
jdb_lxson''
0
)
jdbmain_lines_button=: [: 1: jdebug_stepover_button
jdbmain_stack_button=: [: 1: jdebug_stepover_button
jdbmain_value_button=: [: 1: jdebug_stepover_button
jdbmain_lines_focus=: 3 : '0 [ syslastfocus=: ''lines'''
jdbmain_stack_focus=: 3 : '0 [ syslastfocus=: ''stack'''
jdbmain_value_focus=: 3 : '0 [ syslastfocus=: ''value'''
jdbmain_getname=: 3 : 0
sel=. jdb_getselect lines_buffer
linesbuf=. get_textview_text lines_buffer

end=. I. LF=linesbuf,LF
bgn=. 0, 1+}:end
if. sel e. bgn ,. end do.
  'ndx name'=. sel jdb_getnamesat linesbuf
else.
  'ndx name'=. sel jdb_getnameat linesbuf
end.
)

jdb_writelines=: 4 : 0
len=. 0, +/\ 1 + # &> y
gtk_text_buffer_set_text lines_buffer; e; #e [ e=. jdb_listboxed y
jdb_wd 'setfocus lines'
if. x do.
  (0 _1 + (MOVELINE+0 1){len) jdb_setselect lines_buffer
end.
jdb_minsize''
)
jdbnone_dun=: ]
jdbnone_ini=: ]
jdbnone_run=: 3 : 0
EMPTY
)
jdbnone_stopwin_button=: 3 : 0
'' jdb_swap i_jdbstop
jdb_lxson''
0
)
makejdbstop=: 3 : 0
table=. gtk_table_new 2 2 1
box1=. gtk_hbox_new 0 0

slines=: gtk_text_view_new ''
slines_buffer=: gtk_text_view_get_buffer slines

gtk_text_view_set_editable slines,0

stopline=. gtk_button_new_with_label <gettext 'Stop Line'
stopall=. gtk_button_new_with_label <gettext 'Stop All'
close=. gtk_button_new_with_label <gettext 'Close'

s0=. gtk_label_new <gettext 'Name:'
s1=. gtk_label_new <gettext 'In:'

store=. gtk_list_store_new_1 1,G_TYPE_STRING
if. 3=GTKVER_j_ do.
  name=: gtk_combo_box_new_with_model_and_entry store
  gtk_combo_box_set_entry_text_column name,0
else.
  name=: gtk_combo_box_entry_new_with_model store,0
end.
g_object_unref store

store=. gtk_list_store_new_1 1,G_TYPE_STRING
if. 3=GTKVER_j_ do.
  locs=: gtk_combo_box_new_with_model_and_entry store
  gtk_combo_box_set_entry_text_column locs,0
else.
  locs=: gtk_combo_box_entry_new_with_model store,0
end.
g_object_unref store
gtk_box_pack_start box1, stopline, 0 0 0
gtk_box_pack_start box1, stopall, 0 0 0
gtk_box_pack_end box1, close, 0 0 0

gtk_table_attach table,s0,0 1 0 1, GTK_FILL, 0 0 0
gtk_table_attach table,s1,1 2 0 1, GTK_FILL, 0 0 0
gtk_table_attach table,name,0 1 1 2, (GTK_FILL+GTK_EXPAND), 0 0 0
gtk_table_attach table,locs,1 2 1 2, (GTK_FILL+GTK_EXPAND), 0 0 0

gtk_box_pack_start jdbstop, box1, 0 0 0
gtk_box_pack_start jdbstop, table, 0 0 0
gtk_box_pack_start jdbstop, slines, 1 1 0
consig stopline;'clicked';'jdbstop_stopline_button'
consig stopall;'clicked';'jdbstop_stopall_button'
consig close;'clicked';'jdbstop_close_button'

consig name;'changed';'jdbstop_name_select'
consig locs;'changed';'jdbstop_locs_select'

gtk_widget_show_all jdbstop
)

CX=: <'Current execution'
jdbstop_dun=: ]
jdbstop_ini=: 3 : 0

lc=. (18!:1[0), 18!:1[1
hd=. ;: 'base z'
lc=. hd, lc -. hd

if. jdb_inactive'' do.
  SMLOC=: <'base'
  SMLOCS=: SMLOC,lc -. SMLOC,<'jdebug'
  STNAMES=: i.0 2
  setcombo_text locs;<SMLOCS
  jdb_stoplocaleset SMLOC
else.
  SMLOC=: CX
  j=. SMLOC, ~. LOCALE, <'base'
  SMLOCS=: j, lc -. j
  setcombo_text locs;<SMLOCS
  nms=. {."1 STACK
  nms=. ~. (jdb_boxxopen y), nms
  r=. ([:{.(_2&{.@I.@('_'=])))&.>nms
  p=. ;('_'={:)&.>nms
  nms1=. (r+&.>(-.p)*&.>#&.>nms){.&.>nms
  SMNAMES=: nms1 ,. LOCALE(I. -.;p)} ([:}.(}:))&.>r}.&.> nms
  STNAMES=: SMNAMES
  0 jdb_stopswritedef SMNAMES
end.
gtk_combo_box_set_active locs,0

)
jdbstop_run=: 3 : 0
makejdbstop''
setfont slines;SMFONT
)
jdbstop_editdef_button=: 3 : 0
if. 0=#SMNAMES do. 0 return. end.
jdb_lxsoff''
'nam loc'=. jdbstop_getcurrentname''
jdb_edit loc jdb_addlocale nam
jdb_lxson''
0
)
jdbstop_stopall_button=: 3 : 0
jdb_lxsoff''
ndx=. gtk_combo_box_get_active name
nam=. {. ndx { SMNAMES
2 jdb_stoponall nam
jdb_stoprefresh jdb_getcursoroffset slines_buffer
jdb_lxson''
0
)
jdbstop_stopline_button=: 3 : 0
jdb_lxsoff''
if. -. LF e. slinesbuf=. get_textview_text slines_buffer do.
  jdbstop_stopall_button''
else.
  bgn=. jdb_getcursoroffset slines_buffer
  num=. +/ LF = bgn {. slinesbuf
  val=. num > {. SMCOUNT
  line=. num - val * 1 + {.SMCOUNT
  nam=. {. SMNDX { SMNAMES
  jdb_stopsetone nam,val;line
  jdb_stopwrite''
  jdb_stoprefresh bgn
end.
jdb_lxson''
0
)
jdbstop_stopname_button=: 3 : 0

jdb_lxsoff''
if. 0 e. $j=. jdbstop_getnameat'' do. jdb_lxson'' return. end.
'pos nam fullid'=. j

if. fullid -: jdbstop_getcurrentname'' do.
  jdbstop_stopall_button''
else.
  1 jdb_stoponall nam
  pos jdb_setselect slines_buffer
  if. SMLOC-:CX do.
    SMNAMES=: ~. SMNAMES, fullid
    setcombo_text name;< {."1 SMNAMES
  end.
end.
jdb_lxson''
0
)
jdbstop_stopwin_button=: 3 : 0
jdb_lxsoff''
if. 0 e. $j=. jdbstop_getnameat'' do. jdb_lxson'' return. end.

'pos nam fullid'=. j
if. fullid -: SMNDX { SMNAMES do. jdb_lxson'' return. end.

'rep both count'=. jdb_stoprep fullid
if. 0=#rep do.
  jdb_info 'No definition for name:',LF,LF,nam
  jdb_lxson'' return.
end.

if. fullid e. SMNAMES do.
  nms=. SMNAMES
  ndx=. SMNAMES i. fullid
else.
  nms=. ~. fullid, SMNAMES
  ndx=. 0
end.

jdb_stopswritedefone rep;both;count;ndx;<nms
jdb_lxson''
0
)
jdbstop_name_select=: 3 : 0
if. 0~:nc <'SMNDX' do. return. end.
if. 0=#SMNAMES do. return. end.
ndx=. gtk_combo_box_get_active name
if. _1=ndx do. return. end.
jdb_lxsoff''
if. ndx ~: SMNDX do.
  nam=. ndx { SMNAMES
  'rep both count'=. jdb_stoprep nam
  if. 0=#rep do.
    j=. 'Unable to get representation of:', LF, LF
    jdb_info j, 0 >@{ ndx { SMNAMES
    SMNAMES=: (<<<ndx) { SMNAMES
    SMNDX=: SMNDX - SMNDX > ndx
    setcombo_text name;< {."1 SMNAMES
    gtk_combo_box_set_active name,SMNDX
  else.
    gtk_text_buffer_set_text slines_buffer; e; #e [ e=. jdb_listboxed rep
    SMNDX=: ndx
    NMC=: 4!:0 nam
    SMBOTH=: both
    SMCOUNT=: count
  end.
end.
jdb_lxson''
)
jdbstop_locs_select=: 3 : 0
jdb_lxsoff''
ndx=. gtk_combo_box_get_active locs
jdb_stoplocaleset >ndx{SMLOCS
jdb_lxson''
)
jdbstop_getcurrentname=: 3 : 0
if. 0=#SMNAMES do. '';'' return. end.
ndx=. gtk_combo_box_get_active name
ndx { SMNAMES
)
jdbstop_getnameat=: 3 : 0

'pos names'=. (jdb_getselect slines_buffer) jdb_getnameat slinesbuf=. get_textview_text slines_buffer

if. 0 = #names do. '' return. end.
loc=. {: SMNDX { SMNAMES
fullid=. loc jdb_fullname names
pos;names;<fullid
)
jdb_stoplocaleset=: 3 : 0
bloc=. jdb_boxopen y
ndx=. SMLOCS i. bloc
idx=. 0

if. bloc -: CX do.
  idx jdb_stopswritedef STNAMES
else.
  18!:4 bloc
  ids=. 4!:1 [ 1 2 3
  18!:4 <'jdebug'
  idx jdb_stopswritedef ids ,. bloc
end.

gtk_combo_box_set_active locs, ndx
SMLOC=: bloc
)
jdb_stopname=: 3 : 0
if. 0 = #y do. 0 return. end.
setcombo_text locs;< ''
gtk_widget_set_sensitive locs,0
y=. jdb_fullname y
nms=. ~. y,SMNAMES,NAME;LOCALE
if. 0 jdb_stopswritedef nms do.
  STNAMES=: ~. y, SMNAMES
  1
else.
  0
end.
)
jdb_stoprefresh=: 3 : 0
'nam loc'=. jdbstop_getcurrentname''
'rep both count'=. jdb_stoprep nam;loc
srep=. jdb_listboxed rep
gtk_text_buffer_set_text slines_buffer; srep; #srep
if. #y do.
  sel=. 2 $ y
  sel jdb_setselect slines_buffer
end.
jdb_wd 'setfocus slines'
SMBOTH=: both
SMCOUNT=: count
)
jdb_stoprep=: 3 : 0

nam=. jdb_boxopen y
rep=. jdb_getdrep nam
lname=. ; nam ,each '_'
both=. 0

if. 0=#rep do. '';0;0 0 return. end.

tac=. -. jdb_isexplicit lname
cls=. 4!:0 <lname
'cls rep0 rep1'=. (tac,cls) jdb_boxrep rep

if. rep0 -: rep1 do.
  if. cls=4 do.
    rep0=. ''
  else.
    both=. 1
    rep1=. ''
  end.
end.

cod0=. jdb_codelines rep0
cod1=. jdb_codelines rep1
num0=. #rep0
num1=. #rep1

if. num0 do.
  stp0=. jdb_stopgetone nam,0;num0;cod0
  r=. stp0 ,&.> jdb_indexit rep0
else.
  r=. ''
end.

if. num1 do.
  stp1=. jdb_stopgetone nam,1;num1;cod1
  r=. r, <' [:] ',40#'-'
  r=. r, stp1 ,&.> jdb_indexit rep1
end.

r; both ; num0, num1

)
jdb_stopswritedef=: 4 : 0
if. 0 e. #y do.
  jdb_stopswritedefone ''
else.
  'rep both count'=. jdb_stoprep x { y
  jdb_stopswritedefone rep;both;count;x;<y
end.
)
jdb_stopswritedefone=: 3 : 0
if. 0 e. #y do.
  setcombo_text name;< ''
  gtk_text_buffer_set_text slines_buffer; ''; 0
  SMNAMES=: i.0 2
  SMNDX=: 0
  SMCOUNT=: 0 0
  0
else.
  'rep both count ndx nms'=. y
  setcombo_text name;< {."1 nms
  gtk_combo_box_set_active name,ndx
  gtk_text_buffer_set_text slines_buffer; e; #e [ e=. jdb_listboxed rep
  gtk_widget_set_sensitive name,1
  gtk_widget_set_sensitive slines,1
  SMNAMES=: nms
  SMNDX=: ndx
  SMBOTH=: both
  SMCOUNT=: count
  *#rep
end.
)

jdbstop_name_button=: [: 0: jdbstop_name_select
jdbstop_locs_button=: [: 0: jdbstop_locs_select
jdbstop_close_button=: [: 0: jdebug_mainwin
j=. 0 : 0
run       0 1 0 0
stepinto  0 1 0 0
stepover  0 1 0 0
stepout   0 1 0 0
runcursor 0 1 0 0
cutback   0 1 0 0
back      0 1 0 0
refresh   0 1 0 0
forward   0 1 0 0
stopname  0 1 1 0
stopwin   1 1 1 1
watchwin  1 1 1 0
editdef   0 1 1 0
stack     0 1 1 1
clear     0 1 1 1
help      1 1 1 1
)

f=. (1: + i.&' ') ({.;".@}.) ]
j=. f ;._2 j
tbnms=: {."1 j
tbvls=: >{:"1 j
jdb_tabcurrent=: 3 : '(i.#tabgroup) i. TABCURRENT'
jdb_tbenable=: 3 : 0
for_i. i.#tbnms do.
  gtk_widget_set_sensitive (".'btn',i{::tbnms),(jdb_tabcurrent''){i{tbvls
end.
)
jdebug_back_button=: 3 : 0
MOVELINE=: jdb_nextline _1
jdb_lexwin''
0
)
jdebug_clear_button=: [: 0: jdb_clear
jdebug_cutback_button=: 3 : 0
jdb_restore''
runimmex0_jgtkide_ '13!:19$0'
0
)
jdebug_forward_button=: 3 : 0
MOVELINE=: jdb_nextline 1
jdb_lexwin''
0
)
jdebug_help_button=: 3 : 0
jdb_lxsoff''
jdb_stopread''
jdb_dbss''
htmlhelp_j_ 'user/debugs.htm'
jdb_stopwrite''
jdb_lxson''
0
)
jdebug_stack_button=: 3 : 0
if. fexist jpath '~addons/ide/gtk/dbview.ijs' do.
  require '~addons/ide/gtk/dbview.ijs'
  jdbview_jdbview_ STACK
end.
0
)
jdebug_refresh_button=: 3 : 0
MOVELINE=: CURRENTLINE
jdb_lexwin''
0
)
jdebug_run_button=: 3 : 0
jdb_restore''
if. MOVELINE=CURRENTLINE do.
  runimmex0_jgtkide_ '13!:4$0'
else.
  runimmex0_jgtkide_ '13!:7 MOVELINE_jdebug_'
end.
0
)
jdebug_runcursor_button=: 3 : 0
line=. jdb_getcursorline lines_buffer
if. line <: CURRENTLINE do.
  jdb_info 'Line selected should be after current line' return.
elseif. line > >./ CODELINES do.
  jdb_info 'Cannot stop on selected line' return.
end.
jdb_restore''
names=. {."1 STACK
CUTNAMES=: LOCALE jdb_addlocale &.> names
CUTLINES=: ; 2 {"1 STACK
0 jdb_stopsetline CURRENTLINE + i. line - CURRENTLINE
1 jdb_stopsetline line
jdb_restore''
runimmex0_jgtkide_ '13!:4$0'
0
)
jdebug_stepout_button=: 3 : 0
jdb_restore''
if. MOVELINE=CURRENTLINE do.
  runimmex0_jgtkide_ '13!:22$0'
else.
  runimmex0_jgtkide_ 'MOVELINE_jdebug_ 13!:22$0'
end.
0
)
jdebug_stepover_button=: 3 : 0
jdb_restore''
if. MOVELINE=CURRENTLINE do.
  runimmex0_jgtkide_ '13!:20$0'
else.
  runimmex0_jgtkide_ 'MOVELINE_jdebug_ 13!:20$0'
end.
0
)
jdebug_stepinto_button=: 3 : 0
jdb_restore''
if. MOVELINE=CURRENTLINE do.
  runimmex0_jgtkide_ '13!:21$0'
else.
  runimmex0_jgtkide_ 'MOVELINE_jdebug_ 13!:21$0'
end.
0
)
jdebug_main=: 3 : 0
if. jdb_inactive'' do.
  jdb_swap i_jdbnone
else.
  jdb_swap i_jdbmain
  if. #jdb_getstack'' do.
    jdb_lexwin''
  end.
end.
jdb_lxson''
)
jdebug_watchwin_button=: 3 : 0
jdb_lxsoff''
jdb_swap i_jdbwatch
jdb_lxson''
0
)
jdebug_mainwin=: 3 : 0
if. jdb_inactive'' do.
  jdb_swap i_jdbnone
else.
  jdb_swap i_jdbmain
  if. #jdb_getstack'' do.
    jdb_lexwin''
  end.
end.
jdb_lxson''
)
jdebug_editdef_button=: 3 : '((TABCURRENT{::tabgroup),''_editdef_button'')~0'
jdebug_stopall_button=: 3 : '((TABCURRENT{::tabgroup),''_stopall_button'')~0'
jdebug_stopline_button=: 3 : '((TABCURRENT{::tabgroup),''_stopline_button'')~0'
jdebug_stopname_button=: 3 : '((TABCURRENT{::tabgroup),''_stopname_button'')~0'
jdebug_stopwin_button=: 3 : '((TABCURRENT{::tabgroup),''_stopwin_button'')~0'
JDBVIEW=: 0 : 0
pc jdbview closeok owner;pn "View";
xywh 0 0 235 150;cc e0 editm ws_vscroll es_readonly rightmove bottommove;
pas 0 0;pcenter;
rem form end;
)
VIEWFONT=: FIXFONT
jdbview_run=: 3 : 0
jdb_wd JDBVIEW
jdb_wd 'setfont e0 ',VIEWFONT
jdb_wd 'set e0 *',y
jdb_wd 'pshow'
)
jdbview_close=: 3 : 'jdb_wd ''pclose'''
jdbview_cancel=: jdbview_close
makejdbwatch=: 3 : 0
frame=. gtk_frame_new <gettext 'Enter Watch Names'
box1=. gtk_hbox_new 0 0
box2=. gtk_vbox_new 0 0

wlist=: gtk_text_view_new ''
wlist_buffer=: gtk_text_view_get_buffer wlist

clear=. gtk_button_new_with_label <gettext 'Clear'
close=. gtk_button_new_with_label <gettext 'Close'
gtk_container_add frame, box1
gtk_box_pack_start box1, wlist, 1 1 0
gtk_box_pack_start box1, box2, 0 0 0
gtk_box_pack_start box2, clear, 0 0 0
gtk_box_pack_start box2, close, 0 0 0
gtk_box_pack_start jdbwatch, frame, 1 1 0
consig clear;'clicked';'jdbwatch_clear_button'
consig close;'clicked';'jdbwatch_close_button'

gtk_widget_show_all jdbwatch
)
jdbwatch_dun=: 3 : 0
if. 0 ~: 4!:0 <'wlistbuf' do. return. end.

wlistbuf=: get_textview_text wlist_buffer
txt=. ' ' (I. wlistbuf=LF)} wlistbuf
nms=. jdb_cutopen txt
nmc=. (4!:0 :: _2:)"0 nms
if. _2 e. nmc do.
  bad=. nmc = _2
  t=. ;: ^:_1 bad # nms
  jdb_info 'Invalid watch name',((1<+/bad)#'s'),': ',t
  return.
end.
WATCH=: nms
)
jdbwatch_ini=: 3 : 0
txt=. jdb_tolist jdb_cutopen WATCH
gtk_text_buffer_set_text wlist_buffer; wlistbuf; #wlistbuf [ wlistbuf=: txt
jdb_wd 'setfocus wlist'
)

jdbwatch_run=: 3 : 0
makejdbwatch''
setfont wlist;SMFONT
)
jdbwatch_clear_button=: 3 : 0
gtk_text_buffer_set_text wlist_buffer; wlistbuf; #wlistbuf [ wlistbuf=: ''
jdb_lxson''
0
)
jdbwatch_stopwin_button=: 3 : 0
'' jdb_swap i_jdbstop
jdb_lxson''
0
)
jdbwatch_close_button=: 3 : 0
wlistbuf=: get_textview_text wlist_buffer
jdebug_mainwin''
0
)
