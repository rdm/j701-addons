NB. plotdata

MTH3=: _3 <\ 'JanFebMarAprMayJunJulAugSepOctNovDec'

d=. 0 : 0
74510  415.2
74513 417.75
74514    428
74515 420.65
74516  418.1
74517  422.8
74520  428.2
74521  424.5
74522    421
74523  415.5
74524  410.3
74527  407.1
74528  408.3
74529 411.25
74530    412
74531  411.4
74534  406.2
74535    404
74536  410.7
74537 410.15
74538  401.3
74541 401.85
74542 401.75
74543  399.6
74544  399.3
74545  396.4
74548  406.7
74549 408.35
74550  406.4
74551  411.4
74552  412.1
74555  410.7
74556  413.7
74557  415.9
74558  410.2
74559 408.25
74562 399.85
74563 401.45
74564  403.4
74565 395.05
74566 392.25
74569  398.5
74570  398.6
74571 390.35
74572 394.15
74573  393.5
74576  399.4
74577  401.2
74578  400.8
74579  397.4
74580 400.75
74583    399
74584  399.6
74585    402
74586 407.15
74587    411
74590  414.1
74591  415.2
74592  417.6
74593  416.6
74594  417.5
74597  420.9
74598 419.15
74599    423
74600  425.3
74601  426.1
74604 420.55
74605 416.95
74606 419.25
74607    422
74612 417.45
74613 405.75
74614    398
74615 399.75
74618  405.3
74619  398.8
74620 393.75
74621 391.35
74622 396.25
74625  396.5
74626 397.15
74627 396.75
74628 382.75
74629  387.3
74633 389.75
74634  394.3
74635    392
74636 386.85
74639  374.1
74640    378
74641 381.15
74642  375.5
74643  373.5
74646  380.8
74647    379
74648  380.2
74649 380.45
74650 382.25
74653 383.85
74654  387.6
74655  390.5
74656 391.45
74657 393.85
74661 395.85
74662 395.85
74663  391.4
74664  388.1
74667 393.45
74668 394.95
74669  389.3
74670 384.25
74671 384.55
74674  382.9
74675  382.3
74676 387.75
74677    386
74678  388.7
74681 393.85
74682  394.6
74683 395.25
74684 396.75
74685 401.15
74688  401.7
74689 396.75
74690 393.75
74691  394.5
74692  394.7
74695  398.4
74696  398.4
74697 397.35
74698  402.2
74699  406.6
74702 408.55
74703 404.25
74704  403.3
74705  403.9
74706  403.7
74709 406.95
74710  405.5
74711  401.1
74712    395
74713 392.85
74716 391.65
74717 392.25
74718  386.2
74719 388.75
74720  389.6
74723 393.25
74724  390.6
74725  392.7
74726  391.8
74727 392.25
74730  398.6
74731 399.05
74732 396.25
74733 396.25
74734 392.75
74737  399.3
74738 401.45
74739  403.2
74740  406.3
74741  405.8
74744 409.95
74745  406.9
74746  405.5
74747 405.95
74748 406.85
74752  408.1
74753    408
74754  407.8
74755  405.8
74758  401.6
74759  401.8
74760  398.1
74761 399.25
74762 400.65
74765 400.75
74766  403.5
74767  404.8
74768  404.4
74769  404.6
74772 404.15
74773 405.45
74774  407.5
74775 408.05
74776 409.45
74779    409
74780  410.3
74781 411.55
74782 412.35
74783 418.15
74786 416.85
74787 414.25
74788 417.95
74789  417.9
74790 418.05
74793 421.75
74794  418.2
74795 412.45
74796 414.65
74797  417.8
74800  418.5
74801 416.25
74802  421.7
74803  425.5
74804  422.4
74807    429
74808 427.15
74809 425.85
74810 423.85
74811  426.2
74814  428.1
74815  425.1
74816  422.2
74817  426.3
74818 428.75
74821 432.95
74822  432.3
74823  435.1
74824 433.35
74825  436.9
74828  439.5
74829 437.95
74830  444.5
74831  444.3
74832  443.7
74835    447
74836    447
74837 448.65
74838  451.7
74839 451.55
74842  450.4
74843    452
74844  451.1
74845 454.35
74846 449.15
74849 455.75
74850 453.75
74851 445.75
74852 437.35
74853  433.9
74856 436.95
74857  438.6
74858  437.8
74859 441.25
74860  439.2
74863 441.75
74864 441.85
74865  442.7
74866  442.4
74867  442.2
74872  443.5
74873 435.15
74874    438
)

GOLDFIX=: _2 [ \0 ". ' ' (I.d=LF) } d
