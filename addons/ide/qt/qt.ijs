NB. J qtide

require 'project'

coclass 'jqtide'

Debugwd=: 0

cocurrent 'z'
wd=: 3 : 0"1
'r c p n b'=: wd1 ,&.>y;2;0;18!:5''
select. r
case. 0 do. 
 EMPTY
case. _1 do.
 memr p,0,n
case. _2 do.
 _2 [\ <;._2 memr p,0,n
case. do.
  (wd ::(''"_) 'qer') (13!:8) 3
end.
)

wd1=: ('"',libjqt,'" wd ', (IFWIN#'+ '),'i *c * *i *c') & cd
wdhandler=: 3 : 0
wdq=: wd 'q'
wd_val=. {:"1 wdq
({."1 wdq)=: wd_val
if. 3=4!:0<'wdhandler_debug' do.
  try. wdhandler_debug'' catch. end.
end.
wd_ndx=. 1 i.~ 3 = 4!:0 [ 3 {. wd_val
if. 3 > wd_ndx do.
  wd_fn=. > wd_ndx { wd_val
  if. 13!:17'' do.
    wd_fn~''
  else.
    try. wd_fn~''
    catch.
      wd_err=. 13!:12''
      if. 0=4!:0 <'ERM_j_' do.
        wd_erm=. ERM_j_
        ERM_j_=: ''
        if. wd_erm -: wd_err do. i.0 0 return. end.
      end.
      wd_err=. LF,,LF,.}.;._2 wd_err
      wdinfo 'wdhandler';'error in: ',wd_fn,wd_err
    end.
  end.
end.
i.0 0
)
wdclippaste=: (wd bind 'clippaste') :: (''"_)
wdqq=: (wd bind 'q') :: (''"_)
wdqchildxywh=: (0 ". [: wd 'qchildxywh ' , ]) :: (0 0 0 0"_)
wdqchildxywhx=: (0 ". [: wd 'qchildxywhx ' , ] ) :: (0 0 0 0"_)
wdqcolor=: (0 ". [: wd 'qcolor ' , ":) :: ( 0 0 0"_)
wdqd=: (wd bind 'qd') :: (''"_)
wdqer=: (wd bind 'qer') :: (''"_)
wdqformx=: (0 ". wd bind 'qformx') :: (0 0 800 600"_)
wdqhinst=: (0 ". wd bind 'qhinst') :: 0:
wdqhwndc=: (0 ". [: wd 'qhwndc ' , ]) :: 0:
wdqhwndp=: (0 ". wd bind 'qhwndp') :: 0:
wdqhwndx=: (0 ". wd bind 'qhwndx') :: 0:
wdqm=: (0 ". wd bind 'qm') :: (800 600 8 16 1 1 3 3 4 4 19 19 0 0 800 570"_)
wdqp=: (wd bind 'qp') :: (''"_)
wdqprinters=: (wd bind 'qprinters') :: (''"_)
wdqpx=: (wd bind 'qpx') :: (''"_)
wdqscreen=: (0 ". wd bind 'qscreen') :: (264 211 800 600 96 96 32 1 _1 36 36 51"_)
wdqwd=: (wd bind 'qwd') :: ('jqt'"_)
s=. '"',libjqt,'" dirmatch ', (IFWIN#'+ '),'> n *c *c'
dirmatch=: [: empty s cd [: ,each 2 {. boxopen

4!:55<'s'
IFJAVA=: 0
wde=: [:
wdbox=: [:
wdforms=: [:
wdmove=: [:
wdqshow=: [:
wdquery=: [:
wdreset=: [:
wdstatus=: [:
mbopen=: [:
mbsave=: [:
wdformedit=: [:

wdinfo=: smoutput @ >@{: @ boxopen
wdisparent=: ('"',libjqt,'" wdisparent >',(IFWIN#'+'),' i *c') cd <@,
wdishandle=: ('"',libjqt,'" wdisparent >',(IFWIN#'+'),' i *c') cd <@":
wdreadimg=: ('"',libjqt,'" wdreadimg >',(IFWIN#'+'),' x *c *i')&cd
wdgetimg=: ('"',libjqt,'" wdgetimg >',(IFWIN#'+'),' x *c i *i')&cd
wdwriteimg=: ('"',libjqt,'" wdwriteimg >',(IFWIN#'+'),' i *c *i *c *c i')&cd
wdputimg=: ('"',libjqt,'" wdputimg >',(IFWIN#'+'),' x *c *i *i *c i')&cd
wdquery=: 0:

wdgetparentid=: 3 : 0
z=. ''
if. r=. ('"',libjqt,'" wdgetparentid >',(IFWIN#'+'),' x x') cd y do. z=. memr r, 0 _1 2 end.
z
)

wdfit=: 0:
wdget=: 4 : 0
nms=. {."1 y
vls=. {:"1 y
if. L. x do. vls {~ nms i. ,&.>x
else. > vls {~ nms i. <,x
end.
)

wdpclose=: [: wd :: empty 'psel ' , ';pclose' ,~ ":
wdcenter=: 0:

wdclipwrite=: ('"',libjqt,'" wdclipwrite >',(IFWIN#'+'),' i *c') cd <@,
wdclipread=: 3 : 0
if. m=. ('"',libjqt,'" wdclipread >',(IFWIN#'+'),' x *i')&cd <l=. ,_1 do.
  z=. memr m, 0, l, 2
  ('"',libjqt,'" wdclipread >',(IFWIN#'+'),' x *i')&cd <<0
  z
else.
  ''
end.
)
coclass 'jqtide'

showevents=: 3 : 0
select. {. y,1
case. 0 do.
  4!:55 <'wdhandler_debug_z_'
case. 1 do.
  wdhandler_debug_z_=: 3 : 'smoutput sysevent'
case. 2 do.
  wdhandler_debug_z_=: 3 : 'smoutput wdq'
end.
EMPTY
)

s=. '"',libjqt,'" android_exec_host ', (IFWIN#'+ '),'> n *c *c *c'
android_exec_host=: [: empty s cd ]

4!:55<'s'
readimg=: 3 : 0
if. m=. wdreadimg (utf8 ,y);wh=. 2$2-2 do.
  d=. _2 ic memr m,0,(*/wh,4),2
  wdreadimg 2#<<0
  (|.wh)$d
else.
  0 0$2-2
end.
)
getimg=: 3 : 0
if. m=. wdgetimg y;(#y);wh=. 2$2-2 do.
  d=. _2 ic memr m,0,(*/wh,4),2
  wdreadimg 2#<<0
  (|.wh)$d
else.
  0 0$2-2
end.
)
writeimg=: 4 : 0
'h w'=. $x
d=. ,x
if. 2> #y=. boxopen y do.
  f=. >@{.y
  type=. }. (}.~ i:&'.') f
  opt=. ''
elseif. 2= #y do.
  f=. >@{.y
  type=. >1{y
  opt=. ''
elseif. do.
  f=. utf8 >@{.y
  type=. >1{y
  opt=. 2{.2}.y
  opt=. (":&.>1{opt) 1}opt
end.
if. 'jpg'-:type do. type=. 'jpeg'
elseif. 'tif'-:type do. type=. 'tiff'
end.
type=. toupper type
if. ''-:opt do. quality=. _1 else. quality=. <. {. 0&".opt end.
d=. fliprgb^:(-.RGBSEQ_j_) d
r=. wdwriteimg (2 ic d); (w,h); f; type; quality
EMPTY
)
putimg=: 4 : 0
'h w'=. $x
d=. ,x
if. 2> #y=. boxopen y do.
  type=. >@{.y
  opt=. ''
elseif. do.
  type=. >@{.y
  opt=. 2{.}.y
  opt=. (":&.>1{opt) 1}opt
end.
if. 'jpg'-:type do. type=. 'jpeg'
elseif. 'tif'-:type do. type=. 'tiff'
end.
type=. toupper type
if. ''-:opt do. quality=. _1 else. quality=. <. {. 0&".opt end.
d=. fliprgb^:(-.RGBSEQ_j_) d
m=. wdputimg (2 ic d); (w,h); (len=. ,_1); type; quality
if. m do.
  z=. memr m,0,len,2
  wdputimg (4#(<<0)),<0
  z
else.
  ''
end.
)

cocurrent 'base'
