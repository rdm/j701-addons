cocurrent 'jlapacke'

LAPACK_ROW_MAJOR=: 101
LAPACK_COL_MAJOR=: 102

LAPACK_WORK_MEMORY_ERROR=: _1010
LAPACK_TRANSPOSE_MEMORY_ERROR=: _1011

3 : 0''
if. 'Linux'-:UNAME do.
  liblapacke=: 'liblapacke.so.3'
elseif. 'Darwin'-:UNAME do.
  liblapacke=: 'liblapacke.dylib'
elseif. 'Win'-:UNAME do.
  liblapacke=: 'liblapacke.dll'
elseif. do.
  liblapacke=: ''
end.
)

LAPACKE_sbdsdc=: (liblapacke,' LAPACKE_sbdsdc >+ i i c c i *f *f *f i *f i *f *i')&cd
LAPACKE_dbdsdc=: (liblapacke,' LAPACKE_dbdsdc >+ i i c c i *d *d *d i *d i *d *i')&cd
LAPACKE_sbdsqr=: (liblapacke,' LAPACKE_sbdsqr >+ i i c i i i i *f *f *f i *f i *f i')&cd
LAPACKE_dbdsqr=: (liblapacke,' LAPACKE_dbdsqr >+ i i c i i i i *d *d *d i *d i *d i')&cd
LAPACKE_zbdsqr=: (liblapacke,' LAPACKE_zbdsqr >+ i i c i i i i *d *d *j i *j i *j i')&cd
LAPACKE_sdisna=: (liblapacke,' LAPACKE_sdisna >+ i c i i *f *f')&cd
LAPACKE_ddisna=: (liblapacke,' LAPACKE_ddisna >+ i c i i *d *d')&cd
LAPACKE_sgbbrd=: (liblapacke,' LAPACKE_sgbbrd >+ i i c i i i i i *f i *f *f *f i *f i *f i')&cd
LAPACKE_dgbbrd=: (liblapacke,' LAPACKE_dgbbrd >+ i i c i i i i i *d i *d *d *d i *d i *d i')&cd
LAPACKE_zgbbrd=: (liblapacke,' LAPACKE_zgbbrd >+ i i c i i i i i *j i *d *d *j i *j i *j i')&cd
LAPACKE_sgbcon=: (liblapacke,' LAPACKE_sgbcon >+ i i c i i i *f i *i f *f')&cd
LAPACKE_dgbcon=: (liblapacke,' LAPACKE_dgbcon >+ i i c i i i *d i *i d *d')&cd
LAPACKE_zgbcon=: (liblapacke,' LAPACKE_zgbcon >+ i i c i i i *j i *i d *d')&cd
LAPACKE_sgbequ=: (liblapacke,' LAPACKE_sgbequ >+ i i i i i i *f i *f *f *f *f *f')&cd
LAPACKE_dgbequ=: (liblapacke,' LAPACKE_dgbequ >+ i i i i i i *d i *d *d *d *d *d')&cd
LAPACKE_zgbequ=: (liblapacke,' LAPACKE_zgbequ >+ i i i i i i *j i *d *d *d *d *d')&cd
LAPACKE_sgbequb=: (liblapacke,' LAPACKE_sgbequb >+ i i i i i i *f i *f *f *f *f *f')&cd
LAPACKE_dgbequb=: (liblapacke,' LAPACKE_dgbequb >+ i i i i i i *d i *d *d *d *d *d')&cd
LAPACKE_zgbequb=: (liblapacke,' LAPACKE_zgbequb >+ i i i i i i *j i *d *d *d *d *d')&cd
LAPACKE_sgbrfs=: (liblapacke,' LAPACKE_sgbrfs >+ i i c i i i i *f i *f i *i *f i *f i *f *f')&cd
LAPACKE_dgbrfs=: (liblapacke,' LAPACKE_dgbrfs >+ i i c i i i i *d i *d i *i *d i *d i *d *d')&cd
LAPACKE_zgbrfs=: (liblapacke,' LAPACKE_zgbrfs >+ i i c i i i i *j i *j i *i *j i *j i *d *d')&cd
LAPACKE_sgbrfsx=: (liblapacke,' LAPACKE_sgbrfsx >+ i i c c i i i i *f i *f i *i *f *f *f i *f i *f *f i *f *f i *f')&cd
LAPACKE_dgbrfsx=: (liblapacke,' LAPACKE_dgbrfsx >+ i i c c i i i i *d i *d i *i *d *d *d i *d i *d *d i *d *d i *d')&cd
LAPACKE_zgbrfsx=: (liblapacke,' LAPACKE_zgbrfsx >+ i i c c i i i i *j i *j i *i *d *d *j i *j i *d *d i *d *d i *d')&cd
LAPACKE_sgbsv=: (liblapacke,' LAPACKE_sgbsv >+ i i i i i i *f i *i *f i')&cd
LAPACKE_dgbsv=: (liblapacke,' LAPACKE_dgbsv >+ i i i i i i *d i *i *d i')&cd
LAPACKE_zgbsv=: (liblapacke,' LAPACKE_zgbsv >+ i i i i i i *j i *i *j i')&cd
LAPACKE_sgbsvx=: (liblapacke,' LAPACKE_sgbsvx >+ i i c c i i i i *f i *f i *i *c *f *f *f i *f i *f *f *f *f')&cd
LAPACKE_dgbsvx=: (liblapacke,' LAPACKE_dgbsvx >+ i i c c i i i i *d i *d i *i *c *d *d *d i *d i *d *d *d *d')&cd
LAPACKE_zgbsvx=: (liblapacke,' LAPACKE_zgbsvx >+ i i c c i i i i *j i *j i *i *c *d *d *j i *j i *d *d *d *d')&cd
LAPACKE_sgbsvxx=: (liblapacke,' LAPACKE_sgbsvxx >+ i i c c i i i i *f i *f i *i *c *f *f *f i *f i *f *f *f i *f *f i *f')&cd
LAPACKE_dgbsvxx=: (liblapacke,' LAPACKE_dgbsvxx >+ i i c c i i i i *d i *d i *i *c *d *d *d i *d i *d *d *d i *d *d i *d')&cd
LAPACKE_zgbsvxx=: (liblapacke,' LAPACKE_zgbsvxx >+ i i c c i i i i *j i *j i *i *c *d *d *j i *j i *d *d *d i *d *d i *d')&cd
LAPACKE_sgbtrf=: (liblapacke,' LAPACKE_sgbtrf >+ i i i i i i *f i *i')&cd
LAPACKE_dgbtrf=: (liblapacke,' LAPACKE_dgbtrf >+ i i i i i i *d i *i')&cd
LAPACKE_zgbtrf=: (liblapacke,' LAPACKE_zgbtrf >+ i i i i i i *j i *i')&cd
LAPACKE_sgbtrs=: (liblapacke,' LAPACKE_sgbtrs >+ i i c i i i i *f i *i *f i')&cd
LAPACKE_dgbtrs=: (liblapacke,' LAPACKE_dgbtrs >+ i i c i i i i *d i *i *d i')&cd
LAPACKE_zgbtrs=: (liblapacke,' LAPACKE_zgbtrs >+ i i c i i i i *j i *i *j i')&cd
LAPACKE_sgebak=: (liblapacke,' LAPACKE_sgebak >+ i i c c i i i *f i *f i')&cd
LAPACKE_dgebak=: (liblapacke,' LAPACKE_dgebak >+ i i c c i i i *d i *d i')&cd
LAPACKE_zgebak=: (liblapacke,' LAPACKE_zgebak >+ i i c c i i i *d i *j i')&cd
LAPACKE_sgebal=: (liblapacke,' LAPACKE_sgebal >+ i i c i *f i *i *i *f')&cd
LAPACKE_dgebal=: (liblapacke,' LAPACKE_dgebal >+ i i c i *d i *i *i *d')&cd
LAPACKE_zgebal=: (liblapacke,' LAPACKE_zgebal >+ i i c i *j i *i *i *d')&cd
LAPACKE_sgebrd=: (liblapacke,' LAPACKE_sgebrd >+ i i i i *f i *f *f *f *f')&cd
LAPACKE_dgebrd=: (liblapacke,' LAPACKE_dgebrd >+ i i i i *d i *d *d *d *d')&cd
LAPACKE_zgebrd=: (liblapacke,' LAPACKE_zgebrd >+ i i i i *j i *d *d *j *j')&cd
LAPACKE_sgecon=: (liblapacke,' LAPACKE_sgecon >+ i i c i *f i f *f')&cd
LAPACKE_dgecon=: (liblapacke,' LAPACKE_dgecon >+ i i c i *d i d *d')&cd
LAPACKE_zgecon=: (liblapacke,' LAPACKE_zgecon >+ i i c i *j i d *d')&cd
LAPACKE_sgeequ=: (liblapacke,' LAPACKE_sgeequ >+ i i i i *f i *f *f *f *f *f')&cd
LAPACKE_dgeequ=: (liblapacke,' LAPACKE_dgeequ >+ i i i i *d i *d *d *d *d *d')&cd
LAPACKE_zgeequ=: (liblapacke,' LAPACKE_zgeequ >+ i i i i *j i *d *d *d *d *d')&cd
LAPACKE_sgeequb=: (liblapacke,' LAPACKE_sgeequb >+ i i i i *f i *f *f *f *f *f')&cd
LAPACKE_dgeequb=: (liblapacke,' LAPACKE_dgeequb >+ i i i i *d i *d *d *d *d *d')&cd
LAPACKE_zgeequb=: (liblapacke,' LAPACKE_zgeequb >+ i i i i *j i *d *d *d *d *d')&cd
LAPACKE_sgees=: (liblapacke,' LAPACKE_sgees >+ i i c c x i *f i *i *f *f *f i')&cd
LAPACKE_dgees=: (liblapacke,' LAPACKE_dgees >+ i i c c x i *d i *i *d *d *d i')&cd
LAPACKE_zgees=: (liblapacke,' LAPACKE_zgees >+ i i c c x i *j i *i *j *j i')&cd
LAPACKE_sgeesx=: (liblapacke,' LAPACKE_sgeesx >+ i i c c x c i *f i *i *f *f *f i *f *f')&cd
LAPACKE_dgeesx=: (liblapacke,' LAPACKE_dgeesx >+ i i c c x c i *d i *i *d *d *d i *d *d')&cd
LAPACKE_zgeesx=: (liblapacke,' LAPACKE_zgeesx >+ i i c c x c i *j i *i *j *j i *d *d')&cd
LAPACKE_sgeev=: (liblapacke,' LAPACKE_sgeev >+ i i c c i *f i *f *f *f i *f i')&cd
LAPACKE_dgeev=: (liblapacke,' LAPACKE_dgeev >+ i i c c i *d i *d *d *d i *d i')&cd
LAPACKE_zgeev=: (liblapacke,' LAPACKE_zgeev >+ i i c c i *j i *j *j i *j i')&cd
LAPACKE_sgeevx=: (liblapacke,' LAPACKE_sgeevx >+ i i c c c c i *f i *f *f *f i *f i *i *i *f *f *f *f')&cd
LAPACKE_dgeevx=: (liblapacke,' LAPACKE_dgeevx >+ i i c c c c i *d i *d *d *d i *d i *i *i *d *d *d *d')&cd
LAPACKE_zgeevx=: (liblapacke,' LAPACKE_zgeevx >+ i i c c c c i *j i *j *j i *j i *i *i *d *d *d *d')&cd
LAPACKE_sgehrd=: (liblapacke,' LAPACKE_sgehrd >+ i i i i i *f i *f')&cd
LAPACKE_dgehrd=: (liblapacke,' LAPACKE_dgehrd >+ i i i i i *d i *d')&cd
LAPACKE_zgehrd=: (liblapacke,' LAPACKE_zgehrd >+ i i i i i *j i *j')&cd
LAPACKE_sgejsv=: (liblapacke,' LAPACKE_sgejsv >+ i i c c c c c c i i *f i *f *f i *f i *f *i')&cd
LAPACKE_dgejsv=: (liblapacke,' LAPACKE_dgejsv >+ i i c c c c c c i i *d i *d *d i *d i *d *i')&cd
LAPACKE_sgelq2=: (liblapacke,' LAPACKE_sgelq2 >+ i i i i *f i *f')&cd
LAPACKE_dgelq2=: (liblapacke,' LAPACKE_dgelq2 >+ i i i i *d i *d')&cd
LAPACKE_zgelq2=: (liblapacke,' LAPACKE_zgelq2 >+ i i i i *j i *j')&cd
LAPACKE_sgelqf=: (liblapacke,' LAPACKE_sgelqf >+ i i i i *f i *f')&cd
LAPACKE_dgelqf=: (liblapacke,' LAPACKE_dgelqf >+ i i i i *d i *d')&cd
LAPACKE_zgelqf=: (liblapacke,' LAPACKE_zgelqf >+ i i i i *j i *j')&cd
LAPACKE_sgels=: (liblapacke,' LAPACKE_sgels >+ i i c i i i *f i *f i')&cd
LAPACKE_dgels=: (liblapacke,' LAPACKE_dgels >+ i i c i i i *d i *d i')&cd
LAPACKE_zgels=: (liblapacke,' LAPACKE_zgels >+ i i c i i i *j i *j i')&cd
LAPACKE_sgelsd=: (liblapacke,' LAPACKE_sgelsd >+ i i i i i *f i *f i *f f *i')&cd
LAPACKE_dgelsd=: (liblapacke,' LAPACKE_dgelsd >+ i i i i i *d i *d i *d d *i')&cd
LAPACKE_zgelsd=: (liblapacke,' LAPACKE_zgelsd >+ i i i i i *j i *j i *d d *i')&cd
LAPACKE_sgelss=: (liblapacke,' LAPACKE_sgelss >+ i i i i i *f i *f i *f f *i')&cd
LAPACKE_dgelss=: (liblapacke,' LAPACKE_dgelss >+ i i i i i *d i *d i *d d *i')&cd
LAPACKE_zgelss=: (liblapacke,' LAPACKE_zgelss >+ i i i i i *j i *j i *d d *i')&cd
LAPACKE_sgelsy=: (liblapacke,' LAPACKE_sgelsy >+ i i i i i *f i *f i *i f *i')&cd
LAPACKE_dgelsy=: (liblapacke,' LAPACKE_dgelsy >+ i i i i i *d i *d i *i d *i')&cd
LAPACKE_zgelsy=: (liblapacke,' LAPACKE_zgelsy >+ i i i i i *j i *j i *i d *i')&cd
LAPACKE_sgeqlf=: (liblapacke,' LAPACKE_sgeqlf >+ i i i i *f i *f')&cd
LAPACKE_dgeqlf=: (liblapacke,' LAPACKE_dgeqlf >+ i i i i *d i *d')&cd
LAPACKE_zgeqlf=: (liblapacke,' LAPACKE_zgeqlf >+ i i i i *j i *j')&cd
LAPACKE_sgeqp3=: (liblapacke,' LAPACKE_sgeqp3 >+ i i i i *f i *i *f')&cd
LAPACKE_dgeqp3=: (liblapacke,' LAPACKE_dgeqp3 >+ i i i i *d i *i *d')&cd
LAPACKE_zgeqp3=: (liblapacke,' LAPACKE_zgeqp3 >+ i i i i *j i *i *j')&cd
LAPACKE_sgeqpf=: (liblapacke,' LAPACKE_sgeqpf >+ i i i i *f i *i *f')&cd
LAPACKE_dgeqpf=: (liblapacke,' LAPACKE_dgeqpf >+ i i i i *d i *i *d')&cd
LAPACKE_zgeqpf=: (liblapacke,' LAPACKE_zgeqpf >+ i i i i *j i *i *j')&cd
LAPACKE_sgeqr2=: (liblapacke,' LAPACKE_sgeqr2 >+ i i i i *f i *f')&cd
LAPACKE_dgeqr2=: (liblapacke,' LAPACKE_dgeqr2 >+ i i i i *d i *d')&cd
LAPACKE_zgeqr2=: (liblapacke,' LAPACKE_zgeqr2 >+ i i i i *j i *j')&cd
LAPACKE_sgeqrf=: (liblapacke,' LAPACKE_sgeqrf >+ i i i i *f i *f')&cd
LAPACKE_dgeqrf=: (liblapacke,' LAPACKE_dgeqrf >+ i i i i *d i *d')&cd
LAPACKE_zgeqrf=: (liblapacke,' LAPACKE_zgeqrf >+ i i i i *j i *j')&cd
LAPACKE_sgeqrfp=: (liblapacke,' LAPACKE_sgeqrfp >+ i i i i *f i *f')&cd
LAPACKE_dgeqrfp=: (liblapacke,' LAPACKE_dgeqrfp >+ i i i i *d i *d')&cd
LAPACKE_zgeqrfp=: (liblapacke,' LAPACKE_zgeqrfp >+ i i i i *j i *j')&cd
LAPACKE_sgerfs=: (liblapacke,' LAPACKE_sgerfs >+ i i c i i *f i *f i *i *f i *f i *f *f')&cd
LAPACKE_dgerfs=: (liblapacke,' LAPACKE_dgerfs >+ i i c i i *d i *d i *i *d i *d i *d *d')&cd
LAPACKE_zgerfs=: (liblapacke,' LAPACKE_zgerfs >+ i i c i i *j i *j i *i *j i *j i *d *d')&cd
LAPACKE_sgerfsx=: (liblapacke,' LAPACKE_sgerfsx >+ i i c c i i *f i *f i *i *f *f *f i *f i *f *f i *f *f i *f')&cd
LAPACKE_dgerfsx=: (liblapacke,' LAPACKE_dgerfsx >+ i i c c i i *d i *d i *i *d *d *d i *d i *d *d i *d *d i *d')&cd
LAPACKE_zgerfsx=: (liblapacke,' LAPACKE_zgerfsx >+ i i c c i i *j i *j i *i *d *d *j i *j i *d *d i *d *d i *d')&cd
LAPACKE_sgerqf=: (liblapacke,' LAPACKE_sgerqf >+ i i i i *f i *f')&cd
LAPACKE_dgerqf=: (liblapacke,' LAPACKE_dgerqf >+ i i i i *d i *d')&cd
LAPACKE_zgerqf=: (liblapacke,' LAPACKE_zgerqf >+ i i i i *j i *j')&cd
LAPACKE_sgesdd=: (liblapacke,' LAPACKE_sgesdd >+ i i c i i *f i *f *f i *f i')&cd
LAPACKE_dgesdd=: (liblapacke,' LAPACKE_dgesdd >+ i i c i i *d i *d *d i *d i')&cd
LAPACKE_zgesdd=: (liblapacke,' LAPACKE_zgesdd >+ i i c i i *j i *d *j i *j i')&cd
LAPACKE_sgesv=: (liblapacke,' LAPACKE_sgesv >+ i i i i *f i *i *f i')&cd
LAPACKE_dgesv=: (liblapacke,' LAPACKE_dgesv >+ i i i i *d i *i *d i')&cd
LAPACKE_zgesv=: (liblapacke,' LAPACKE_zgesv >+ i i i i *j i *i *j i')&cd
LAPACKE_dsgesv=: (liblapacke,' LAPACKE_dsgesv >+ i i i i *d i *i *d i *d i *i')&cd
LAPACKE_zcgesv=: (liblapacke,' LAPACKE_zcgesv >+ i i i i *j i *i *j i *j i *i')&cd
LAPACKE_sgesvd=: (liblapacke,' LAPACKE_sgesvd >+ i i c c i i *f i *f *f i *f i *f')&cd
LAPACKE_dgesvd=: (liblapacke,' LAPACKE_dgesvd >+ i i c c i i *d i *d *d i *d i *d')&cd
LAPACKE_zgesvd=: (liblapacke,' LAPACKE_zgesvd >+ i i c c i i *j i *d *j i *j i *d')&cd
LAPACKE_sgesvj=: (liblapacke,' LAPACKE_sgesvj >+ i i c c c i i *f i *f i *f i *f')&cd
LAPACKE_dgesvj=: (liblapacke,' LAPACKE_dgesvj >+ i i c c c i i *d i *d i *d i *d')&cd
LAPACKE_sgesvx=: (liblapacke,' LAPACKE_sgesvx >+ i i c c i i *f i *f i *i *c *f *f *f i *f i *f *f *f *f')&cd
LAPACKE_dgesvx=: (liblapacke,' LAPACKE_dgesvx >+ i i c c i i *d i *d i *i *c *d *d *d i *d i *d *d *d *d')&cd
LAPACKE_zgesvx=: (liblapacke,' LAPACKE_zgesvx >+ i i c c i i *j i *j i *i *c *d *d *j i *j i *d *d *d *d')&cd
LAPACKE_sgesvxx=: (liblapacke,' LAPACKE_sgesvxx >+ i i c c i i *f i *f i *i *c *f *f *f i *f i *f *f *f i *f *f i *f')&cd
LAPACKE_dgesvxx=: (liblapacke,' LAPACKE_dgesvxx >+ i i c c i i *d i *d i *i *c *d *d *d i *d i *d *d *d i *d *d i *d')&cd
LAPACKE_zgesvxx=: (liblapacke,' LAPACKE_zgesvxx >+ i i c c i i *j i *j i *i *c *d *d *j i *j i *d *d *d i *d *d i *d')&cd
LAPACKE_sgetf2=: (liblapacke,' LAPACKE_sgetf2 >+ i i i i *f i *i')&cd
LAPACKE_dgetf2=: (liblapacke,' LAPACKE_dgetf2 >+ i i i i *d i *i')&cd
LAPACKE_zgetf2=: (liblapacke,' LAPACKE_zgetf2 >+ i i i i *j i *i')&cd
LAPACKE_sgetrf=: (liblapacke,' LAPACKE_sgetrf >+ i i i i *f i *i')&cd
LAPACKE_dgetrf=: (liblapacke,' LAPACKE_dgetrf >+ i i i i *d i *i')&cd
LAPACKE_zgetrf=: (liblapacke,' LAPACKE_zgetrf >+ i i i i *j i *i')&cd
LAPACKE_sgetri=: (liblapacke,' LAPACKE_sgetri >+ i i i *f i *i')&cd
LAPACKE_dgetri=: (liblapacke,' LAPACKE_dgetri >+ i i i *d i *i')&cd
LAPACKE_zgetri=: (liblapacke,' LAPACKE_zgetri >+ i i i *j i *i')&cd
LAPACKE_sgetrs=: (liblapacke,' LAPACKE_sgetrs >+ i i c i i *f i *i *f i')&cd
LAPACKE_dgetrs=: (liblapacke,' LAPACKE_dgetrs >+ i i c i i *d i *i *d i')&cd
LAPACKE_zgetrs=: (liblapacke,' LAPACKE_zgetrs >+ i i c i i *j i *i *j i')&cd
LAPACKE_sggbak=: (liblapacke,' LAPACKE_sggbak >+ i i c c i i i *f *f i *f i')&cd
LAPACKE_dggbak=: (liblapacke,' LAPACKE_dggbak >+ i i c c i i i *d *d i *d i')&cd
LAPACKE_zggbak=: (liblapacke,' LAPACKE_zggbak >+ i i c c i i i *d *d i *j i')&cd
LAPACKE_sggbal=: (liblapacke,' LAPACKE_sggbal >+ i i c i *f i *f i *i *i *f *f')&cd
LAPACKE_dggbal=: (liblapacke,' LAPACKE_dggbal >+ i i c i *d i *d i *i *i *d *d')&cd
LAPACKE_zggbal=: (liblapacke,' LAPACKE_zggbal >+ i i c i *j i *j i *i *i *d *d')&cd
LAPACKE_sgges=: (liblapacke,' LAPACKE_sgges >+ i i c c c x i *f i *f i *i *f *f *f *f i *f i')&cd
LAPACKE_dgges=: (liblapacke,' LAPACKE_dgges >+ i i c c c x i *d i *d i *i *d *d *d *d i *d i')&cd
LAPACKE_zgges=: (liblapacke,' LAPACKE_zgges >+ i i c c c x i *j i *j i *i *j *j *j i *j i')&cd
LAPACKE_sggesx=: (liblapacke,' LAPACKE_sggesx >+ i i c c c x c i *f i *f i *i *f *f *f *f i *f i *f *f')&cd
LAPACKE_dggesx=: (liblapacke,' LAPACKE_dggesx >+ i i c c c x c i *d i *d i *i *d *d *d *d i *d i *d *d')&cd
LAPACKE_zggesx=: (liblapacke,' LAPACKE_zggesx >+ i i c c c x c i *j i *j i *i *j *j *j i *j i *d *d')&cd
LAPACKE_sggev=: (liblapacke,' LAPACKE_sggev >+ i i c c i *f i *f i *f *f *f *f i *f i')&cd
LAPACKE_dggev=: (liblapacke,' LAPACKE_dggev >+ i i c c i *d i *d i *d *d *d *d i *d i')&cd
LAPACKE_zggev=: (liblapacke,' LAPACKE_zggev >+ i i c c i *j i *j i *j *j *j i *j i')&cd
LAPACKE_sggevx=: (liblapacke,' LAPACKE_sggevx >+ i i c c c c i *f i *f i *f *f *f *f i *f i *i *i *f *f *f *f *f *f')&cd
LAPACKE_dggevx=: (liblapacke,' LAPACKE_dggevx >+ i i c c c c i *d i *d i *d *d *d *d i *d i *i *i *d *d *d *d *d *d')&cd
LAPACKE_zggevx=: (liblapacke,' LAPACKE_zggevx >+ i i c c c c i *j i *j i *j *j *j i *j i *i *i *d *d *d *d *d *d')&cd
LAPACKE_sggglm=: (liblapacke,' LAPACKE_sggglm >+ i i i i i *f i *f i *f *f *f')&cd
LAPACKE_dggglm=: (liblapacke,' LAPACKE_dggglm >+ i i i i i *d i *d i *d *d *d')&cd
LAPACKE_zggglm=: (liblapacke,' LAPACKE_zggglm >+ i i i i i *j i *j i *j *j *j')&cd
LAPACKE_sgghrd=: (liblapacke,' LAPACKE_sgghrd >+ i i c c i i i *f i *f i *f i *f i')&cd
LAPACKE_dgghrd=: (liblapacke,' LAPACKE_dgghrd >+ i i c c i i i *d i *d i *d i *d i')&cd
LAPACKE_zgghrd=: (liblapacke,' LAPACKE_zgghrd >+ i i c c i i i *j i *j i *j i *j i')&cd
LAPACKE_sgglse=: (liblapacke,' LAPACKE_sgglse >+ i i i i i *f i *f i *f *f *f')&cd
LAPACKE_dgglse=: (liblapacke,' LAPACKE_dgglse >+ i i i i i *d i *d i *d *d *d')&cd
LAPACKE_zgglse=: (liblapacke,' LAPACKE_zgglse >+ i i i i i *j i *j i *j *j *j')&cd
LAPACKE_sggqrf=: (liblapacke,' LAPACKE_sggqrf >+ i i i i i *f i *f *f i *f')&cd
LAPACKE_dggqrf=: (liblapacke,' LAPACKE_dggqrf >+ i i i i i *d i *d *d i *d')&cd
LAPACKE_zggqrf=: (liblapacke,' LAPACKE_zggqrf >+ i i i i i *j i *j *j i *j')&cd
LAPACKE_sggrqf=: (liblapacke,' LAPACKE_sggrqf >+ i i i i i *f i *f *f i *f')&cd
LAPACKE_dggrqf=: (liblapacke,' LAPACKE_dggrqf >+ i i i i i *d i *d *d i *d')&cd
LAPACKE_zggrqf=: (liblapacke,' LAPACKE_zggrqf >+ i i i i i *j i *j *j i *j')&cd
LAPACKE_sggsvd=: (liblapacke,' LAPACKE_sggsvd >+ i i c c c i i i *i *i *f i *f i *f *f *f i *f i *f i *i')&cd
LAPACKE_dggsvd=: (liblapacke,' LAPACKE_dggsvd >+ i i c c c i i i *i *i *d i *d i *d *d *d i *d i *d i *i')&cd
LAPACKE_zggsvd=: (liblapacke,' LAPACKE_zggsvd >+ i i c c c i i i *i *i *j i *j i *d *d *j i *j i *j i *i')&cd
LAPACKE_sggsvp=: (liblapacke,' LAPACKE_sggsvp >+ i i c c c i i i *f i *f i f f *i *i *f i *f i *f i')&cd
LAPACKE_dggsvp=: (liblapacke,' LAPACKE_dggsvp >+ i i c c c i i i *d i *d i d d *i *i *d i *d i *d i')&cd
LAPACKE_zggsvp=: (liblapacke,' LAPACKE_zggsvp >+ i i c c c i i i *j i *j i d d *i *i *j i *j i *j i')&cd
LAPACKE_sgtcon=: (liblapacke,' LAPACKE_sgtcon >+ i c i *f *f *f *f *i f *f')&cd
LAPACKE_dgtcon=: (liblapacke,' LAPACKE_dgtcon >+ i c i *d *d *d *d *i d *d')&cd
LAPACKE_zgtcon=: (liblapacke,' LAPACKE_zgtcon >+ i c i *j *j *j *j *i d *d')&cd
LAPACKE_sgtrfs=: (liblapacke,' LAPACKE_sgtrfs >+ i i c i i *f *f *f *f *f *f *f *i *f i *f i *f *f')&cd
LAPACKE_dgtrfs=: (liblapacke,' LAPACKE_dgtrfs >+ i i c i i *d *d *d *d *d *d *d *i *d i *d i *d *d')&cd
LAPACKE_zgtrfs=: (liblapacke,' LAPACKE_zgtrfs >+ i i c i i *j *j *j *j *j *j *j *i *j i *j i *d *d')&cd
LAPACKE_sgtsv=: (liblapacke,' LAPACKE_sgtsv >+ i i i i *f *f *f *f i')&cd
LAPACKE_dgtsv=: (liblapacke,' LAPACKE_dgtsv >+ i i i i *d *d *d *d i')&cd
LAPACKE_zgtsv=: (liblapacke,' LAPACKE_zgtsv >+ i i i i *j *j *j *j i')&cd
LAPACKE_sgtsvx=: (liblapacke,' LAPACKE_sgtsvx >+ i i c c i i *f *f *f *f *f *f *f *i *f i *f i *f *f *f')&cd
LAPACKE_dgtsvx=: (liblapacke,' LAPACKE_dgtsvx >+ i i c c i i *d *d *d *d *d *d *d *i *d i *d i *d *d *d')&cd
LAPACKE_zgtsvx=: (liblapacke,' LAPACKE_zgtsvx >+ i i c c i i *j *j *j *j *j *j *j *i *j i *j i *d *d *d')&cd
LAPACKE_sgttrf=: (liblapacke,' LAPACKE_sgttrf >+ i i *f *f *f *f *i')&cd
LAPACKE_dgttrf=: (liblapacke,' LAPACKE_dgttrf >+ i i *d *d *d *d *i')&cd
LAPACKE_zgttrf=: (liblapacke,' LAPACKE_zgttrf >+ i i *j *j *j *j *i')&cd
LAPACKE_sgttrs=: (liblapacke,' LAPACKE_sgttrs >+ i i c i i *f *f *f *f *i *f i')&cd
LAPACKE_dgttrs=: (liblapacke,' LAPACKE_dgttrs >+ i i c i i *d *d *d *d *i *d i')&cd
LAPACKE_zgttrs=: (liblapacke,' LAPACKE_zgttrs >+ i i c i i *j *j *j *j *i *j i')&cd
LAPACKE_zhbev=: (liblapacke,' LAPACKE_zhbev >+ i i c c i i *j i *d *j i')&cd
LAPACKE_zhbevd=: (liblapacke,' LAPACKE_zhbevd >+ i i c c i i *j i *d *j i')&cd
LAPACKE_zhbevx=: (liblapacke,' LAPACKE_zhbevx >+ i i c c c i i *j i *j i d d i i d *i *d *j i *i')&cd
LAPACKE_zhbgst=: (liblapacke,' LAPACKE_zhbgst >+ i i c c i i i *j i *j i *j i')&cd
LAPACKE_zhbgv=: (liblapacke,' LAPACKE_zhbgv >+ i i c c i i i *j i *j i *d *j i')&cd
LAPACKE_zhbgvd=: (liblapacke,' LAPACKE_zhbgvd >+ i i c c i i i *j i *j i *d *j i')&cd
LAPACKE_zhbgvx=: (liblapacke,' LAPACKE_zhbgvx >+ i i c c c i i i *j i *j i *j i d d i i d *i *d *j i *i')&cd
LAPACKE_zhbtrd=: (liblapacke,' LAPACKE_zhbtrd >+ i i c c i i *j i *d *d *j i')&cd
LAPACKE_zhecon=: (liblapacke,' LAPACKE_zhecon >+ i i c i *j i *i d *d')&cd
LAPACKE_zheequb=: (liblapacke,' LAPACKE_zheequb >+ i i c i *j i *d *d *d')&cd
LAPACKE_zheev=: (liblapacke,' LAPACKE_zheev >+ i i c c i *j i *d')&cd
LAPACKE_zheevd=: (liblapacke,' LAPACKE_zheevd >+ i i c c i *j i *d')&cd
LAPACKE_zheevr=: (liblapacke,' LAPACKE_zheevr >+ i i c c c i *j i d d i i d *i *d *j i *i')&cd
LAPACKE_zheevx=: (liblapacke,' LAPACKE_zheevx >+ i i c c c i *j i d d i i d *i *d *j i *i')&cd
LAPACKE_zhegst=: (liblapacke,' LAPACKE_zhegst >+ i i i c i *j i *j i')&cd
LAPACKE_zhegv=: (liblapacke,' LAPACKE_zhegv >+ i i i c c i *j i *j i *d')&cd
LAPACKE_zhegvd=: (liblapacke,' LAPACKE_zhegvd >+ i i i c c i *j i *j i *d')&cd
LAPACKE_zhegvx=: (liblapacke,' LAPACKE_zhegvx >+ i i i c c c i *j i *j i d d i i d *i *d *j i *i')&cd
LAPACKE_zherfs=: (liblapacke,' LAPACKE_zherfs >+ i i c i i *j i *j i *i *j i *j i *d *d')&cd
LAPACKE_zherfsx=: (liblapacke,' LAPACKE_zherfsx >+ i i c c i i *j i *j i *i *d *j i *j i *d *d i *d *d i *d')&cd
LAPACKE_zhesv=: (liblapacke,' LAPACKE_zhesv >+ i i c i i *j i *i *j i')&cd
LAPACKE_zhesvx=: (liblapacke,' LAPACKE_zhesvx >+ i i c c i i *j i *j i *i *j i *j i *d *d *d')&cd
LAPACKE_zhesvxx=: (liblapacke,' LAPACKE_zhesvxx >+ i i c c i i *j i *j i *i *c *d *j i *j i *d *d *d i *d *d i *d')&cd
LAPACKE_zhetrd=: (liblapacke,' LAPACKE_zhetrd >+ i i c i *j i *d *d *j')&cd
LAPACKE_zhetrf=: (liblapacke,' LAPACKE_zhetrf >+ i i c i *j i *i')&cd
LAPACKE_zhetri=: (liblapacke,' LAPACKE_zhetri >+ i i c i *j i *i')&cd
LAPACKE_zhetrs=: (liblapacke,' LAPACKE_zhetrs >+ i i c i i *j i *i *j i')&cd
LAPACKE_zhfrk=: (liblapacke,' LAPACKE_zhfrk >+ i i c c c i i d *j i d *j')&cd
LAPACKE_shgeqz=: (liblapacke,' LAPACKE_shgeqz >+ i i c c c i i i *f i *f i *f *f *f *f i *f i')&cd
LAPACKE_dhgeqz=: (liblapacke,' LAPACKE_dhgeqz >+ i i c c c i i i *d i *d i *d *d *d *d i *d i')&cd
LAPACKE_zhgeqz=: (liblapacke,' LAPACKE_zhgeqz >+ i i c c c i i i *j i *j i *j *j *j i *j i')&cd
LAPACKE_zhpcon=: (liblapacke,' LAPACKE_zhpcon >+ i i c i *j *i d *d')&cd
LAPACKE_zhpev=: (liblapacke,' LAPACKE_zhpev >+ i i c c i *j *d *j i')&cd
LAPACKE_zhpevd=: (liblapacke,' LAPACKE_zhpevd >+ i i c c i *j *d *j i')&cd
LAPACKE_zhpevx=: (liblapacke,' LAPACKE_zhpevx >+ i i c c c i *j d d i i d *i *d *j i *i')&cd
LAPACKE_zhpgst=: (liblapacke,' LAPACKE_zhpgst >+ i i i c i *j *j')&cd
LAPACKE_zhpgv=: (liblapacke,' LAPACKE_zhpgv >+ i i i c c i *j *j *d *j i')&cd
LAPACKE_zhpgvd=: (liblapacke,' LAPACKE_zhpgvd >+ i i i c c i *j *j *d *j i')&cd
LAPACKE_zhpgvx=: (liblapacke,' LAPACKE_zhpgvx >+ i i i c c c i *j *j d d i i d *i *d *j i *i')&cd
LAPACKE_zhprfs=: (liblapacke,' LAPACKE_zhprfs >+ i i c i i *j *j *i *j i *j i *d *d')&cd
LAPACKE_zhpsv=: (liblapacke,' LAPACKE_zhpsv >+ i i c i i *j *i *j i')&cd
LAPACKE_zhpsvx=: (liblapacke,' LAPACKE_zhpsvx >+ i i c c i i *j *j *i *j i *j i *d *d *d')&cd
LAPACKE_zhptrd=: (liblapacke,' LAPACKE_zhptrd >+ i i c i *j *d *d *j')&cd
LAPACKE_zhptrf=: (liblapacke,' LAPACKE_zhptrf >+ i i c i *j *i')&cd
LAPACKE_zhptri=: (liblapacke,' LAPACKE_zhptri >+ i i c i *j *i')&cd
LAPACKE_zhptrs=: (liblapacke,' LAPACKE_zhptrs >+ i i c i i *j *i *j i')&cd
LAPACKE_shsein=: (liblapacke,' LAPACKE_shsein >+ i i c c c *i i *f i *f *f *f i *f i i *i *i *i')&cd
LAPACKE_dhsein=: (liblapacke,' LAPACKE_dhsein >+ i i c c c *i i *d i *d *d *d i *d i i *i *i *i')&cd
LAPACKE_zhsein=: (liblapacke,' LAPACKE_zhsein >+ i i c c c *i i *j i *j *j i *j i i *i *i *i')&cd
LAPACKE_shseqr=: (liblapacke,' LAPACKE_shseqr >+ i i c c i i i *f i *f *f *f i')&cd
LAPACKE_dhseqr=: (liblapacke,' LAPACKE_dhseqr >+ i i c c i i i *d i *d *d *d i')&cd
LAPACKE_zhseqr=: (liblapacke,' LAPACKE_zhseqr >+ i i c c i i i *j i *j *j i')&cd
LAPACKE_zlacgv=: (liblapacke,' LAPACKE_zlacgv >+ i i *j i')&cd
LAPACKE_slacpy=: (liblapacke,' LAPACKE_slacpy >+ i i c i i *f i *f i')&cd
LAPACKE_dlacpy=: (liblapacke,' LAPACKE_dlacpy >+ i i c i i *d i *d i')&cd
LAPACKE_zlacpy=: (liblapacke,' LAPACKE_zlacpy >+ i i c i i *j i *j i')&cd
LAPACKE_slag2d=: (liblapacke,' LAPACKE_slag2d >+ i i i i *f i *d i')&cd
LAPACKE_dlag2s=: (liblapacke,' LAPACKE_dlag2s >+ i i i i *d i *f i')&cd
LAPACKE_slagge=: (liblapacke,' LAPACKE_slagge >+ i i i i i i *f *f i *i')&cd
LAPACKE_dlagge=: (liblapacke,' LAPACKE_dlagge >+ i i i i i i *d *d i *i')&cd
LAPACKE_zlagge=: (liblapacke,' LAPACKE_zlagge >+ i i i i i i *d *j i *i')&cd
LAPACKE_slamch=: (liblapacke,' LAPACKE_slamch >+ f c')&cd
LAPACKE_dlamch=: (liblapacke,' LAPACKE_dlamch >+ d c')&cd
LAPACKE_slange=: (liblapacke,' LAPACKE_slange >+ f i c i i *f i')&cd
LAPACKE_dlange=: (liblapacke,' LAPACKE_dlange >+ d i c i i *d i')&cd
LAPACKE_zlange=: (liblapacke,' LAPACKE_zlange >+ d i c i i *j i')&cd
LAPACKE_zlanhe=: (liblapacke,' LAPACKE_zlanhe >+ d i c c i *j i')&cd
LAPACKE_slansy=: (liblapacke,' LAPACKE_slansy >+ f i c c i *f i')&cd
LAPACKE_dlansy=: (liblapacke,' LAPACKE_dlansy >+ d i c c i *d i')&cd
LAPACKE_zlansy=: (liblapacke,' LAPACKE_zlansy >+ d i c c i *j i')&cd
LAPACKE_slantr=: (liblapacke,' LAPACKE_slantr >+ f i c c c i i *f i')&cd
LAPACKE_dlantr=: (liblapacke,' LAPACKE_dlantr >+ d i c c c i i *d i')&cd
LAPACKE_zlantr=: (liblapacke,' LAPACKE_zlantr >+ d i c c c i i *j i')&cd
LAPACKE_slarfb=: (liblapacke,' LAPACKE_slarfb >+ i i c c c c i i i *f i *f i *f i')&cd
LAPACKE_dlarfb=: (liblapacke,' LAPACKE_dlarfb >+ i i c c c c i i i *d i *d i *d i')&cd
LAPACKE_zlarfb=: (liblapacke,' LAPACKE_zlarfb >+ i i c c c c i i i *j i *j i *j i')&cd
LAPACKE_slarfg=: (liblapacke,' LAPACKE_slarfg >+ i i *f *f i *f')&cd
LAPACKE_dlarfg=: (liblapacke,' LAPACKE_dlarfg >+ i i *d *d i *d')&cd
LAPACKE_zlarfg=: (liblapacke,' LAPACKE_zlarfg >+ i i *j *j i *j')&cd
LAPACKE_slarft=: (liblapacke,' LAPACKE_slarft >+ i i c c i i *f i *f *f i')&cd
LAPACKE_dlarft=: (liblapacke,' LAPACKE_dlarft >+ i i c c i i *d i *d *d i')&cd
LAPACKE_zlarft=: (liblapacke,' LAPACKE_zlarft >+ i i c c i i *j i *j *j i')&cd
LAPACKE_slarfx=: (liblapacke,' LAPACKE_slarfx >+ i i c i i *f f *f i *f')&cd
LAPACKE_dlarfx=: (liblapacke,' LAPACKE_dlarfx >+ i i c i i *d d *d i *d')&cd
LAPACKE_zlarfx=: (liblapacke,' LAPACKE_zlarfx >+ i i c i i *j j *j i *j')&cd
LAPACKE_slarnv=: (liblapacke,' LAPACKE_slarnv >+ i i *i i *f')&cd
LAPACKE_dlarnv=: (liblapacke,' LAPACKE_dlarnv >+ i i *i i *d')&cd
LAPACKE_zlarnv=: (liblapacke,' LAPACKE_zlarnv >+ i i *i i *j')&cd
LAPACKE_slaset=: (liblapacke,' LAPACKE_slaset >+ i i c i i f f *f i')&cd
LAPACKE_dlaset=: (liblapacke,' LAPACKE_dlaset >+ i i c i i d d *d i')&cd
LAPACKE_zlaset=: (liblapacke,' LAPACKE_zlaset >+ i i c i i j j *j i')&cd
LAPACKE_slasrt=: (liblapacke,' LAPACKE_slasrt >+ i c i *f')&cd
LAPACKE_dlasrt=: (liblapacke,' LAPACKE_dlasrt >+ i c i *d')&cd
LAPACKE_slaswp=: (liblapacke,' LAPACKE_slaswp >+ i i i *f i i i *i i')&cd
LAPACKE_dlaswp=: (liblapacke,' LAPACKE_dlaswp >+ i i i *d i i i *i i')&cd
LAPACKE_zlaswp=: (liblapacke,' LAPACKE_zlaswp >+ i i i *j i i i *i i')&cd
LAPACKE_slatms=: (liblapacke,' LAPACKE_slatms >+ i i i i c *i c *f i f f i i c *f i')&cd
LAPACKE_dlatms=: (liblapacke,' LAPACKE_dlatms >+ i i i i c *i c *d i d d i i c *d i')&cd
LAPACKE_zlatms=: (liblapacke,' LAPACKE_zlatms >+ i i i i c *i c *d i d d i i c *j i')&cd
LAPACKE_slauum=: (liblapacke,' LAPACKE_slauum >+ i i c i *f i')&cd
LAPACKE_dlauum=: (liblapacke,' LAPACKE_dlauum >+ i i c i *d i')&cd
LAPACKE_zlauum=: (liblapacke,' LAPACKE_zlauum >+ i i c i *j i')&cd
LAPACKE_sopgtr=: (liblapacke,' LAPACKE_sopgtr >+ i i c i *f *f *f i')&cd
LAPACKE_dopgtr=: (liblapacke,' LAPACKE_dopgtr >+ i i c i *d *d *d i')&cd
LAPACKE_sopmtr=: (liblapacke,' LAPACKE_sopmtr >+ i i c c c i i *f *f *f i')&cd
LAPACKE_dopmtr=: (liblapacke,' LAPACKE_dopmtr >+ i i c c c i i *d *d *d i')&cd
LAPACKE_sorgbr=: (liblapacke,' LAPACKE_sorgbr >+ i i c i i i *f i *f')&cd
LAPACKE_dorgbr=: (liblapacke,' LAPACKE_dorgbr >+ i i c i i i *d i *d')&cd
LAPACKE_sorghr=: (liblapacke,' LAPACKE_sorghr >+ i i i i i *f i *f')&cd
LAPACKE_dorghr=: (liblapacke,' LAPACKE_dorghr >+ i i i i i *d i *d')&cd
LAPACKE_sorglq=: (liblapacke,' LAPACKE_sorglq >+ i i i i i *f i *f')&cd
LAPACKE_dorglq=: (liblapacke,' LAPACKE_dorglq >+ i i i i i *d i *d')&cd
LAPACKE_sorgql=: (liblapacke,' LAPACKE_sorgql >+ i i i i i *f i *f')&cd
LAPACKE_dorgql=: (liblapacke,' LAPACKE_dorgql >+ i i i i i *d i *d')&cd
LAPACKE_sorgqr=: (liblapacke,' LAPACKE_sorgqr >+ i i i i i *f i *f')&cd
LAPACKE_dorgqr=: (liblapacke,' LAPACKE_dorgqr >+ i i i i i *d i *d')&cd
LAPACKE_sorgrq=: (liblapacke,' LAPACKE_sorgrq >+ i i i i i *f i *f')&cd
LAPACKE_dorgrq=: (liblapacke,' LAPACKE_dorgrq >+ i i i i i *d i *d')&cd
LAPACKE_sorgtr=: (liblapacke,' LAPACKE_sorgtr >+ i i c i *f i *f')&cd
LAPACKE_dorgtr=: (liblapacke,' LAPACKE_dorgtr >+ i i c i *d i *d')&cd
LAPACKE_sormbr=: (liblapacke,' LAPACKE_sormbr >+ i i c c c i i i *f i *f *f i')&cd
LAPACKE_dormbr=: (liblapacke,' LAPACKE_dormbr >+ i i c c c i i i *d i *d *d i')&cd
LAPACKE_sormhr=: (liblapacke,' LAPACKE_sormhr >+ i i c c i i i i *f i *f *f i')&cd
LAPACKE_dormhr=: (liblapacke,' LAPACKE_dormhr >+ i i c c i i i i *d i *d *d i')&cd
LAPACKE_sormlq=: (liblapacke,' LAPACKE_sormlq >+ i i c c i i i *f i *f *f i')&cd
LAPACKE_dormlq=: (liblapacke,' LAPACKE_dormlq >+ i i c c i i i *d i *d *d i')&cd
LAPACKE_sormql=: (liblapacke,' LAPACKE_sormql >+ i i c c i i i *f i *f *f i')&cd
LAPACKE_dormql=: (liblapacke,' LAPACKE_dormql >+ i i c c i i i *d i *d *d i')&cd
LAPACKE_sormqr=: (liblapacke,' LAPACKE_sormqr >+ i i c c i i i *f i *f *f i')&cd
LAPACKE_dormqr=: (liblapacke,' LAPACKE_dormqr >+ i i c c i i i *d i *d *d i')&cd
LAPACKE_sormrq=: (liblapacke,' LAPACKE_sormrq >+ i i c c i i i *f i *f *f i')&cd
LAPACKE_dormrq=: (liblapacke,' LAPACKE_dormrq >+ i i c c i i i *d i *d *d i')&cd
LAPACKE_sormrz=: (liblapacke,' LAPACKE_sormrz >+ i i c c i i i i *f i *f *f i')&cd
LAPACKE_dormrz=: (liblapacke,' LAPACKE_dormrz >+ i i c c i i i i *d i *d *d i')&cd
LAPACKE_sormtr=: (liblapacke,' LAPACKE_sormtr >+ i i c c c i i *f i *f *f i')&cd
LAPACKE_dormtr=: (liblapacke,' LAPACKE_dormtr >+ i i c c c i i *d i *d *d i')&cd
LAPACKE_spbcon=: (liblapacke,' LAPACKE_spbcon >+ i i c i i *f i f *f')&cd
LAPACKE_dpbcon=: (liblapacke,' LAPACKE_dpbcon >+ i i c i i *d i d *d')&cd
LAPACKE_zpbcon=: (liblapacke,' LAPACKE_zpbcon >+ i i c i i *j i d *d')&cd
LAPACKE_spbequ=: (liblapacke,' LAPACKE_spbequ >+ i i c i i *f i *f *f *f')&cd
LAPACKE_dpbequ=: (liblapacke,' LAPACKE_dpbequ >+ i i c i i *d i *d *d *d')&cd
LAPACKE_zpbequ=: (liblapacke,' LAPACKE_zpbequ >+ i i c i i *j i *d *d *d')&cd
LAPACKE_spbrfs=: (liblapacke,' LAPACKE_spbrfs >+ i i c i i i *f i *f i *f i *f i *f *f')&cd
LAPACKE_dpbrfs=: (liblapacke,' LAPACKE_dpbrfs >+ i i c i i i *d i *d i *d i *d i *d *d')&cd
LAPACKE_zpbrfs=: (liblapacke,' LAPACKE_zpbrfs >+ i i c i i i *j i *j i *j i *j i *d *d')&cd
LAPACKE_spbstf=: (liblapacke,' LAPACKE_spbstf >+ i i c i i *f i')&cd
LAPACKE_dpbstf=: (liblapacke,' LAPACKE_dpbstf >+ i i c i i *d i')&cd
LAPACKE_zpbstf=: (liblapacke,' LAPACKE_zpbstf >+ i i c i i *j i')&cd
LAPACKE_spbsv=: (liblapacke,' LAPACKE_spbsv >+ i i c i i i *f i *f i')&cd
LAPACKE_dpbsv=: (liblapacke,' LAPACKE_dpbsv >+ i i c i i i *d i *d i')&cd
LAPACKE_zpbsv=: (liblapacke,' LAPACKE_zpbsv >+ i i c i i i *j i *j i')&cd
LAPACKE_spbsvx=: (liblapacke,' LAPACKE_spbsvx >+ i i c c i i i *f i *f i *c *f *f i *f i *f *f *f')&cd
LAPACKE_dpbsvx=: (liblapacke,' LAPACKE_dpbsvx >+ i i c c i i i *d i *d i *c *d *d i *d i *d *d *d')&cd
LAPACKE_zpbsvx=: (liblapacke,' LAPACKE_zpbsvx >+ i i c c i i i *j i *j i *c *d *j i *j i *d *d *d')&cd
LAPACKE_spbtrf=: (liblapacke,' LAPACKE_spbtrf >+ i i c i i *f i')&cd
LAPACKE_dpbtrf=: (liblapacke,' LAPACKE_dpbtrf >+ i i c i i *d i')&cd
LAPACKE_zpbtrf=: (liblapacke,' LAPACKE_zpbtrf >+ i i c i i *j i')&cd
LAPACKE_spbtrs=: (liblapacke,' LAPACKE_spbtrs >+ i i c i i i *f i *f i')&cd
LAPACKE_dpbtrs=: (liblapacke,' LAPACKE_dpbtrs >+ i i c i i i *d i *d i')&cd
LAPACKE_zpbtrs=: (liblapacke,' LAPACKE_zpbtrs >+ i i c i i i *j i *j i')&cd
LAPACKE_spftrf=: (liblapacke,' LAPACKE_spftrf >+ i i c c i *f')&cd
LAPACKE_dpftrf=: (liblapacke,' LAPACKE_dpftrf >+ i i c c i *d')&cd
LAPACKE_zpftrf=: (liblapacke,' LAPACKE_zpftrf >+ i i c c i *j')&cd
LAPACKE_spftri=: (liblapacke,' LAPACKE_spftri >+ i i c c i *f')&cd
LAPACKE_dpftri=: (liblapacke,' LAPACKE_dpftri >+ i i c c i *d')&cd
LAPACKE_zpftri=: (liblapacke,' LAPACKE_zpftri >+ i i c c i *j')&cd
LAPACKE_spftrs=: (liblapacke,' LAPACKE_spftrs >+ i i c c i i *f *f i')&cd
LAPACKE_dpftrs=: (liblapacke,' LAPACKE_dpftrs >+ i i c c i i *d *d i')&cd
LAPACKE_zpftrs=: (liblapacke,' LAPACKE_zpftrs >+ i i c c i i *j *j i')&cd
LAPACKE_spocon=: (liblapacke,' LAPACKE_spocon >+ i i c i *f i f *f')&cd
LAPACKE_dpocon=: (liblapacke,' LAPACKE_dpocon >+ i i c i *d i d *d')&cd
LAPACKE_zpocon=: (liblapacke,' LAPACKE_zpocon >+ i i c i *j i d *d')&cd
LAPACKE_spoequ=: (liblapacke,' LAPACKE_spoequ >+ i i i *f i *f *f *f')&cd
LAPACKE_dpoequ=: (liblapacke,' LAPACKE_dpoequ >+ i i i *d i *d *d *d')&cd
LAPACKE_zpoequ=: (liblapacke,' LAPACKE_zpoequ >+ i i i *j i *d *d *d')&cd
LAPACKE_spoequb=: (liblapacke,' LAPACKE_spoequb >+ i i i *f i *f *f *f')&cd
LAPACKE_dpoequb=: (liblapacke,' LAPACKE_dpoequb >+ i i i *d i *d *d *d')&cd
LAPACKE_zpoequb=: (liblapacke,' LAPACKE_zpoequb >+ i i i *j i *d *d *d')&cd
LAPACKE_sporfs=: (liblapacke,' LAPACKE_sporfs >+ i i c i i *f i *f i *f i *f i *f *f')&cd
LAPACKE_dporfs=: (liblapacke,' LAPACKE_dporfs >+ i i c i i *d i *d i *d i *d i *d *d')&cd
LAPACKE_zporfs=: (liblapacke,' LAPACKE_zporfs >+ i i c i i *j i *j i *j i *j i *d *d')&cd
LAPACKE_sporfsx=: (liblapacke,' LAPACKE_sporfsx >+ i i c c i i *f i *f i *f *f i *f i *f *f i *f *f i *f')&cd
LAPACKE_dporfsx=: (liblapacke,' LAPACKE_dporfsx >+ i i c c i i *d i *d i *d *d i *d i *d *d i *d *d i *d')&cd
LAPACKE_zporfsx=: (liblapacke,' LAPACKE_zporfsx >+ i i c c i i *j i *j i *d *j i *j i *d *d i *d *d i *d')&cd
LAPACKE_sposv=: (liblapacke,' LAPACKE_sposv >+ i i c i i *f i *f i')&cd
LAPACKE_dposv=: (liblapacke,' LAPACKE_dposv >+ i i c i i *d i *d i')&cd
LAPACKE_zposv=: (liblapacke,' LAPACKE_zposv >+ i i c i i *j i *j i')&cd
LAPACKE_dsposv=: (liblapacke,' LAPACKE_dsposv >+ i i c i i *d i *d i *d i *i')&cd
LAPACKE_zcposv=: (liblapacke,' LAPACKE_zcposv >+ i i c i i *j i *j i *j i *i')&cd
LAPACKE_sposvx=: (liblapacke,' LAPACKE_sposvx >+ i i c c i i *f i *f i *c *f *f i *f i *f *f *f')&cd
LAPACKE_dposvx=: (liblapacke,' LAPACKE_dposvx >+ i i c c i i *d i *d i *c *d *d i *d i *d *d *d')&cd
LAPACKE_zposvx=: (liblapacke,' LAPACKE_zposvx >+ i i c c i i *j i *j i *c *d *j i *j i *d *d *d')&cd
LAPACKE_sposvxx=: (liblapacke,' LAPACKE_sposvxx >+ i i c c i i *f i *f i *c *f *f i *f i *f *f *f i *f *f i *f')&cd
LAPACKE_dposvxx=: (liblapacke,' LAPACKE_dposvxx >+ i i c c i i *d i *d i *c *d *d i *d i *d *d *d i *d *d i *d')&cd
LAPACKE_zposvxx=: (liblapacke,' LAPACKE_zposvxx >+ i i c c i i *j i *j i *c *d *j i *j i *d *d *d i *d *d i *d')&cd
LAPACKE_spotrf=: (liblapacke,' LAPACKE_spotrf >+ i i c i *f i')&cd
LAPACKE_dpotrf=: (liblapacke,' LAPACKE_dpotrf >+ i i c i *d i')&cd
LAPACKE_zpotrf=: (liblapacke,' LAPACKE_zpotrf >+ i i c i *j i')&cd
LAPACKE_spotri=: (liblapacke,' LAPACKE_spotri >+ i i c i *f i')&cd
LAPACKE_dpotri=: (liblapacke,' LAPACKE_dpotri >+ i i c i *d i')&cd
LAPACKE_zpotri=: (liblapacke,' LAPACKE_zpotri >+ i i c i *j i')&cd
LAPACKE_spotrs=: (liblapacke,' LAPACKE_spotrs >+ i i c i i *f i *f i')&cd
LAPACKE_dpotrs=: (liblapacke,' LAPACKE_dpotrs >+ i i c i i *d i *d i')&cd
LAPACKE_zpotrs=: (liblapacke,' LAPACKE_zpotrs >+ i i c i i *j i *j i')&cd
LAPACKE_sppcon=: (liblapacke,' LAPACKE_sppcon >+ i i c i *f f *f')&cd
LAPACKE_dppcon=: (liblapacke,' LAPACKE_dppcon >+ i i c i *d d *d')&cd
LAPACKE_zppcon=: (liblapacke,' LAPACKE_zppcon >+ i i c i *j d *d')&cd
LAPACKE_sppequ=: (liblapacke,' LAPACKE_sppequ >+ i i c i *f *f *f *f')&cd
LAPACKE_dppequ=: (liblapacke,' LAPACKE_dppequ >+ i i c i *d *d *d *d')&cd
LAPACKE_zppequ=: (liblapacke,' LAPACKE_zppequ >+ i i c i *j *d *d *d')&cd
LAPACKE_spprfs=: (liblapacke,' LAPACKE_spprfs >+ i i c i i *f *f *f i *f i *f *f')&cd
LAPACKE_dpprfs=: (liblapacke,' LAPACKE_dpprfs >+ i i c i i *d *d *d i *d i *d *d')&cd
LAPACKE_zpprfs=: (liblapacke,' LAPACKE_zpprfs >+ i i c i i *j *j *j i *j i *d *d')&cd
LAPACKE_sppsv=: (liblapacke,' LAPACKE_sppsv >+ i i c i i *f *f i')&cd
LAPACKE_dppsv=: (liblapacke,' LAPACKE_dppsv >+ i i c i i *d *d i')&cd
LAPACKE_zppsv=: (liblapacke,' LAPACKE_zppsv >+ i i c i i *j *j i')&cd
LAPACKE_sppsvx=: (liblapacke,' LAPACKE_sppsvx >+ i i c c i i *f *f *c *f *f i *f i *f *f *f')&cd
LAPACKE_dppsvx=: (liblapacke,' LAPACKE_dppsvx >+ i i c c i i *d *d *c *d *d i *d i *d *d *d')&cd
LAPACKE_zppsvx=: (liblapacke,' LAPACKE_zppsvx >+ i i c c i i *j *j *c *d *j i *j i *d *d *d')&cd
LAPACKE_spptrf=: (liblapacke,' LAPACKE_spptrf >+ i i c i *f')&cd
LAPACKE_dpptrf=: (liblapacke,' LAPACKE_dpptrf >+ i i c i *d')&cd
LAPACKE_zpptrf=: (liblapacke,' LAPACKE_zpptrf >+ i i c i *j')&cd
LAPACKE_spptri=: (liblapacke,' LAPACKE_spptri >+ i i c i *f')&cd
LAPACKE_dpptri=: (liblapacke,' LAPACKE_dpptri >+ i i c i *d')&cd
LAPACKE_zpptri=: (liblapacke,' LAPACKE_zpptri >+ i i c i *j')&cd
LAPACKE_spptrs=: (liblapacke,' LAPACKE_spptrs >+ i i c i i *f *f i')&cd
LAPACKE_dpptrs=: (liblapacke,' LAPACKE_dpptrs >+ i i c i i *d *d i')&cd
LAPACKE_zpptrs=: (liblapacke,' LAPACKE_zpptrs >+ i i c i i *j *j i')&cd
LAPACKE_spstrf=: (liblapacke,' LAPACKE_spstrf >+ i i c i *f i *i *i f')&cd
LAPACKE_dpstrf=: (liblapacke,' LAPACKE_dpstrf >+ i i c i *d i *i *i d')&cd
LAPACKE_zpstrf=: (liblapacke,' LAPACKE_zpstrf >+ i i c i *j i *i *i d')&cd
LAPACKE_sptcon=: (liblapacke,' LAPACKE_sptcon >+ i i *f *f f *f')&cd
LAPACKE_dptcon=: (liblapacke,' LAPACKE_dptcon >+ i i *d *d d *d')&cd
LAPACKE_zptcon=: (liblapacke,' LAPACKE_zptcon >+ i i *d *j d *d')&cd
LAPACKE_spteqr=: (liblapacke,' LAPACKE_spteqr >+ i i c i *f *f *f i')&cd
LAPACKE_dpteqr=: (liblapacke,' LAPACKE_dpteqr >+ i i c i *d *d *d i')&cd
LAPACKE_zpteqr=: (liblapacke,' LAPACKE_zpteqr >+ i i c i *d *d *j i')&cd
LAPACKE_sptrfs=: (liblapacke,' LAPACKE_sptrfs >+ i i i i *f *f *f *f *f i *f i *f *f')&cd
LAPACKE_dptrfs=: (liblapacke,' LAPACKE_dptrfs >+ i i i i *d *d *d *d *d i *d i *d *d')&cd
LAPACKE_zptrfs=: (liblapacke,' LAPACKE_zptrfs >+ i i c i i *d *j *d *j *j i *j i *d *d')&cd
LAPACKE_sptsv=: (liblapacke,' LAPACKE_sptsv >+ i i i i *f *f *f i')&cd
LAPACKE_dptsv=: (liblapacke,' LAPACKE_dptsv >+ i i i i *d *d *d i')&cd
LAPACKE_zptsv=: (liblapacke,' LAPACKE_zptsv >+ i i i i *d *j *j i')&cd
LAPACKE_sptsvx=: (liblapacke,' LAPACKE_sptsvx >+ i i c i i *f *f *f *f *f i *f i *f *f *f')&cd
LAPACKE_dptsvx=: (liblapacke,' LAPACKE_dptsvx >+ i i c i i *d *d *d *d *d i *d i *d *d *d')&cd
LAPACKE_zptsvx=: (liblapacke,' LAPACKE_zptsvx >+ i i c i i *d *j *d *j *j i *j i *d *d *d')&cd
LAPACKE_spttrf=: (liblapacke,' LAPACKE_spttrf >+ i i *f *f')&cd
LAPACKE_dpttrf=: (liblapacke,' LAPACKE_dpttrf >+ i i *d *d')&cd
LAPACKE_zpttrf=: (liblapacke,' LAPACKE_zpttrf >+ i i *d *j')&cd
LAPACKE_spttrs=: (liblapacke,' LAPACKE_spttrs >+ i i i i *f *f *f i')&cd
LAPACKE_dpttrs=: (liblapacke,' LAPACKE_dpttrs >+ i i i i *d *d *d i')&cd
LAPACKE_zpttrs=: (liblapacke,' LAPACKE_zpttrs >+ i i c i i *d *j *j i')&cd
LAPACKE_ssbev=: (liblapacke,' LAPACKE_ssbev >+ i i c c i i *f i *f *f i')&cd
LAPACKE_dsbev=: (liblapacke,' LAPACKE_dsbev >+ i i c c i i *d i *d *d i')&cd
LAPACKE_ssbevd=: (liblapacke,' LAPACKE_ssbevd >+ i i c c i i *f i *f *f i')&cd
LAPACKE_dsbevd=: (liblapacke,' LAPACKE_dsbevd >+ i i c c i i *d i *d *d i')&cd
LAPACKE_ssbevx=: (liblapacke,' LAPACKE_ssbevx >+ i i c c c i i *f i *f i f f i i f *i *f *f i *i')&cd
LAPACKE_dsbevx=: (liblapacke,' LAPACKE_dsbevx >+ i i c c c i i *d i *d i d d i i d *i *d *d i *i')&cd
LAPACKE_ssbgst=: (liblapacke,' LAPACKE_ssbgst >+ i i c c i i i *f i *f i *f i')&cd
LAPACKE_dsbgst=: (liblapacke,' LAPACKE_dsbgst >+ i i c c i i i *d i *d i *d i')&cd
LAPACKE_ssbgv=: (liblapacke,' LAPACKE_ssbgv >+ i i c c i i i *f i *f i *f *f i')&cd
LAPACKE_dsbgv=: (liblapacke,' LAPACKE_dsbgv >+ i i c c i i i *d i *d i *d *d i')&cd
LAPACKE_ssbgvd=: (liblapacke,' LAPACKE_ssbgvd >+ i i c c i i i *f i *f i *f *f i')&cd
LAPACKE_dsbgvd=: (liblapacke,' LAPACKE_dsbgvd >+ i i c c i i i *d i *d i *d *d i')&cd
LAPACKE_ssbgvx=: (liblapacke,' LAPACKE_ssbgvx >+ i i c c c i i i *f i *f i *f i f f i i f *i *f *f i *i')&cd
LAPACKE_dsbgvx=: (liblapacke,' LAPACKE_dsbgvx >+ i i c c c i i i *d i *d i *d i d d i i d *i *d *d i *i')&cd
LAPACKE_ssbtrd=: (liblapacke,' LAPACKE_ssbtrd >+ i i c c i i *f i *f *f *f i')&cd
LAPACKE_dsbtrd=: (liblapacke,' LAPACKE_dsbtrd >+ i i c c i i *d i *d *d *d i')&cd
LAPACKE_ssfrk=: (liblapacke,' LAPACKE_ssfrk >+ i i c c c i i f *f i f *f')&cd
LAPACKE_dsfrk=: (liblapacke,' LAPACKE_dsfrk >+ i i c c c i i d *d i d *d')&cd
LAPACKE_sspcon=: (liblapacke,' LAPACKE_sspcon >+ i i c i *f *i f *f')&cd
LAPACKE_dspcon=: (liblapacke,' LAPACKE_dspcon >+ i i c i *d *i d *d')&cd
LAPACKE_zspcon=: (liblapacke,' LAPACKE_zspcon >+ i i c i *j *i d *d')&cd
LAPACKE_sspev=: (liblapacke,' LAPACKE_sspev >+ i i c c i *f *f *f i')&cd
LAPACKE_dspev=: (liblapacke,' LAPACKE_dspev >+ i i c c i *d *d *d i')&cd
LAPACKE_sspevd=: (liblapacke,' LAPACKE_sspevd >+ i i c c i *f *f *f i')&cd
LAPACKE_dspevd=: (liblapacke,' LAPACKE_dspevd >+ i i c c i *d *d *d i')&cd
LAPACKE_sspevx=: (liblapacke,' LAPACKE_sspevx >+ i i c c c i *f f f i i f *i *f *f i *i')&cd
LAPACKE_dspevx=: (liblapacke,' LAPACKE_dspevx >+ i i c c c i *d d d i i d *i *d *d i *i')&cd
LAPACKE_sspgst=: (liblapacke,' LAPACKE_sspgst >+ i i i c i *f *f')&cd
LAPACKE_dspgst=: (liblapacke,' LAPACKE_dspgst >+ i i i c i *d *d')&cd
LAPACKE_sspgv=: (liblapacke,' LAPACKE_sspgv >+ i i i c c i *f *f *f *f i')&cd
LAPACKE_dspgv=: (liblapacke,' LAPACKE_dspgv >+ i i i c c i *d *d *d *d i')&cd
LAPACKE_sspgvd=: (liblapacke,' LAPACKE_sspgvd >+ i i i c c i *f *f *f *f i')&cd
LAPACKE_dspgvd=: (liblapacke,' LAPACKE_dspgvd >+ i i i c c i *d *d *d *d i')&cd
LAPACKE_sspgvx=: (liblapacke,' LAPACKE_sspgvx >+ i i i c c c i *f *f f f i i f *i *f *f i *i')&cd
LAPACKE_dspgvx=: (liblapacke,' LAPACKE_dspgvx >+ i i i c c c i *d *d d d i i d *i *d *d i *i')&cd
LAPACKE_ssprfs=: (liblapacke,' LAPACKE_ssprfs >+ i i c i i *f *f *i *f i *f i *f *f')&cd
LAPACKE_dsprfs=: (liblapacke,' LAPACKE_dsprfs >+ i i c i i *d *d *i *d i *d i *d *d')&cd
LAPACKE_zsprfs=: (liblapacke,' LAPACKE_zsprfs >+ i i c i i *j *j *i *j i *j i *d *d')&cd
LAPACKE_sspsv=: (liblapacke,' LAPACKE_sspsv >+ i i c i i *f *i *f i')&cd
LAPACKE_dspsv=: (liblapacke,' LAPACKE_dspsv >+ i i c i i *d *i *d i')&cd
LAPACKE_zspsv=: (liblapacke,' LAPACKE_zspsv >+ i i c i i *j *i *j i')&cd
LAPACKE_sspsvx=: (liblapacke,' LAPACKE_sspsvx >+ i i c c i i *f *f *i *f i *f i *f *f *f')&cd
LAPACKE_dspsvx=: (liblapacke,' LAPACKE_dspsvx >+ i i c c i i *d *d *i *d i *d i *d *d *d')&cd
LAPACKE_zspsvx=: (liblapacke,' LAPACKE_zspsvx >+ i i c c i i *j *j *i *j i *j i *d *d *d')&cd
LAPACKE_ssptrd=: (liblapacke,' LAPACKE_ssptrd >+ i i c i *f *f *f *f')&cd
LAPACKE_dsptrd=: (liblapacke,' LAPACKE_dsptrd >+ i i c i *d *d *d *d')&cd
LAPACKE_ssptrf=: (liblapacke,' LAPACKE_ssptrf >+ i i c i *f *i')&cd
LAPACKE_dsptrf=: (liblapacke,' LAPACKE_dsptrf >+ i i c i *d *i')&cd
LAPACKE_zsptrf=: (liblapacke,' LAPACKE_zsptrf >+ i i c i *j *i')&cd
LAPACKE_ssptri=: (liblapacke,' LAPACKE_ssptri >+ i i c i *f *i')&cd
LAPACKE_dsptri=: (liblapacke,' LAPACKE_dsptri >+ i i c i *d *i')&cd
LAPACKE_zsptri=: (liblapacke,' LAPACKE_zsptri >+ i i c i *j *i')&cd
LAPACKE_ssptrs=: (liblapacke,' LAPACKE_ssptrs >+ i i c i i *f *i *f i')&cd
LAPACKE_dsptrs=: (liblapacke,' LAPACKE_dsptrs >+ i i c i i *d *i *d i')&cd
LAPACKE_zsptrs=: (liblapacke,' LAPACKE_zsptrs >+ i i c i i *j *i *j i')&cd
LAPACKE_sstebz=: (liblapacke,' LAPACKE_sstebz >+ i c c i f f i i f *f *f *i *i *f *i *i')&cd
LAPACKE_dstebz=: (liblapacke,' LAPACKE_dstebz >+ i c c i d d i i d *d *d *i *i *d *i *i')&cd
LAPACKE_sstedc=: (liblapacke,' LAPACKE_sstedc >+ i i c i *f *f *f i')&cd
LAPACKE_dstedc=: (liblapacke,' LAPACKE_dstedc >+ i i c i *d *d *d i')&cd
LAPACKE_zstedc=: (liblapacke,' LAPACKE_zstedc >+ i i c i *d *d *j i')&cd
LAPACKE_sstegr=: (liblapacke,' LAPACKE_sstegr >+ i i c c i *f *f f f i i f *i *f *f i *i')&cd
LAPACKE_dstegr=: (liblapacke,' LAPACKE_dstegr >+ i i c c i *d *d d d i i d *i *d *d i *i')&cd
LAPACKE_zstegr=: (liblapacke,' LAPACKE_zstegr >+ i i c c i *d *d d d i i d *i *d *j i *i')&cd
LAPACKE_sstein=: (liblapacke,' LAPACKE_sstein >+ i i i *f *f i *f *i *i *f i *i')&cd
LAPACKE_dstein=: (liblapacke,' LAPACKE_dstein >+ i i i *d *d i *d *i *i *d i *i')&cd
LAPACKE_zstein=: (liblapacke,' LAPACKE_zstein >+ i i i *d *d i *d *i *i *j i *i')&cd
LAPACKE_sstemr=: (liblapacke,' LAPACKE_sstemr >+ i i c c i *f *f f f i i *i *f *f i i *i *i')&cd
LAPACKE_dstemr=: (liblapacke,' LAPACKE_dstemr >+ i i c c i *d *d d d i i *i *d *d i i *i *i')&cd
LAPACKE_zstemr=: (liblapacke,' LAPACKE_zstemr >+ i i c c i *d *d d d i i *i *d *j i i *i *i')&cd
LAPACKE_ssteqr=: (liblapacke,' LAPACKE_ssteqr >+ i i c i *f *f *f i')&cd
LAPACKE_dsteqr=: (liblapacke,' LAPACKE_dsteqr >+ i i c i *d *d *d i')&cd
LAPACKE_zsteqr=: (liblapacke,' LAPACKE_zsteqr >+ i i c i *d *d *j i')&cd
LAPACKE_ssterf=: (liblapacke,' LAPACKE_ssterf >+ i i *f *f')&cd
LAPACKE_dsterf=: (liblapacke,' LAPACKE_dsterf >+ i i *d *d')&cd
LAPACKE_sstev=: (liblapacke,' LAPACKE_sstev >+ i i c i *f *f *f i')&cd
LAPACKE_dstev=: (liblapacke,' LAPACKE_dstev >+ i i c i *d *d *d i')&cd
LAPACKE_sstevd=: (liblapacke,' LAPACKE_sstevd >+ i i c i *f *f *f i')&cd
LAPACKE_dstevd=: (liblapacke,' LAPACKE_dstevd >+ i i c i *d *d *d i')&cd
LAPACKE_sstevr=: (liblapacke,' LAPACKE_sstevr >+ i i c c i *f *f f f i i f *i *f *f i *i')&cd
LAPACKE_dstevr=: (liblapacke,' LAPACKE_dstevr >+ i i c c i *d *d d d i i d *i *d *d i *i')&cd
LAPACKE_sstevx=: (liblapacke,' LAPACKE_sstevx >+ i i c c i *f *f f f i i f *i *f *f i *i')&cd
LAPACKE_dstevx=: (liblapacke,' LAPACKE_dstevx >+ i i c c i *d *d d d i i d *i *d *d i *i')&cd
LAPACKE_ssycon=: (liblapacke,' LAPACKE_ssycon >+ i i c i *f i *i f *f')&cd
LAPACKE_dsycon=: (liblapacke,' LAPACKE_dsycon >+ i i c i *d i *i d *d')&cd
LAPACKE_zsycon=: (liblapacke,' LAPACKE_zsycon >+ i i c i *j i *i d *d')&cd
LAPACKE_ssyequb=: (liblapacke,' LAPACKE_ssyequb >+ i i c i *f i *f *f *f')&cd
LAPACKE_dsyequb=: (liblapacke,' LAPACKE_dsyequb >+ i i c i *d i *d *d *d')&cd
LAPACKE_zsyequb=: (liblapacke,' LAPACKE_zsyequb >+ i i c i *j i *d *d *d')&cd
LAPACKE_ssyev=: (liblapacke,' LAPACKE_ssyev >+ i i c c i *f i *f')&cd
LAPACKE_dsyev=: (liblapacke,' LAPACKE_dsyev >+ i i c c i *d i *d')&cd
LAPACKE_ssyevd=: (liblapacke,' LAPACKE_ssyevd >+ i i c c i *f i *f')&cd
LAPACKE_dsyevd=: (liblapacke,' LAPACKE_dsyevd >+ i i c c i *d i *d')&cd
LAPACKE_ssyevr=: (liblapacke,' LAPACKE_ssyevr >+ i i c c c i *f i f f i i f *i *f *f i *i')&cd
LAPACKE_dsyevr=: (liblapacke,' LAPACKE_dsyevr >+ i i c c c i *d i d d i i d *i *d *d i *i')&cd
LAPACKE_ssyevx=: (liblapacke,' LAPACKE_ssyevx >+ i i c c c i *f i f f i i f *i *f *f i *i')&cd
LAPACKE_dsyevx=: (liblapacke,' LAPACKE_dsyevx >+ i i c c c i *d i d d i i d *i *d *d i *i')&cd
LAPACKE_ssygst=: (liblapacke,' LAPACKE_ssygst >+ i i i c i *f i *f i')&cd
LAPACKE_dsygst=: (liblapacke,' LAPACKE_dsygst >+ i i i c i *d i *d i')&cd
LAPACKE_ssygv=: (liblapacke,' LAPACKE_ssygv >+ i i i c c i *f i *f i *f')&cd
LAPACKE_dsygv=: (liblapacke,' LAPACKE_dsygv >+ i i i c c i *d i *d i *d')&cd
LAPACKE_ssygvd=: (liblapacke,' LAPACKE_ssygvd >+ i i i c c i *f i *f i *f')&cd
LAPACKE_dsygvd=: (liblapacke,' LAPACKE_dsygvd >+ i i i c c i *d i *d i *d')&cd
LAPACKE_ssygvx=: (liblapacke,' LAPACKE_ssygvx >+ i i i c c c i *f i *f i f f i i f *i *f *f i *i')&cd
LAPACKE_dsygvx=: (liblapacke,' LAPACKE_dsygvx >+ i i i c c c i *d i *d i d d i i d *i *d *d i *i')&cd
LAPACKE_ssyrfs=: (liblapacke,' LAPACKE_ssyrfs >+ i i c i i *f i *f i *i *f i *f i *f *f')&cd
LAPACKE_dsyrfs=: (liblapacke,' LAPACKE_dsyrfs >+ i i c i i *d i *d i *i *d i *d i *d *d')&cd
LAPACKE_zsyrfs=: (liblapacke,' LAPACKE_zsyrfs >+ i i c i i *j i *j i *i *j i *j i *d *d')&cd
LAPACKE_ssyrfsx=: (liblapacke,' LAPACKE_ssyrfsx >+ i i c c i i *f i *f i *i *f *f i *f i *f *f i *f *f i *f')&cd
LAPACKE_dsyrfsx=: (liblapacke,' LAPACKE_dsyrfsx >+ i i c c i i *d i *d i *i *d *d i *d i *d *d i *d *d i *d')&cd
LAPACKE_zsyrfsx=: (liblapacke,' LAPACKE_zsyrfsx >+ i i c c i i *j i *j i *i *d *j i *j i *d *d i *d *d i *d')&cd
LAPACKE_ssysv=: (liblapacke,' LAPACKE_ssysv >+ i i c i i *f i *i *f i')&cd
LAPACKE_dsysv=: (liblapacke,' LAPACKE_dsysv >+ i i c i i *d i *i *d i')&cd
LAPACKE_zsysv=: (liblapacke,' LAPACKE_zsysv >+ i i c i i *j i *i *j i')&cd
LAPACKE_ssysvx=: (liblapacke,' LAPACKE_ssysvx >+ i i c c i i *f i *f i *i *f i *f i *f *f *f')&cd
LAPACKE_dsysvx=: (liblapacke,' LAPACKE_dsysvx >+ i i c c i i *d i *d i *i *d i *d i *d *d *d')&cd
LAPACKE_zsysvx=: (liblapacke,' LAPACKE_zsysvx >+ i i c c i i *j i *j i *i *j i *j i *d *d *d')&cd
LAPACKE_ssysvxx=: (liblapacke,' LAPACKE_ssysvxx >+ i i c c i i *f i *f i *i *c *f *f i *f i *f *f *f i *f *f i *f')&cd
LAPACKE_dsysvxx=: (liblapacke,' LAPACKE_dsysvxx >+ i i c c i i *d i *d i *i *c *d *d i *d i *d *d *d i *d *d i *d')&cd
LAPACKE_zsysvxx=: (liblapacke,' LAPACKE_zsysvxx >+ i i c c i i *j i *j i *i *c *d *j i *j i *d *d *d i *d *d i *d')&cd
LAPACKE_ssytrd=: (liblapacke,' LAPACKE_ssytrd >+ i i c i *f i *f *f *f')&cd
LAPACKE_dsytrd=: (liblapacke,' LAPACKE_dsytrd >+ i i c i *d i *d *d *d')&cd
LAPACKE_ssytrf=: (liblapacke,' LAPACKE_ssytrf >+ i i c i *f i *i')&cd
LAPACKE_dsytrf=: (liblapacke,' LAPACKE_dsytrf >+ i i c i *d i *i')&cd
LAPACKE_zsytrf=: (liblapacke,' LAPACKE_zsytrf >+ i i c i *j i *i')&cd
LAPACKE_ssytri=: (liblapacke,' LAPACKE_ssytri >+ i i c i *f i *i')&cd
LAPACKE_dsytri=: (liblapacke,' LAPACKE_dsytri >+ i i c i *d i *i')&cd
LAPACKE_zsytri=: (liblapacke,' LAPACKE_zsytri >+ i i c i *j i *i')&cd
LAPACKE_ssytrs=: (liblapacke,' LAPACKE_ssytrs >+ i i c i i *f i *i *f i')&cd
LAPACKE_dsytrs=: (liblapacke,' LAPACKE_dsytrs >+ i i c i i *d i *i *d i')&cd
LAPACKE_zsytrs=: (liblapacke,' LAPACKE_zsytrs >+ i i c i i *j i *i *j i')&cd
LAPACKE_stbcon=: (liblapacke,' LAPACKE_stbcon >+ i i c c c i i *f i *f')&cd
LAPACKE_dtbcon=: (liblapacke,' LAPACKE_dtbcon >+ i i c c c i i *d i *d')&cd
LAPACKE_ztbcon=: (liblapacke,' LAPACKE_ztbcon >+ i i c c c i i *j i *d')&cd
LAPACKE_stbrfs=: (liblapacke,' LAPACKE_stbrfs >+ i i c c c i i i *f i *f i *f i *f *f')&cd
LAPACKE_dtbrfs=: (liblapacke,' LAPACKE_dtbrfs >+ i i c c c i i i *d i *d i *d i *d *d')&cd
LAPACKE_ztbrfs=: (liblapacke,' LAPACKE_ztbrfs >+ i i c c c i i i *j i *j i *j i *d *d')&cd
LAPACKE_stbtrs=: (liblapacke,' LAPACKE_stbtrs >+ i i c c c i i i *f i *f i')&cd
LAPACKE_dtbtrs=: (liblapacke,' LAPACKE_dtbtrs >+ i i c c c i i i *d i *d i')&cd
LAPACKE_ztbtrs=: (liblapacke,' LAPACKE_ztbtrs >+ i i c c c i i i *j i *j i')&cd
LAPACKE_stfsm=: (liblapacke,' LAPACKE_stfsm >+ i i c c c c c i i f *f *f i')&cd
LAPACKE_dtfsm=: (liblapacke,' LAPACKE_dtfsm >+ i i c c c c c i i d *d *d i')&cd
LAPACKE_ztfsm=: (liblapacke,' LAPACKE_ztfsm >+ i i c c c c c i i j *j *j i')&cd
LAPACKE_stftri=: (liblapacke,' LAPACKE_stftri >+ i i c c c i *f')&cd
LAPACKE_dtftri=: (liblapacke,' LAPACKE_dtftri >+ i i c c c i *d')&cd
LAPACKE_ztftri=: (liblapacke,' LAPACKE_ztftri >+ i i c c c i *j')&cd
LAPACKE_stfttp=: (liblapacke,' LAPACKE_stfttp >+ i i c c i *f *f')&cd
LAPACKE_dtfttp=: (liblapacke,' LAPACKE_dtfttp >+ i i c c i *d *d')&cd
LAPACKE_ztfttp=: (liblapacke,' LAPACKE_ztfttp >+ i i c c i *j *j')&cd
LAPACKE_stfttr=: (liblapacke,' LAPACKE_stfttr >+ i i c c i *f *f i')&cd
LAPACKE_dtfttr=: (liblapacke,' LAPACKE_dtfttr >+ i i c c i *d *d i')&cd
LAPACKE_ztfttr=: (liblapacke,' LAPACKE_ztfttr >+ i i c c i *j *j i')&cd
LAPACKE_stgevc=: (liblapacke,' LAPACKE_stgevc >+ i i c c *i i *f i *f i *f i *f i i *i')&cd
LAPACKE_dtgevc=: (liblapacke,' LAPACKE_dtgevc >+ i i c c *i i *d i *d i *d i *d i i *i')&cd
LAPACKE_ztgevc=: (liblapacke,' LAPACKE_ztgevc >+ i i c c *i i *j i *j i *j i *j i i *i')&cd
LAPACKE_stgexc=: (liblapacke,' LAPACKE_stgexc >+ i i i i i *f i *f i *f i *f i *i *i')&cd
LAPACKE_dtgexc=: (liblapacke,' LAPACKE_dtgexc >+ i i i i i *d i *d i *d i *d i *i *i')&cd
LAPACKE_ztgexc=: (liblapacke,' LAPACKE_ztgexc >+ i i i i i *j i *j i *j i *j i i i')&cd
LAPACKE_stgsen=: (liblapacke,' LAPACKE_stgsen >+ i i i i i *i i *f i *f i *f *f *f *f i *f i *i *f *f *f')&cd
LAPACKE_dtgsen=: (liblapacke,' LAPACKE_dtgsen >+ i i i i i *i i *d i *d i *d *d *d *d i *d i *i *d *d *d')&cd
LAPACKE_ztgsen=: (liblapacke,' LAPACKE_ztgsen >+ i i i i i *i i *j i *j i *j *j *j i *j i *i *d *d *d')&cd
LAPACKE_stgsja=: (liblapacke,' LAPACKE_stgsja >+ i i c c c i i i i i *f i *f i f f *f *f *f i *f i *f i *i')&cd
LAPACKE_dtgsja=: (liblapacke,' LAPACKE_dtgsja >+ i i c c c i i i i i *d i *d i d d *d *d *d i *d i *d i *i')&cd
LAPACKE_ztgsja=: (liblapacke,' LAPACKE_ztgsja >+ i i c c c i i i i i *j i *j i d d *d *d *j i *j i *j i *i')&cd
LAPACKE_stgsna=: (liblapacke,' LAPACKE_stgsna >+ i i c c *i i *f i *f i *f i *f i *f *f i *i')&cd
LAPACKE_dtgsna=: (liblapacke,' LAPACKE_dtgsna >+ i i c c *i i *d i *d i *d i *d i *d *d i *i')&cd
LAPACKE_ztgsna=: (liblapacke,' LAPACKE_ztgsna >+ i i c c *i i *j i *j i *j i *j i *d *d i *i')&cd
LAPACKE_stgsyl=: (liblapacke,' LAPACKE_stgsyl >+ i i c i i i *f i *f i *f i *f i *f i *f i *f *f')&cd
LAPACKE_dtgsyl=: (liblapacke,' LAPACKE_dtgsyl >+ i i c i i i *d i *d i *d i *d i *d i *d i *d *d')&cd
LAPACKE_ztgsyl=: (liblapacke,' LAPACKE_ztgsyl >+ i i c i i i *j i *j i *j i *j i *j i *j i *d *d')&cd
LAPACKE_stpcon=: (liblapacke,' LAPACKE_stpcon >+ i i c c c i *f *f')&cd
LAPACKE_dtpcon=: (liblapacke,' LAPACKE_dtpcon >+ i i c c c i *d *d')&cd
LAPACKE_ztpcon=: (liblapacke,' LAPACKE_ztpcon >+ i i c c c i *j *d')&cd
LAPACKE_stprfs=: (liblapacke,' LAPACKE_stprfs >+ i i c c c i i *f *f i *f i *f *f')&cd
LAPACKE_dtprfs=: (liblapacke,' LAPACKE_dtprfs >+ i i c c c i i *d *d i *d i *d *d')&cd
LAPACKE_ztprfs=: (liblapacke,' LAPACKE_ztprfs >+ i i c c c i i *j *j i *j i *d *d')&cd
LAPACKE_stptri=: (liblapacke,' LAPACKE_stptri >+ i i c c i *f')&cd
LAPACKE_dtptri=: (liblapacke,' LAPACKE_dtptri >+ i i c c i *d')&cd
LAPACKE_ztptri=: (liblapacke,' LAPACKE_ztptri >+ i i c c i *j')&cd
LAPACKE_stptrs=: (liblapacke,' LAPACKE_stptrs >+ i i c c c i i *f *f i')&cd
LAPACKE_dtptrs=: (liblapacke,' LAPACKE_dtptrs >+ i i c c c i i *d *d i')&cd
LAPACKE_ztptrs=: (liblapacke,' LAPACKE_ztptrs >+ i i c c c i i *j *j i')&cd
LAPACKE_stpttf=: (liblapacke,' LAPACKE_stpttf >+ i i c c i *f *f')&cd
LAPACKE_dtpttf=: (liblapacke,' LAPACKE_dtpttf >+ i i c c i *d *d')&cd
LAPACKE_ztpttf=: (liblapacke,' LAPACKE_ztpttf >+ i i c c i *j *j')&cd
LAPACKE_stpttr=: (liblapacke,' LAPACKE_stpttr >+ i i c i *f *f i')&cd
LAPACKE_dtpttr=: (liblapacke,' LAPACKE_dtpttr >+ i i c i *d *d i')&cd
LAPACKE_ztpttr=: (liblapacke,' LAPACKE_ztpttr >+ i i c i *j *j i')&cd
LAPACKE_strcon=: (liblapacke,' LAPACKE_strcon >+ i i c c c i *f i *f')&cd
LAPACKE_dtrcon=: (liblapacke,' LAPACKE_dtrcon >+ i i c c c i *d i *d')&cd
LAPACKE_ztrcon=: (liblapacke,' LAPACKE_ztrcon >+ i i c c c i *j i *d')&cd
LAPACKE_strevc=: (liblapacke,' LAPACKE_strevc >+ i i c c *i i *f i *f i *f i i *i')&cd
LAPACKE_dtrevc=: (liblapacke,' LAPACKE_dtrevc >+ i i c c *i i *d i *d i *d i i *i')&cd
LAPACKE_ztrevc=: (liblapacke,' LAPACKE_ztrevc >+ i i c c *i i *j i *j i *j i i *i')&cd
LAPACKE_strexc=: (liblapacke,' LAPACKE_strexc >+ i i c i *f i *f i *i *i')&cd
LAPACKE_dtrexc=: (liblapacke,' LAPACKE_dtrexc >+ i i c i *d i *d i *i *i')&cd
LAPACKE_ztrexc=: (liblapacke,' LAPACKE_ztrexc >+ i i c i *j i *j i i i')&cd
LAPACKE_strrfs=: (liblapacke,' LAPACKE_strrfs >+ i i c c c i i *f i *f i *f i *f *f')&cd
LAPACKE_dtrrfs=: (liblapacke,' LAPACKE_dtrrfs >+ i i c c c i i *d i *d i *d i *d *d')&cd
LAPACKE_ztrrfs=: (liblapacke,' LAPACKE_ztrrfs >+ i i c c c i i *j i *j i *j i *d *d')&cd
LAPACKE_strsen=: (liblapacke,' LAPACKE_strsen >+ i i c c *i i *f i *f i *f *f *i *f *f')&cd
LAPACKE_dtrsen=: (liblapacke,' LAPACKE_dtrsen >+ i i c c *i i *d i *d i *d *d *i *d *d')&cd
LAPACKE_ztrsen=: (liblapacke,' LAPACKE_ztrsen >+ i i c c *i i *j i *j i *j *i *d *d')&cd
LAPACKE_strsna=: (liblapacke,' LAPACKE_strsna >+ i i c c *i i *f i *f i *f i *f *f i *i')&cd
LAPACKE_dtrsna=: (liblapacke,' LAPACKE_dtrsna >+ i i c c *i i *d i *d i *d i *d *d i *i')&cd
LAPACKE_ztrsna=: (liblapacke,' LAPACKE_ztrsna >+ i i c c *i i *j i *j i *j i *d *d i *i')&cd
LAPACKE_strsyl=: (liblapacke,' LAPACKE_strsyl >+ i i c c i i i *f i *f i *f i *f')&cd
LAPACKE_dtrsyl=: (liblapacke,' LAPACKE_dtrsyl >+ i i c c i i i *d i *d i *d i *d')&cd
LAPACKE_ztrsyl=: (liblapacke,' LAPACKE_ztrsyl >+ i i c c i i i *j i *j i *j i *d')&cd
LAPACKE_strtri=: (liblapacke,' LAPACKE_strtri >+ i i c c i *f i')&cd
LAPACKE_dtrtri=: (liblapacke,' LAPACKE_dtrtri >+ i i c c i *d i')&cd
LAPACKE_ztrtri=: (liblapacke,' LAPACKE_ztrtri >+ i i c c i *j i')&cd
LAPACKE_strtrs=: (liblapacke,' LAPACKE_strtrs >+ i i c c c i i *f i *f i')&cd
LAPACKE_dtrtrs=: (liblapacke,' LAPACKE_dtrtrs >+ i i c c c i i *d i *d i')&cd
LAPACKE_ztrtrs=: (liblapacke,' LAPACKE_ztrtrs >+ i i c c c i i *j i *j i')&cd
LAPACKE_strttf=: (liblapacke,' LAPACKE_strttf >+ i i c c i *f i *f')&cd
LAPACKE_dtrttf=: (liblapacke,' LAPACKE_dtrttf >+ i i c c i *d i *d')&cd
LAPACKE_ztrttf=: (liblapacke,' LAPACKE_ztrttf >+ i i c c i *j i *j')&cd
LAPACKE_strttp=: (liblapacke,' LAPACKE_strttp >+ i i c i *f i *f')&cd
LAPACKE_dtrttp=: (liblapacke,' LAPACKE_dtrttp >+ i i c i *d i *d')&cd
LAPACKE_ztrttp=: (liblapacke,' LAPACKE_ztrttp >+ i i c i *j i *j')&cd
LAPACKE_stzrzf=: (liblapacke,' LAPACKE_stzrzf >+ i i i i *f i *f')&cd
LAPACKE_dtzrzf=: (liblapacke,' LAPACKE_dtzrzf >+ i i i i *d i *d')&cd
LAPACKE_ztzrzf=: (liblapacke,' LAPACKE_ztzrzf >+ i i i i *j i *j')&cd
LAPACKE_zungbr=: (liblapacke,' LAPACKE_zungbr >+ i i c i i i *j i *j')&cd
LAPACKE_zunghr=: (liblapacke,' LAPACKE_zunghr >+ i i i i i *j i *j')&cd
LAPACKE_zunglq=: (liblapacke,' LAPACKE_zunglq >+ i i i i i *j i *j')&cd
LAPACKE_zungql=: (liblapacke,' LAPACKE_zungql >+ i i i i i *j i *j')&cd
LAPACKE_zungqr=: (liblapacke,' LAPACKE_zungqr >+ i i i i i *j i *j')&cd
LAPACKE_zungrq=: (liblapacke,' LAPACKE_zungrq >+ i i i i i *j i *j')&cd
LAPACKE_zungtr=: (liblapacke,' LAPACKE_zungtr >+ i i c i *j i *j')&cd
LAPACKE_zunmbr=: (liblapacke,' LAPACKE_zunmbr >+ i i c c c i i i *j i *j *j i')&cd
LAPACKE_zunmhr=: (liblapacke,' LAPACKE_zunmhr >+ i i c c i i i i *j i *j *j i')&cd
LAPACKE_zunmlq=: (liblapacke,' LAPACKE_zunmlq >+ i i c c i i i *j i *j *j i')&cd
LAPACKE_zunmql=: (liblapacke,' LAPACKE_zunmql >+ i i c c i i i *j i *j *j i')&cd
LAPACKE_zunmqr=: (liblapacke,' LAPACKE_zunmqr >+ i i c c i i i *j i *j *j i')&cd
LAPACKE_zunmrq=: (liblapacke,' LAPACKE_zunmrq >+ i i c c i i i *j i *j *j i')&cd
LAPACKE_zunmrz=: (liblapacke,' LAPACKE_zunmrz >+ i i c c i i i i *j i *j *j i')&cd
LAPACKE_zunmtr=: (liblapacke,' LAPACKE_zunmtr >+ i i c c c i i *j i *j *j i')&cd
LAPACKE_zupgtr=: (liblapacke,' LAPACKE_zupgtr >+ i i c i *j *j *j i')&cd
LAPACKE_zupmtr=: (liblapacke,' LAPACKE_zupmtr >+ i i c c c i i *j *j *j i')&cd
LAPACKE_sbdsdc_work=: (liblapacke,' LAPACKE_sbdsdc_work >+ i i c c i *f *f *f i *f i *f *i *f *i')&cd
LAPACKE_dbdsdc_work=: (liblapacke,' LAPACKE_dbdsdc_work >+ i i c c i *d *d *d i *d i *d *i *d *i')&cd
LAPACKE_sbdsqr_work=: (liblapacke,' LAPACKE_sbdsqr_work >+ i i c i i i i *f *f *f i *f i *f i *f')&cd
LAPACKE_dbdsqr_work=: (liblapacke,' LAPACKE_dbdsqr_work >+ i i c i i i i *d *d *d i *d i *d i *d')&cd
LAPACKE_zbdsqr_work=: (liblapacke,' LAPACKE_zbdsqr_work >+ i i c i i i i *d *d *j i *j i *j i *d')&cd
LAPACKE_sdisna_work=: (liblapacke,' LAPACKE_sdisna_work >+ i c i i *f *f')&cd
LAPACKE_ddisna_work=: (liblapacke,' LAPACKE_ddisna_work >+ i c i i *d *d')&cd
LAPACKE_sgbbrd_work=: (liblapacke,' LAPACKE_sgbbrd_work >+ i i c i i i i i *f i *f *f *f i *f i *f i *f')&cd
LAPACKE_dgbbrd_work=: (liblapacke,' LAPACKE_dgbbrd_work >+ i i c i i i i i *d i *d *d *d i *d i *d i *d')&cd
LAPACKE_zgbbrd_work=: (liblapacke,' LAPACKE_zgbbrd_work >+ i i c i i i i i *j i *d *d *j i *j i *j i *j *d')&cd
LAPACKE_sgbcon_work=: (liblapacke,' LAPACKE_sgbcon_work >+ i i c i i i *f i *i f *f *f *i')&cd
LAPACKE_dgbcon_work=: (liblapacke,' LAPACKE_dgbcon_work >+ i i c i i i *d i *i d *d *d *i')&cd
LAPACKE_zgbcon_work=: (liblapacke,' LAPACKE_zgbcon_work >+ i i c i i i *j i *i d *d *j *d')&cd
LAPACKE_sgbequ_work=: (liblapacke,' LAPACKE_sgbequ_work >+ i i i i i i *f i *f *f *f *f *f')&cd
LAPACKE_dgbequ_work=: (liblapacke,' LAPACKE_dgbequ_work >+ i i i i i i *d i *d *d *d *d *d')&cd
LAPACKE_zgbequ_work=: (liblapacke,' LAPACKE_zgbequ_work >+ i i i i i i *j i *d *d *d *d *d')&cd
LAPACKE_sgbequb_work=: (liblapacke,' LAPACKE_sgbequb_work >+ i i i i i i *f i *f *f *f *f *f')&cd
LAPACKE_dgbequb_work=: (liblapacke,' LAPACKE_dgbequb_work >+ i i i i i i *d i *d *d *d *d *d')&cd
LAPACKE_zgbequb_work=: (liblapacke,' LAPACKE_zgbequb_work >+ i i i i i i *j i *d *d *d *d *d')&cd
LAPACKE_sgbrfs_work=: (liblapacke,' LAPACKE_sgbrfs_work >+ i i c i i i i *f i *f i *i *f i *f i *f *f *f *i')&cd
LAPACKE_dgbrfs_work=: (liblapacke,' LAPACKE_dgbrfs_work >+ i i c i i i i *d i *d i *i *d i *d i *d *d *d *i')&cd
LAPACKE_zgbrfs_work=: (liblapacke,' LAPACKE_zgbrfs_work >+ i i c i i i i *j i *j i *i *j i *j i *d *d *j *d')&cd
LAPACKE_sgbrfsx_work=: (liblapacke,' LAPACKE_sgbrfsx_work >+ i i c c i i i i *f i *f i *i *f *f *f i *f i *f *f i *f *f i *f *f *i')&cd
LAPACKE_dgbrfsx_work=: (liblapacke,' LAPACKE_dgbrfsx_work >+ i i c c i i i i *d i *d i *i *d *d *d i *d i *d *d i *d *d i *d *d *i')&cd
LAPACKE_zgbrfsx_work=: (liblapacke,' LAPACKE_zgbrfsx_work >+ i i c c i i i i *j i *j i *i *d *d *j i *j i *d *d i *d *d i *d *j *d')&cd
LAPACKE_sgbsv_work=: (liblapacke,' LAPACKE_sgbsv_work >+ i i i i i i *f i *i *f i')&cd
LAPACKE_dgbsv_work=: (liblapacke,' LAPACKE_dgbsv_work >+ i i i i i i *d i *i *d i')&cd
LAPACKE_zgbsv_work=: (liblapacke,' LAPACKE_zgbsv_work >+ i i i i i i *j i *i *j i')&cd
LAPACKE_sgbsvx_work=: (liblapacke,' LAPACKE_sgbsvx_work >+ i i c c i i i i *f i *f i *i *c *f *f *f i *f i *f *f *f *f *i')&cd
LAPACKE_dgbsvx_work=: (liblapacke,' LAPACKE_dgbsvx_work >+ i i c c i i i i *d i *d i *i *c *d *d *d i *d i *d *d *d *d *i')&cd
LAPACKE_zgbsvx_work=: (liblapacke,' LAPACKE_zgbsvx_work >+ i i c c i i i i *j i *j i *i *c *d *d *j i *j i *d *d *d *j *d')&cd
LAPACKE_sgbsvxx_work=: (liblapacke,' LAPACKE_sgbsvxx_work >+ i i c c i i i i *f i *f i *i *c *f *f *f i *f i *f *f *f i *f *f i *f *f *i')&cd
LAPACKE_dgbsvxx_work=: (liblapacke,' LAPACKE_dgbsvxx_work >+ i i c c i i i i *d i *d i *i *c *d *d *d i *d i *d *d *d i *d *d i *d *d *i')&cd
LAPACKE_zgbsvxx_work=: (liblapacke,' LAPACKE_zgbsvxx_work >+ i i c c i i i i *j i *j i *i *c *d *d *j i *j i *d *d *d i *d *d i *d *j *d')&cd
LAPACKE_sgbtrf_work=: (liblapacke,' LAPACKE_sgbtrf_work >+ i i i i i i *f i *i')&cd
LAPACKE_dgbtrf_work=: (liblapacke,' LAPACKE_dgbtrf_work >+ i i i i i i *d i *i')&cd
LAPACKE_zgbtrf_work=: (liblapacke,' LAPACKE_zgbtrf_work >+ i i i i i i *j i *i')&cd
LAPACKE_sgbtrs_work=: (liblapacke,' LAPACKE_sgbtrs_work >+ i i c i i i i *f i *i *f i')&cd
LAPACKE_dgbtrs_work=: (liblapacke,' LAPACKE_dgbtrs_work >+ i i c i i i i *d i *i *d i')&cd
LAPACKE_zgbtrs_work=: (liblapacke,' LAPACKE_zgbtrs_work >+ i i c i i i i *j i *i *j i')&cd
LAPACKE_sgebak_work=: (liblapacke,' LAPACKE_sgebak_work >+ i i c c i i i *f i *f i')&cd
LAPACKE_dgebak_work=: (liblapacke,' LAPACKE_dgebak_work >+ i i c c i i i *d i *d i')&cd
LAPACKE_zgebak_work=: (liblapacke,' LAPACKE_zgebak_work >+ i i c c i i i *d i *j i')&cd
LAPACKE_sgebal_work=: (liblapacke,' LAPACKE_sgebal_work >+ i i c i *f i *i *i *f')&cd
LAPACKE_dgebal_work=: (liblapacke,' LAPACKE_dgebal_work >+ i i c i *d i *i *i *d')&cd
LAPACKE_zgebal_work=: (liblapacke,' LAPACKE_zgebal_work >+ i i c i *j i *i *i *d')&cd
LAPACKE_sgebrd_work=: (liblapacke,' LAPACKE_sgebrd_work >+ i i i i *f i *f *f *f *f *f i')&cd
LAPACKE_dgebrd_work=: (liblapacke,' LAPACKE_dgebrd_work >+ i i i i *d i *d *d *d *d *d i')&cd
LAPACKE_zgebrd_work=: (liblapacke,' LAPACKE_zgebrd_work >+ i i i i *j i *d *d *j *j *j i')&cd
LAPACKE_sgecon_work=: (liblapacke,' LAPACKE_sgecon_work >+ i i c i *f i f *f *f *i')&cd
LAPACKE_dgecon_work=: (liblapacke,' LAPACKE_dgecon_work >+ i i c i *d i d *d *d *i')&cd
LAPACKE_zgecon_work=: (liblapacke,' LAPACKE_zgecon_work >+ i i c i *j i d *d *j *d')&cd
LAPACKE_sgeequ_work=: (liblapacke,' LAPACKE_sgeequ_work >+ i i i i *f i *f *f *f *f *f')&cd
LAPACKE_dgeequ_work=: (liblapacke,' LAPACKE_dgeequ_work >+ i i i i *d i *d *d *d *d *d')&cd
LAPACKE_zgeequ_work=: (liblapacke,' LAPACKE_zgeequ_work >+ i i i i *j i *d *d *d *d *d')&cd
LAPACKE_sgeequb_work=: (liblapacke,' LAPACKE_sgeequb_work >+ i i i i *f i *f *f *f *f *f')&cd
LAPACKE_dgeequb_work=: (liblapacke,' LAPACKE_dgeequb_work >+ i i i i *d i *d *d *d *d *d')&cd
LAPACKE_zgeequb_work=: (liblapacke,' LAPACKE_zgeequb_work >+ i i i i *j i *d *d *d *d *d')&cd
LAPACKE_sgees_work=: (liblapacke,' LAPACKE_sgees_work >+ i i c c x i *f i *i *f *f *f i *f i *i')&cd
LAPACKE_dgees_work=: (liblapacke,' LAPACKE_dgees_work >+ i i c c x i *d i *i *d *d *d i *d i *i')&cd
LAPACKE_zgees_work=: (liblapacke,' LAPACKE_zgees_work >+ i i c c x i *j i *i *j *j i *j i *d *i')&cd
LAPACKE_sgeesx_work=: (liblapacke,' LAPACKE_sgeesx_work >+ i i c c x c i *f i *i *f *f *f i *f *f *f i *i i *i')&cd
LAPACKE_dgeesx_work=: (liblapacke,' LAPACKE_dgeesx_work >+ i i c c x c i *d i *i *d *d *d i *d *d *d i *i i *i')&cd
LAPACKE_zgeesx_work=: (liblapacke,' LAPACKE_zgeesx_work >+ i i c c x c i *j i *i *j *j i *d *d *j i *d *i')&cd
LAPACKE_sgeev_work=: (liblapacke,' LAPACKE_sgeev_work >+ i i c c i *f i *f *f *f i *f i *f i')&cd
LAPACKE_dgeev_work=: (liblapacke,' LAPACKE_dgeev_work >+ i i c c i *d i *d *d *d i *d i *d i')&cd
LAPACKE_zgeev_work=: (liblapacke,' LAPACKE_zgeev_work >+ i i c c i *j i *j *j i *j i *j i *d')&cd
LAPACKE_sgeevx_work=: (liblapacke,' LAPACKE_sgeevx_work >+ i i c c c c i *f i *f *f *f i *f i *i *i *f *f *f *f *f i *i')&cd
LAPACKE_dgeevx_work=: (liblapacke,' LAPACKE_dgeevx_work >+ i i c c c c i *d i *d *d *d i *d i *i *i *d *d *d *d *d i *i')&cd
LAPACKE_zgeevx_work=: (liblapacke,' LAPACKE_zgeevx_work >+ i i c c c c i *j i *j *j i *j i *i *i *d *d *d *d *j i *d')&cd
LAPACKE_sgehrd_work=: (liblapacke,' LAPACKE_sgehrd_work >+ i i i i i *f i *f *f i')&cd
LAPACKE_dgehrd_work=: (liblapacke,' LAPACKE_dgehrd_work >+ i i i i i *d i *d *d i')&cd
LAPACKE_zgehrd_work=: (liblapacke,' LAPACKE_zgehrd_work >+ i i i i i *j i *j *j i')&cd
LAPACKE_sgejsv_work=: (liblapacke,' LAPACKE_sgejsv_work >+ i i c c c c c c i i *f i *f *f i *f i *f i *i')&cd
LAPACKE_dgejsv_work=: (liblapacke,' LAPACKE_dgejsv_work >+ i i c c c c c c i i *d i *d *d i *d i *d i *i')&cd
LAPACKE_sgelq2_work=: (liblapacke,' LAPACKE_sgelq2_work >+ i i i i *f i *f *f')&cd
LAPACKE_dgelq2_work=: (liblapacke,' LAPACKE_dgelq2_work >+ i i i i *d i *d *d')&cd
LAPACKE_zgelq2_work=: (liblapacke,' LAPACKE_zgelq2_work >+ i i i i *j i *j *j')&cd
LAPACKE_sgelqf_work=: (liblapacke,' LAPACKE_sgelqf_work >+ i i i i *f i *f *f i')&cd
LAPACKE_dgelqf_work=: (liblapacke,' LAPACKE_dgelqf_work >+ i i i i *d i *d *d i')&cd
LAPACKE_zgelqf_work=: (liblapacke,' LAPACKE_zgelqf_work >+ i i i i *j i *j *j i')&cd
LAPACKE_sgels_work=: (liblapacke,' LAPACKE_sgels_work >+ i i c i i i *f i *f i *f i')&cd
LAPACKE_dgels_work=: (liblapacke,' LAPACKE_dgels_work >+ i i c i i i *d i *d i *d i')&cd
LAPACKE_zgels_work=: (liblapacke,' LAPACKE_zgels_work >+ i i c i i i *j i *j i *j i')&cd
LAPACKE_sgelsd_work=: (liblapacke,' LAPACKE_sgelsd_work >+ i i i i i *f i *f i *f f *i *f i *i')&cd
LAPACKE_dgelsd_work=: (liblapacke,' LAPACKE_dgelsd_work >+ i i i i i *d i *d i *d d *i *d i *i')&cd
LAPACKE_zgelsd_work=: (liblapacke,' LAPACKE_zgelsd_work >+ i i i i i *j i *j i *d d *i *j i *d *i')&cd
LAPACKE_sgelss_work=: (liblapacke,' LAPACKE_sgelss_work >+ i i i i i *f i *f i *f f *i *f i')&cd
LAPACKE_dgelss_work=: (liblapacke,' LAPACKE_dgelss_work >+ i i i i i *d i *d i *d d *i *d i')&cd
LAPACKE_zgelss_work=: (liblapacke,' LAPACKE_zgelss_work >+ i i i i i *j i *j i *d d *i *j i *d')&cd
LAPACKE_sgelsy_work=: (liblapacke,' LAPACKE_sgelsy_work >+ i i i i i *f i *f i *i f *i *f i')&cd
LAPACKE_dgelsy_work=: (liblapacke,' LAPACKE_dgelsy_work >+ i i i i i *d i *d i *i d *i *d i')&cd
LAPACKE_zgelsy_work=: (liblapacke,' LAPACKE_zgelsy_work >+ i i i i i *j i *j i *i d *i *j i *d')&cd
LAPACKE_sgeqlf_work=: (liblapacke,' LAPACKE_sgeqlf_work >+ i i i i *f i *f *f i')&cd
LAPACKE_dgeqlf_work=: (liblapacke,' LAPACKE_dgeqlf_work >+ i i i i *d i *d *d i')&cd
LAPACKE_zgeqlf_work=: (liblapacke,' LAPACKE_zgeqlf_work >+ i i i i *j i *j *j i')&cd
LAPACKE_sgeqp3_work=: (liblapacke,' LAPACKE_sgeqp3_work >+ i i i i *f i *i *f *f i')&cd
LAPACKE_dgeqp3_work=: (liblapacke,' LAPACKE_dgeqp3_work >+ i i i i *d i *i *d *d i')&cd
LAPACKE_zgeqp3_work=: (liblapacke,' LAPACKE_zgeqp3_work >+ i i i i *j i *i *j *j i *d')&cd
LAPACKE_sgeqpf_work=: (liblapacke,' LAPACKE_sgeqpf_work >+ i i i i *f i *i *f *f')&cd
LAPACKE_dgeqpf_work=: (liblapacke,' LAPACKE_dgeqpf_work >+ i i i i *d i *i *d *d')&cd
LAPACKE_zgeqpf_work=: (liblapacke,' LAPACKE_zgeqpf_work >+ i i i i *j i *i *j *j *d')&cd
LAPACKE_sgeqr2_work=: (liblapacke,' LAPACKE_sgeqr2_work >+ i i i i *f i *f *f')&cd
LAPACKE_dgeqr2_work=: (liblapacke,' LAPACKE_dgeqr2_work >+ i i i i *d i *d *d')&cd
LAPACKE_zgeqr2_work=: (liblapacke,' LAPACKE_zgeqr2_work >+ i i i i *j i *j *j')&cd
LAPACKE_sgeqrf_work=: (liblapacke,' LAPACKE_sgeqrf_work >+ i i i i *f i *f *f i')&cd
LAPACKE_dgeqrf_work=: (liblapacke,' LAPACKE_dgeqrf_work >+ i i i i *d i *d *d i')&cd
LAPACKE_zgeqrf_work=: (liblapacke,' LAPACKE_zgeqrf_work >+ i i i i *j i *j *j i')&cd
LAPACKE_sgeqrfp_work=: (liblapacke,' LAPACKE_sgeqrfp_work >+ i i i i *f i *f *f i')&cd
LAPACKE_dgeqrfp_work=: (liblapacke,' LAPACKE_dgeqrfp_work >+ i i i i *d i *d *d i')&cd
LAPACKE_zgeqrfp_work=: (liblapacke,' LAPACKE_zgeqrfp_work >+ i i i i *j i *j *j i')&cd
LAPACKE_sgerfs_work=: (liblapacke,' LAPACKE_sgerfs_work >+ i i c i i *f i *f i *i *f i *f i *f *f *f *i')&cd
LAPACKE_dgerfs_work=: (liblapacke,' LAPACKE_dgerfs_work >+ i i c i i *d i *d i *i *d i *d i *d *d *d *i')&cd
LAPACKE_zgerfs_work=: (liblapacke,' LAPACKE_zgerfs_work >+ i i c i i *j i *j i *i *j i *j i *d *d *j *d')&cd
LAPACKE_sgerfsx_work=: (liblapacke,' LAPACKE_sgerfsx_work >+ i i c c i i *f i *f i *i *f *f *f i *f i *f *f i *f *f i *f *f *i')&cd
LAPACKE_dgerfsx_work=: (liblapacke,' LAPACKE_dgerfsx_work >+ i i c c i i *d i *d i *i *d *d *d i *d i *d *d i *d *d i *d *d *i')&cd
LAPACKE_zgerfsx_work=: (liblapacke,' LAPACKE_zgerfsx_work >+ i i c c i i *j i *j i *i *d *d *j i *j i *d *d i *d *d i *d *j *d')&cd
LAPACKE_sgerqf_work=: (liblapacke,' LAPACKE_sgerqf_work >+ i i i i *f i *f *f i')&cd
LAPACKE_dgerqf_work=: (liblapacke,' LAPACKE_dgerqf_work >+ i i i i *d i *d *d i')&cd
LAPACKE_zgerqf_work=: (liblapacke,' LAPACKE_zgerqf_work >+ i i i i *j i *j *j i')&cd
LAPACKE_sgesdd_work=: (liblapacke,' LAPACKE_sgesdd_work >+ i i c i i *f i *f *f i *f i *f i *i')&cd
LAPACKE_dgesdd_work=: (liblapacke,' LAPACKE_dgesdd_work >+ i i c i i *d i *d *d i *d i *d i *i')&cd
LAPACKE_zgesdd_work=: (liblapacke,' LAPACKE_zgesdd_work >+ i i c i i *j i *d *j i *j i *j i *d *i')&cd
LAPACKE_sgesv_work=: (liblapacke,' LAPACKE_sgesv_work >+ i i i i *f i *i *f i')&cd
LAPACKE_dgesv_work=: (liblapacke,' LAPACKE_dgesv_work >+ i i i i *d i *i *d i')&cd
LAPACKE_zgesv_work=: (liblapacke,' LAPACKE_zgesv_work >+ i i i i *j i *i *j i')&cd
LAPACKE_dsgesv_work=: (liblapacke,' LAPACKE_dsgesv_work >+ i i i i *d i *i *d i *d i *d *f *i')&cd
LAPACKE_sgesvd_work=: (liblapacke,' LAPACKE_sgesvd_work >+ i i c c i i *f i *f *f i *f i *f i')&cd
LAPACKE_dgesvd_work=: (liblapacke,' LAPACKE_dgesvd_work >+ i i c c i i *d i *d *d i *d i *d i')&cd
LAPACKE_zgesvd_work=: (liblapacke,' LAPACKE_zgesvd_work >+ i i c c i i *j i *d *j i *j i *j i *d')&cd
LAPACKE_sgesvj_work=: (liblapacke,' LAPACKE_sgesvj_work >+ i i c c c i i *f i *f i *f i *f i')&cd
LAPACKE_dgesvj_work=: (liblapacke,' LAPACKE_dgesvj_work >+ i i c c c i i *d i *d i *d i *d i')&cd
LAPACKE_sgesvx_work=: (liblapacke,' LAPACKE_sgesvx_work >+ i i c c i i *f i *f i *i *c *f *f *f i *f i *f *f *f *f *i')&cd
LAPACKE_dgesvx_work=: (liblapacke,' LAPACKE_dgesvx_work >+ i i c c i i *d i *d i *i *c *d *d *d i *d i *d *d *d *d *i')&cd
LAPACKE_zgesvx_work=: (liblapacke,' LAPACKE_zgesvx_work >+ i i c c i i *j i *j i *i *c *d *d *j i *j i *d *d *d *j *d')&cd
LAPACKE_sgesvxx_work=: (liblapacke,' LAPACKE_sgesvxx_work >+ i i c c i i *f i *f i *i *c *f *f *f i *f i *f *f *f i *f *f i *f *f *i')&cd
LAPACKE_dgesvxx_work=: (liblapacke,' LAPACKE_dgesvxx_work >+ i i c c i i *d i *d i *i *c *d *d *d i *d i *d *d *d i *d *d i *d *d *i')&cd
LAPACKE_zgesvxx_work=: (liblapacke,' LAPACKE_zgesvxx_work >+ i i c c i i *j i *j i *i *c *d *d *j i *j i *d *d *d i *d *d i *d *j *d')&cd
LAPACKE_sgetf2_work=: (liblapacke,' LAPACKE_sgetf2_work >+ i i i i *f i *i')&cd
LAPACKE_dgetf2_work=: (liblapacke,' LAPACKE_dgetf2_work >+ i i i i *d i *i')&cd
LAPACKE_zgetf2_work=: (liblapacke,' LAPACKE_zgetf2_work >+ i i i i *j i *i')&cd
LAPACKE_sgetrf_work=: (liblapacke,' LAPACKE_sgetrf_work >+ i i i i *f i *i')&cd
LAPACKE_dgetrf_work=: (liblapacke,' LAPACKE_dgetrf_work >+ i i i i *d i *i')&cd
LAPACKE_zgetrf_work=: (liblapacke,' LAPACKE_zgetrf_work >+ i i i i *j i *i')&cd
LAPACKE_sgetri_work=: (liblapacke,' LAPACKE_sgetri_work >+ i i i *f i *i *f i')&cd
LAPACKE_dgetri_work=: (liblapacke,' LAPACKE_dgetri_work >+ i i i *d i *i *d i')&cd
LAPACKE_zgetri_work=: (liblapacke,' LAPACKE_zgetri_work >+ i i i *j i *i *j i')&cd
LAPACKE_sgetrs_work=: (liblapacke,' LAPACKE_sgetrs_work >+ i i c i i *f i *i *f i')&cd
LAPACKE_dgetrs_work=: (liblapacke,' LAPACKE_dgetrs_work >+ i i c i i *d i *i *d i')&cd
LAPACKE_zgetrs_work=: (liblapacke,' LAPACKE_zgetrs_work >+ i i c i i *j i *i *j i')&cd
LAPACKE_sggbak_work=: (liblapacke,' LAPACKE_sggbak_work >+ i i c c i i i *f *f i *f i')&cd
LAPACKE_dggbak_work=: (liblapacke,' LAPACKE_dggbak_work >+ i i c c i i i *d *d i *d i')&cd
LAPACKE_zggbak_work=: (liblapacke,' LAPACKE_zggbak_work >+ i i c c i i i *d *d i *j i')&cd
LAPACKE_sggbal_work=: (liblapacke,' LAPACKE_sggbal_work >+ i i c i *f i *f i *i *i *f *f *f')&cd
LAPACKE_dggbal_work=: (liblapacke,' LAPACKE_dggbal_work >+ i i c i *d i *d i *i *i *d *d *d')&cd
LAPACKE_zggbal_work=: (liblapacke,' LAPACKE_zggbal_work >+ i i c i *j i *j i *i *i *d *d *d')&cd
LAPACKE_sgges_work=: (liblapacke,' LAPACKE_sgges_work >+ i i c c c x i *f i *f i *i *f *f *f *f i *f i *f i *i')&cd
LAPACKE_dgges_work=: (liblapacke,' LAPACKE_dgges_work >+ i i c c c x i *d i *d i *i *d *d *d *d i *d i *d i *i')&cd
LAPACKE_zgges_work=: (liblapacke,' LAPACKE_zgges_work >+ i i c c c x i *j i *j i *i *j *j *j i *j i *j i *d *i')&cd
LAPACKE_sggesx_work=: (liblapacke,' LAPACKE_sggesx_work >+ i i c c c x c i *f i *f i *i *f *f *f *f i *f i *f *f *f i *i i *i')&cd
LAPACKE_dggesx_work=: (liblapacke,' LAPACKE_dggesx_work >+ i i c c c x c i *d i *d i *i *d *d *d *d i *d i *d *d *d i *i i *i')&cd
LAPACKE_zggesx_work=: (liblapacke,' LAPACKE_zggesx_work >+ i i c c c x c i *j i *j i *i *j *j *j i *j i *d *d *j i *d *i i *i')&cd
LAPACKE_sggev_work=: (liblapacke,' LAPACKE_sggev_work >+ i i c c i *f i *f i *f *f *f *f i *f i *f i')&cd
LAPACKE_dggev_work=: (liblapacke,' LAPACKE_dggev_work >+ i i c c i *d i *d i *d *d *d *d i *d i *d i')&cd
LAPACKE_zggev_work=: (liblapacke,' LAPACKE_zggev_work >+ i i c c i *j i *j i *j *j *j i *j i *j i *d')&cd
LAPACKE_sggevx_work=: (liblapacke,' LAPACKE_sggevx_work >+ i i c c c c i *f i *f i *f *f *f *f i *f i *i *i *f *f *f *f *f *f *f i *i *i')&cd
LAPACKE_dggevx_work=: (liblapacke,' LAPACKE_dggevx_work >+ i i c c c c i *d i *d i *d *d *d *d i *d i *i *i *d *d *d *d *d *d *d i *i *i')&cd
LAPACKE_zggevx_work=: (liblapacke,' LAPACKE_zggevx_work >+ i i c c c c i *j i *j i *j *j *j i *j i *i *i *d *d *d *d *d *d *j i *d *i *i')&cd
LAPACKE_sggglm_work=: (liblapacke,' LAPACKE_sggglm_work >+ i i i i i *f i *f i *f *f *f *f i')&cd
LAPACKE_dggglm_work=: (liblapacke,' LAPACKE_dggglm_work >+ i i i i i *d i *d i *d *d *d *d i')&cd
LAPACKE_zggglm_work=: (liblapacke,' LAPACKE_zggglm_work >+ i i i i i *j i *j i *j *j *j *j i')&cd
LAPACKE_sgghrd_work=: (liblapacke,' LAPACKE_sgghrd_work >+ i i c c i i i *f i *f i *f i *f i')&cd
LAPACKE_dgghrd_work=: (liblapacke,' LAPACKE_dgghrd_work >+ i i c c i i i *d i *d i *d i *d i')&cd
LAPACKE_zgghrd_work=: (liblapacke,' LAPACKE_zgghrd_work >+ i i c c i i i *j i *j i *j i *j i')&cd
LAPACKE_sgglse_work=: (liblapacke,' LAPACKE_sgglse_work >+ i i i i i *f i *f i *f *f *f *f i')&cd
LAPACKE_dgglse_work=: (liblapacke,' LAPACKE_dgglse_work >+ i i i i i *d i *d i *d *d *d *d i')&cd
LAPACKE_zgglse_work=: (liblapacke,' LAPACKE_zgglse_work >+ i i i i i *j i *j i *j *j *j *j i')&cd
LAPACKE_sggqrf_work=: (liblapacke,' LAPACKE_sggqrf_work >+ i i i i i *f i *f *f i *f *f i')&cd
LAPACKE_dggqrf_work=: (liblapacke,' LAPACKE_dggqrf_work >+ i i i i i *d i *d *d i *d *d i')&cd
LAPACKE_zggqrf_work=: (liblapacke,' LAPACKE_zggqrf_work >+ i i i i i *j i *j *j i *j *j i')&cd
LAPACKE_sggrqf_work=: (liblapacke,' LAPACKE_sggrqf_work >+ i i i i i *f i *f *f i *f *f i')&cd
LAPACKE_dggrqf_work=: (liblapacke,' LAPACKE_dggrqf_work >+ i i i i i *d i *d *d i *d *d i')&cd
LAPACKE_zggrqf_work=: (liblapacke,' LAPACKE_zggrqf_work >+ i i i i i *j i *j *j i *j *j i')&cd
LAPACKE_sggsvd_work=: (liblapacke,' LAPACKE_sggsvd_work >+ i i c c c i i i *i *i *f i *f i *f *f *f i *f i *f i *f *i')&cd
LAPACKE_dggsvd_work=: (liblapacke,' LAPACKE_dggsvd_work >+ i i c c c i i i *i *i *d i *d i *d *d *d i *d i *d i *d *i')&cd
LAPACKE_zggsvd_work=: (liblapacke,' LAPACKE_zggsvd_work >+ i i c c c i i i *i *i *j i *j i *d *d *j i *j i *j i *j *d *i')&cd
LAPACKE_sggsvp_work=: (liblapacke,' LAPACKE_sggsvp_work >+ i i c c c i i i *f i *f i f f *i *i *f i *f i *f i *i *f *f')&cd
LAPACKE_dggsvp_work=: (liblapacke,' LAPACKE_dggsvp_work >+ i i c c c i i i *d i *d i d d *i *i *d i *d i *d i *i *d *d')&cd
LAPACKE_zggsvp_work=: (liblapacke,' LAPACKE_zggsvp_work >+ i i c c c i i i *j i *j i d d *i *i *j i *j i *j i *i *d *j *j')&cd
LAPACKE_sgtcon_work=: (liblapacke,' LAPACKE_sgtcon_work >+ i c i *f *f *f *f *i f *f *f *i')&cd
LAPACKE_dgtcon_work=: (liblapacke,' LAPACKE_dgtcon_work >+ i c i *d *d *d *d *i d *d *d *i')&cd
LAPACKE_zgtcon_work=: (liblapacke,' LAPACKE_zgtcon_work >+ i c i *j *j *j *j *i d *d *j')&cd
LAPACKE_sgtrfs_work=: (liblapacke,' LAPACKE_sgtrfs_work >+ i i c i i *f *f *f *f *f *f *f *i *f i *f i *f *f *f *i')&cd
LAPACKE_dgtrfs_work=: (liblapacke,' LAPACKE_dgtrfs_work >+ i i c i i *d *d *d *d *d *d *d *i *d i *d i *d *d *d *i')&cd
LAPACKE_zgtrfs_work=: (liblapacke,' LAPACKE_zgtrfs_work >+ i i c i i *j *j *j *j *j *j *j *i *j i *j i *d *d *j *d')&cd
LAPACKE_sgtsv_work=: (liblapacke,' LAPACKE_sgtsv_work >+ i i i i *f *f *f *f i')&cd
LAPACKE_dgtsv_work=: (liblapacke,' LAPACKE_dgtsv_work >+ i i i i *d *d *d *d i')&cd
LAPACKE_zgtsv_work=: (liblapacke,' LAPACKE_zgtsv_work >+ i i i i *j *j *j *j i')&cd
LAPACKE_sgtsvx_work=: (liblapacke,' LAPACKE_sgtsvx_work >+ i i c c i i *f *f *f *f *f *f *f *i *f i *f i *f *f *f *f *i')&cd
LAPACKE_dgtsvx_work=: (liblapacke,' LAPACKE_dgtsvx_work >+ i i c c i i *d *d *d *d *d *d *d *i *d i *d i *d *d *d *d *i')&cd
LAPACKE_zgtsvx_work=: (liblapacke,' LAPACKE_zgtsvx_work >+ i i c c i i *j *j *j *j *j *j *j *i *j i *j i *d *d *d *j *d')&cd
LAPACKE_sgttrf_work=: (liblapacke,' LAPACKE_sgttrf_work >+ i i *f *f *f *f *i')&cd
LAPACKE_dgttrf_work=: (liblapacke,' LAPACKE_dgttrf_work >+ i i *d *d *d *d *i')&cd
LAPACKE_zgttrf_work=: (liblapacke,' LAPACKE_zgttrf_work >+ i i *j *j *j *j *i')&cd
LAPACKE_sgttrs_work=: (liblapacke,' LAPACKE_sgttrs_work >+ i i c i i *f *f *f *f *i *f i')&cd
LAPACKE_dgttrs_work=: (liblapacke,' LAPACKE_dgttrs_work >+ i i c i i *d *d *d *d *i *d i')&cd
LAPACKE_zgttrs_work=: (liblapacke,' LAPACKE_zgttrs_work >+ i i c i i *j *j *j *j *i *j i')&cd
LAPACKE_zhbev_work=: (liblapacke,' LAPACKE_zhbev_work >+ i i c c i i *j i *d *j i *j *d')&cd
LAPACKE_zhbevd_work=: (liblapacke,' LAPACKE_zhbevd_work >+ i i c c i i *j i *d *j i *j i *d i *i i')&cd
LAPACKE_zhbevx_work=: (liblapacke,' LAPACKE_zhbevx_work >+ i i c c c i i *j i *j i d d i i d *i *d *j i *j *d *i *i')&cd
LAPACKE_zhbgst_work=: (liblapacke,' LAPACKE_zhbgst_work >+ i i c c i i i *j i *j i *j i *j *d')&cd
LAPACKE_zhbgv_work=: (liblapacke,' LAPACKE_zhbgv_work >+ i i c c i i i *j i *j i *d *j i *j *d')&cd
LAPACKE_zhbgvd_work=: (liblapacke,' LAPACKE_zhbgvd_work >+ i i c c i i i *j i *j i *d *j i *j i *d i *i i')&cd
LAPACKE_zhbgvx_work=: (liblapacke,' LAPACKE_zhbgvx_work >+ i i c c c i i i *j i *j i *j i d d i i d *i *d *j i *j *d *i *i')&cd
LAPACKE_zhbtrd_work=: (liblapacke,' LAPACKE_zhbtrd_work >+ i i c c i i *j i *d *d *j i *j')&cd
LAPACKE_zhecon_work=: (liblapacke,' LAPACKE_zhecon_work >+ i i c i *j i *i d *d *j')&cd
LAPACKE_zheequb_work=: (liblapacke,' LAPACKE_zheequb_work >+ i i c i *j i *d *d *d *j')&cd
LAPACKE_zheev_work=: (liblapacke,' LAPACKE_zheev_work >+ i i c c i *j i *d *j i *d')&cd
LAPACKE_zheevd_work=: (liblapacke,' LAPACKE_zheevd_work >+ i i c c i *j i *d *j i *d i *i i')&cd
LAPACKE_zheevr_work=: (liblapacke,' LAPACKE_zheevr_work >+ i i c c c i *j i d d i i d *i *d *j i *i *j i *d i *i i')&cd
LAPACKE_zheevx_work=: (liblapacke,' LAPACKE_zheevx_work >+ i i c c c i *j i d d i i d *i *d *j i *j i *d *i *i')&cd
LAPACKE_zhegst_work=: (liblapacke,' LAPACKE_zhegst_work >+ i i i c i *j i *j i')&cd
LAPACKE_zhegv_work=: (liblapacke,' LAPACKE_zhegv_work >+ i i i c c i *j i *j i *d *j i *d')&cd
LAPACKE_zhegvd_work=: (liblapacke,' LAPACKE_zhegvd_work >+ i i i c c i *j i *j i *d *j i *d i *i i')&cd
LAPACKE_zhegvx_work=: (liblapacke,' LAPACKE_zhegvx_work >+ i i i c c c i *j i *j i d d i i d *i *d *j i *j i *d *i *i')&cd
LAPACKE_zherfs_work=: (liblapacke,' LAPACKE_zherfs_work >+ i i c i i *j i *j i *i *j i *j i *d *d *j *d')&cd
LAPACKE_zherfsx_work=: (liblapacke,' LAPACKE_zherfsx_work >+ i i c c i i *j i *j i *i *d *j i *j i *d *d i *d *d i *d *j *d')&cd
LAPACKE_zhesv_work=: (liblapacke,' LAPACKE_zhesv_work >+ i i c i i *j i *i *j i *j i')&cd
LAPACKE_zhesvx_work=: (liblapacke,' LAPACKE_zhesvx_work >+ i i c c i i *j i *j i *i *j i *j i *d *d *d *j i *d')&cd
LAPACKE_zhesvxx_work=: (liblapacke,' LAPACKE_zhesvxx_work >+ i i c c i i *j i *j i *i *c *d *j i *j i *d *d *d i *d *d i *d *j *d')&cd
LAPACKE_zhetrd_work=: (liblapacke,' LAPACKE_zhetrd_work >+ i i c i *j i *d *d *j *j i')&cd
LAPACKE_zhetrf_work=: (liblapacke,' LAPACKE_zhetrf_work >+ i i c i *j i *i *j i')&cd
LAPACKE_zhetri_work=: (liblapacke,' LAPACKE_zhetri_work >+ i i c i *j i *i *j')&cd
LAPACKE_zhetrs_work=: (liblapacke,' LAPACKE_zhetrs_work >+ i i c i i *j i *i *j i')&cd
LAPACKE_zhfrk_work=: (liblapacke,' LAPACKE_zhfrk_work >+ i i c c c i i d *j i d *j')&cd
LAPACKE_shgeqz_work=: (liblapacke,' LAPACKE_shgeqz_work >+ i i c c c i i i *f i *f i *f *f *f *f i *f i *f i')&cd
LAPACKE_dhgeqz_work=: (liblapacke,' LAPACKE_dhgeqz_work >+ i i c c c i i i *d i *d i *d *d *d *d i *d i *d i')&cd
LAPACKE_zhgeqz_work=: (liblapacke,' LAPACKE_zhgeqz_work >+ i i c c c i i i *j i *j i *j *j *j i *j i *j i *d')&cd
LAPACKE_zhpcon_work=: (liblapacke,' LAPACKE_zhpcon_work >+ i i c i *j *i d *d *j')&cd
LAPACKE_zhpev_work=: (liblapacke,' LAPACKE_zhpev_work >+ i i c c i *j *d *j i *j *d')&cd
LAPACKE_zhpevd_work=: (liblapacke,' LAPACKE_zhpevd_work >+ i i c c i *j *d *j i *j i *d i *i i')&cd
LAPACKE_zhpevx_work=: (liblapacke,' LAPACKE_zhpevx_work >+ i i c c c i *j d d i i d *i *d *j i *j *d *i *i')&cd
LAPACKE_zhpgst_work=: (liblapacke,' LAPACKE_zhpgst_work >+ i i i c i *j *j')&cd
LAPACKE_zhpgv_work=: (liblapacke,' LAPACKE_zhpgv_work >+ i i i c c i *j *j *d *j i *j *d')&cd
LAPACKE_zhpgvd_work=: (liblapacke,' LAPACKE_zhpgvd_work >+ i i i c c i *j *j *d *j i *j i *d i *i i')&cd
LAPACKE_zhpgvx_work=: (liblapacke,' LAPACKE_zhpgvx_work >+ i i i c c c i *j *j d d i i d *i *d *j i *j *d *i *i')&cd
LAPACKE_zhprfs_work=: (liblapacke,' LAPACKE_zhprfs_work >+ i i c i i *j *j *i *j i *j i *d *d *j *d')&cd
LAPACKE_zhpsv_work=: (liblapacke,' LAPACKE_zhpsv_work >+ i i c i i *j *i *j i')&cd
LAPACKE_zhpsvx_work=: (liblapacke,' LAPACKE_zhpsvx_work >+ i i c c i i *j *j *i *j i *j i *d *d *d *j *d')&cd
LAPACKE_zhptrd_work=: (liblapacke,' LAPACKE_zhptrd_work >+ i i c i *j *d *d *j')&cd
LAPACKE_zhptrf_work=: (liblapacke,' LAPACKE_zhptrf_work >+ i i c i *j *i')&cd
LAPACKE_zhptri_work=: (liblapacke,' LAPACKE_zhptri_work >+ i i c i *j *i *j')&cd
LAPACKE_zhptrs_work=: (liblapacke,' LAPACKE_zhptrs_work >+ i i c i i *j *i *j i')&cd
LAPACKE_shsein_work=: (liblapacke,' LAPACKE_shsein_work >+ i i c c c *i i *f i *f *f *f i *f i i *i *f *i *i')&cd
LAPACKE_dhsein_work=: (liblapacke,' LAPACKE_dhsein_work >+ i i c c c *i i *d i *d *d *d i *d i i *i *d *i *i')&cd
LAPACKE_zhsein_work=: (liblapacke,' LAPACKE_zhsein_work >+ i i c c c *i i *j i *j *j i *j i i *i *j *d *i *i')&cd
LAPACKE_shseqr_work=: (liblapacke,' LAPACKE_shseqr_work >+ i i c c i i i *f i *f *f *f i *f i')&cd
LAPACKE_dhseqr_work=: (liblapacke,' LAPACKE_dhseqr_work >+ i i c c i i i *d i *d *d *d i *d i')&cd
LAPACKE_zhseqr_work=: (liblapacke,' LAPACKE_zhseqr_work >+ i i c c i i i *j i *j *j i *j i')&cd
LAPACKE_zlacgv_work=: (liblapacke,' LAPACKE_zlacgv_work >+ i i *j i')&cd
LAPACKE_slacpy_work=: (liblapacke,' LAPACKE_slacpy_work >+ i i c i i *f i *f i')&cd
LAPACKE_dlacpy_work=: (liblapacke,' LAPACKE_dlacpy_work >+ i i c i i *d i *d i')&cd
LAPACKE_zlacpy_work=: (liblapacke,' LAPACKE_zlacpy_work >+ i i c i i *j i *j i')&cd
LAPACKE_slag2d_work=: (liblapacke,' LAPACKE_slag2d_work >+ i i i i *f i *d i')&cd
LAPACKE_dlag2s_work=: (liblapacke,' LAPACKE_dlag2s_work >+ i i i i *d i *f i')&cd
LAPACKE_slagge_work=: (liblapacke,' LAPACKE_slagge_work >+ i i i i i i *f *f i *i *f')&cd
LAPACKE_dlagge_work=: (liblapacke,' LAPACKE_dlagge_work >+ i i i i i i *d *d i *i *d')&cd
LAPACKE_zlagge_work=: (liblapacke,' LAPACKE_zlagge_work >+ i i i i i i *d *j i *i *j')&cd
LAPACKE_zlaghe_work=: (liblapacke,' LAPACKE_zlaghe_work >+ i i i i *d *j i *i *j')&cd
LAPACKE_slagsy_work=: (liblapacke,' LAPACKE_slagsy_work >+ i i i i *f *f i *i *f')&cd
LAPACKE_dlagsy_work=: (liblapacke,' LAPACKE_dlagsy_work >+ i i i i *d *d i *i *d')&cd
LAPACKE_zlagsy_work=: (liblapacke,' LAPACKE_zlagsy_work >+ i i i i *d *j i *i *j')&cd
LAPACKE_slapmr_work=: (liblapacke,' LAPACKE_slapmr_work >+ i i i i i *f i *i')&cd
LAPACKE_dlapmr_work=: (liblapacke,' LAPACKE_dlapmr_work >+ i i i i i *d i *i')&cd
LAPACKE_zlapmr_work=: (liblapacke,' LAPACKE_zlapmr_work >+ i i i i i *j i *i')&cd
LAPACKE_slartgp_work=: (liblapacke,' LAPACKE_slartgp_work >+ i f f *f *f *f')&cd
LAPACKE_dlartgp_work=: (liblapacke,' LAPACKE_dlartgp_work >+ i d d *d *d *d')&cd
LAPACKE_slartgs_work=: (liblapacke,' LAPACKE_slartgs_work >+ i f f f *f *f')&cd
LAPACKE_dlartgs_work=: (liblapacke,' LAPACKE_dlartgs_work >+ i d d d *d *d')&cd
LAPACKE_slapy2_work=: (liblapacke,' LAPACKE_slapy2_work >+ f f f')&cd
LAPACKE_dlapy2_work=: (liblapacke,' LAPACKE_dlapy2_work >+ d d d')&cd
LAPACKE_slapy3_work=: (liblapacke,' LAPACKE_slapy3_work >+ f f f f')&cd
LAPACKE_dlapy3_work=: (liblapacke,' LAPACKE_dlapy3_work >+ d d d d')&cd
LAPACKE_slamch_work=: (liblapacke,' LAPACKE_slamch_work >+ f c')&cd
LAPACKE_dlamch_work=: (liblapacke,' LAPACKE_dlamch_work >+ d c')&cd
LAPACKE_slange_work=: (liblapacke,' LAPACKE_slange_work >+ f i c i i *f i *f')&cd
LAPACKE_dlange_work=: (liblapacke,' LAPACKE_dlange_work >+ d i c i i *d i *d')&cd
LAPACKE_zlange_work=: (liblapacke,' LAPACKE_zlange_work >+ d i c i i *j i *d')&cd
LAPACKE_zlanhe_work=: (liblapacke,' LAPACKE_zlanhe_work >+ d i c c i *j i *d')&cd
LAPACKE_slansy_work=: (liblapacke,' LAPACKE_slansy_work >+ f i c c i *f i *f')&cd
LAPACKE_dlansy_work=: (liblapacke,' LAPACKE_dlansy_work >+ d i c c i *d i *d')&cd
LAPACKE_zlansy_work=: (liblapacke,' LAPACKE_zlansy_work >+ d i c c i *j i *d')&cd
LAPACKE_slantr_work=: (liblapacke,' LAPACKE_slantr_work >+ f i c c c i i *f i *f')&cd
LAPACKE_dlantr_work=: (liblapacke,' LAPACKE_dlantr_work >+ d i c c c i i *d i *d')&cd
LAPACKE_zlantr_work=: (liblapacke,' LAPACKE_zlantr_work >+ d i c c c i i *j i *d')&cd
LAPACKE_slarfb_work=: (liblapacke,' LAPACKE_slarfb_work >+ i i c c c c i i i *f i *f i *f i *f i')&cd
LAPACKE_dlarfb_work=: (liblapacke,' LAPACKE_dlarfb_work >+ i i c c c c i i i *d i *d i *d i *d i')&cd
LAPACKE_zlarfb_work=: (liblapacke,' LAPACKE_zlarfb_work >+ i i c c c c i i i *j i *j i *j i *j i')&cd
LAPACKE_slarfg_work=: (liblapacke,' LAPACKE_slarfg_work >+ i i *f *f i *f')&cd
LAPACKE_dlarfg_work=: (liblapacke,' LAPACKE_dlarfg_work >+ i i *d *d i *d')&cd
LAPACKE_zlarfg_work=: (liblapacke,' LAPACKE_zlarfg_work >+ i i *j *j i *j')&cd
LAPACKE_slarft_work=: (liblapacke,' LAPACKE_slarft_work >+ i i c c i i *f i *f *f i')&cd
LAPACKE_dlarft_work=: (liblapacke,' LAPACKE_dlarft_work >+ i i c c i i *d i *d *d i')&cd
LAPACKE_zlarft_work=: (liblapacke,' LAPACKE_zlarft_work >+ i i c c i i *j i *j *j i')&cd
LAPACKE_slarfx_work=: (liblapacke,' LAPACKE_slarfx_work >+ i i c i i *f f *f i *f')&cd
LAPACKE_dlarfx_work=: (liblapacke,' LAPACKE_dlarfx_work >+ i i c i i *d d *d i *d')&cd
LAPACKE_zlarfx_work=: (liblapacke,' LAPACKE_zlarfx_work >+ i i c i i *j j *j i *j')&cd
LAPACKE_slarnv_work=: (liblapacke,' LAPACKE_slarnv_work >+ i i *i i *f')&cd
LAPACKE_dlarnv_work=: (liblapacke,' LAPACKE_dlarnv_work >+ i i *i i *d')&cd
LAPACKE_zlarnv_work=: (liblapacke,' LAPACKE_zlarnv_work >+ i i *i i *j')&cd
LAPACKE_slaset_work=: (liblapacke,' LAPACKE_slaset_work >+ i i c i i f f *f i')&cd
LAPACKE_dlaset_work=: (liblapacke,' LAPACKE_dlaset_work >+ i i c i i d d *d i')&cd
LAPACKE_zlaset_work=: (liblapacke,' LAPACKE_zlaset_work >+ i i c i i j j *j i')&cd
LAPACKE_slasrt_work=: (liblapacke,' LAPACKE_slasrt_work >+ i c i *f')&cd
LAPACKE_dlasrt_work=: (liblapacke,' LAPACKE_dlasrt_work >+ i c i *d')&cd
LAPACKE_slaswp_work=: (liblapacke,' LAPACKE_slaswp_work >+ i i i *f i i i *i i')&cd
LAPACKE_dlaswp_work=: (liblapacke,' LAPACKE_dlaswp_work >+ i i i *d i i i *i i')&cd
LAPACKE_zlaswp_work=: (liblapacke,' LAPACKE_zlaswp_work >+ i i i *j i i i *i i')&cd
LAPACKE_slatms_work=: (liblapacke,' LAPACKE_slatms_work >+ i i i i c *i c *f i f f i i c *f i *f')&cd
LAPACKE_dlatms_work=: (liblapacke,' LAPACKE_dlatms_work >+ i i i i c *i c *d i d d i i c *d i *d')&cd
LAPACKE_zlatms_work=: (liblapacke,' LAPACKE_zlatms_work >+ i i i i c *i c *d i d d i i c *j i *j')&cd
LAPACKE_slauum_work=: (liblapacke,' LAPACKE_slauum_work >+ i i c i *f i')&cd
LAPACKE_dlauum_work=: (liblapacke,' LAPACKE_dlauum_work >+ i i c i *d i')&cd
LAPACKE_zlauum_work=: (liblapacke,' LAPACKE_zlauum_work >+ i i c i *j i')&cd
LAPACKE_sopgtr_work=: (liblapacke,' LAPACKE_sopgtr_work >+ i i c i *f *f *f i *f')&cd
LAPACKE_dopgtr_work=: (liblapacke,' LAPACKE_dopgtr_work >+ i i c i *d *d *d i *d')&cd
LAPACKE_sopmtr_work=: (liblapacke,' LAPACKE_sopmtr_work >+ i i c c c i i *f *f *f i *f')&cd
LAPACKE_dopmtr_work=: (liblapacke,' LAPACKE_dopmtr_work >+ i i c c c i i *d *d *d i *d')&cd
LAPACKE_sorgbr_work=: (liblapacke,' LAPACKE_sorgbr_work >+ i i c i i i *f i *f *f i')&cd
LAPACKE_dorgbr_work=: (liblapacke,' LAPACKE_dorgbr_work >+ i i c i i i *d i *d *d i')&cd
LAPACKE_sorghr_work=: (liblapacke,' LAPACKE_sorghr_work >+ i i i i i *f i *f *f i')&cd
LAPACKE_dorghr_work=: (liblapacke,' LAPACKE_dorghr_work >+ i i i i i *d i *d *d i')&cd
LAPACKE_sorglq_work=: (liblapacke,' LAPACKE_sorglq_work >+ i i i i i *f i *f *f i')&cd
LAPACKE_dorglq_work=: (liblapacke,' LAPACKE_dorglq_work >+ i i i i i *d i *d *d i')&cd
LAPACKE_sorgql_work=: (liblapacke,' LAPACKE_sorgql_work >+ i i i i i *f i *f *f i')&cd
LAPACKE_dorgql_work=: (liblapacke,' LAPACKE_dorgql_work >+ i i i i i *d i *d *d i')&cd
LAPACKE_sorgqr_work=: (liblapacke,' LAPACKE_sorgqr_work >+ i i i i i *f i *f *f i')&cd
LAPACKE_dorgqr_work=: (liblapacke,' LAPACKE_dorgqr_work >+ i i i i i *d i *d *d i')&cd
LAPACKE_sorgrq_work=: (liblapacke,' LAPACKE_sorgrq_work >+ i i i i i *f i *f *f i')&cd
LAPACKE_dorgrq_work=: (liblapacke,' LAPACKE_dorgrq_work >+ i i i i i *d i *d *d i')&cd
LAPACKE_sorgtr_work=: (liblapacke,' LAPACKE_sorgtr_work >+ i i c i *f i *f *f i')&cd
LAPACKE_dorgtr_work=: (liblapacke,' LAPACKE_dorgtr_work >+ i i c i *d i *d *d i')&cd
LAPACKE_sormbr_work=: (liblapacke,' LAPACKE_sormbr_work >+ i i c c c i i i *f i *f *f i *f i')&cd
LAPACKE_dormbr_work=: (liblapacke,' LAPACKE_dormbr_work >+ i i c c c i i i *d i *d *d i *d i')&cd
LAPACKE_sormhr_work=: (liblapacke,' LAPACKE_sormhr_work >+ i i c c i i i i *f i *f *f i *f i')&cd
LAPACKE_dormhr_work=: (liblapacke,' LAPACKE_dormhr_work >+ i i c c i i i i *d i *d *d i *d i')&cd
LAPACKE_sormlq_work=: (liblapacke,' LAPACKE_sormlq_work >+ i i c c i i i *f i *f *f i *f i')&cd
LAPACKE_dormlq_work=: (liblapacke,' LAPACKE_dormlq_work >+ i i c c i i i *d i *d *d i *d i')&cd
LAPACKE_sormql_work=: (liblapacke,' LAPACKE_sormql_work >+ i i c c i i i *f i *f *f i *f i')&cd
LAPACKE_dormql_work=: (liblapacke,' LAPACKE_dormql_work >+ i i c c i i i *d i *d *d i *d i')&cd
LAPACKE_sormqr_work=: (liblapacke,' LAPACKE_sormqr_work >+ i i c c i i i *f i *f *f i *f i')&cd
LAPACKE_dormqr_work=: (liblapacke,' LAPACKE_dormqr_work >+ i i c c i i i *d i *d *d i *d i')&cd
LAPACKE_sormrq_work=: (liblapacke,' LAPACKE_sormrq_work >+ i i c c i i i *f i *f *f i *f i')&cd
LAPACKE_dormrq_work=: (liblapacke,' LAPACKE_dormrq_work >+ i i c c i i i *d i *d *d i *d i')&cd
LAPACKE_sormrz_work=: (liblapacke,' LAPACKE_sormrz_work >+ i i c c i i i i *f i *f *f i *f i')&cd
LAPACKE_dormrz_work=: (liblapacke,' LAPACKE_dormrz_work >+ i i c c i i i i *d i *d *d i *d i')&cd
LAPACKE_sormtr_work=: (liblapacke,' LAPACKE_sormtr_work >+ i i c c c i i *f i *f *f i *f i')&cd
LAPACKE_dormtr_work=: (liblapacke,' LAPACKE_dormtr_work >+ i i c c c i i *d i *d *d i *d i')&cd
LAPACKE_spbcon_work=: (liblapacke,' LAPACKE_spbcon_work >+ i i c i i *f i f *f *f *i')&cd
LAPACKE_dpbcon_work=: (liblapacke,' LAPACKE_dpbcon_work >+ i i c i i *d i d *d *d *i')&cd
LAPACKE_zpbcon_work=: (liblapacke,' LAPACKE_zpbcon_work >+ i i c i i *j i d *d *j *d')&cd
LAPACKE_spbequ_work=: (liblapacke,' LAPACKE_spbequ_work >+ i i c i i *f i *f *f *f')&cd
LAPACKE_dpbequ_work=: (liblapacke,' LAPACKE_dpbequ_work >+ i i c i i *d i *d *d *d')&cd
LAPACKE_zpbequ_work=: (liblapacke,' LAPACKE_zpbequ_work >+ i i c i i *j i *d *d *d')&cd
LAPACKE_spbrfs_work=: (liblapacke,' LAPACKE_spbrfs_work >+ i i c i i i *f i *f i *f i *f i *f *f *f *i')&cd
LAPACKE_dpbrfs_work=: (liblapacke,' LAPACKE_dpbrfs_work >+ i i c i i i *d i *d i *d i *d i *d *d *d *i')&cd
LAPACKE_zpbrfs_work=: (liblapacke,' LAPACKE_zpbrfs_work >+ i i c i i i *j i *j i *j i *j i *d *d *j *d')&cd
LAPACKE_spbstf_work=: (liblapacke,' LAPACKE_spbstf_work >+ i i c i i *f i')&cd
LAPACKE_dpbstf_work=: (liblapacke,' LAPACKE_dpbstf_work >+ i i c i i *d i')&cd
LAPACKE_zpbstf_work=: (liblapacke,' LAPACKE_zpbstf_work >+ i i c i i *j i')&cd
LAPACKE_spbsv_work=: (liblapacke,' LAPACKE_spbsv_work >+ i i c i i i *f i *f i')&cd
LAPACKE_dpbsv_work=: (liblapacke,' LAPACKE_dpbsv_work >+ i i c i i i *d i *d i')&cd
LAPACKE_zpbsv_work=: (liblapacke,' LAPACKE_zpbsv_work >+ i i c i i i *j i *j i')&cd
LAPACKE_spbsvx_work=: (liblapacke,' LAPACKE_spbsvx_work >+ i i c c i i i *f i *f i *c *f *f i *f i *f *f *f *f *i')&cd
LAPACKE_dpbsvx_work=: (liblapacke,' LAPACKE_dpbsvx_work >+ i i c c i i i *d i *d i *c *d *d i *d i *d *d *d *d *i')&cd
LAPACKE_zpbsvx_work=: (liblapacke,' LAPACKE_zpbsvx_work >+ i i c c i i i *j i *j i *c *d *j i *j i *d *d *d *j *d')&cd
LAPACKE_spbtrf_work=: (liblapacke,' LAPACKE_spbtrf_work >+ i i c i i *f i')&cd
LAPACKE_dpbtrf_work=: (liblapacke,' LAPACKE_dpbtrf_work >+ i i c i i *d i')&cd
LAPACKE_zpbtrf_work=: (liblapacke,' LAPACKE_zpbtrf_work >+ i i c i i *j i')&cd
LAPACKE_spbtrs_work=: (liblapacke,' LAPACKE_spbtrs_work >+ i i c i i i *f i *f i')&cd
LAPACKE_dpbtrs_work=: (liblapacke,' LAPACKE_dpbtrs_work >+ i i c i i i *d i *d i')&cd
LAPACKE_zpbtrs_work=: (liblapacke,' LAPACKE_zpbtrs_work >+ i i c i i i *j i *j i')&cd
LAPACKE_spftrf_work=: (liblapacke,' LAPACKE_spftrf_work >+ i i c c i *f')&cd
LAPACKE_dpftrf_work=: (liblapacke,' LAPACKE_dpftrf_work >+ i i c c i *d')&cd
LAPACKE_zpftrf_work=: (liblapacke,' LAPACKE_zpftrf_work >+ i i c c i *j')&cd
LAPACKE_spftri_work=: (liblapacke,' LAPACKE_spftri_work >+ i i c c i *f')&cd
LAPACKE_dpftri_work=: (liblapacke,' LAPACKE_dpftri_work >+ i i c c i *d')&cd
LAPACKE_zpftri_work=: (liblapacke,' LAPACKE_zpftri_work >+ i i c c i *j')&cd
LAPACKE_spftrs_work=: (liblapacke,' LAPACKE_spftrs_work >+ i i c c i i *f *f i')&cd
LAPACKE_dpftrs_work=: (liblapacke,' LAPACKE_dpftrs_work >+ i i c c i i *d *d i')&cd
LAPACKE_zpftrs_work=: (liblapacke,' LAPACKE_zpftrs_work >+ i i c c i i *j *j i')&cd
LAPACKE_spocon_work=: (liblapacke,' LAPACKE_spocon_work >+ i i c i *f i f *f *f *i')&cd
LAPACKE_dpocon_work=: (liblapacke,' LAPACKE_dpocon_work >+ i i c i *d i d *d *d *i')&cd
LAPACKE_zpocon_work=: (liblapacke,' LAPACKE_zpocon_work >+ i i c i *j i d *d *j *d')&cd
LAPACKE_spoequ_work=: (liblapacke,' LAPACKE_spoequ_work >+ i i i *f i *f *f *f')&cd
LAPACKE_dpoequ_work=: (liblapacke,' LAPACKE_dpoequ_work >+ i i i *d i *d *d *d')&cd
LAPACKE_zpoequ_work=: (liblapacke,' LAPACKE_zpoequ_work >+ i i i *j i *d *d *d')&cd
LAPACKE_spoequb_work=: (liblapacke,' LAPACKE_spoequb_work >+ i i i *f i *f *f *f')&cd
LAPACKE_dpoequb_work=: (liblapacke,' LAPACKE_dpoequb_work >+ i i i *d i *d *d *d')&cd
LAPACKE_zpoequb_work=: (liblapacke,' LAPACKE_zpoequb_work >+ i i i *j i *d *d *d')&cd
LAPACKE_sporfs_work=: (liblapacke,' LAPACKE_sporfs_work >+ i i c i i *f i *f i *f i *f i *f *f *f *i')&cd
LAPACKE_dporfs_work=: (liblapacke,' LAPACKE_dporfs_work >+ i i c i i *d i *d i *d i *d i *d *d *d *i')&cd
LAPACKE_zporfs_work=: (liblapacke,' LAPACKE_zporfs_work >+ i i c i i *j i *j i *j i *j i *d *d *j *d')&cd
LAPACKE_sporfsx_work=: (liblapacke,' LAPACKE_sporfsx_work >+ i i c c i i *f i *f i *f *f i *f i *f *f i *f *f i *f *f *i')&cd
LAPACKE_dporfsx_work=: (liblapacke,' LAPACKE_dporfsx_work >+ i i c c i i *d i *d i *d *d i *d i *d *d i *d *d i *d *d *i')&cd
LAPACKE_zporfsx_work=: (liblapacke,' LAPACKE_zporfsx_work >+ i i c c i i *j i *j i *d *j i *j i *d *d i *d *d i *d *j *d')&cd
LAPACKE_sposv_work=: (liblapacke,' LAPACKE_sposv_work >+ i i c i i *f i *f i')&cd
LAPACKE_dposv_work=: (liblapacke,' LAPACKE_dposv_work >+ i i c i i *d i *d i')&cd
LAPACKE_zposv_work=: (liblapacke,' LAPACKE_zposv_work >+ i i c i i *j i *j i')&cd
LAPACKE_dsposv_work=: (liblapacke,' LAPACKE_dsposv_work >+ i i c i i *d i *d i *d i *d *f *i')&cd
LAPACKE_sposvx_work=: (liblapacke,' LAPACKE_sposvx_work >+ i i c c i i *f i *f i *c *f *f i *f i *f *f *f *f *i')&cd
LAPACKE_dposvx_work=: (liblapacke,' LAPACKE_dposvx_work >+ i i c c i i *d i *d i *c *d *d i *d i *d *d *d *d *i')&cd
LAPACKE_zposvx_work=: (liblapacke,' LAPACKE_zposvx_work >+ i i c c i i *j i *j i *c *d *j i *j i *d *d *d *j *d')&cd
LAPACKE_sposvxx_work=: (liblapacke,' LAPACKE_sposvxx_work >+ i i c c i i *f i *f i *c *f *f i *f i *f *f *f i *f *f i *f *f *i')&cd
LAPACKE_dposvxx_work=: (liblapacke,' LAPACKE_dposvxx_work >+ i i c c i i *d i *d i *c *d *d i *d i *d *d *d i *d *d i *d *d *i')&cd
LAPACKE_zposvxx_work=: (liblapacke,' LAPACKE_zposvxx_work >+ i i c c i i *j i *j i *c *d *j i *j i *d *d *d i *d *d i *d *j *d')&cd
LAPACKE_spotrf_work=: (liblapacke,' LAPACKE_spotrf_work >+ i i c i *f i')&cd
LAPACKE_dpotrf_work=: (liblapacke,' LAPACKE_dpotrf_work >+ i i c i *d i')&cd
LAPACKE_zpotrf_work=: (liblapacke,' LAPACKE_zpotrf_work >+ i i c i *j i')&cd
LAPACKE_spotri_work=: (liblapacke,' LAPACKE_spotri_work >+ i i c i *f i')&cd
LAPACKE_dpotri_work=: (liblapacke,' LAPACKE_dpotri_work >+ i i c i *d i')&cd
LAPACKE_zpotri_work=: (liblapacke,' LAPACKE_zpotri_work >+ i i c i *j i')&cd
LAPACKE_spotrs_work=: (liblapacke,' LAPACKE_spotrs_work >+ i i c i i *f i *f i')&cd
LAPACKE_dpotrs_work=: (liblapacke,' LAPACKE_dpotrs_work >+ i i c i i *d i *d i')&cd
LAPACKE_zpotrs_work=: (liblapacke,' LAPACKE_zpotrs_work >+ i i c i i *j i *j i')&cd
LAPACKE_sppcon_work=: (liblapacke,' LAPACKE_sppcon_work >+ i i c i *f f *f *f *i')&cd
LAPACKE_dppcon_work=: (liblapacke,' LAPACKE_dppcon_work >+ i i c i *d d *d *d *i')&cd
LAPACKE_zppcon_work=: (liblapacke,' LAPACKE_zppcon_work >+ i i c i *j d *d *j *d')&cd
LAPACKE_sppequ_work=: (liblapacke,' LAPACKE_sppequ_work >+ i i c i *f *f *f *f')&cd
LAPACKE_dppequ_work=: (liblapacke,' LAPACKE_dppequ_work >+ i i c i *d *d *d *d')&cd
LAPACKE_zppequ_work=: (liblapacke,' LAPACKE_zppequ_work >+ i i c i *j *d *d *d')&cd
LAPACKE_spprfs_work=: (liblapacke,' LAPACKE_spprfs_work >+ i i c i i *f *f *f i *f i *f *f *f *i')&cd
LAPACKE_dpprfs_work=: (liblapacke,' LAPACKE_dpprfs_work >+ i i c i i *d *d *d i *d i *d *d *d *i')&cd
LAPACKE_zpprfs_work=: (liblapacke,' LAPACKE_zpprfs_work >+ i i c i i *j *j *j i *j i *d *d *j *d')&cd
LAPACKE_sppsv_work=: (liblapacke,' LAPACKE_sppsv_work >+ i i c i i *f *f i')&cd
LAPACKE_dppsv_work=: (liblapacke,' LAPACKE_dppsv_work >+ i i c i i *d *d i')&cd
LAPACKE_zppsv_work=: (liblapacke,' LAPACKE_zppsv_work >+ i i c i i *j *j i')&cd
LAPACKE_sppsvx_work=: (liblapacke,' LAPACKE_sppsvx_work >+ i i c c i i *f *f *c *f *f i *f i *f *f *f *f *i')&cd
LAPACKE_dppsvx_work=: (liblapacke,' LAPACKE_dppsvx_work >+ i i c c i i *d *d *c *d *d i *d i *d *d *d *d *i')&cd
LAPACKE_zppsvx_work=: (liblapacke,' LAPACKE_zppsvx_work >+ i i c c i i *j *j *c *d *j i *j i *d *d *d *j *d')&cd
LAPACKE_spptrf_work=: (liblapacke,' LAPACKE_spptrf_work >+ i i c i *f')&cd
LAPACKE_dpptrf_work=: (liblapacke,' LAPACKE_dpptrf_work >+ i i c i *d')&cd
LAPACKE_zpptrf_work=: (liblapacke,' LAPACKE_zpptrf_work >+ i i c i *j')&cd
LAPACKE_spptri_work=: (liblapacke,' LAPACKE_spptri_work >+ i i c i *f')&cd
LAPACKE_dpptri_work=: (liblapacke,' LAPACKE_dpptri_work >+ i i c i *d')&cd
LAPACKE_zpptri_work=: (liblapacke,' LAPACKE_zpptri_work >+ i i c i *j')&cd
LAPACKE_spptrs_work=: (liblapacke,' LAPACKE_spptrs_work >+ i i c i i *f *f i')&cd
LAPACKE_dpptrs_work=: (liblapacke,' LAPACKE_dpptrs_work >+ i i c i i *d *d i')&cd
LAPACKE_zpptrs_work=: (liblapacke,' LAPACKE_zpptrs_work >+ i i c i i *j *j i')&cd
LAPACKE_spstrf_work=: (liblapacke,' LAPACKE_spstrf_work >+ i i c i *f i *i *i f *f')&cd
LAPACKE_dpstrf_work=: (liblapacke,' LAPACKE_dpstrf_work >+ i i c i *d i *i *i d *d')&cd
LAPACKE_zpstrf_work=: (liblapacke,' LAPACKE_zpstrf_work >+ i i c i *j i *i *i d *d')&cd
LAPACKE_sptcon_work=: (liblapacke,' LAPACKE_sptcon_work >+ i i *f *f f *f *f')&cd
LAPACKE_dptcon_work=: (liblapacke,' LAPACKE_dptcon_work >+ i i *d *d d *d *d')&cd
LAPACKE_zptcon_work=: (liblapacke,' LAPACKE_zptcon_work >+ i i *d *j d *d *d')&cd
LAPACKE_spteqr_work=: (liblapacke,' LAPACKE_spteqr_work >+ i i c i *f *f *f i *f')&cd
LAPACKE_dpteqr_work=: (liblapacke,' LAPACKE_dpteqr_work >+ i i c i *d *d *d i *d')&cd
LAPACKE_zpteqr_work=: (liblapacke,' LAPACKE_zpteqr_work >+ i i c i *d *d *j i *d')&cd
LAPACKE_sptrfs_work=: (liblapacke,' LAPACKE_sptrfs_work >+ i i i i *f *f *f *f *f i *f i *f *f *f')&cd
LAPACKE_dptrfs_work=: (liblapacke,' LAPACKE_dptrfs_work >+ i i i i *d *d *d *d *d i *d i *d *d *d')&cd
LAPACKE_zptrfs_work=: (liblapacke,' LAPACKE_zptrfs_work >+ i i c i i *d *j *d *j *j i *j i *d *d *j *d')&cd
LAPACKE_sptsv_work=: (liblapacke,' LAPACKE_sptsv_work >+ i i i i *f *f *f i')&cd
LAPACKE_dptsv_work=: (liblapacke,' LAPACKE_dptsv_work >+ i i i i *d *d *d i')&cd
LAPACKE_zptsv_work=: (liblapacke,' LAPACKE_zptsv_work >+ i i i i *d *j *j i')&cd
LAPACKE_sptsvx_work=: (liblapacke,' LAPACKE_sptsvx_work >+ i i c i i *f *f *f *f *f i *f i *f *f *f *f')&cd
LAPACKE_dptsvx_work=: (liblapacke,' LAPACKE_dptsvx_work >+ i i c i i *d *d *d *d *d i *d i *d *d *d *d')&cd
LAPACKE_zptsvx_work=: (liblapacke,' LAPACKE_zptsvx_work >+ i i c i i *d *j *d *j *j i *j i *d *d *d *j *d')&cd
LAPACKE_spttrf_work=: (liblapacke,' LAPACKE_spttrf_work >+ i i *f *f')&cd
LAPACKE_dpttrf_work=: (liblapacke,' LAPACKE_dpttrf_work >+ i i *d *d')&cd
LAPACKE_zpttrf_work=: (liblapacke,' LAPACKE_zpttrf_work >+ i i *d *j')&cd
LAPACKE_spttrs_work=: (liblapacke,' LAPACKE_spttrs_work >+ i i i i *f *f *f i')&cd
LAPACKE_dpttrs_work=: (liblapacke,' LAPACKE_dpttrs_work >+ i i i i *d *d *d i')&cd
LAPACKE_zpttrs_work=: (liblapacke,' LAPACKE_zpttrs_work >+ i i c i i *d *j *j i')&cd
LAPACKE_ssbev_work=: (liblapacke,' LAPACKE_ssbev_work >+ i i c c i i *f i *f *f i *f')&cd
LAPACKE_dsbev_work=: (liblapacke,' LAPACKE_dsbev_work >+ i i c c i i *d i *d *d i *d')&cd
LAPACKE_ssbevd_work=: (liblapacke,' LAPACKE_ssbevd_work >+ i i c c i i *f i *f *f i *f i *i i')&cd
LAPACKE_dsbevd_work=: (liblapacke,' LAPACKE_dsbevd_work >+ i i c c i i *d i *d *d i *d i *i i')&cd
LAPACKE_ssbevx_work=: (liblapacke,' LAPACKE_ssbevx_work >+ i i c c c i i *f i *f i f f i i f *i *f *f i *f *i *i')&cd
LAPACKE_dsbevx_work=: (liblapacke,' LAPACKE_dsbevx_work >+ i i c c c i i *d i *d i d d i i d *i *d *d i *d *i *i')&cd
LAPACKE_ssbgst_work=: (liblapacke,' LAPACKE_ssbgst_work >+ i i c c i i i *f i *f i *f i *f')&cd
LAPACKE_dsbgst_work=: (liblapacke,' LAPACKE_dsbgst_work >+ i i c c i i i *d i *d i *d i *d')&cd
LAPACKE_ssbgv_work=: (liblapacke,' LAPACKE_ssbgv_work >+ i i c c i i i *f i *f i *f *f i *f')&cd
LAPACKE_dsbgv_work=: (liblapacke,' LAPACKE_dsbgv_work >+ i i c c i i i *d i *d i *d *d i *d')&cd
LAPACKE_ssbgvd_work=: (liblapacke,' LAPACKE_ssbgvd_work >+ i i c c i i i *f i *f i *f *f i *f i *i i')&cd
LAPACKE_dsbgvd_work=: (liblapacke,' LAPACKE_dsbgvd_work >+ i i c c i i i *d i *d i *d *d i *d i *i i')&cd
LAPACKE_ssbgvx_work=: (liblapacke,' LAPACKE_ssbgvx_work >+ i i c c c i i i *f i *f i *f i f f i i f *i *f *f i *f *i *i')&cd
LAPACKE_dsbgvx_work=: (liblapacke,' LAPACKE_dsbgvx_work >+ i i c c c i i i *d i *d i *d i d d i i d *i *d *d i *d *i *i')&cd
LAPACKE_ssbtrd_work=: (liblapacke,' LAPACKE_ssbtrd_work >+ i i c c i i *f i *f *f *f i *f')&cd
LAPACKE_dsbtrd_work=: (liblapacke,' LAPACKE_dsbtrd_work >+ i i c c i i *d i *d *d *d i *d')&cd
LAPACKE_ssfrk_work=: (liblapacke,' LAPACKE_ssfrk_work >+ i i c c c i i f *f i f *f')&cd
LAPACKE_dsfrk_work=: (liblapacke,' LAPACKE_dsfrk_work >+ i i c c c i i d *d i d *d')&cd
LAPACKE_sspcon_work=: (liblapacke,' LAPACKE_sspcon_work >+ i i c i *f *i f *f *f *i')&cd
LAPACKE_dspcon_work=: (liblapacke,' LAPACKE_dspcon_work >+ i i c i *d *i d *d *d *i')&cd
LAPACKE_zspcon_work=: (liblapacke,' LAPACKE_zspcon_work >+ i i c i *j *i d *d *j')&cd
LAPACKE_sspev_work=: (liblapacke,' LAPACKE_sspev_work >+ i i c c i *f *f *f i *f')&cd
LAPACKE_dspev_work=: (liblapacke,' LAPACKE_dspev_work >+ i i c c i *d *d *d i *d')&cd
LAPACKE_sspevd_work=: (liblapacke,' LAPACKE_sspevd_work >+ i i c c i *f *f *f i *f i *i i')&cd
LAPACKE_dspevd_work=: (liblapacke,' LAPACKE_dspevd_work >+ i i c c i *d *d *d i *d i *i i')&cd
LAPACKE_sspevx_work=: (liblapacke,' LAPACKE_sspevx_work >+ i i c c c i *f f f i i f *i *f *f i *f *i *i')&cd
LAPACKE_dspevx_work=: (liblapacke,' LAPACKE_dspevx_work >+ i i c c c i *d d d i i d *i *d *d i *d *i *i')&cd
LAPACKE_sspgst_work=: (liblapacke,' LAPACKE_sspgst_work >+ i i i c i *f *f')&cd
LAPACKE_dspgst_work=: (liblapacke,' LAPACKE_dspgst_work >+ i i i c i *d *d')&cd
LAPACKE_sspgv_work=: (liblapacke,' LAPACKE_sspgv_work >+ i i i c c i *f *f *f *f i *f')&cd
LAPACKE_dspgv_work=: (liblapacke,' LAPACKE_dspgv_work >+ i i i c c i *d *d *d *d i *d')&cd
LAPACKE_sspgvd_work=: (liblapacke,' LAPACKE_sspgvd_work >+ i i i c c i *f *f *f *f i *f i *i i')&cd
LAPACKE_dspgvd_work=: (liblapacke,' LAPACKE_dspgvd_work >+ i i i c c i *d *d *d *d i *d i *i i')&cd
LAPACKE_sspgvx_work=: (liblapacke,' LAPACKE_sspgvx_work >+ i i i c c c i *f *f f f i i f *i *f *f i *f *i *i')&cd
LAPACKE_dspgvx_work=: (liblapacke,' LAPACKE_dspgvx_work >+ i i i c c c i *d *d d d i i d *i *d *d i *d *i *i')&cd
LAPACKE_ssprfs_work=: (liblapacke,' LAPACKE_ssprfs_work >+ i i c i i *f *f *i *f i *f i *f *f *f *i')&cd
LAPACKE_dsprfs_work=: (liblapacke,' LAPACKE_dsprfs_work >+ i i c i i *d *d *i *d i *d i *d *d *d *i')&cd
LAPACKE_zsprfs_work=: (liblapacke,' LAPACKE_zsprfs_work >+ i i c i i *j *j *i *j i *j i *d *d *j *d')&cd
LAPACKE_sspsv_work=: (liblapacke,' LAPACKE_sspsv_work >+ i i c i i *f *i *f i')&cd
LAPACKE_dspsv_work=: (liblapacke,' LAPACKE_dspsv_work >+ i i c i i *d *i *d i')&cd
LAPACKE_zspsv_work=: (liblapacke,' LAPACKE_zspsv_work >+ i i c i i *j *i *j i')&cd
LAPACKE_sspsvx_work=: (liblapacke,' LAPACKE_sspsvx_work >+ i i c c i i *f *f *i *f i *f i *f *f *f *f *i')&cd
LAPACKE_dspsvx_work=: (liblapacke,' LAPACKE_dspsvx_work >+ i i c c i i *d *d *i *d i *d i *d *d *d *d *i')&cd
LAPACKE_zspsvx_work=: (liblapacke,' LAPACKE_zspsvx_work >+ i i c c i i *j *j *i *j i *j i *d *d *d *j *d')&cd
LAPACKE_ssptrd_work=: (liblapacke,' LAPACKE_ssptrd_work >+ i i c i *f *f *f *f')&cd
LAPACKE_dsptrd_work=: (liblapacke,' LAPACKE_dsptrd_work >+ i i c i *d *d *d *d')&cd
LAPACKE_ssptrf_work=: (liblapacke,' LAPACKE_ssptrf_work >+ i i c i *f *i')&cd
LAPACKE_dsptrf_work=: (liblapacke,' LAPACKE_dsptrf_work >+ i i c i *d *i')&cd
LAPACKE_zsptrf_work=: (liblapacke,' LAPACKE_zsptrf_work >+ i i c i *j *i')&cd
LAPACKE_ssptri_work=: (liblapacke,' LAPACKE_ssptri_work >+ i i c i *f *i *f')&cd
LAPACKE_dsptri_work=: (liblapacke,' LAPACKE_dsptri_work >+ i i c i *d *i *d')&cd
LAPACKE_zsptri_work=: (liblapacke,' LAPACKE_zsptri_work >+ i i c i *j *i *j')&cd
LAPACKE_ssptrs_work=: (liblapacke,' LAPACKE_ssptrs_work >+ i i c i i *f *i *f i')&cd
LAPACKE_dsptrs_work=: (liblapacke,' LAPACKE_dsptrs_work >+ i i c i i *d *i *d i')&cd
LAPACKE_zsptrs_work=: (liblapacke,' LAPACKE_zsptrs_work >+ i i c i i *j *i *j i')&cd
LAPACKE_sstebz_work=: (liblapacke,' LAPACKE_sstebz_work >+ i c c i f f i i f *f *f *i *i *f *i *i *f *i')&cd
LAPACKE_dstebz_work=: (liblapacke,' LAPACKE_dstebz_work >+ i c c i d d i i d *d *d *i *i *d *i *i *d *i')&cd
LAPACKE_sstedc_work=: (liblapacke,' LAPACKE_sstedc_work >+ i i c i *f *f *f i *f i *i i')&cd
LAPACKE_dstedc_work=: (liblapacke,' LAPACKE_dstedc_work >+ i i c i *d *d *d i *d i *i i')&cd
LAPACKE_zstedc_work=: (liblapacke,' LAPACKE_zstedc_work >+ i i c i *d *d *j i *j i *d i *i i')&cd
LAPACKE_sstegr_work=: (liblapacke,' LAPACKE_sstegr_work >+ i i c c i *f *f f f i i f *i *f *f i *i *f i *i i')&cd
LAPACKE_dstegr_work=: (liblapacke,' LAPACKE_dstegr_work >+ i i c c i *d *d d d i i d *i *d *d i *i *d i *i i')&cd
LAPACKE_zstegr_work=: (liblapacke,' LAPACKE_zstegr_work >+ i i c c i *d *d d d i i d *i *d *j i *i *d i *i i')&cd
LAPACKE_sstein_work=: (liblapacke,' LAPACKE_sstein_work >+ i i i *f *f i *f *i *i *f i *f *i *i')&cd
LAPACKE_dstein_work=: (liblapacke,' LAPACKE_dstein_work >+ i i i *d *d i *d *i *i *d i *d *i *i')&cd
LAPACKE_zstein_work=: (liblapacke,' LAPACKE_zstein_work >+ i i i *d *d i *d *i *i *j i *d *i *i')&cd
LAPACKE_sstemr_work=: (liblapacke,' LAPACKE_sstemr_work >+ i i c c i *f *f f f i i *i *f *f i i *i *i *f i *i i')&cd
LAPACKE_dstemr_work=: (liblapacke,' LAPACKE_dstemr_work >+ i i c c i *d *d d d i i *i *d *d i i *i *i *d i *i i')&cd
LAPACKE_zstemr_work=: (liblapacke,' LAPACKE_zstemr_work >+ i i c c i *d *d d d i i *i *d *j i i *i *i *d i *i i')&cd
LAPACKE_ssteqr_work=: (liblapacke,' LAPACKE_ssteqr_work >+ i i c i *f *f *f i *f')&cd
LAPACKE_dsteqr_work=: (liblapacke,' LAPACKE_dsteqr_work >+ i i c i *d *d *d i *d')&cd
LAPACKE_zsteqr_work=: (liblapacke,' LAPACKE_zsteqr_work >+ i i c i *d *d *j i *d')&cd
LAPACKE_ssterf_work=: (liblapacke,' LAPACKE_ssterf_work >+ i i *f *f')&cd
LAPACKE_dsterf_work=: (liblapacke,' LAPACKE_dsterf_work >+ i i *d *d')&cd
LAPACKE_sstev_work=: (liblapacke,' LAPACKE_sstev_work >+ i i c i *f *f *f i *f')&cd
LAPACKE_dstev_work=: (liblapacke,' LAPACKE_dstev_work >+ i i c i *d *d *d i *d')&cd
LAPACKE_sstevd_work=: (liblapacke,' LAPACKE_sstevd_work >+ i i c i *f *f *f i *f i *i i')&cd
LAPACKE_dstevd_work=: (liblapacke,' LAPACKE_dstevd_work >+ i i c i *d *d *d i *d i *i i')&cd
LAPACKE_sstevr_work=: (liblapacke,' LAPACKE_sstevr_work >+ i i c c i *f *f f f i i f *i *f *f i *i *f i *i i')&cd
LAPACKE_dstevr_work=: (liblapacke,' LAPACKE_dstevr_work >+ i i c c i *d *d d d i i d *i *d *d i *i *d i *i i')&cd
LAPACKE_sstevx_work=: (liblapacke,' LAPACKE_sstevx_work >+ i i c c i *f *f f f i i f *i *f *f i *f *i *i')&cd
LAPACKE_dstevx_work=: (liblapacke,' LAPACKE_dstevx_work >+ i i c c i *d *d d d i i d *i *d *d i *d *i *i')&cd
LAPACKE_ssycon_work=: (liblapacke,' LAPACKE_ssycon_work >+ i i c i *f i *i f *f *f *i')&cd
LAPACKE_dsycon_work=: (liblapacke,' LAPACKE_dsycon_work >+ i i c i *d i *i d *d *d *i')&cd
LAPACKE_zsycon_work=: (liblapacke,' LAPACKE_zsycon_work >+ i i c i *j i *i d *d *j')&cd
LAPACKE_ssyequb_work=: (liblapacke,' LAPACKE_ssyequb_work >+ i i c i *f i *f *f *f *f')&cd
LAPACKE_dsyequb_work=: (liblapacke,' LAPACKE_dsyequb_work >+ i i c i *d i *d *d *d *d')&cd
LAPACKE_zsyequb_work=: (liblapacke,' LAPACKE_zsyequb_work >+ i i c i *j i *d *d *d *j')&cd
LAPACKE_ssyev_work=: (liblapacke,' LAPACKE_ssyev_work >+ i i c c i *f i *f *f i')&cd
LAPACKE_dsyev_work=: (liblapacke,' LAPACKE_dsyev_work >+ i i c c i *d i *d *d i')&cd
LAPACKE_ssyevd_work=: (liblapacke,' LAPACKE_ssyevd_work >+ i i c c i *f i *f *f i *i i')&cd
LAPACKE_dsyevd_work=: (liblapacke,' LAPACKE_dsyevd_work >+ i i c c i *d i *d *d i *i i')&cd
LAPACKE_ssyevr_work=: (liblapacke,' LAPACKE_ssyevr_work >+ i i c c c i *f i f f i i f *i *f *f i *i *f i *i i')&cd
LAPACKE_dsyevr_work=: (liblapacke,' LAPACKE_dsyevr_work >+ i i c c c i *d i d d i i d *i *d *d i *i *d i *i i')&cd
LAPACKE_ssyevx_work=: (liblapacke,' LAPACKE_ssyevx_work >+ i i c c c i *f i f f i i f *i *f *f i *f i *i *i')&cd
LAPACKE_dsyevx_work=: (liblapacke,' LAPACKE_dsyevx_work >+ i i c c c i *d i d d i i d *i *d *d i *d i *i *i')&cd
LAPACKE_ssygst_work=: (liblapacke,' LAPACKE_ssygst_work >+ i i i c i *f i *f i')&cd
LAPACKE_dsygst_work=: (liblapacke,' LAPACKE_dsygst_work >+ i i i c i *d i *d i')&cd
LAPACKE_ssygv_work=: (liblapacke,' LAPACKE_ssygv_work >+ i i i c c i *f i *f i *f *f i')&cd
LAPACKE_dsygv_work=: (liblapacke,' LAPACKE_dsygv_work >+ i i i c c i *d i *d i *d *d i')&cd
LAPACKE_ssygvd_work=: (liblapacke,' LAPACKE_ssygvd_work >+ i i i c c i *f i *f i *f *f i *i i')&cd
LAPACKE_dsygvd_work=: (liblapacke,' LAPACKE_dsygvd_work >+ i i i c c i *d i *d i *d *d i *i i')&cd
LAPACKE_ssygvx_work=: (liblapacke,' LAPACKE_ssygvx_work >+ i i i c c c i *f i *f i f f i i f *i *f *f i *f i *i *i')&cd
LAPACKE_dsygvx_work=: (liblapacke,' LAPACKE_dsygvx_work >+ i i i c c c i *d i *d i d d i i d *i *d *d i *d i *i *i')&cd
LAPACKE_ssyrfs_work=: (liblapacke,' LAPACKE_ssyrfs_work >+ i i c i i *f i *f i *i *f i *f i *f *f *f *i')&cd
LAPACKE_dsyrfs_work=: (liblapacke,' LAPACKE_dsyrfs_work >+ i i c i i *d i *d i *i *d i *d i *d *d *d *i')&cd
LAPACKE_zsyrfs_work=: (liblapacke,' LAPACKE_zsyrfs_work >+ i i c i i *j i *j i *i *j i *j i *d *d *j *d')&cd
LAPACKE_ssyrfsx_work=: (liblapacke,' LAPACKE_ssyrfsx_work >+ i i c c i i *f i *f i *i *f *f i *f i *f *f i *f *f i *f *f *i')&cd
LAPACKE_dsyrfsx_work=: (liblapacke,' LAPACKE_dsyrfsx_work >+ i i c c i i *d i *d i *i *d *d i *d i *d *d i *d *d i *d *d *i')&cd
LAPACKE_zsyrfsx_work=: (liblapacke,' LAPACKE_zsyrfsx_work >+ i i c c i i *j i *j i *i *d *j i *j i *d *d i *d *d i *d *j *d')&cd
LAPACKE_ssysv_work=: (liblapacke,' LAPACKE_ssysv_work >+ i i c i i *f i *i *f i *f i')&cd
LAPACKE_dsysv_work=: (liblapacke,' LAPACKE_dsysv_work >+ i i c i i *d i *i *d i *d i')&cd
LAPACKE_zsysv_work=: (liblapacke,' LAPACKE_zsysv_work >+ i i c i i *j i *i *j i *j i')&cd
LAPACKE_ssysvx_work=: (liblapacke,' LAPACKE_ssysvx_work >+ i i c c i i *f i *f i *i *f i *f i *f *f *f *f i *i')&cd
LAPACKE_dsysvx_work=: (liblapacke,' LAPACKE_dsysvx_work >+ i i c c i i *d i *d i *i *d i *d i *d *d *d *d i *i')&cd
LAPACKE_zsysvx_work=: (liblapacke,' LAPACKE_zsysvx_work >+ i i c c i i *j i *j i *i *j i *j i *d *d *d *j i *d')&cd
LAPACKE_ssysvxx_work=: (liblapacke,' LAPACKE_ssysvxx_work >+ i i c c i i *f i *f i *i *c *f *f i *f i *f *f *f i *f *f i *f *f *i')&cd
LAPACKE_dsysvxx_work=: (liblapacke,' LAPACKE_dsysvxx_work >+ i i c c i i *d i *d i *i *c *d *d i *d i *d *d *d i *d *d i *d *d *i')&cd
LAPACKE_zsysvxx_work=: (liblapacke,' LAPACKE_zsysvxx_work >+ i i c c i i *j i *j i *i *c *d *j i *j i *d *d *d i *d *d i *d *j *d')&cd
LAPACKE_ssytrd_work=: (liblapacke,' LAPACKE_ssytrd_work >+ i i c i *f i *f *f *f *f i')&cd
LAPACKE_dsytrd_work=: (liblapacke,' LAPACKE_dsytrd_work >+ i i c i *d i *d *d *d *d i')&cd
LAPACKE_ssytrf_work=: (liblapacke,' LAPACKE_ssytrf_work >+ i i c i *f i *i *f i')&cd
LAPACKE_dsytrf_work=: (liblapacke,' LAPACKE_dsytrf_work >+ i i c i *d i *i *d i')&cd
LAPACKE_zsytrf_work=: (liblapacke,' LAPACKE_zsytrf_work >+ i i c i *j i *i *j i')&cd
LAPACKE_ssytri_work=: (liblapacke,' LAPACKE_ssytri_work >+ i i c i *f i *i *f')&cd
LAPACKE_dsytri_work=: (liblapacke,' LAPACKE_dsytri_work >+ i i c i *d i *i *d')&cd
LAPACKE_zsytri_work=: (liblapacke,' LAPACKE_zsytri_work >+ i i c i *j i *i *j')&cd
LAPACKE_ssytrs_work=: (liblapacke,' LAPACKE_ssytrs_work >+ i i c i i *f i *i *f i')&cd
LAPACKE_dsytrs_work=: (liblapacke,' LAPACKE_dsytrs_work >+ i i c i i *d i *i *d i')&cd
LAPACKE_zsytrs_work=: (liblapacke,' LAPACKE_zsytrs_work >+ i i c i i *j i *i *j i')&cd
LAPACKE_stbcon_work=: (liblapacke,' LAPACKE_stbcon_work >+ i i c c c i i *f i *f *f *i')&cd
LAPACKE_dtbcon_work=: (liblapacke,' LAPACKE_dtbcon_work >+ i i c c c i i *d i *d *d *i')&cd
LAPACKE_ztbcon_work=: (liblapacke,' LAPACKE_ztbcon_work >+ i i c c c i i *j i *d *j *d')&cd
LAPACKE_stbrfs_work=: (liblapacke,' LAPACKE_stbrfs_work >+ i i c c c i i i *f i *f i *f i *f *f *f *i')&cd
LAPACKE_dtbrfs_work=: (liblapacke,' LAPACKE_dtbrfs_work >+ i i c c c i i i *d i *d i *d i *d *d *d *i')&cd
LAPACKE_ztbrfs_work=: (liblapacke,' LAPACKE_ztbrfs_work >+ i i c c c i i i *j i *j i *j i *d *d *j *d')&cd
LAPACKE_stbtrs_work=: (liblapacke,' LAPACKE_stbtrs_work >+ i i c c c i i i *f i *f i')&cd
LAPACKE_dtbtrs_work=: (liblapacke,' LAPACKE_dtbtrs_work >+ i i c c c i i i *d i *d i')&cd
LAPACKE_ztbtrs_work=: (liblapacke,' LAPACKE_ztbtrs_work >+ i i c c c i i i *j i *j i')&cd
LAPACKE_stfsm_work=: (liblapacke,' LAPACKE_stfsm_work >+ i i c c c c c i i f *f *f i')&cd
LAPACKE_dtfsm_work=: (liblapacke,' LAPACKE_dtfsm_work >+ i i c c c c c i i d *d *d i')&cd
LAPACKE_ztfsm_work=: (liblapacke,' LAPACKE_ztfsm_work >+ i i c c c c c i i j *j *j i')&cd
LAPACKE_stftri_work=: (liblapacke,' LAPACKE_stftri_work >+ i i c c c i *f')&cd
LAPACKE_dtftri_work=: (liblapacke,' LAPACKE_dtftri_work >+ i i c c c i *d')&cd
LAPACKE_ztftri_work=: (liblapacke,' LAPACKE_ztftri_work >+ i i c c c i *j')&cd
LAPACKE_stfttp_work=: (liblapacke,' LAPACKE_stfttp_work >+ i i c c i *f *f')&cd
LAPACKE_dtfttp_work=: (liblapacke,' LAPACKE_dtfttp_work >+ i i c c i *d *d')&cd
LAPACKE_ztfttp_work=: (liblapacke,' LAPACKE_ztfttp_work >+ i i c c i *j *j')&cd
LAPACKE_stfttr_work=: (liblapacke,' LAPACKE_stfttr_work >+ i i c c i *f *f i')&cd
LAPACKE_dtfttr_work=: (liblapacke,' LAPACKE_dtfttr_work >+ i i c c i *d *d i')&cd
LAPACKE_ztfttr_work=: (liblapacke,' LAPACKE_ztfttr_work >+ i i c c i *j *j i')&cd
LAPACKE_stgevc_work=: (liblapacke,' LAPACKE_stgevc_work >+ i i c c *i i *f i *f i *f i *f i i *i *f')&cd
LAPACKE_dtgevc_work=: (liblapacke,' LAPACKE_dtgevc_work >+ i i c c *i i *d i *d i *d i *d i i *i *d')&cd
LAPACKE_ztgevc_work=: (liblapacke,' LAPACKE_ztgevc_work >+ i i c c *i i *j i *j i *j i *j i i *i *j *d')&cd
LAPACKE_stgexc_work=: (liblapacke,' LAPACKE_stgexc_work >+ i i i i i *f i *f i *f i *f i *i *i *f i')&cd
LAPACKE_dtgexc_work=: (liblapacke,' LAPACKE_dtgexc_work >+ i i i i i *d i *d i *d i *d i *i *i *d i')&cd
LAPACKE_ztgexc_work=: (liblapacke,' LAPACKE_ztgexc_work >+ i i i i i *j i *j i *j i *j i i i')&cd
LAPACKE_stgsen_work=: (liblapacke,' LAPACKE_stgsen_work >+ i i i i i *i i *f i *f i *f *f *f *f i *f i *i *f *f *f *f i *i i')&cd
LAPACKE_dtgsen_work=: (liblapacke,' LAPACKE_dtgsen_work >+ i i i i i *i i *d i *d i *d *d *d *d i *d i *i *d *d *d *d i *i i')&cd
LAPACKE_ztgsen_work=: (liblapacke,' LAPACKE_ztgsen_work >+ i i i i i *i i *j i *j i *j *j *j i *j i *i *d *d *d *j i *i i')&cd
LAPACKE_stgsja_work=: (liblapacke,' LAPACKE_stgsja_work >+ i i c c c i i i i i *f i *f i f f *f *f *f i *f i *f i *f *i')&cd
LAPACKE_dtgsja_work=: (liblapacke,' LAPACKE_dtgsja_work >+ i i c c c i i i i i *d i *d i d d *d *d *d i *d i *d i *d *i')&cd
LAPACKE_ztgsja_work=: (liblapacke,' LAPACKE_ztgsja_work >+ i i c c c i i i i i *j i *j i d d *d *d *j i *j i *j i *j *i')&cd
LAPACKE_stgsna_work=: (liblapacke,' LAPACKE_stgsna_work >+ i i c c *i i *f i *f i *f i *f i *f *f i *i *f i *i')&cd
LAPACKE_dtgsna_work=: (liblapacke,' LAPACKE_dtgsna_work >+ i i c c *i i *d i *d i *d i *d i *d *d i *i *d i *i')&cd
LAPACKE_ztgsna_work=: (liblapacke,' LAPACKE_ztgsna_work >+ i i c c *i i *j i *j i *j i *j i *d *d i *i *j i *i')&cd
LAPACKE_stgsyl_work=: (liblapacke,' LAPACKE_stgsyl_work >+ i i c i i i *f i *f i *f i *f i *f i *f i *f *f *f i *i')&cd
LAPACKE_dtgsyl_work=: (liblapacke,' LAPACKE_dtgsyl_work >+ i i c i i i *d i *d i *d i *d i *d i *d i *d *d *d i *i')&cd
LAPACKE_ztgsyl_work=: (liblapacke,' LAPACKE_ztgsyl_work >+ i i c i i i *j i *j i *j i *j i *j i *j i *d *d *j i *i')&cd
LAPACKE_stpcon_work=: (liblapacke,' LAPACKE_stpcon_work >+ i i c c c i *f *f *f *i')&cd
LAPACKE_dtpcon_work=: (liblapacke,' LAPACKE_dtpcon_work >+ i i c c c i *d *d *d *i')&cd
LAPACKE_ztpcon_work=: (liblapacke,' LAPACKE_ztpcon_work >+ i i c c c i *j *d *j *d')&cd
LAPACKE_stprfs_work=: (liblapacke,' LAPACKE_stprfs_work >+ i i c c c i i *f *f i *f i *f *f *f *i')&cd
LAPACKE_dtprfs_work=: (liblapacke,' LAPACKE_dtprfs_work >+ i i c c c i i *d *d i *d i *d *d *d *i')&cd
LAPACKE_ztprfs_work=: (liblapacke,' LAPACKE_ztprfs_work >+ i i c c c i i *j *j i *j i *d *d *j *d')&cd
LAPACKE_stptri_work=: (liblapacke,' LAPACKE_stptri_work >+ i i c c i *f')&cd
LAPACKE_dtptri_work=: (liblapacke,' LAPACKE_dtptri_work >+ i i c c i *d')&cd
LAPACKE_ztptri_work=: (liblapacke,' LAPACKE_ztptri_work >+ i i c c i *j')&cd
LAPACKE_stptrs_work=: (liblapacke,' LAPACKE_stptrs_work >+ i i c c c i i *f *f i')&cd
LAPACKE_dtptrs_work=: (liblapacke,' LAPACKE_dtptrs_work >+ i i c c c i i *d *d i')&cd
LAPACKE_ztptrs_work=: (liblapacke,' LAPACKE_ztptrs_work >+ i i c c c i i *j *j i')&cd
LAPACKE_stpttf_work=: (liblapacke,' LAPACKE_stpttf_work >+ i i c c i *f *f')&cd
LAPACKE_dtpttf_work=: (liblapacke,' LAPACKE_dtpttf_work >+ i i c c i *d *d')&cd
LAPACKE_ztpttf_work=: (liblapacke,' LAPACKE_ztpttf_work >+ i i c c i *j *j')&cd
LAPACKE_stpttr_work=: (liblapacke,' LAPACKE_stpttr_work >+ i i c i *f *f i')&cd
LAPACKE_dtpttr_work=: (liblapacke,' LAPACKE_dtpttr_work >+ i i c i *d *d i')&cd
LAPACKE_ztpttr_work=: (liblapacke,' LAPACKE_ztpttr_work >+ i i c i *j *j i')&cd
LAPACKE_strcon_work=: (liblapacke,' LAPACKE_strcon_work >+ i i c c c i *f i *f *f *i')&cd
LAPACKE_dtrcon_work=: (liblapacke,' LAPACKE_dtrcon_work >+ i i c c c i *d i *d *d *i')&cd
LAPACKE_ztrcon_work=: (liblapacke,' LAPACKE_ztrcon_work >+ i i c c c i *j i *d *j *d')&cd
LAPACKE_strevc_work=: (liblapacke,' LAPACKE_strevc_work >+ i i c c *i i *f i *f i *f i i *i *f')&cd
LAPACKE_dtrevc_work=: (liblapacke,' LAPACKE_dtrevc_work >+ i i c c *i i *d i *d i *d i i *i *d')&cd
LAPACKE_ztrevc_work=: (liblapacke,' LAPACKE_ztrevc_work >+ i i c c *i i *j i *j i *j i i *i *j *d')&cd
LAPACKE_strexc_work=: (liblapacke,' LAPACKE_strexc_work >+ i i c i *f i *f i *i *i *f')&cd
LAPACKE_dtrexc_work=: (liblapacke,' LAPACKE_dtrexc_work >+ i i c i *d i *d i *i *i *d')&cd
LAPACKE_ztrexc_work=: (liblapacke,' LAPACKE_ztrexc_work >+ i i c i *j i *j i i i')&cd
LAPACKE_strrfs_work=: (liblapacke,' LAPACKE_strrfs_work >+ i i c c c i i *f i *f i *f i *f *f *f *i')&cd
LAPACKE_dtrrfs_work=: (liblapacke,' LAPACKE_dtrrfs_work >+ i i c c c i i *d i *d i *d i *d *d *d *i')&cd
LAPACKE_ztrrfs_work=: (liblapacke,' LAPACKE_ztrrfs_work >+ i i c c c i i *j i *j i *j i *d *d *j *d')&cd
LAPACKE_strsen_work=: (liblapacke,' LAPACKE_strsen_work >+ i i c c *i i *f i *f i *f *f *i *f *f *f i *i i')&cd
LAPACKE_dtrsen_work=: (liblapacke,' LAPACKE_dtrsen_work >+ i i c c *i i *d i *d i *d *d *i *d *d *d i *i i')&cd
LAPACKE_ztrsen_work=: (liblapacke,' LAPACKE_ztrsen_work >+ i i c c *i i *j i *j i *j *i *d *d *j i')&cd
LAPACKE_strsna_work=: (liblapacke,' LAPACKE_strsna_work >+ i i c c *i i *f i *f i *f i *f *f i *i *f i *i')&cd
LAPACKE_dtrsna_work=: (liblapacke,' LAPACKE_dtrsna_work >+ i i c c *i i *d i *d i *d i *d *d i *i *d i *i')&cd
LAPACKE_ztrsna_work=: (liblapacke,' LAPACKE_ztrsna_work >+ i i c c *i i *j i *j i *j i *d *d i *i *j i *d')&cd
LAPACKE_strsyl_work=: (liblapacke,' LAPACKE_strsyl_work >+ i i c c i i i *f i *f i *f i *f')&cd
LAPACKE_dtrsyl_work=: (liblapacke,' LAPACKE_dtrsyl_work >+ i i c c i i i *d i *d i *d i *d')&cd
LAPACKE_ztrsyl_work=: (liblapacke,' LAPACKE_ztrsyl_work >+ i i c c i i i *j i *j i *j i *d')&cd
LAPACKE_strtri_work=: (liblapacke,' LAPACKE_strtri_work >+ i i c c i *f i')&cd
LAPACKE_dtrtri_work=: (liblapacke,' LAPACKE_dtrtri_work >+ i i c c i *d i')&cd
LAPACKE_ztrtri_work=: (liblapacke,' LAPACKE_ztrtri_work >+ i i c c i *j i')&cd
LAPACKE_strtrs_work=: (liblapacke,' LAPACKE_strtrs_work >+ i i c c c i i *f i *f i')&cd
LAPACKE_dtrtrs_work=: (liblapacke,' LAPACKE_dtrtrs_work >+ i i c c c i i *d i *d i')&cd
LAPACKE_ztrtrs_work=: (liblapacke,' LAPACKE_ztrtrs_work >+ i i c c c i i *j i *j i')&cd
LAPACKE_strttf_work=: (liblapacke,' LAPACKE_strttf_work >+ i i c c i *f i *f')&cd
LAPACKE_dtrttf_work=: (liblapacke,' LAPACKE_dtrttf_work >+ i i c c i *d i *d')&cd
LAPACKE_ztrttf_work=: (liblapacke,' LAPACKE_ztrttf_work >+ i i c c i *j i *j')&cd
LAPACKE_strttp_work=: (liblapacke,' LAPACKE_strttp_work >+ i i c i *f i *f')&cd
LAPACKE_dtrttp_work=: (liblapacke,' LAPACKE_dtrttp_work >+ i i c i *d i *d')&cd
LAPACKE_ztrttp_work=: (liblapacke,' LAPACKE_ztrttp_work >+ i i c i *j i *j')&cd
LAPACKE_stzrzf_work=: (liblapacke,' LAPACKE_stzrzf_work >+ i i i i *f i *f *f i')&cd
LAPACKE_dtzrzf_work=: (liblapacke,' LAPACKE_dtzrzf_work >+ i i i i *d i *d *d i')&cd
LAPACKE_ztzrzf_work=: (liblapacke,' LAPACKE_ztzrzf_work >+ i i i i *j i *j *j i')&cd
LAPACKE_zungbr_work=: (liblapacke,' LAPACKE_zungbr_work >+ i i c i i i *j i *j *j i')&cd
LAPACKE_zunghr_work=: (liblapacke,' LAPACKE_zunghr_work >+ i i i i i *j i *j *j i')&cd
LAPACKE_zunglq_work=: (liblapacke,' LAPACKE_zunglq_work >+ i i i i i *j i *j *j i')&cd
LAPACKE_zungql_work=: (liblapacke,' LAPACKE_zungql_work >+ i i i i i *j i *j *j i')&cd
LAPACKE_zungqr_work=: (liblapacke,' LAPACKE_zungqr_work >+ i i i i i *j i *j *j i')&cd
LAPACKE_zungrq_work=: (liblapacke,' LAPACKE_zungrq_work >+ i i i i i *j i *j *j i')&cd
LAPACKE_zungtr_work=: (liblapacke,' LAPACKE_zungtr_work >+ i i c i *j i *j *j i')&cd
LAPACKE_zunmbr_work=: (liblapacke,' LAPACKE_zunmbr_work >+ i i c c c i i i *j i *j *j i *j i')&cd
LAPACKE_zunmhr_work=: (liblapacke,' LAPACKE_zunmhr_work >+ i i c c i i i i *j i *j *j i *j i')&cd
LAPACKE_zunmlq_work=: (liblapacke,' LAPACKE_zunmlq_work >+ i i c c i i i *j i *j *j i *j i')&cd
LAPACKE_zunmql_work=: (liblapacke,' LAPACKE_zunmql_work >+ i i c c i i i *j i *j *j i *j i')&cd
LAPACKE_zunmqr_work=: (liblapacke,' LAPACKE_zunmqr_work >+ i i c c i i i *j i *j *j i *j i')&cd
LAPACKE_zunmrq_work=: (liblapacke,' LAPACKE_zunmrq_work >+ i i c c i i i *j i *j *j i *j i')&cd
LAPACKE_zunmrz_work=: (liblapacke,' LAPACKE_zunmrz_work >+ i i c c i i i i *j i *j *j i *j i')&cd
LAPACKE_zunmtr_work=: (liblapacke,' LAPACKE_zunmtr_work >+ i i c c c i i *j i *j *j i *j i')&cd
LAPACKE_zupgtr_work=: (liblapacke,' LAPACKE_zupgtr_work >+ i i c i *j *j *j i *j')&cd
LAPACKE_zupmtr_work=: (liblapacke,' LAPACKE_zupmtr_work >+ i i c c c i i *j *j *j i *j')&cd
LAPACKE_zlaghe=: (liblapacke,' LAPACKE_zlaghe >+ i i i i *d *j i *i')&cd
LAPACKE_slagsy=: (liblapacke,' LAPACKE_slagsy >+ i i i i *f *f i *i')&cd
LAPACKE_dlagsy=: (liblapacke,' LAPACKE_dlagsy >+ i i i i *d *d i *i')&cd
LAPACKE_zlagsy=: (liblapacke,' LAPACKE_zlagsy >+ i i i i *d *j i *i')&cd
LAPACKE_slapmr=: (liblapacke,' LAPACKE_slapmr >+ i i i i i *f i *i')&cd
LAPACKE_dlapmr=: (liblapacke,' LAPACKE_dlapmr >+ i i i i i *d i *i')&cd
LAPACKE_zlapmr=: (liblapacke,' LAPACKE_zlapmr >+ i i i i i *j i *i')&cd
LAPACKE_slapy2=: (liblapacke,' LAPACKE_slapy2 >+ f f f')&cd
LAPACKE_dlapy2=: (liblapacke,' LAPACKE_dlapy2 >+ d d d')&cd
LAPACKE_slapy3=: (liblapacke,' LAPACKE_slapy3 >+ f f f f')&cd
LAPACKE_dlapy3=: (liblapacke,' LAPACKE_dlapy3 >+ d d d d')&cd
LAPACKE_slartgp=: (liblapacke,' LAPACKE_slartgp >+ i f f *f *f *f')&cd
LAPACKE_dlartgp=: (liblapacke,' LAPACKE_dlartgp >+ i d d *d *d *d')&cd
LAPACKE_slartgs=: (liblapacke,' LAPACKE_slartgs >+ i f f f *f *f')&cd
LAPACKE_dlartgs=: (liblapacke,' LAPACKE_dlartgs >+ i d d d *d *d')&cd
LAPACKE_dbbcsd=: (liblapacke,' LAPACKE_dbbcsd >+ i i c c c c c i i i *d *d *d i *d i *d i *d i *d *d *d *d *d *d *d *d')&cd
LAPACKE_dbbcsd_work=: (liblapacke,' LAPACKE_dbbcsd_work >+ i i c c c c c i i i *d *d *d i *d i *d i *d i *d *d *d *d *d *d *d *d *d i')&cd
LAPACKE_dorbdb=: (liblapacke,' LAPACKE_dorbdb >+ i i c c i i i *d i *d i *d i *d i *d *d *d *d *d *d')&cd
LAPACKE_dorbdb_work=: (liblapacke,' LAPACKE_dorbdb_work >+ i i c c i i i *d i *d i *d i *d i *d *d *d *d *d *d *d i')&cd
LAPACKE_dorcsd=: (liblapacke,' LAPACKE_dorcsd >+ i i c c c c c c i i i *d i *d i *d i *d i *d *d i *d i *d i *d i')&cd
LAPACKE_dorcsd_work=: (liblapacke,' LAPACKE_dorcsd_work >+ i i c c c c c c i i i *d i *d i *d i *d i *d *d i *d i *d i *d i *d i *i')&cd
LAPACKE_dsyconv=: (liblapacke,' LAPACKE_dsyconv >+ i i c c i *d i *i')&cd
LAPACKE_dsyconv_work=: (liblapacke,' LAPACKE_dsyconv_work >+ i i c c i *d i *i *d')&cd
LAPACKE_dsyswapr=: (liblapacke,' LAPACKE_dsyswapr >+ i i c i *d i i')&cd
LAPACKE_dsyswapr_work=: (liblapacke,' LAPACKE_dsyswapr_work >+ i i c i *d i i')&cd
LAPACKE_dsytri2=: (liblapacke,' LAPACKE_dsytri2 >+ i i c i *d i *i')&cd
LAPACKE_dsytri2_work=: (liblapacke,' LAPACKE_dsytri2_work >+ i i c i *d i *i *j i')&cd
LAPACKE_dsytri2x=: (liblapacke,' LAPACKE_dsytri2x >+ i i c i *d i *i i')&cd
LAPACKE_dsytri2x_work=: (liblapacke,' LAPACKE_dsytri2x_work >+ i i c i *d i *i *d i')&cd
LAPACKE_dsytrs2=: (liblapacke,' LAPACKE_dsytrs2 >+ i i c i i *d i *i *d i')&cd
LAPACKE_dsytrs2_work=: (liblapacke,' LAPACKE_dsytrs2_work >+ i i c i i *d i *i *d i *d')&cd
LAPACKE_sbbcsd=: (liblapacke,' LAPACKE_sbbcsd >+ i i c c c c c i i i *f *f *f i *f i *f i *f i *f *f *f *f *f *f *f *f')&cd
LAPACKE_sbbcsd_work=: (liblapacke,' LAPACKE_sbbcsd_work >+ i i c c c c c i i i *f *f *f i *f i *f i *f i *f *f *f *f *f *f *f *f *f i')&cd
LAPACKE_sorbdb=: (liblapacke,' LAPACKE_sorbdb >+ i i c c i i i *f i *f i *f i *f i *f *f *f *f *f *f')&cd
LAPACKE_sorbdb_work=: (liblapacke,' LAPACKE_sorbdb_work >+ i i c c i i i *f i *f i *f i *f i *f *f *f *f *f *f *f i')&cd
LAPACKE_sorcsd=: (liblapacke,' LAPACKE_sorcsd >+ i i c c c c c c i i i *f i *f i *f i *f i *f *f i *f i *f i *f i')&cd
LAPACKE_sorcsd_work=: (liblapacke,' LAPACKE_sorcsd_work >+ i i c c c c c c i i i *f i *f i *f i *f i *f *f i *f i *f i *f i *f i *i')&cd
LAPACKE_ssyconv=: (liblapacke,' LAPACKE_ssyconv >+ i i c c i *f i *i')&cd
LAPACKE_ssyconv_work=: (liblapacke,' LAPACKE_ssyconv_work >+ i i c c i *f i *i *f')&cd
LAPACKE_ssyswapr=: (liblapacke,' LAPACKE_ssyswapr >+ i i c i *f i i')&cd
LAPACKE_ssyswapr_work=: (liblapacke,' LAPACKE_ssyswapr_work >+ i i c i *f i i')&cd
LAPACKE_ssytri2=: (liblapacke,' LAPACKE_ssytri2 >+ i i c i *f i *i')&cd
LAPACKE_ssytri2x=: (liblapacke,' LAPACKE_ssytri2x >+ i i c i *f i *i i')&cd
LAPACKE_ssytri2x_work=: (liblapacke,' LAPACKE_ssytri2x_work >+ i i c i *f i *i *f i')&cd
LAPACKE_ssytrs2=: (liblapacke,' LAPACKE_ssytrs2 >+ i i c i i *f i *i *f i')&cd
LAPACKE_ssytrs2_work=: (liblapacke,' LAPACKE_ssytrs2_work >+ i i c i i *f i *i *f i *f')&cd
LAPACKE_zbbcsd=: (liblapacke,' LAPACKE_zbbcsd >+ i i c c c c c i i i *d *d *j i *j i *j i *j i *d *d *d *d *d *d *d *d')&cd
LAPACKE_zbbcsd_work=: (liblapacke,' LAPACKE_zbbcsd_work >+ i i c c c c c i i i *d *d *j i *j i *j i *j i *d *d *d *d *d *d *d *d *d i')&cd
LAPACKE_zheswapr=: (liblapacke,' LAPACKE_zheswapr >+ i i c i *j i i')&cd
LAPACKE_zheswapr_work=: (liblapacke,' LAPACKE_zheswapr_work >+ i i c i *j i i')&cd
LAPACKE_zhetri2=: (liblapacke,' LAPACKE_zhetri2 >+ i i c i *j i *i')&cd
LAPACKE_zhetri2_work=: (liblapacke,' LAPACKE_zhetri2_work >+ i i c i *j i *i *j i')&cd
LAPACKE_zhetri2x=: (liblapacke,' LAPACKE_zhetri2x >+ i i c i *j i *i i')&cd
LAPACKE_zhetri2x_work=: (liblapacke,' LAPACKE_zhetri2x_work >+ i i c i *j i *i *j i')&cd
LAPACKE_zhetrs2=: (liblapacke,' LAPACKE_zhetrs2 >+ i i c i i *j i *i *j i')&cd
LAPACKE_zhetrs2_work=: (liblapacke,' LAPACKE_zhetrs2_work >+ i i c i i *j i *i *j i *j')&cd
LAPACKE_zsyconv=: (liblapacke,' LAPACKE_zsyconv >+ i i c c i *j i *i')&cd
LAPACKE_zsyconv_work=: (liblapacke,' LAPACKE_zsyconv_work >+ i i c c i *j i *i *j')&cd
LAPACKE_zsyswapr=: (liblapacke,' LAPACKE_zsyswapr >+ i i c i *j i i')&cd
LAPACKE_zsyswapr_work=: (liblapacke,' LAPACKE_zsyswapr_work >+ i i c i *j i i')&cd
LAPACKE_zsytri2=: (liblapacke,' LAPACKE_zsytri2 >+ i i c i *j i *i')&cd
LAPACKE_zsytri2_work=: (liblapacke,' LAPACKE_zsytri2_work >+ i i c i *j i *i *j i')&cd
LAPACKE_zsytri2x=: (liblapacke,' LAPACKE_zsytri2x >+ i i c i *j i *i i')&cd
LAPACKE_zsytri2x_work=: (liblapacke,' LAPACKE_zsytri2x_work >+ i i c i *j i *i *j i')&cd
LAPACKE_zsytrs2=: (liblapacke,' LAPACKE_zsytrs2 >+ i i c i i *j i *i *j i')&cd
LAPACKE_zsytrs2_work=: (liblapacke,' LAPACKE_zsytrs2_work >+ i i c i i *j i *i *j i *j')&cd
LAPACKE_zunbdb=: (liblapacke,' LAPACKE_zunbdb >+ i i c c i i i *j i *j i *j i *j i *d *d *j *j *j *j')&cd
LAPACKE_zunbdb_work=: (liblapacke,' LAPACKE_zunbdb_work >+ i i c c i i i *j i *j i *j i *j i *d *d *j *j *j *j *j i')&cd
LAPACKE_zuncsd=: (liblapacke,' LAPACKE_zuncsd >+ i i c c c c c c i i i *j i *j i *j i *j i *d *j i *j i *j i *j i')&cd
LAPACKE_zuncsd_work=: (liblapacke,' LAPACKE_zuncsd_work >+ i i c c c c c c i i i *j i *j i *j i *j i *d *j i *j i *j i *j i *j i *d i *i')&cd
LAPACKE_sgemqrt=: (liblapacke,' LAPACKE_sgemqrt >+ i i c c i i i i *f i *f i *f i')&cd
LAPACKE_dgemqrt=: (liblapacke,' LAPACKE_dgemqrt >+ i i c c i i i i *d i *d i *d i')&cd
LAPACKE_zgemqrt=: (liblapacke,' LAPACKE_zgemqrt >+ i i c c i i i i *j i *j i *j i')&cd
LAPACKE_sgeqrt=: (liblapacke,' LAPACKE_sgeqrt >+ i i i i i *f i *f i')&cd
LAPACKE_dgeqrt=: (liblapacke,' LAPACKE_dgeqrt >+ i i i i i *d i *d i')&cd
LAPACKE_zgeqrt=: (liblapacke,' LAPACKE_zgeqrt >+ i i i i i *j i *j i')&cd
LAPACKE_sgeqrt2=: (liblapacke,' LAPACKE_sgeqrt2 >+ i i i i *f i *f i')&cd
LAPACKE_dgeqrt2=: (liblapacke,' LAPACKE_dgeqrt2 >+ i i i i *d i *d i')&cd
LAPACKE_zgeqrt2=: (liblapacke,' LAPACKE_zgeqrt2 >+ i i i i *j i *j i')&cd
LAPACKE_sgeqrt3=: (liblapacke,' LAPACKE_sgeqrt3 >+ i i i i *f i *f i')&cd
LAPACKE_dgeqrt3=: (liblapacke,' LAPACKE_dgeqrt3 >+ i i i i *d i *d i')&cd
LAPACKE_zgeqrt3=: (liblapacke,' LAPACKE_zgeqrt3 >+ i i i i *j i *j i')&cd
LAPACKE_stpmqrt=: (liblapacke,' LAPACKE_stpmqrt >+ i i c c i i i i i *f i *f i *f i *f i')&cd
LAPACKE_dtpmqrt=: (liblapacke,' LAPACKE_dtpmqrt >+ i i c c i i i i i *d i *d i *d i *d i')&cd
LAPACKE_ztpmqrt=: (liblapacke,' LAPACKE_ztpmqrt >+ i i c c i i i i i *j i *j i *j i *j i')&cd
LAPACKE_dtpqrt=: (liblapacke,' LAPACKE_dtpqrt >+ i i i i i i *d i *d i *d i')&cd
LAPACKE_ztpqrt=: (liblapacke,' LAPACKE_ztpqrt >+ i i i i i i *j i *j i *j i')&cd
LAPACKE_stpqrt2=: (liblapacke,' LAPACKE_stpqrt2 >+ i i i i i *f i *f i *f i')&cd
LAPACKE_dtpqrt2=: (liblapacke,' LAPACKE_dtpqrt2 >+ i i i i i *d i *d i *d i')&cd
LAPACKE_ztpqrt2=: (liblapacke,' LAPACKE_ztpqrt2 >+ i i i i i *j i *j i *j i')&cd
LAPACKE_stprfb=: (liblapacke,' LAPACKE_stprfb >+ i i c c c c i i i i *f i *f i *f i *f i')&cd
LAPACKE_dtprfb=: (liblapacke,' LAPACKE_dtprfb >+ i i c c c c i i i i *d i *d i *d i *d i')&cd
LAPACKE_ztprfb=: (liblapacke,' LAPACKE_ztprfb >+ i i c c c c i i i i *j i *j i *j i *j i')&cd
LAPACKE_sgemqrt_work=: (liblapacke,' LAPACKE_sgemqrt_work >+ i i c c i i i i *f i *f i *f i *f')&cd
LAPACKE_dgemqrt_work=: (liblapacke,' LAPACKE_dgemqrt_work >+ i i c c i i i i *d i *d i *d i *d')&cd
LAPACKE_zgemqrt_work=: (liblapacke,' LAPACKE_zgemqrt_work >+ i i c c i i i i *j i *j i *j i *j')&cd
LAPACKE_sgeqrt_work=: (liblapacke,' LAPACKE_sgeqrt_work >+ i i i i i *f i *f i *f')&cd
LAPACKE_dgeqrt_work=: (liblapacke,' LAPACKE_dgeqrt_work >+ i i i i i *d i *d i *d')&cd
LAPACKE_zgeqrt_work=: (liblapacke,' LAPACKE_zgeqrt_work >+ i i i i i *j i *j i *j')&cd
LAPACKE_sgeqrt2_work=: (liblapacke,' LAPACKE_sgeqrt2_work >+ i i i i *f i *f i')&cd
LAPACKE_dgeqrt2_work=: (liblapacke,' LAPACKE_dgeqrt2_work >+ i i i i *d i *d i')&cd
LAPACKE_zgeqrt2_work=: (liblapacke,' LAPACKE_zgeqrt2_work >+ i i i i *j i *j i')&cd
LAPACKE_sgeqrt3_work=: (liblapacke,' LAPACKE_sgeqrt3_work >+ i i i i *f i *f i')&cd
LAPACKE_dgeqrt3_work=: (liblapacke,' LAPACKE_dgeqrt3_work >+ i i i i *d i *d i')&cd
LAPACKE_zgeqrt3_work=: (liblapacke,' LAPACKE_zgeqrt3_work >+ i i i i *j i *j i')&cd
LAPACKE_stpmqrt_work=: (liblapacke,' LAPACKE_stpmqrt_work >+ i i c c i i i i i *f i *f i *f i *f i *f')&cd
LAPACKE_dtpmqrt_work=: (liblapacke,' LAPACKE_dtpmqrt_work >+ i i c c i i i i i *d i *d i *d i *d i *d')&cd
LAPACKE_ztpmqrt_work=: (liblapacke,' LAPACKE_ztpmqrt_work >+ i i c c i i i i i *j i *j i *j i *j i *j')&cd
LAPACKE_dtpqrt_work=: (liblapacke,' LAPACKE_dtpqrt_work >+ i i i i i i *d i *d i *d i *d')&cd
LAPACKE_ztpqrt_work=: (liblapacke,' LAPACKE_ztpqrt_work >+ i i i i i i *j i *j i *j i *j')&cd
LAPACKE_stpqrt2_work=: (liblapacke,' LAPACKE_stpqrt2_work >+ i i i i i *f i *f i *f i')&cd
LAPACKE_dtpqrt2_work=: (liblapacke,' LAPACKE_dtpqrt2_work >+ i i i i i *d i *d i *d i')&cd
LAPACKE_ztpqrt2_work=: (liblapacke,' LAPACKE_ztpqrt2_work >+ i i i i i *j i *j i *j i')&cd
LAPACKE_stprfb_work=: (liblapacke,' LAPACKE_stprfb_work >+ i i c c c c i i i i *f i *f i *f i *f i *f i')&cd
LAPACKE_dtprfb_work=: (liblapacke,' LAPACKE_dtprfb_work >+ i i c c c c i i i i *d i *d i *d i *d i *d i')&cd
LAPACKE_ztprfb_work=: (liblapacke,' LAPACKE_ztprfb_work >+ i i c c c c i i i i *j i *j i *j i *j i *d i')&cd
LAPACKE_zsyr=: (liblapacke,' LAPACKE_zsyr >+ i i c i j *j i *j i')&cd
LAPACKE_zsyr_work=: (liblapacke,' LAPACKE_zsyr_work >+ i i c i j *j i *j i')&cd
LAPACKE_ilaver=: (liblapacke,' LAPACKE_ilaver >+ n *i *i *i')&cd

NB. lapack utils
NB.
NB. z2d           convert complex to float datatype if zero imagine part
NB.
NB. matchclean    if clean x-y is all 0
NB.
NB. diagmat       rectangular diagonal matrix
NB. idmat         rectangular identity matrix with shifted diagonal
NB. ltmat         lower triangular (trapezoidal) matrix
NB. utmat         upper triangular (trapezoidal) matrix
NB.
NB. ltri          return only lower triangular (trapezoidal) matrix
NB. utri          return only upper triangular (trapezoidal) matrix
NB. sltri         return only strictly lower triangular (trapezoidal) matrix
NB. sutri         return only strictly upper triangular (trapezoidal) matrix
NB.
NB. cxpair        reconstruct complex columns
NB. xtoken        exclude tokens with indices in x from list y
NB. invperm       inverse permutation of x by pivot indices
NB.               from y
NB. makepermat    generate inverse permutation matrix P from
NB.               pivot indices y

izero=: 23-23
ione=: 23-22
dzero=: 1.1-1.1
done=: 2.1-1.1
zzero=: 1j1-1j1
zone=: 2j1-1j1

z2d=: [ ^: (-. @ -:) (9 & o.)

mp=: +/ . *

NB. from general/numeric
NB. =========================================================
NB.*clean v clean y to tolerance of x (default 1e_10)
NB. form: tolerance (default 1e_10) clean numbers
NB. sets values less than tolerance to 0
clean=: 1e_10&$: : (4 : 0)
if. L. y do.
  x clean each y
else.
  if. (3!:0 y) e. 16 16384 do.
    j./"1 y * x <: | y=. +.y
  else.
    y * x <: |y
  end.
end.
)

NB. =========================================================
matchclean=: 0: *./ . = clean @ , @: -

NB. =========================================================
NB. diagmat   rectangular diagonal matrix with y on diagonal
NB. x=rows-columns , x=0 is default
NB. e.g.
NB.    diagmat 3 5 7
NB. 3 0 0
NB. 0 5 0
NB. 0 0 7
NB.    1 diagmat 3 5 7
NB. 3 0 0
NB. 0 5 0
NB. 0 0 7
NB. 0 0 0
NB.    _1 diagmat 3 5 7
NB. 3 0 0 0
NB. 0 5 0 0
NB. 0 0 7 0

diagmat=: (0 $: ]) :(((0 (>. , -@<.) [) + #@]) {. (* =@i.@#)@])

NB. =========================================================
NB. idmat   rectangular identity matrix with shifted diagonal
NB. e.g.
NB.    idmat 3
NB. 1 0 0
NB. 0 1 0
NB. 0 0 1
NB.    idmat 3 4
NB. 1 0 0 0
NB. 0 1 0 0
NB. 0 0 1 0
NB.    1 idmat 3 4
NB. 0 1 0 0
NB. 0 0 1 0
NB. 0 0 0 1

idmat=: (0 $: ]) :(= ({. -~/&i. {:)@])

NB. =========================================================
NB. ltmat   lower triangular (trapezoidal) boolean matrix
NB. e.g.
NB.    ltmat 3
NB. 1 0 0
NB. 1 1 0
NB. 1 1 1
NB.    ltmat 3 5
NB. 1 0 0 0 0
NB. 1 1 0 0 0
NB. 1 1 1 0 0
NB.    1 ltmat 3 5
NB. 1 1 0 0 0
NB. 1 1 1 0 0
NB. 1 1 1 1 0

ltmat=: (0 $: ]) :(>: ({. -~/&i. {:)@])

NB. =========================================================
NB. utmat   upper triangular (trapezoidal) boolean matrix
NB. e.g.
NB.    utmat 3
NB. 1 1 1
NB. 0 1 1
NB. 0 0 1
NB.    utmat 3 5
NB. 1 1 1 1 1
NB. 0 1 1 1 1
NB. 0 0 1 1 1
NB.    1 utmat 3 5
NB. 0 1 1 1 1
NB. 0 0 1 1 1
NB. 0 0 0 1 1

utmat=: (0 $: ]) :(<: ({. -~/&i. {:)@])

NB. =========================================================
NB. ltri   return only lower triangular (trapezoidal) matrix
NB. e.g.
NB.   ltri 3 5 $ 2
NB. 2 0 0 0 0
NB. 2 2 0 0 0
NB. 2 2 2 0 0
NB.    1 ltri 3 5 $ 2
NB. 2 2 0 0 0
NB. 2 2 2 0 0
NB. 2 2 2 2 0

ltri=: (0 $: ]) : (] * (>: ({. -~/&i. {:)@$@]))

NB. =========================================================
NB. utri   return only upper triangular (trapezoidal) matrix
NB. e.g.
NB.    utri 3 5 $ 2
NB. 2 2 2 2 2
NB. 0 2 2 2 2
NB. 0 0 2 2 2
NB.    1 utri 3 5 $ 2
NB. 0 2 2 2 2
NB. 0 0 2 2 2
NB. 0 0 0 2 2

utri=: (0 $: ]) : (] * (<: ({. -~/&i. {:)@$@]))

NB. =========================================================
NB. sltri   return only strictly lower triangular (trapezoidal) matrix
NB. e.g.
NB.    sltri 3 5 $ 2
NB. 0 0 0 0 0
NB. 2 0 0 0 0
NB. 2 2 0 0 0
NB.    1 sltri 3 5 $ 2
NB. 2 0 0 0 0
NB. 2 2 0 0 0
NB. 2 2 2 0 0

sltri=: (0 $: ]) : (] * (> ({. -~/&i. {:)@$@]))

NB. =========================================================
NB. sutri   return only strictly upper triangular (trapezoidal) matrix
NB. e.g.
NB.    sutri 3 5 $ 2
NB. 0 2 2 2 2
NB. 0 0 2 2 2
NB. 0 0 0 2 2
NB.    1 sutri 3 5 $ 2
NB. 0 0 2 2 2
NB. 0 0 0 2 2
NB. 0 0 0 0 2

sutri=: (0 $: ]) : (] * (< ({. -~/&i. {:)@$@]))

NB. =========================================================
NB. cxpair - reconstruct complex columns

cxpair=: 4 : 0
'i j'=: |: _2 [\ x
r=. i {"1 y
z=. j. j {"1 y
n=. (r+z) ,. r-z
n (i,j)}"1 y
)

NB. =========================================================
NB. pivot indices utilities
NB.
NB. pivot indices come from DGETRF, ZGETRF etc. as IPIV;
NB. IPIV(i) and i are 1-based numbers of rows, mutually
NB. interchanged in table
NB.
NB. invperm    - inverse permutation of x by pivot indices
NB.              from y
NB. makepermat - generate inverse permutation matrix P from
NB.              pivot indices y

NB. ipiv2scrp=: ((}: ^: ({. -: {:)) &. >)@(<"1)@(i.@# ,. <:)  NB. pivot indices to standard cycle representation of the permutation
ipiv2scrp=: <"1@(#~ ~:/"1)@(i.@# ,. <:)  NB. pivot indices to standard cycle representation of the permutation
invperm=: C.~ ipiv2scrp
makepermat=: C. @ ipiv2scrp =/ i. @ #
