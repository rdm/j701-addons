NB. plotdemo.ijs   - plot demos
NB.
NB. uses locale jdplot

3 : 0''
if. -.IFJ6 do.
  require 'graphics/plot'
else.
  require 'dates files isigraph numeric graphics/plot'
end.
''
)

path=. jpath '~addons/graphics/plot/demo/'
files=. path&,@(,&'.ijs') each ;: 'plexam plotdwin pledit plview'
coclass 'jdplot'
coinsert 'jzplot';'jafm';'jgl2'
load files

plotdemo_run_jdplot_''
