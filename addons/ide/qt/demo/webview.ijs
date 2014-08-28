NB. webview
NB.
NB. !!! this is experimental and *will* change...
NB.
NB. cover for the QWebView
NB. cmd so far:
NB.  set c url
NB.  setp c baseurl url
NB.  setp c html text

NB. =========================================================
webview=: 3 : 0
wd 'pc webview'
wd 'cc w1 webview'
wd 'set w1 *http://www.yahoo.com'
wd 'cc w2 webview'
wd 'setp w2 baseurl *http://www.jsoftware.com'
wd 'setp w2 html *<html><body><img src=''./zippy.gif'' /></body></html>'
wd 'pmovex 100 10 600 250'
wd 'pshow'
)

NB. =========================================================
webview_close=: 3 : 0
wd 'pclose'
)

NB. =========================================================
showevents_jqtide_ 2
webview''
