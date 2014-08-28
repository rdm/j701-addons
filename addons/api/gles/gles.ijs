coclass 'jgles'

GL_DX_ANGLE=: 0-:(1 0&-:@('libGLESv2.dll glGetError i'&cd ::cder))`1:@.IFUNIX ''
GL_ES_VERSION_2_0=: IFIOS +. (UNAME-:'Android') +. GL_DX_ANGLE
3 : 0''
if. 0~: 4!:0<'ADD_GLSL_VERSION' do. ADD_GLSL_VERSION=: 0 end.
if. 0~: 4!:0<'ADD_GLSL_ES_VERSION' do. ADD_GLSL_ES_VERSION=: 0 end.
if. 0~: 4!:0<'EMU_GLES' do.EMU_GLES=: 0 end.
EMU_GLES=: EMU_GLES > IFIOS +. UNAME-:'Android'
EMU_GLES=: EMU_GLES +. GL_DX_ANGLE
''
)

GLPROC_Initialized=: -. IFWIN > EMU_GLES

3 : 0''
if. UNAME-:'Win' do.
  if. EMU_GLES do.
    libgles=: <'libGLESv2.dll'
    glXGetProcAddress=: 'libEGL.dll eglGetProcAddress > x *c'&(15!:0)
  else.
    libgles=: <'opengl32.dll'
    OBJ_BITMAP=: 7
    SRCCOPY=: 16bcc0020
    SIZEBITMAP=: 24
    DIB_RGB_COLORS=: 0

    BitBlt=: 'gdi32 BitBlt i x i i i i x i i i'&(15!:0)
    ChoosePixelFormat=: 'gdi32 ChoosePixelFormat > i x *c'&(15!:0)
    CreateCompatibleBitmap=: 'gdi32 CreateCompatibleBitmap > x x i i'&(15!:0)
    CreateCompatibleDC=: 'gdi32 CreateCompatibleDC > x x'&(15!:0)
    CreateDIBSection=: 'gdi32 CreateDIBSection x x *c i *x x i'&(15!:0)
    CreateFont=: 'gdi32 CreateFontA x i i i i i i i i i i i i i *c'&(15!:0)
    DeleteDC=: 'gdi32 DeleteDC > i x'&(15!:0)
    ResetDC=: 'gdi32 ResetDC > i x'&(15!:0)
    DeleteObject=: 'gdi32 DeleteObject > i x'&(15!:0)
    GetCurrentObject=: 'gdi32 GetCurrentObject > x x i'&(15!:0)
    GetObject=: 'gdi32 GetObjectW > i x i x'&(15!:0)
    GetDC=: 'user32 GetDC > x x'&(15!:0)
    ReleaseDC=: 'user32 ReleaseDC > i x x'&(15!:0)
    SelectObject=: 'gdi32 SelectObject > x x x'&(15!:0)
    SetPixelFormat=: 'gdi32 SetPixelFormat > i x i *c'&(15!:0)
    SwapBuffers=: 'gdi32 SwapBuffers > i x'&(15!:0)

    wglCreateContext=: 'opengl32.dll wglCreateContext > x x'&(15!:0)
    wglDeleteContext=: 'opengl32.dll wglDeleteContext > i x'&(15!:0)
    wglGetCurrentContext=: 'opengl32.dll wglGetCurrentContext > x'&(15!:0)
    wglGetCurrentDC=: 'opengl32.dll wglGetCurrentDC > x'&(15!:0)
    wglMakeCurrent=: 'opengl32.dll wglMakeCurrent > i x x'&(15!:0)
    wglSwapBuffers=: 'opengl32.dll wglSwapBuffers > i x'&(15!:0)
    wglUseFontBitmapsA=: 'opengl32.dll wglUseFontBitmapsA i x i i i'&(15!:0)
    wglUseFontOutlinesA=: 'opengl32.dll wglUseFontOutlinesA i x i i i f f i *f'&(15!:0)

    wglGetProcAddress=: 'opengl32.dll wglGetProcAddress > x *c'&(15!:0)
  end.
elseif. UNAME-:'Linux' do.
  libgles=: <'libGL.so.1 '
  glXGetProcAddress=: 'libGL.so.1 glXGetProcAddress > x *c'&(15!:0)
elseif. UNAME-:'Android' do.
  libgles=: <'libGLESv2.so'
elseif. UNAME-:'Darwin' do.
  libgles=: <'/System/Library/Frameworks/OpenGL.framework/Libraries/libGL.dylib'
end.
''
)
aglGetProcAddress=: 3 : 0
y=. <'_',>y
if. 0= 'libdl.dylib NSIsSymbolNameDefined > s *c'&(15!:0) y do. 0 return. end.
if. 0= symbol=. 'libdl.dylib NSLookupAndBindSymbol > x *c'&(15!:0) y do. 0 return. end.
'libdl.dylib NSAddressOfSymbol > x x'&(15!:0) symbol
)
cddefgl=: 4 : 0
y=. dtb (y i. ':'){.y
if. 0=#y do. '' return. end.
n=. y i. ' '
f=. n {. y
d=. (_2 * (<_2{.f) e. '_1';'_2';'_3') }. f
p=. n }. y
(f)=: (x,' ',d,p)&(15!:0)
''
)
cddefgl2=: 3 : 0
y=. dtb (y i. ':'){.y
if. 0=#y do. '' return. end.
n=. y i. ' '
f=. n {. y
d=. (_2 * (<_2{.f) e. '_1';'_2';'_3') }. f
p=. n }. y
(f)=: ('0 ',(":".d,'PROC_jgles_'), p)&(15!:0)
''
)
wglPROC=: 3 : 0
if. GLPROC_Initialized do. '' return. end.
g=. aglGetProcAddress`wglGetProcAddress`glXGetProcAddress@.(('Darwin';'Win')i.<UNAME)
(p,&.><'PROC_jgles_')=: g "0 p=. ({.~ i.&' ')&.> GLES_FUNC
f=. 0~: ". &> (p,&.><'PROC_jgles_')
cddefgl2_jgles_ &.> f#GLES_FUNC
GLPROC_Initialized=: 1
''
)
GLES_FUNC_2=: 0 : 0
glClearIndex > n f                                 : void glClearIndex (GLfloat);
glClearColor > n f f f f                           : void glClearColor (GLclampf, GLclampf, GLclampf, GLclampf);
glClear > n i                                      : void glClear (GLbitfield);
glIndexMask > n i                                  : void glIndexMask (GLuint);
glColorMask > n s s s s                            : void glColorMask (GLboolean, GLboolean, GLboolean, GLboolean);
glAlphaFunc > n i f                                : void glAlphaFunc (GLenum, GLclampf);
glBlendFunc > n i i                                : void glBlendFunc (GLenum, GLenum);
glLogicOp > n i                                    : void glLogicOp (GLenum);
glCullFace > n i                                   : void glCullFace (GLenum);
glFrontFace > n i                                  : void glFrontFace (GLenum);
glPointSize > n f                                  : void glPointSize (GLfloat);
glLineWidth > n f                                  : void glLineWidth (GLfloat);
glLineStipple > n i s                              : void glLineStipple (GLint, GLushort);
glPolygonMode > n i i                              : void glPolygonMode (GLenum, GLenum);
glPolygonOffset > n f f                            : void glPolygonOffset (GLfloat, GLfloat);
glPolygonStipple > n *c                            : void glPolygonStipple (GLubyte *);
glGetPolygonStipple > n *c                         : void glGetPolygonStipple (GLubyte *);
glEdgeFlag > n s                                   : void glEdgeFlag (GLboolean);
glEdgeFlagv > n *s                                 : void glEdgeFlagv (GLboolean *);
glScissor > n i i i i                              : void glScissor (GLint, GLint, GLsizei, GLsizei);
glClipPlane > n i *d                               : void glClipPlane (GLenum, GLdouble *);
glGetClipPlane > n i *d                            : void glGetClipPlane (GLenum, GLdouble *);
glDrawBuffer > n i                                 : void glDrawBuffer (GLenum);
glReadBuffer > n i                                 : void glReadBuffer (GLenum);
glEnable > n i                                     : void glEnable (GLenum);
glDisable > n i                                    : void glDisable (GLenum);
glIsEnabled > s i                                  : GLboolean glIsEnabled (GLenum);
glEnableClientState > n i                          : void glEnableClientState (GLenum);
glDisableClientState > n i                         : void glDisableClientState (GLenum);
glGetBooleanv > n i *s                             : void glGetBooleanv (GLenum, GLboolean *);
glGetDoublev > n i *d                              : void glGetDoublev (GLenum, GLdouble *);
glGetFloatv > n i *f                               : void glGetFloatv (GLenum, GLfloat *);
glGetIntegerv > n i *i                             : void glGetIntegerv (GLenum, GLint *);
glPushAttrib > n i                                 : void glPushAttrib (GLbitfield);
glPopAttrib > n                                    : void glPopAttrib (void);
glPushClientAttrib > n i                           : void glPushClientAttrib (GLbitfield);
glPopClientAttrib > n                              : void glPopClientAttrib (void);
glRenderMode > i i                                 : GLint glRenderMode (GLenum);
glGetError > i                                     : GLenum glGetError (void);
glGetString > x i                                  : GLubyte *glGetString (GLenum);
glFinish > n                                       : void glFinish (void);
glFlush > n                                        : void glFlush (void);
glHint > n i i                                     : void glHint (GLenum, GLenum);
glClearDepth > n d                                 : void glClearDepth (GLclampd);
glDepthFunc > n i                                  : void glDepthFunc (GLenum);
glDepthMask > n s                                  : void glDepthMask (GLboolean);
glDepthRange > n d d                               : void glDepthRange (GLclampd, GLclampd);
glClearAccum > n f f f f                           : void glClearAccum (GLfloat, GLfloat, GLfloat, GLfloat);
glAccum > n i f                                    : void glAccum (GLenum, GLfloat);
glMatrixMode > n i                                 : void glMatrixMode (GLenum);
glOrtho > n d d d d d d                            : void glOrtho (GLdouble, GLdouble, GLdouble, GLdouble, GLdouble, GLdouble);
glFrustum > n d d d d d d                          : void glFrustum (GLdouble, GLdouble, GLdouble, GLdouble, GLdouble, GLdouble);
glViewport > n i i i i                             : void glViewport (GLint, GLint, GLsizei, GLsizei);
glPushMatrix > n                                   : void glPushMatrix (void);
glPopMatrix > n                                    : void glPopMatrix (void);
glLoadIdentity > n                                 : void glLoadIdentity (void);
glLoadMatrixd > n *d                               : void glLoadMatrixd (GLdouble *);
glLoadMatrixf > n *f                               : void glLoadMatrixf (GLfloat *);
glMultMatrixd > n *d                               : void glMultMatrixd (GLdouble *);
glMultMatrixf > n *f                               : void glMultMatrixf (GLfloat *);
glRotated > n d d d d                              : void glRotated (GLdouble, GLdouble, GLdouble, GLdouble);
glRotatef > n f f f f                              : void glRotatef (GLfloat, GLfloat, GLfloat, GLfloat);
glScaled > n d d d                                 : void glScaled (GLdouble, GLdouble, GLdouble);
glScalef > n f f f                                 : void glScalef (GLfloat, GLfloat, GLfloat);
glTranslated > n d d d                             : void glTranslated (GLdouble, GLdouble, GLdouble);
glTranslatef > n f f f                             : void glTranslatef (GLfloat, GLfloat, GLfloat);
glIsList > s i                                     : GLboolean glIsList (GLuint);
glDeleteLists > n i i                              : void glDeleteLists (GLuint, GLsizei);
glGenLists > i i                                   : GLuint glGenLists (GLsizei);
glNewList > n i i                                  : void glNewList (GLuint, GLenum);
glEndList > n                                      : void glEndList (void);
glCallList > n i                                   : void glCallList (GLuint);
glCallLists > n i i *x                             : void glCallLists (GLsizei, GLenum, GLvoid *);
glListBase > n i                                   : void glListBase (GLuint);
glBegin > n i                                      : void glBegin (GLenum);
glEnd > n                                          : void glEnd (void);
glVertex2d > n d d                                 : void glVertex2d (GLdouble, GLdouble);
glVertex2f > n f f                                 : void glVertex2f (GLfloat, GLfloat);
glVertex2i > n i i                                 : void glVertex2i (GLint, GLint);
glVertex2s > n s s                                 : void glVertex2s (GLshort, GLshort);
glVertex3d > n d d d                               : void glVertex3d (GLdouble, GLdouble, GLdouble);
glVertex3f > n f f f                               : void glVertex3f (GLfloat, GLfloat, GLfloat);
glVertex3i > n i i i                               : void glVertex3i (GLint, GLint, GLint);
glVertex3s > n s s s                               : void glVertex3s (GLshort, GLshort, GLshort);
glVertex4d > n d d d d                             : void glVertex4d (GLdouble, GLdouble, GLdouble, GLdouble);
glVertex4f > n f f f f                             : void glVertex4f (GLfloat, GLfloat, GLfloat, GLfloat);
glVertex4i > n i i i i                             : void glVertex4i (GLint, GLint, GLint, GLint);
glVertex4s > n s s s s                             : void glVertex4s (GLshort, GLshort, GLshort, GLshort);
glVertex2dv > n *d                                 : void glVertex2dv (GLdouble *);
glVertex2fv > n *f                                 : void glVertex2fv (GLfloat *);
glVertex2iv > n *i                                 : void glVertex2iv (GLint *);
glVertex2sv > n *s                                 : void glVertex2sv (GLshort *);
glVertex3dv > n *d                                 : void glVertex3dv (GLdouble *);
glVertex3fv > n *f                                 : void glVertex3fv (GLfloat *);
glVertex3iv > n *i                                 : void glVertex3iv (GLint *);
glVertex3sv > n *s                                 : void glVertex3sv (GLshort *);
glVertex4dv > n *d                                 : void glVertex4dv (GLdouble *);
glVertex4fv > n *f                                 : void glVertex4fv (GLfloat *);
glVertex4iv > n *i                                 : void glVertex4iv (GLint *);
glVertex4sv > n *s                                 : void glVertex4sv (GLshort *);
glNormal3b > n c c c                               : void glNormal3b (GLbyte, GLbyte, GLbyte);
glNormal3d > n d d d                               : void glNormal3d (GLdouble, GLdouble, GLdouble);
glNormal3f > n f f f                               : void glNormal3f (GLfloat, GLfloat, GLfloat);
glNormal3i > n i i i                               : void glNormal3i (GLint, GLint, GLint);
glNormal3s > n s s s                               : void glNormal3s (GLshort, GLshort, GLshort);
glNormal3bv > n *c                                 : void glNormal3bv (GLbyte *);
glNormal3dv > n *d                                 : void glNormal3dv (GLdouble *);
glNormal3fv > n *f                                 : void glNormal3fv (GLfloat *);
glNormal3iv > n *i                                 : void glNormal3iv (GLint *);
glNormal3sv > n *s                                 : void glNormal3sv (GLshort *);
glIndexd > n d                                     : void glIndexd (GLdouble);
glIndexf > n f                                     : void glIndexf (GLfloat);
glIndexi > n i                                     : void glIndexi (GLint);
glIndexs > n s                                     : void glIndexs (GLshort);
glIndexub > n c                                    : void glIndexub (GLubyte);
glIndexdv > n *d                                   : void glIndexdv (GLdouble *);
glIndexfv > n *f                                   : void glIndexfv (GLfloat *);
glIndexiv > n *i                                   : void glIndexiv (GLint *);
glIndexsv > n *s                                   : void glIndexsv (GLshort *);
glIndexubv > n *c                                  : void glIndexubv (GLubyte *);
glColor3b > n c c c                                : void glColor3b (GLbyte, GLbyte, GLbyte);
glColor3d > n d d d                                : void glColor3d (GLdouble, GLdouble, GLdouble);
glColor3f > n f f f                                : void glColor3f (GLfloat, GLfloat, GLfloat);
glColor3i > n i i i                                : void glColor3i (GLint, GLint, GLint);
glColor3s > n s s s                                : void glColor3s (GLshort, GLshort, GLshort);
glColor3ub > n c c c                               : void glColor3ub (GLubyte, GLubyte, GLubyte);
glColor3ui > n i i i                               : void glColor3ui (GLuint, GLuint, GLuint);
glColor3us > n s s s                               : void glColor3us (GLushort, GLushort, GLushort);
glColor4b > n c c c c                              : void glColor4b (GLbyte, GLbyte, GLbyte, GLbyte);
glColor4d > n d d d d                              : void glColor4d (GLdouble, GLdouble, GLdouble, GLdouble);
glColor4f > n f f f f                              : void glColor4f (GLfloat, GLfloat, GLfloat, GLfloat);
glColor4i > n i i i i                              : void glColor4i (GLint, GLint, GLint, GLint);
glColor4s > n s s s s                              : void glColor4s (GLshort, GLshort, GLshort, GLshort);
glColor4ub > n c c c c                             : void glColor4ub (GLubyte, GLubyte, GLubyte, GLubyte);
glColor4ui > n i i i i                             : void glColor4ui (GLuint, GLuint, GLuint, GLuint);
glColor4us > n s s s s                             : void glColor4us (GLushort, GLushort, GLushort, GLushort);
glColor3bv > n *c                                  : void glColor3bv (GLbyte *);
glColor3dv > n *d                                  : void glColor3dv (GLdouble *);
glColor3fv > n *f                                  : void glColor3fv (GLfloat *);
glColor3iv > n *i                                  : void glColor3iv (GLint *);
glColor3sv > n *s                                  : void glColor3sv (GLshort *);
glColor3ubv > n *c                                 : void glColor3ubv (GLubyte *);
glColor3uiv > n *i                                 : void glColor3uiv (GLuint *);
glColor3usv > n *s                                 : void glColor3usv (GLushort *);
glColor4bv > n *c                                  : void glColor4bv (GLbyte *);
glColor4dv > n *d                                  : void glColor4dv (GLdouble *);
glColor4fv > n *f                                  : void glColor4fv (GLfloat *);
glColor4iv > n *i                                  : void glColor4iv (GLint *);
glColor4sv > n *s                                  : void glColor4sv (GLshort *);
glColor4ubv > n *c                                 : void glColor4ubv (GLubyte *);
glColor4uiv > n *i                                 : void glColor4uiv (GLuint *);
glColor4usv > n *s                                 : void glColor4usv (GLushort *);
glTexCoord1d > n d                                 : void glTexCoord1d (GLdouble);
glTexCoord1f > n f                                 : void glTexCoord1f (GLfloat);
glTexCoord1i > n i                                 : void glTexCoord1i (GLint);
glTexCoord1s > n s                                 : void glTexCoord1s (GLshort);
glTexCoord2d > n d d                               : void glTexCoord2d (GLdouble, GLdouble);
glTexCoord2f > n f f                               : void glTexCoord2f (GLfloat, GLfloat);
glTexCoord2i > n i i                               : void glTexCoord2i (GLint, GLint);
glTexCoord2s > n s s                               : void glTexCoord2s (GLshort, GLshort);
glTexCoord3d > n d d d                             : void glTexCoord3d (GLdouble, GLdouble, GLdouble);
glTexCoord3f > n f f f                             : void glTexCoord3f (GLfloat, GLfloat, GLfloat);
glTexCoord3i > n i i i                             : void glTexCoord3i (GLint, GLint, GLint);
glTexCoord3s > n s s s                             : void glTexCoord3s (GLshort, GLshort, GLshort);
glTexCoord4d > n d d d d                           : void glTexCoord4d (GLdouble, GLdouble, GLdouble, GLdouble);
glTexCoord4f > n f f f f                           : void glTexCoord4f (GLfloat, GLfloat, GLfloat, GLfloat);
glTexCoord4i > n i i i i                           : void glTexCoord4i (GLint, GLint, GLint, GLint);
glTexCoord4s > n s s s s                           : void glTexCoord4s (GLshort, GLshort, GLshort, GLshort);
glTexCoord1dv > n *d                               : void glTexCoord1dv (GLdouble *);
glTexCoord1fv > n *f                               : void glTexCoord1fv (GLfloat *);
glTexCoord1iv > n *i                               : void glTexCoord1iv (GLint *);
glTexCoord1sv > n *s                               : void glTexCoord1sv (GLshort *);
glTexCoord2dv > n *d                               : void glTexCoord2dv (GLdouble *);
glTexCoord2fv > n *f                               : void glTexCoord2fv (GLfloat *);
glTexCoord2iv > n *i                               : void glTexCoord2iv (GLint *);
glTexCoord2sv > n *s                               : void glTexCoord2sv (GLshort *);
glTexCoord3dv > n *d                               : void glTexCoord3dv (GLdouble *);
glTexCoord3fv > n *f                               : void glTexCoord3fv (GLfloat *);
glTexCoord3iv > n *i                               : void glTexCoord3iv (GLint *);
glTexCoord3sv > n *s                               : void glTexCoord3sv (GLshort *);
glTexCoord4dv > n *d                               : void glTexCoord4dv (GLdouble *);
glTexCoord4fv > n *f                               : void glTexCoord4fv (GLfloat *);
glTexCoord4iv > n *i                               : void glTexCoord4iv (GLint *);
glTexCoord4sv > n *s                               : void glTexCoord4sv (GLshort *);
glRasterPos2d > n d d                              : void glRasterPos2d (GLdouble, GLdouble);
glRasterPos2f > n f f                              : void glRasterPos2f (GLfloat, GLfloat);
glRasterPos2i > n i i                              : void glRasterPos2i (GLint, GLint);
glRasterPos2s > n s s                              : void glRasterPos2s (GLshort, GLshort);
glRasterPos3d > n d d d                            : void glRasterPos3d (GLdouble, GLdouble, GLdouble);
glRasterPos3f > n f f f                            : void glRasterPos3f (GLfloat, GLfloat, GLfloat);
glRasterPos3i > n i i i                            : void glRasterPos3i (GLint, GLint, GLint);
glRasterPos3s > n s s s                            : void glRasterPos3s (GLshort, GLshort, GLshort);
glRasterPos4d > n d d d d                          : void glRasterPos4d (GLdouble, GLdouble, GLdouble, GLdouble);
glRasterPos4f > n f f f f                          : void glRasterPos4f (GLfloat, GLfloat, GLfloat, GLfloat);
glRasterPos4i > n i i i i                          : void glRasterPos4i (GLint, GLint, GLint, GLint);
glRasterPos4s > n s s s s                          : void glRasterPos4s (GLshort, GLshort, GLshort, GLshort);
glRasterPos2dv > n *d                              : void glRasterPos2dv (GLdouble *);
glRasterPos2fv > n *f                              : void glRasterPos2fv (GLfloat *);
glRasterPos2iv > n *i                              : void glRasterPos2iv (GLint *);
glRasterPos2sv > n *s                              : void glRasterPos2sv (GLshort *);
glRasterPos3dv > n *d                              : void glRasterPos3dv (GLdouble *);
glRasterPos3fv > n *f                              : void glRasterPos3fv (GLfloat *);
glRasterPos3iv > n *i                              : void glRasterPos3iv (GLint *);
glRasterPos3sv > n *s                              : void glRasterPos3sv (GLshort *);
glRasterPos4dv > n *d                              : void glRasterPos4dv (GLdouble *);
glRasterPos4fv > n *f                              : void glRasterPos4fv (GLfloat *);
glRasterPos4iv > n *i                              : void glRasterPos4iv (GLint *);
glRasterPos4sv > n *s                              : void glRasterPos4sv (GLshort *);
glRectd > n d d d d                                : void glRectd (GLdouble, GLdouble, GLdouble, GLdouble);
glRectf > n f f f f                                : void glRectf (GLfloat, GLfloat, GLfloat, GLfloat);
glRecti > n i i i i                                : void glRecti (GLint, GLint, GLint, GLint);
glRects > n s s s s                                : void glRects (GLshort, GLshort, GLshort, GLshort);
glRectdv > n *d *d                                 : void glRectdv (GLdouble *, GLdouble *);
glRectfv > n *f *f                                 : void glRectfv (GLfloat *, GLfloat *);
glRectiv > n *i *i                                 : void glRectiv (GLint *, GLint *);
glRectsv > n *s *s                                 : void glRectsv (GLshort *, GLshort *);
glVertexPointer > n i i i *x                       : void glVertexPointer (GLint, GLenum, GLsizei, GLvoid *);
glNormalPointer > n i i *x                         : void glNormalPointer (GLenum, GLsizei, GLvoid *);
glColorPointer > n i i i *x                        : void glColorPointer (GLint, GLenum, GLsizei, GLvoid *);
glIndexPointer > n i i *x                          : void glIndexPointer (GLenum, GLsizei, GLvoid *);
glTexCoordPointer > n i i i *x                     : void glTexCoordPointer (GLint, GLenum, GLsizei, GLvoid *);
glEdgeFlagPointer > n i *x                         : void glEdgeFlagPointer (GLsizei, GLvoid *);
glGetPointerv > n i *x                             : void glGetPointerv (GLenum, GLvoid **);
glArrayElement > n i                               : void glArrayElement (GLint);
glDrawArrays > n i i i                             : void glDrawArrays (GLenum, GLint, GLsizei);
glDrawElements > n i i i *x                        : void glDrawElements (GLenum, GLsizei, GLenum, GLvoid *);
glInterleavedArrays > n i i *x                     : void glInterleavedArrays (GLenum, GLsizei, GLvoid *);
glShadeModel > n i                                 : void glShadeModel (GLenum);
glLightf > n i i f                                 : void glLightf (GLenum, GLenum, GLfloat);
glLighti > n i i i                                 : void glLighti (GLenum, GLenum, GLint);
glLightfv > n i i *f                               : void glLightfv (GLenum, GLenum, GLfloat *);
glLightiv > n i i *i                               : void glLightiv (GLenum, GLenum, GLint *);
glGetLightfv > n i i *f                            : void glGetLightfv (GLenum, GLenum, GLfloat *);
glGetLightiv > n i i *i                            : void glGetLightiv (GLenum, GLenum, GLint *);
glLightModelf > n i f                              : void glLightModelf (GLenum, GLfloat);
glLightModeli > n i i                              : void glLightModeli (GLenum, GLint);
glLightModelfv > n i *f                            : void glLightModelfv (GLenum, GLfloat *);
glLightModeliv > n i *i                            : void glLightModeliv (GLenum, GLint *);
glMaterialf > n i i f                              : void glMaterialf (GLenum, GLenum, GLfloat);
glMateriali > n i i i                              : void glMateriali (GLenum, GLenum, GLint);
glMaterialfv > n i i *f                            : void glMaterialfv (GLenum, GLenum, GLfloat *);
glMaterialiv > n i i *i                            : void glMaterialiv (GLenum, GLenum, GLint *);
glGetMaterialfv > n i i *f                         : void glGetMaterialfv (GLenum, GLenum, GLfloat *);
glGetMaterialiv > n i i *i                         : void glGetMaterialiv (GLenum, GLenum, GLint *);
glColorMaterial > n i i                            : void glColorMaterial (GLenum, GLenum);
glPixelZoom > n f f                                : void glPixelZoom (GLfloat, GLfloat);
glPixelStoref > n i f                              : void glPixelStoref (GLenum, GLfloat);
glPixelStorei > n i i                              : void glPixelStorei (GLenum, GLint);
glPixelTransferf > n i f                           : void glPixelTransferf (GLenum, GLfloat);
glPixelTransferi > n i i                           : void glPixelTransferi (GLenum, GLint);
glPixelMapfv > n i i *f                            : void glPixelMapfv (GLenum, GLsizei, GLfloat *);
glPixelMapuiv > n i i *i                           : void glPixelMapuiv (GLenum, GLsizei, GLuint *);
glPixelMapusv > n i i *s                           : void glPixelMapusv (GLenum, GLsizei, GLushort *);
glGetPixelMapfv > n i *f                           : void glGetPixelMapfv (GLenum, GLfloat *);
glGetPixelMapuiv > n i *i                          : void glGetPixelMapuiv (GLenum, GLuint *);
glGetPixelMapusv > n i *s                          : void glGetPixelMapusv (GLenum, GLushort *);
glBitmap > n i i f f f f *c                        : void glBitmap (GLsizei, GLsizei, GLfloat, GLfloat, GLfloat, GLfloat, GLubyte *);
glReadPixels > n i i i i i i *x                    : void glReadPixels (GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glDrawPixels > n i i i i *x                        : void glDrawPixels (GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glCopyPixels > n i i i i i                         : void glCopyPixels (GLint, GLint, GLsizei, GLsizei, GLenum);
glStencilFunc > n i i i                            : void glStencilFunc (GLenum, GLint, GLuint);
glStencilMask > n i                                : void glStencilMask (GLuint);
glStencilOp > n i i i                              : void glStencilOp (GLenum, GLenum, GLenum);
glClearStencil > n i                               : void glClearStencil (GLint);
glTexGend > n i i d                                : void glTexGend (GLenum, GLenum, GLdouble);
glTexGenf > n i i f                                : void glTexGenf (GLenum, GLenum, GLfloat);
glTexGeni > n i i i                                : void glTexGeni (GLenum, GLenum, GLint);
glTexGendv > n i i *d                              : void glTexGendv (GLenum, GLenum, GLdouble *);
glTexGenfv > n i i *f                              : void glTexGenfv (GLenum, GLenum, GLfloat *);
glTexGeniv > n i i *i                              : void glTexGeniv (GLenum, GLenum, GLint *);
glGetTexGendv > n i i *d                           : void glGetTexGendv (GLenum, GLenum, GLdouble *);
glGetTexGenfv > n i i *f                           : void glGetTexGenfv (GLenum, GLenum, GLfloat *);
glGetTexGeniv > n i i *i                           : void glGetTexGeniv (GLenum, GLenum, GLint *);
glTexEnvf > n i i f                                : void glTexEnvf (GLenum, GLenum, GLfloat);
glTexEnvi > n i i i                                : void glTexEnvi (GLenum, GLenum, GLint);
glTexEnvfv > n i i *f                              : void glTexEnvfv (GLenum, GLenum, GLfloat *);
glTexEnviv > n i i *i                              : void glTexEnviv (GLenum, GLenum, GLint *);
glGetTexEnvfv > n i i *f                           : void glGetTexEnvfv (GLenum, GLenum, GLfloat *);
glGetTexEnviv > n i i *i                           : void glGetTexEnviv (GLenum, GLenum, GLint *);
glTexParameterf > n i i f                          : void glTexParameterf (GLenum, GLenum, GLfloat);
glTexParameteri > n i i i                          : void glTexParameteri (GLenum, GLenum, GLint);
glTexParameterfv > n i i *f                        : void glTexParameterfv (GLenum, GLenum, GLfloat *);
glTexParameteriv > n i i *i                        : void glTexParameteriv (GLenum, GLenum, GLint *);
glGetTexParameterfv > n i i *f                     : void glGetTexParameterfv (GLenum, GLenum, GLfloat *);
glGetTexParameteriv > n i i *i                     : void glGetTexParameteriv (GLenum, GLenum, GLint *);
glGetTexLevelParameterfv > n i i i *f              : void glGetTexLevelParameterfv (GLenum, GLint, GLenum, GLfloat *);
glGetTexLevelParameteriv > n i i i *i              : void glGetTexLevelParameteriv (GLenum, GLint, GLenum, GLint *);
glTexImage1D > n i i i i i i i *x                  : void glTexImage1D (GLenum, GLint, GLint, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glTexImage2D > n i i i i i i i i *x                : void glTexImage2D (GLenum, GLint, GLint, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glGetTexImage > n i i i i *x                       : void glGetTexImage (GLenum, GLint, GLenum, GLenum, GLvoid *);
glGenTextures > n i *i                             : void glGenTextures (GLsizei, GLuint *);
glDeleteTextures > n i *i                          : void glDeleteTextures (GLsizei, GLuint *);
glBindTexture > n i i                              : void glBindTexture (GLenum, GLuint);
glPrioritizeTextures > n i *i *f                   : void glPrioritizeTextures (GLsizei, GLuint *, GLclampf *);
glAreTexturesResident > s i *i *s                  : GLboolean glAreTexturesResident (GLsizei, GLuint *, GLboolean *);
glIsTexture > s i                                  : GLboolean glIsTexture (GLuint);
glTexSubImage1D > n i i i i i i *x                 : void glTexSubImage1D (GLenum, GLint, GLint, GLsizei, GLenum, GLenum, GLvoid *);
glTexSubImage2D > n i i i i i i i i *x             : void glTexSubImage2D (GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glCopyTexImage1D > n i i i i i i i                 : void glCopyTexImage1D (GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLint);
glCopyTexImage2D > n i i i i i i i i               : void glCopyTexImage2D (GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLsizei, GLint);
glCopyTexSubImage1D > n i i i i i i                : void glCopyTexSubImage1D (GLenum, GLint, GLint, GLint, GLint, GLsizei);
glCopyTexSubImage2D > n i i i i i i i i            : void glCopyTexSubImage2D (GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
glMap1d > n i d d i i *d                           : void glMap1d (GLenum, GLdouble, GLdouble, GLint, GLint, GLdouble *);
glMap1f > n i f f i i *f                           : void glMap1f (GLenum, GLfloat, GLfloat, GLint, GLint, GLfloat *);
glMap2d > n i d d i i d d i i *d                   : void glMap2d (GLenum, GLdouble, GLdouble, GLint, GLint, GLdouble, GLdouble, GLint, GLint, GLdouble *);
glMap2f > n i f f i i f f i i *f                   : void glMap2f (GLenum, GLfloat, GLfloat, GLint, GLint, GLfloat, GLfloat, GLint, GLint, GLfloat *);
glGetMapdv > n i i *d                              : void glGetMapdv (GLenum, GLenum, GLdouble *);
glGetMapfv > n i i *f                              : void glGetMapfv (GLenum, GLenum, GLfloat *);
glGetMapiv > n i i *i                              : void glGetMapiv (GLenum, GLenum, GLint *);
glEvalCoord1d > n d                                : void glEvalCoord1d (GLdouble);
glEvalCoord1f > n f                                : void glEvalCoord1f (GLfloat);
glEvalCoord1dv > n *d                              : void glEvalCoord1dv (GLdouble *);
glEvalCoord1fv > n *f                              : void glEvalCoord1fv (GLfloat *);
glEvalCoord2d > n d d                              : void glEvalCoord2d (GLdouble, GLdouble);
glEvalCoord2f > n f f                              : void glEvalCoord2f (GLfloat, GLfloat);
glEvalCoord2dv > n *d                              : void glEvalCoord2dv (GLdouble *);
glEvalCoord2fv > n *f                              : void glEvalCoord2fv (GLfloat *);
glMapGrid1d > n i d d                              : void glMapGrid1d (GLint, GLdouble, GLdouble);
glMapGrid1f > n i f f                              : void glMapGrid1f (GLint, GLfloat, GLfloat);
glMapGrid2d > n i d d i d d                        : void glMapGrid2d (GLint, GLdouble, GLdouble, GLint, GLdouble, GLdouble);
glMapGrid2f > n i f f i f f                        : void glMapGrid2f (GLint, GLfloat, GLfloat, GLint, GLfloat, GLfloat);
glEvalPoint1 > n i                                 : void glEvalPoint1 (GLint);
glEvalPoint2 > n i i                               : void glEvalPoint2 (GLint, GLint);
glEvalMesh1 > n i i i                              : void glEvalMesh1 (GLenum, GLint, GLint);
glEvalMesh2 > n i i i i i                          : void glEvalMesh2 (GLenum, GLint, GLint, GLint, GLint);
glFogf > n i f                                     : void glFogf (GLenum, GLfloat);
glFogi > n i i                                     : void glFogi (GLenum, GLint);
glFogfv > n i *f                                   : void glFogfv (GLenum, GLfloat *);
glFogiv > n i *i                                   : void glFogiv (GLenum, GLint *);
glFeedbackBuffer > n i i *f                        : void glFeedbackBuffer (GLsizei, GLenum, GLfloat *);
glPassThrough > n f                                : void glPassThrough (GLfloat);
glSelectBuffer > n i *i                            : void glSelectBuffer (GLsizei, GLuint *);
glInitNames > n                                    : void glInitNames (void);
glLoadName > n i                                   : void glLoadName (GLuint);
glPushName > n i                                   : void glPushName (GLuint);
glPopName > n                                      : void glPopName (void);
glDrawRangeElements > n i i i i i *x               : void glDrawRangeElements (GLenum, GLuint, GLuint, GLsizei, GLenum, GLvoid *);
glTexImage3D > n i i i i i i i i i *x              : void glTexImage3D (GLenum, GLint, GLint, GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glTexSubImage3D > n i i i i i i i i i i *x         : void glTexSubImage3D (GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glCopyTexSubImage3D > n i i i i i i i i i          : void glCopyTexSubImage3D (GLenum, GLint, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
glColorTable > n i i i i i *x                      : void glColorTable (GLenum, GLenum, GLsizei, GLenum, GLenum, GLvoid *);
glColorSubTable > n i i i i i *x                   : void glColorSubTable (GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glColorTableParameteriv > n i i *i                 : void glColorTableParameteriv (GLenum, GLenum, GLint *);
glColorTableParameterfv > n i i *f                 : void glColorTableParameterfv (GLenum, GLenum, GLfloat *);
glCopyColorSubTable > n i i i i i                  : void glCopyColorSubTable (GLenum, GLsizei, GLint, GLint, GLsizei);
glCopyColorTable > n i i i i i                     : void glCopyColorTable (GLenum, GLenum, GLint, GLint, GLsizei);
glGetColorTable > n i i i *x                       : void glGetColorTable (GLenum, GLenum, GLenum, GLvoid *);
glGetColorTableParameterfv > n i i *f              : void glGetColorTableParameterfv (GLenum, GLenum, GLfloat *);
glGetColorTableParameteriv > n i i *i              : void glGetColorTableParameteriv (GLenum, GLenum, GLint *);
glBlendEquation > n i                              : void glBlendEquation (GLenum);
glBlendColor > n f f f f                           : void glBlendColor (GLclampf, GLclampf, GLclampf, GLclampf);
glHistogram > n i i i s                            : void glHistogram (GLenum, GLsizei, GLenum, GLboolean);
glResetHistogram > n i                             : void glResetHistogram (GLenum);
glGetHistogram > n i s i i *x                      : void glGetHistogram (GLenum, GLboolean, GLenum, GLenum, GLvoid *);
glGetHistogramParameterfv > n i i *f               : void glGetHistogramParameterfv (GLenum, GLenum, GLfloat *);
glGetHistogramParameteriv > n i i *i               : void glGetHistogramParameteriv (GLenum, GLenum, GLint *);
glMinmax > n i i s                                 : void glMinmax (GLenum, GLenum, GLboolean);
glResetMinmax > n i                                : void glResetMinmax (GLenum);
glGetMinmax > n i s i i *x                         : void glGetMinmax (GLenum, GLboolean, GLenum, GLenum, GLvoid *);
glGetMinmaxParameterfv > n i i *f                  : void glGetMinmaxParameterfv (GLenum, GLenum, GLfloat *);
glGetMinmaxParameteriv > n i i *i                  : void glGetMinmaxParameteriv (GLenum, GLenum, GLint *);
glConvolutionFilter1D > n i i i i i *x             : void glConvolutionFilter1D (GLenum, GLenum, GLsizei, GLenum, GLenum, GLvoid *);
glConvolutionFilter2D > n i i i i i i *x           : void glConvolutionFilter2D (GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glConvolutionParameterf > n i i f                  : void glConvolutionParameterf (GLenum, GLenum, GLfloat);
glConvolutionParameterfv > n i i *f                : void glConvolutionParameterfv (GLenum, GLenum, GLfloat *);
glConvolutionParameteri > n i i i                  : void glConvolutionParameteri (GLenum, GLenum, GLint);
glConvolutionParameteriv > n i i *i                : void glConvolutionParameteriv (GLenum, GLenum, GLint *);
glCopyConvolutionFilter1D > n i i i i i            : void glCopyConvolutionFilter1D (GLenum, GLenum, GLint, GLint, GLsizei);
glCopyConvolutionFilter2D > n i i i i i i          : void glCopyConvolutionFilter2D (GLenum, GLenum, GLint, GLint, GLsizei, GLsizei);
glGetConvolutionFilter > n i i i *x                : void glGetConvolutionFilter (GLenum, GLenum, GLenum, GLvoid *);
glGetConvolutionParameterfv > n i i *f             : void glGetConvolutionParameterfv (GLenum, GLenum, GLfloat *);
glGetConvolutionParameteriv > n i i *i             : void glGetConvolutionParameteriv (GLenum, GLenum, GLint *);
glSeparableFilter2D > n i i i i i i *x *x          : void glSeparableFilter2D (GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid *, GLvoid *);
glGetSeparableFilter > n i i i *x *x *x            : void glGetSeparableFilter (GLenum, GLenum, GLenum, GLvoid *, GLvoid *, GLvoid *);
glActiveTexture > n i                              : void glActiveTexture (GLenum);
glClientActiveTexture > n i                        : void glClientActiveTexture (GLenum);
glCompressedTexImage1D > n i i i i i i *x          : void glCompressedTexImage1D (GLenum, GLint, GLenum, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedTexImage2D > n i i i i i i i *x        : void glCompressedTexImage2D (GLenum, GLint, GLenum, GLsizei, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedTexImage3D > n i i i i i i i i *x      : void glCompressedTexImage3D (GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedTexSubImage1D > n i i i i i i *x       : void glCompressedTexSubImage1D (GLenum, GLint, GLint, GLsizei, GLenum, GLsizei, GLvoid *);
glCompressedTexSubImage2D > n i i i i i i i i *x   : void glCompressedTexSubImage2D (GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLsizei, GLvoid *);
glCompressedTexSubImage3D > n i i i i i i i i i i *x : void glCompressedTexSubImage3D (GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, GLvoid *);
glGetCompressedTexImage > n i i *x                 : void glGetCompressedTexImage (GLenum, GLint, GLvoid *);
glMultiTexCoord1d > n i d                          : void glMultiTexCoord1d (GLenum, GLdouble);
glMultiTexCoord1dv > n i *d                        : void glMultiTexCoord1dv (GLenum, GLdouble *);
glMultiTexCoord1f > n i f                          : void glMultiTexCoord1f (GLenum, GLfloat);
glMultiTexCoord1fv > n i *f                        : void glMultiTexCoord1fv (GLenum, GLfloat *);
glMultiTexCoord1i > n i i                          : void glMultiTexCoord1i (GLenum, GLint);
glMultiTexCoord1iv > n i *i                        : void glMultiTexCoord1iv (GLenum, GLint *);
glMultiTexCoord1s > n i s                          : void glMultiTexCoord1s (GLenum, GLshort);
glMultiTexCoord1sv > n i *s                        : void glMultiTexCoord1sv (GLenum, GLshort *);
glMultiTexCoord2d > n i d d                        : void glMultiTexCoord2d (GLenum, GLdouble, GLdouble);
glMultiTexCoord2dv > n i *d                        : void glMultiTexCoord2dv (GLenum, GLdouble *);
glMultiTexCoord2f > n i f f                        : void glMultiTexCoord2f (GLenum, GLfloat, GLfloat);
glMultiTexCoord2fv > n i *f                        : void glMultiTexCoord2fv (GLenum, GLfloat *);
glMultiTexCoord2i > n i i i                        : void glMultiTexCoord2i (GLenum, GLint, GLint);
glMultiTexCoord2iv > n i *i                        : void glMultiTexCoord2iv (GLenum, GLint *);
glMultiTexCoord2s > n i s s                        : void glMultiTexCoord2s (GLenum, GLshort, GLshort);
glMultiTexCoord2sv > n i *s                        : void glMultiTexCoord2sv (GLenum, GLshort *);
glMultiTexCoord3d > n i d d d                      : void glMultiTexCoord3d (GLenum, GLdouble, GLdouble, GLdouble);
glMultiTexCoord3dv > n i *d                        : void glMultiTexCoord3dv (GLenum, GLdouble *);
glMultiTexCoord3f > n i f f f                      : void glMultiTexCoord3f (GLenum, GLfloat, GLfloat, GLfloat);
glMultiTexCoord3fv > n i *f                        : void glMultiTexCoord3fv (GLenum, GLfloat *);
glMultiTexCoord3i > n i i i i                      : void glMultiTexCoord3i (GLenum, GLint, GLint, GLint);
glMultiTexCoord3iv > n i *i                        : void glMultiTexCoord3iv (GLenum, GLint *);
glMultiTexCoord3s > n i s s s                      : void glMultiTexCoord3s (GLenum, GLshort, GLshort, GLshort);
glMultiTexCoord3sv > n i *s                        : void glMultiTexCoord3sv (GLenum, GLshort *);
glMultiTexCoord4d > n i d d d d                    : void glMultiTexCoord4d (GLenum, GLdouble, GLdouble, GLdouble, GLdouble);
glMultiTexCoord4dv > n i *d                        : void glMultiTexCoord4dv (GLenum, GLdouble *);
glMultiTexCoord4f > n i f f f f                    : void glMultiTexCoord4f (GLenum, GLfloat, GLfloat, GLfloat, GLfloat);
glMultiTexCoord4fv > n i *f                        : void glMultiTexCoord4fv (GLenum, GLfloat *);
glMultiTexCoord4i > n i i i i i                    : void glMultiTexCoord4i (GLenum, GLint, GLint, GLint, GLint);
glMultiTexCoord4iv > n i *i                        : void glMultiTexCoord4iv (GLenum, GLint *);
glMultiTexCoord4s > n i s s s s                    : void glMultiTexCoord4s (GLenum, GLshort, GLshort, GLshort, GLshort);
glMultiTexCoord4sv > n i *s                        : void glMultiTexCoord4sv (GLenum, GLshort *);
glLoadTransposeMatrixd > n *d                      : void glLoadTransposeMatrixd (GLdouble *);
glLoadTransposeMatrixf > n *f                      : void glLoadTransposeMatrixf (GLfloat *);
glMultTransposeMatrixd > n *d                      : void glMultTransposeMatrixd (GLdouble *);
glMultTransposeMatrixf > n *f                      : void glMultTransposeMatrixf (GLfloat *);
glSampleCoverage > n f s                           : void glSampleCoverage (GLclampf, GLboolean);
glActiveTextureARB > n i                           : void glActiveTextureARB (GLenum);
glClientActiveTextureARB > n i                     : void glClientActiveTextureARB (GLenum);
glMultiTexCoord1dARB > n i d                       : void glMultiTexCoord1dARB (GLenum, GLdouble);
glMultiTexCoord1dvARB > n i *d                     : void glMultiTexCoord1dvARB (GLenum, GLdouble *);
glMultiTexCoord1fARB > n i f                       : void glMultiTexCoord1fARB (GLenum, GLfloat);
glMultiTexCoord1fvARB > n i *f                     : void glMultiTexCoord1fvARB (GLenum, GLfloat *);
glMultiTexCoord1iARB > n i i                       : void glMultiTexCoord1iARB (GLenum, GLint);
glMultiTexCoord1ivARB > n i *i                     : void glMultiTexCoord1ivARB (GLenum, GLint *);
glMultiTexCoord1sARB > n i s                       : void glMultiTexCoord1sARB (GLenum, GLshort);
glMultiTexCoord1svARB > n i *s                     : void glMultiTexCoord1svARB (GLenum, GLshort *);
glMultiTexCoord2dARB > n i d d                     : void glMultiTexCoord2dARB (GLenum, GLdouble, GLdouble);
glMultiTexCoord2dvARB > n i *d                     : void glMultiTexCoord2dvARB (GLenum, GLdouble *);
glMultiTexCoord2fARB > n i f f                     : void glMultiTexCoord2fARB (GLenum, GLfloat, GLfloat);
glMultiTexCoord2fvARB > n i *f                     : void glMultiTexCoord2fvARB (GLenum, GLfloat *);
glMultiTexCoord2iARB > n i i i                     : void glMultiTexCoord2iARB (GLenum, GLint, GLint);
glMultiTexCoord2ivARB > n i *i                     : void glMultiTexCoord2ivARB (GLenum, GLint *);
glMultiTexCoord2sARB > n i s s                     : void glMultiTexCoord2sARB (GLenum, GLshort, GLshort);
glMultiTexCoord2svARB > n i *s                     : void glMultiTexCoord2svARB (GLenum, GLshort *);
glMultiTexCoord3dARB > n i d d d                   : void glMultiTexCoord3dARB (GLenum, GLdouble, GLdouble, GLdouble);
glMultiTexCoord3dvARB > n i *d                     : void glMultiTexCoord3dvARB (GLenum, GLdouble *);
glMultiTexCoord3fARB > n i f f f                   : void glMultiTexCoord3fARB (GLenum, GLfloat, GLfloat, GLfloat);
glMultiTexCoord3fvARB > n i *f                     : void glMultiTexCoord3fvARB (GLenum, GLfloat *);
glMultiTexCoord3iARB > n i i i i                   : void glMultiTexCoord3iARB (GLenum, GLint, GLint, GLint);
glMultiTexCoord3ivARB > n i *i                     : void glMultiTexCoord3ivARB (GLenum, GLint *);
glMultiTexCoord3sARB > n i s s s                   : void glMultiTexCoord3sARB (GLenum, GLshort, GLshort, GLshort);
glMultiTexCoord3svARB > n i *s                     : void glMultiTexCoord3svARB (GLenum, GLshort *);
glMultiTexCoord4dARB > n i d d d d                 : void glMultiTexCoord4dARB (GLenum, GLdouble, GLdouble, GLdouble, GLdouble);
glMultiTexCoord4dvARB > n i *d                     : void glMultiTexCoord4dvARB (GLenum, GLdouble *);
glMultiTexCoord4fARB > n i f f f f                 : void glMultiTexCoord4fARB (GLenum, GLfloat, GLfloat, GLfloat, GLfloat);
glMultiTexCoord4fvARB > n i *f                     : void glMultiTexCoord4fvARB (GLenum, GLfloat *);
glMultiTexCoord4iARB > n i i i i i                 : void glMultiTexCoord4iARB (GLenum, GLint, GLint, GLint, GLint);
glMultiTexCoord4ivARB > n i *i                     : void glMultiTexCoord4ivARB (GLenum, GLint *);
glMultiTexCoord4sARB > n i s s s s                 : void glMultiTexCoord4sARB (GLenum, GLshort, GLshort, GLshort, GLshort);
glMultiTexCoord4svARB > n i *s                     : void glMultiTexCoord4svARB (GLenum, GLshort *);
imaxabs > x x                                      : intmax_t imaxabs (intmax_t);
imaxdiv > x x x                                    : imaxdiv_t imaxdiv (intmax_t, intmax_t);
strtoimax > x *c *x i                              : intmax_t strtoimax (char *, char **, int);
strtoumax > x *c *x i                              : uintmax_t strtoumax (char *, char **, int);
wcstoimax > x *i *x i                              : intmax_t wcstoimax (__gwchar_t *, __gwchar_t **, int);
wcstoumax > x *i *x i                              : uintmax_t wcstoumax (__gwchar_t *, __gwchar_t **, int);
glColorTable > n i i i i i *x                      : void glColorTable (GLenum, GLenum, GLsizei, GLenum, GLenum, GLvoid *);
glColorTableParameterfv > n i i *f                 : void glColorTableParameterfv (GLenum, GLenum, GLfloat *);
glColorTableParameteriv > n i i *i                 : void glColorTableParameteriv (GLenum, GLenum, GLint *);
glCopyColorTable > n i i i i i                     : void glCopyColorTable (GLenum, GLenum, GLint, GLint, GLsizei);
glGetColorTable > n i i i *x                       : void glGetColorTable (GLenum, GLenum, GLenum, GLvoid *);
glGetColorTableParameterfv > n i i *f              : void glGetColorTableParameterfv (GLenum, GLenum, GLfloat *);
glGetColorTableParameteriv > n i i *i              : void glGetColorTableParameteriv (GLenum, GLenum, GLint *);
glColorSubTable > n i i i i i *x                   : void glColorSubTable (GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glCopyColorSubTable > n i i i i i                  : void glCopyColorSubTable (GLenum, GLsizei, GLint, GLint, GLsizei);
glConvolutionFilter1D > n i i i i i *x             : void glConvolutionFilter1D (GLenum, GLenum, GLsizei, GLenum, GLenum, GLvoid *);
glConvolutionFilter2D > n i i i i i i *x           : void glConvolutionFilter2D (GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glConvolutionParameterf > n i i f                  : void glConvolutionParameterf (GLenum, GLenum, GLfloat);
glConvolutionParameterfv > n i i *f                : void glConvolutionParameterfv (GLenum, GLenum, GLfloat *);
glConvolutionParameteri > n i i i                  : void glConvolutionParameteri (GLenum, GLenum, GLint);
glConvolutionParameteriv > n i i *i                : void glConvolutionParameteriv (GLenum, GLenum, GLint *);
glCopyConvolutionFilter1D > n i i i i i            : void glCopyConvolutionFilter1D (GLenum, GLenum, GLint, GLint, GLsizei);
glCopyConvolutionFilter2D > n i i i i i i          : void glCopyConvolutionFilter2D (GLenum, GLenum, GLint, GLint, GLsizei, GLsizei);
glGetConvolutionFilter > n i i i *x                : void glGetConvolutionFilter (GLenum, GLenum, GLenum, GLvoid *);
glGetConvolutionParameterfv > n i i *f             : void glGetConvolutionParameterfv (GLenum, GLenum, GLfloat *);
glGetConvolutionParameteriv > n i i *i             : void glGetConvolutionParameteriv (GLenum, GLenum, GLint *);
glGetSeparableFilter > n i i i *x *x *x            : void glGetSeparableFilter (GLenum, GLenum, GLenum, GLvoid *, GLvoid *, GLvoid *);
glSeparableFilter2D > n i i i i i i *x *x          : void glSeparableFilter2D (GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid *, GLvoid *);
glGetHistogram > n i s i i *x                      : void glGetHistogram (GLenum, GLboolean, GLenum, GLenum, GLvoid *);
glGetHistogramParameterfv > n i i *f               : void glGetHistogramParameterfv (GLenum, GLenum, GLfloat *);
glGetHistogramParameteriv > n i i *i               : void glGetHistogramParameteriv (GLenum, GLenum, GLint *);
glGetMinmax > n i s i i *x                         : void glGetMinmax (GLenum, GLboolean, GLenum, GLenum, GLvoid *);
glGetMinmaxParameterfv > n i i *f                  : void glGetMinmaxParameterfv (GLenum, GLenum, GLfloat *);
glGetMinmaxParameteriv > n i i *i                  : void glGetMinmaxParameteriv (GLenum, GLenum, GLint *);
glHistogram > n i i i s                            : void glHistogram (GLenum, GLsizei, GLenum, GLboolean);
glMinmax > n i i s                                 : void glMinmax (GLenum, GLenum, GLboolean);
glResetHistogram > n i                             : void glResetHistogram (GLenum);
glResetMinmax > n i                                : void glResetMinmax (GLenum);
glClientActiveTexture > n i                        : void glClientActiveTexture (GLenum);
glMultiTexCoord1d > n i d                          : void glMultiTexCoord1d (GLenum, GLdouble);
glMultiTexCoord1dv > n i *d                        : void glMultiTexCoord1dv (GLenum, GLdouble *);
glMultiTexCoord1f > n i f                          : void glMultiTexCoord1f (GLenum, GLfloat);
glMultiTexCoord1fv > n i *f                        : void glMultiTexCoord1fv (GLenum, GLfloat *);
glMultiTexCoord1i > n i i                          : void glMultiTexCoord1i (GLenum, GLint);
glMultiTexCoord1iv > n i *i                        : void glMultiTexCoord1iv (GLenum, GLint *);
glMultiTexCoord1s > n i s                          : void glMultiTexCoord1s (GLenum, GLshort);
glMultiTexCoord1sv > n i *s                        : void glMultiTexCoord1sv (GLenum, GLshort *);
glMultiTexCoord2d > n i d d                        : void glMultiTexCoord2d (GLenum, GLdouble, GLdouble);
glMultiTexCoord2dv > n i *d                        : void glMultiTexCoord2dv (GLenum, GLdouble *);
glMultiTexCoord2f > n i f f                        : void glMultiTexCoord2f (GLenum, GLfloat, GLfloat);
glMultiTexCoord2fv > n i *f                        : void glMultiTexCoord2fv (GLenum, GLfloat *);
glMultiTexCoord2i > n i i i                        : void glMultiTexCoord2i (GLenum, GLint, GLint);
glMultiTexCoord2iv > n i *i                        : void glMultiTexCoord2iv (GLenum, GLint *);
glMultiTexCoord2s > n i s s                        : void glMultiTexCoord2s (GLenum, GLshort, GLshort);
glMultiTexCoord2sv > n i *s                        : void glMultiTexCoord2sv (GLenum, GLshort *);
glMultiTexCoord3d > n i d d d                      : void glMultiTexCoord3d (GLenum, GLdouble, GLdouble, GLdouble);
glMultiTexCoord3dv > n i *d                        : void glMultiTexCoord3dv (GLenum, GLdouble *);
glMultiTexCoord3f > n i f f f                      : void glMultiTexCoord3f (GLenum, GLfloat, GLfloat, GLfloat);
glMultiTexCoord3fv > n i *f                        : void glMultiTexCoord3fv (GLenum, GLfloat *);
glMultiTexCoord3i > n i i i i                      : void glMultiTexCoord3i (GLenum, GLint, GLint, GLint);
glMultiTexCoord3iv > n i *i                        : void glMultiTexCoord3iv (GLenum, GLint *);
glMultiTexCoord3s > n i s s s                      : void glMultiTexCoord3s (GLenum, GLshort, GLshort, GLshort);
glMultiTexCoord3sv > n i *s                        : void glMultiTexCoord3sv (GLenum, GLshort *);
glMultiTexCoord4d > n i d d d d                    : void glMultiTexCoord4d (GLenum, GLdouble, GLdouble, GLdouble, GLdouble);
glMultiTexCoord4dv > n i *d                        : void glMultiTexCoord4dv (GLenum, GLdouble *);
glMultiTexCoord4f > n i f f f f                    : void glMultiTexCoord4f (GLenum, GLfloat, GLfloat, GLfloat, GLfloat);
glMultiTexCoord4fv > n i *f                        : void glMultiTexCoord4fv (GLenum, GLfloat *);
glMultiTexCoord4i > n i i i i i                    : void glMultiTexCoord4i (GLenum, GLint, GLint, GLint, GLint);
glMultiTexCoord4iv > n i *i                        : void glMultiTexCoord4iv (GLenum, GLint *);
glMultiTexCoord4s > n i s s s s                    : void glMultiTexCoord4s (GLenum, GLshort, GLshort, GLshort, GLshort);
glMultiTexCoord4sv > n i *s                        : void glMultiTexCoord4sv (GLenum, GLshort *);
glLoadTransposeMatrixf > n *f                      : void glLoadTransposeMatrixf (GLfloat *);
glLoadTransposeMatrixd > n *d                      : void glLoadTransposeMatrixd (GLdouble *);
glMultTransposeMatrixf > n *f                      : void glMultTransposeMatrixf (GLfloat *);
glMultTransposeMatrixd > n *d                      : void glMultTransposeMatrixd (GLdouble *);
glBlendFuncSeparate > n i i i i                    : void glBlendFuncSeparate (GLenum, GLenum, GLenum, GLenum);
glMultiDrawArrays > n i *i *i i                    : void glMultiDrawArrays (GLenum, GLint *, GLsizei *, GLsizei);
glMultiDrawElements > n i *i i *x i                : void glMultiDrawElements (GLenum, GLsizei *, GLenum, GLvoid **, GLsizei);
glPointParameterf > n i f                          : void glPointParameterf (GLenum, GLfloat);
glPointParameterfv > n i *f                        : void glPointParameterfv (GLenum, GLfloat *);
glPointParameteri > n i i                          : void glPointParameteri (GLenum, GLint);
glPointParameteriv > n i *i                        : void glPointParameteriv (GLenum, GLint *);
glFogCoordf > n f                                  : void glFogCoordf (GLfloat);
glFogCoordfv > n *f                                : void glFogCoordfv (GLfloat *);
glFogCoordd > n d                                  : void glFogCoordd (GLdouble);
glFogCoorddv > n *d                                : void glFogCoorddv (GLdouble *);
glFogCoordPointer > n i i *x                       : void glFogCoordPointer (GLenum, GLsizei, GLvoid *);
glSecondaryColor3b > n c c c                       : void glSecondaryColor3b (GLbyte, GLbyte, GLbyte);
glSecondaryColor3bv > n *c                         : void glSecondaryColor3bv (GLbyte *);
glSecondaryColor3d > n d d d                       : void glSecondaryColor3d (GLdouble, GLdouble, GLdouble);
glSecondaryColor3dv > n *d                         : void glSecondaryColor3dv (GLdouble *);
glSecondaryColor3f > n f f f                       : void glSecondaryColor3f (GLfloat, GLfloat, GLfloat);
glSecondaryColor3fv > n *f                         : void glSecondaryColor3fv (GLfloat *);
glSecondaryColor3i > n i i i                       : void glSecondaryColor3i (GLint, GLint, GLint);
glSecondaryColor3iv > n *i                         : void glSecondaryColor3iv (GLint *);
glSecondaryColor3s > n s s s                       : void glSecondaryColor3s (GLshort, GLshort, GLshort);
glSecondaryColor3sv > n *s                         : void glSecondaryColor3sv (GLshort *);
glSecondaryColor3ub > n c c c                      : void glSecondaryColor3ub (GLubyte, GLubyte, GLubyte);
glSecondaryColor3ubv > n *c                        : void glSecondaryColor3ubv (GLubyte *);
glSecondaryColor3ui > n i i i                      : void glSecondaryColor3ui (GLuint, GLuint, GLuint);
glSecondaryColor3uiv > n *i                        : void glSecondaryColor3uiv (GLuint *);
glSecondaryColor3us > n s s s                      : void glSecondaryColor3us (GLushort, GLushort, GLushort);
glSecondaryColor3usv > n *s                        : void glSecondaryColor3usv (GLushort *);
glSecondaryColorPointer > n i i i *x               : void glSecondaryColorPointer (GLint, GLenum, GLsizei, GLvoid *);
glWindowPos2d > n d d                              : void glWindowPos2d (GLdouble, GLdouble);
glWindowPos2dv > n *d                              : void glWindowPos2dv (GLdouble *);
glWindowPos2f > n f f                              : void glWindowPos2f (GLfloat, GLfloat);
glWindowPos2fv > n *f                              : void glWindowPos2fv (GLfloat *);
glWindowPos2i > n i i                              : void glWindowPos2i (GLint, GLint);
glWindowPos2iv > n *i                              : void glWindowPos2iv (GLint *);
glWindowPos2s > n s s                              : void glWindowPos2s (GLshort, GLshort);
glWindowPos2sv > n *s                              : void glWindowPos2sv (GLshort *);
glWindowPos3d > n d d d                            : void glWindowPos3d (GLdouble, GLdouble, GLdouble);
glWindowPos3dv > n *d                              : void glWindowPos3dv (GLdouble *);
glWindowPos3f > n f f f                            : void glWindowPos3f (GLfloat, GLfloat, GLfloat);
glWindowPos3fv > n *f                              : void glWindowPos3fv (GLfloat *);
glWindowPos3i > n i i i                            : void glWindowPos3i (GLint, GLint, GLint);
glWindowPos3iv > n *i                              : void glWindowPos3iv (GLint *);
glWindowPos3s > n s s s                            : void glWindowPos3s (GLshort, GLshort, GLshort);
glWindowPos3sv > n *s                              : void glWindowPos3sv (GLshort *);
glGenQueries > n i *i                              : void glGenQueries (GLsizei, GLuint *);
glDeleteQueries > n i *i                           : void glDeleteQueries (GLsizei, GLuint *);
glIsQuery > s i                                    : GLboolean glIsQuery (GLuint);
glBeginQuery > n i i                               : void glBeginQuery (GLenum, GLuint);
glEndQuery > n i                                   : void glEndQuery (GLenum);
glGetQueryiv > n i i *i                            : void glGetQueryiv (GLenum, GLenum, GLint *);
glGetQueryObjectiv > n i i *i                      : void glGetQueryObjectiv (GLuint, GLenum, GLint *);
glGetQueryObjectuiv > n i i *i                     : void glGetQueryObjectuiv (GLuint, GLenum, GLuint *);
glBindBuffer > n i i                               : void glBindBuffer (GLenum, GLuint);
glDeleteBuffers > n i *i                           : void glDeleteBuffers (GLsizei, GLuint *);
glGenBuffers > n i *i                              : void glGenBuffers (GLsizei, GLuint *);
glIsBuffer > s i                                   : GLboolean glIsBuffer (GLuint);
glBufferData > n i i *x i                          : void glBufferData (GLenum, GLsizeiptr, GLvoid *, GLenum);
glBufferSubData > n i i i *x                       : void glBufferSubData (GLenum, GLintptr, GLsizeiptr, GLvoid *);
glGetBufferSubData > n i i i *x                    : void glGetBufferSubData (GLenum, GLintptr, GLsizeiptr, GLvoid *);
glMapBuffer > x i i                                : GLvoid *glMapBuffer (GLenum, GLenum);
glUnmapBuffer > s i                                : GLboolean glUnmapBuffer (GLenum);
glGetBufferParameteriv > n i i *i                  : void glGetBufferParameteriv (GLenum, GLenum, GLint *);
glGetBufferPointerv > n i i *x                     : void glGetBufferPointerv (GLenum, GLenum, GLvoid **);
glBlendEquationSeparate > n i i                    : void glBlendEquationSeparate (GLenum, GLenum);
glDrawBuffers > n i *i                             : void glDrawBuffers (GLsizei, GLenum *);
glStencilOpSeparate > n i i i i                    : void glStencilOpSeparate (GLenum, GLenum, GLenum, GLenum);
glStencilFuncSeparate > n i i i i                  : void glStencilFuncSeparate (GLenum, GLenum, GLint, GLuint);
glStencilMaskSeparate > n i i                      : void glStencilMaskSeparate (GLenum, GLuint);
glAttachShader > n i i                             : void glAttachShader (GLuint, GLuint);
glBindAttribLocation > n i i *c                    : void glBindAttribLocation (GLuint, GLuint, GLchar *);
glCompileShader > n i                              : void glCompileShader (GLuint);
glCreateProgram > i                                : GLuint glCreateProgram (void);
glCreateShader > i i                               : GLuint glCreateShader (GLenum);
glDeleteProgram > n i                              : void glDeleteProgram (GLuint);
glDeleteShader > n i                               : void glDeleteShader (GLuint);
glDetachShader > n i i                             : void glDetachShader (GLuint, GLuint);
glDisableVertexAttribArray > n i                   : void glDisableVertexAttribArray (GLuint);
glEnableVertexAttribArray > n i                    : void glEnableVertexAttribArray (GLuint);
glGetActiveAttrib > n i i i *i *i *i *c            : void glGetActiveAttrib (GLuint, GLuint, GLsizei, GLsizei *, GLint *, GLenum *, GLchar *);
glGetActiveUniform > n i i i *i *i *i *c           : void glGetActiveUniform (GLuint, GLuint, GLsizei, GLsizei *, GLint *, GLenum *, GLchar *);
glGetAttachedShaders > n i i *i *i                 : void glGetAttachedShaders (GLuint, GLsizei, GLsizei *, GLuint *);
glGetAttribLocation > i i *c                       : GLint glGetAttribLocation (GLuint, GLchar *);
glGetProgramiv > n i i *i                          : void glGetProgramiv (GLuint, GLenum, GLint *);
glGetProgramInfoLog > n i i *i *c                  : void glGetProgramInfoLog (GLuint, GLsizei, GLsizei *, GLchar *);
glGetShaderiv > n i i *i                           : void glGetShaderiv (GLuint, GLenum, GLint *);
glGetShaderInfoLog > n i i *i *c                   : void glGetShaderInfoLog (GLuint, GLsizei, GLsizei *, GLchar *);
glGetShaderSource > n i i *i *c                    : void glGetShaderSource (GLuint, GLsizei, GLsizei *, GLchar *);
glGetUniformLocation > i i *c                      : GLint glGetUniformLocation (GLuint, GLchar *);
glGetUniformfv > n i i *f                          : void glGetUniformfv (GLuint, GLint, GLfloat *);
glGetUniformiv > n i i *i                          : void glGetUniformiv (GLuint, GLint, GLint *);
glGetVertexAttribdv > n i i *d                     : void glGetVertexAttribdv (GLuint, GLenum, GLdouble *);
glGetVertexAttribfv > n i i *f                     : void glGetVertexAttribfv (GLuint, GLenum, GLfloat *);
glGetVertexAttribiv > n i i *i                     : void glGetVertexAttribiv (GLuint, GLenum, GLint *);
glGetVertexAttribPointerv > n i i *x               : void glGetVertexAttribPointerv (GLuint, GLenum, GLvoid **);
glIsProgram > s i                                  : GLboolean glIsProgram (GLuint);
glIsShader > s i                                   : GLboolean glIsShader (GLuint);
glLinkProgram > n i                                : void glLinkProgram (GLuint);
glShaderSource > n i i *x *i                       : void glShaderSource (GLuint, GLsizei, GLchar **, GLint *);
glUseProgram > n i                                 : void glUseProgram (GLuint);
glUniform1f > n i f                                : void glUniform1f (GLint, GLfloat);
glUniform2f > n i f f                              : void glUniform2f (GLint, GLfloat, GLfloat);
glUniform3f > n i f f f                            : void glUniform3f (GLint, GLfloat, GLfloat, GLfloat);
glUniform4f > n i f f f f                          : void glUniform4f (GLint, GLfloat, GLfloat, GLfloat, GLfloat);
glUniform1i > n i i                                : void glUniform1i (GLint, GLint);
glUniform2i > n i i i                              : void glUniform2i (GLint, GLint, GLint);
glUniform3i > n i i i i                            : void glUniform3i (GLint, GLint, GLint, GLint);
glUniform4i > n i i i i i                          : void glUniform4i (GLint, GLint, GLint, GLint, GLint);
glUniform1fv > n i i *f                            : void glUniform1fv (GLint, GLsizei, GLfloat *);
glUniform2fv > n i i *f                            : void glUniform2fv (GLint, GLsizei, GLfloat *);
glUniform3fv > n i i *f                            : void glUniform3fv (GLint, GLsizei, GLfloat *);
glUniform4fv > n i i *f                            : void glUniform4fv (GLint, GLsizei, GLfloat *);
glUniform1iv > n i i *i                            : void glUniform1iv (GLint, GLsizei, GLint *);
glUniform2iv > n i i *i                            : void glUniform2iv (GLint, GLsizei, GLint *);
glUniform3iv > n i i *i                            : void glUniform3iv (GLint, GLsizei, GLint *);
glUniform4iv > n i i *i                            : void glUniform4iv (GLint, GLsizei, GLint *);
glUniformMatrix2fv > n i i s *f                    : void glUniformMatrix2fv (GLint, GLsizei, GLboolean, GLfloat *);
glUniformMatrix3fv > n i i s *f                    : void glUniformMatrix3fv (GLint, GLsizei, GLboolean, GLfloat *);
glUniformMatrix4fv > n i i s *f                    : void glUniformMatrix4fv (GLint, GLsizei, GLboolean, GLfloat *);
glValidateProgram > n i                            : void glValidateProgram (GLuint);
glVertexAttrib1d > n i d                           : void glVertexAttrib1d (GLuint, GLdouble);
glVertexAttrib1dv > n i *d                         : void glVertexAttrib1dv (GLuint, GLdouble *);
glVertexAttrib1f > n i f                           : void glVertexAttrib1f (GLuint, GLfloat);
glVertexAttrib1fv > n i *f                         : void glVertexAttrib1fv (GLuint, GLfloat *);
glVertexAttrib1s > n i s                           : void glVertexAttrib1s (GLuint, GLshort);
glVertexAttrib1sv > n i *s                         : void glVertexAttrib1sv (GLuint, GLshort *);
glVertexAttrib2d > n i d d                         : void glVertexAttrib2d (GLuint, GLdouble, GLdouble);
glVertexAttrib2dv > n i *d                         : void glVertexAttrib2dv (GLuint, GLdouble *);
glVertexAttrib2f > n i f f                         : void glVertexAttrib2f (GLuint, GLfloat, GLfloat);
glVertexAttrib2fv > n i *f                         : void glVertexAttrib2fv (GLuint, GLfloat *);
glVertexAttrib2s > n i s s                         : void glVertexAttrib2s (GLuint, GLshort, GLshort);
glVertexAttrib2sv > n i *s                         : void glVertexAttrib2sv (GLuint, GLshort *);
glVertexAttrib3d > n i d d d                       : void glVertexAttrib3d (GLuint, GLdouble, GLdouble, GLdouble);
glVertexAttrib3dv > n i *d                         : void glVertexAttrib3dv (GLuint, GLdouble *);
glVertexAttrib3f > n i f f f                       : void glVertexAttrib3f (GLuint, GLfloat, GLfloat, GLfloat);
glVertexAttrib3fv > n i *f                         : void glVertexAttrib3fv (GLuint, GLfloat *);
glVertexAttrib3s > n i s s s                       : void glVertexAttrib3s (GLuint, GLshort, GLshort, GLshort);
glVertexAttrib3sv > n i *s                         : void glVertexAttrib3sv (GLuint, GLshort *);
glVertexAttrib4Nbv > n i *c                        : void glVertexAttrib4Nbv (GLuint, GLbyte *);
glVertexAttrib4Niv > n i *i                        : void glVertexAttrib4Niv (GLuint, GLint *);
glVertexAttrib4Nsv > n i *s                        : void glVertexAttrib4Nsv (GLuint, GLshort *);
glVertexAttrib4Nub > n i c c c c                   : void glVertexAttrib4Nub (GLuint, GLubyte, GLubyte, GLubyte, GLubyte);
glVertexAttrib4Nubv > n i *c                       : void glVertexAttrib4Nubv (GLuint, GLubyte *);
glVertexAttrib4Nuiv > n i *i                       : void glVertexAttrib4Nuiv (GLuint, GLuint *);
glVertexAttrib4Nusv > n i *s                       : void glVertexAttrib4Nusv (GLuint, GLushort *);
glVertexAttrib4bv > n i *c                         : void glVertexAttrib4bv (GLuint, GLbyte *);
glVertexAttrib4d > n i d d d d                     : void glVertexAttrib4d (GLuint, GLdouble, GLdouble, GLdouble, GLdouble);
glVertexAttrib4dv > n i *d                         : void glVertexAttrib4dv (GLuint, GLdouble *);
glVertexAttrib4f > n i f f f f                     : void glVertexAttrib4f (GLuint, GLfloat, GLfloat, GLfloat, GLfloat);
glVertexAttrib4fv > n i *f                         : void glVertexAttrib4fv (GLuint, GLfloat *);
glVertexAttrib4iv > n i *i                         : void glVertexAttrib4iv (GLuint, GLint *);
glVertexAttrib4s > n i s s s s                     : void glVertexAttrib4s (GLuint, GLshort, GLshort, GLshort, GLshort);
glVertexAttrib4sv > n i *s                         : void glVertexAttrib4sv (GLuint, GLshort *);
glVertexAttrib4ubv > n i *c                        : void glVertexAttrib4ubv (GLuint, GLubyte *);
glVertexAttrib4uiv > n i *i                        : void glVertexAttrib4uiv (GLuint, GLuint *);
glVertexAttrib4usv > n i *s                        : void glVertexAttrib4usv (GLuint, GLushort *);
glVertexAttribPointer > n i i i s i *x             : void glVertexAttribPointer (GLuint, GLint, GLenum, GLboolean, GLsizei, GLvoid *);
glUniformMatrix2x3fv > n i i s *f                  : void glUniformMatrix2x3fv (GLint, GLsizei, GLboolean, GLfloat *);
glUniformMatrix3x2fv > n i i s *f                  : void glUniformMatrix3x2fv (GLint, GLsizei, GLboolean, GLfloat *);
glUniformMatrix2x4fv > n i i s *f                  : void glUniformMatrix2x4fv (GLint, GLsizei, GLboolean, GLfloat *);
glUniformMatrix4x2fv > n i i s *f                  : void glUniformMatrix4x2fv (GLint, GLsizei, GLboolean, GLfloat *);
glUniformMatrix3x4fv > n i i s *f                  : void glUniformMatrix3x4fv (GLint, GLsizei, GLboolean, GLfloat *);
glUniformMatrix4x3fv > n i i s *f                  : void glUniformMatrix4x3fv (GLint, GLsizei, GLboolean, GLfloat *);
glColorMaski > n i s s s s                         : void glColorMaski (GLuint, GLboolean, GLboolean, GLboolean, GLboolean);
glGetBooleani_v > n i i *s                         : void glGetBooleani_v (GLenum, GLuint, GLboolean *);
glGetIntegeri_v > n i i *i                         : void glGetIntegeri_v (GLenum, GLuint, GLint *);
glEnablei > n i i                                  : void glEnablei (GLenum, GLuint);
glDisablei > n i i                                 : void glDisablei (GLenum, GLuint);
glIsEnabledi > s i i                               : GLboolean glIsEnabledi (GLenum, GLuint);
glBeginTransformFeedback > n i                     : void glBeginTransformFeedback (GLenum);
glEndTransformFeedback > n                         : void glEndTransformFeedback (void);
glBindBufferRange > n i i i i i                    : void glBindBufferRange (GLenum, GLuint, GLuint, GLintptr, GLsizeiptr);
glBindBufferBase > n i i i                         : void glBindBufferBase (GLenum, GLuint, GLuint);
glTransformFeedbackVaryings > n i i *x i           : void glTransformFeedbackVaryings (GLuint, GLsizei, GLchar **, GLenum);
glGetTransformFeedbackVarying > n i i i *i *i *i *c : void glGetTransformFeedbackVarying (GLuint, GLuint, GLsizei, GLsizei *, GLsizei *, GLenum *, GLchar *);
glClampColor > n i i                               : void glClampColor (GLenum, GLenum);
glBeginConditionalRender > n i i                   : void glBeginConditionalRender (GLuint, GLenum);
glEndConditionalRender > n                         : void glEndConditionalRender (void);
glVertexAttribIPointer > n i i i i *x              : void glVertexAttribIPointer (GLuint, GLint, GLenum, GLsizei, GLvoid *);
glGetVertexAttribIiv > n i i *i                    : void glGetVertexAttribIiv (GLuint, GLenum, GLint *);
glGetVertexAttribIuiv > n i i *i                   : void glGetVertexAttribIuiv (GLuint, GLenum, GLuint *);
glVertexAttribI1i > n i i                          : void glVertexAttribI1i (GLuint, GLint);
glVertexAttribI2i > n i i i                        : void glVertexAttribI2i (GLuint, GLint, GLint);
glVertexAttribI3i > n i i i i                      : void glVertexAttribI3i (GLuint, GLint, GLint, GLint);
glVertexAttribI4i > n i i i i i                    : void glVertexAttribI4i (GLuint, GLint, GLint, GLint, GLint);
glVertexAttribI1ui > n i i                         : void glVertexAttribI1ui (GLuint, GLuint);
glVertexAttribI2ui > n i i i                       : void glVertexAttribI2ui (GLuint, GLuint, GLuint);
glVertexAttribI3ui > n i i i i                     : void glVertexAttribI3ui (GLuint, GLuint, GLuint, GLuint);
glVertexAttribI4ui > n i i i i i                   : void glVertexAttribI4ui (GLuint, GLuint, GLuint, GLuint, GLuint);
glVertexAttribI1iv > n i *i                        : void glVertexAttribI1iv (GLuint, GLint *);
glVertexAttribI2iv > n i *i                        : void glVertexAttribI2iv (GLuint, GLint *);
glVertexAttribI3iv > n i *i                        : void glVertexAttribI3iv (GLuint, GLint *);
glVertexAttribI4iv > n i *i                        : void glVertexAttribI4iv (GLuint, GLint *);
glVertexAttribI1uiv > n i *i                       : void glVertexAttribI1uiv (GLuint, GLuint *);
glVertexAttribI2uiv > n i *i                       : void glVertexAttribI2uiv (GLuint, GLuint *);
glVertexAttribI3uiv > n i *i                       : void glVertexAttribI3uiv (GLuint, GLuint *);
glVertexAttribI4uiv > n i *i                       : void glVertexAttribI4uiv (GLuint, GLuint *);
glVertexAttribI4bv > n i *c                        : void glVertexAttribI4bv (GLuint, GLbyte *);
glVertexAttribI4sv > n i *s                        : void glVertexAttribI4sv (GLuint, GLshort *);
glVertexAttribI4ubv > n i *c                       : void glVertexAttribI4ubv (GLuint, GLubyte *);
glVertexAttribI4usv > n i *s                       : void glVertexAttribI4usv (GLuint, GLushort *);
glGetUniformuiv > n i i *i                         : void glGetUniformuiv (GLuint, GLint, GLuint *);
glBindFragDataLocation > n i i *c                  : void glBindFragDataLocation (GLuint, GLuint, GLchar *);
glGetFragDataLocation > i i *c                     : GLint glGetFragDataLocation (GLuint, GLchar *);
glUniform1ui > n i i                               : void glUniform1ui (GLint, GLuint);
glUniform2ui > n i i i                             : void glUniform2ui (GLint, GLuint, GLuint);
glUniform3ui > n i i i i                           : void glUniform3ui (GLint, GLuint, GLuint, GLuint);
glUniform4ui > n i i i i i                         : void glUniform4ui (GLint, GLuint, GLuint, GLuint, GLuint);
glUniform1uiv > n i i *i                           : void glUniform1uiv (GLint, GLsizei, GLuint *);
glUniform2uiv > n i i *i                           : void glUniform2uiv (GLint, GLsizei, GLuint *);
glUniform3uiv > n i i *i                           : void glUniform3uiv (GLint, GLsizei, GLuint *);
glUniform4uiv > n i i *i                           : void glUniform4uiv (GLint, GLsizei, GLuint *);
glTexParameterIiv > n i i *i                       : void glTexParameterIiv (GLenum, GLenum, GLint *);
glTexParameterIuiv > n i i *i                      : void glTexParameterIuiv (GLenum, GLenum, GLuint *);
glGetTexParameterIiv > n i i *i                    : void glGetTexParameterIiv (GLenum, GLenum, GLint *);
glGetTexParameterIuiv > n i i *i                   : void glGetTexParameterIuiv (GLenum, GLenum, GLuint *);
glClearBufferiv > n i i *i                         : void glClearBufferiv (GLenum, GLint, GLint *);
glClearBufferuiv > n i i *i                        : void glClearBufferuiv (GLenum, GLint, GLuint *);
glClearBufferfv > n i i *f                         : void glClearBufferfv (GLenum, GLint, GLfloat *);
glClearBufferfi > n i i f i                        : void glClearBufferfi (GLenum, GLint, GLfloat, GLint);
glGetStringi > x i i                               : GLubyte *glGetStringi (GLenum, GLuint);
glDrawArraysInstanced > n i i i i                  : void glDrawArraysInstanced (GLenum, GLint, GLsizei, GLsizei);
glDrawElementsInstanced > n i i i *x i             : void glDrawElementsInstanced (GLenum, GLsizei, GLenum, GLvoid *, GLsizei);
glTexBuffer > n i i i                              : void glTexBuffer (GLenum, GLenum, GLuint);
glPrimitiveRestartIndex > n i                      : void glPrimitiveRestartIndex (GLuint);
glGetInteger64i_v > n i i *l                       : void glGetInteger64i_v (GLenum, GLuint, GLint64 *);
glGetBufferParameteri64v > n i i *l                : void glGetBufferParameteri64v (GLenum, GLenum, GLint64 *);
glFramebufferTexture > n i i i i                   : void glFramebufferTexture (GLenum, GLenum, GLuint, GLint);
glVertexAttribDivisor > n i i                      : void glVertexAttribDivisor (GLuint, GLuint);
glMinSampleShading > n f                           : void glMinSampleShading (GLclampf);
glBlendEquationi > n i i                           : void glBlendEquationi (GLuint, GLenum);
glBlendEquationSeparatei > n i i i                 : void glBlendEquationSeparatei (GLuint, GLenum, GLenum);
glBlendFunci > n i i i                             : void glBlendFunci (GLuint, GLenum, GLenum);
glBlendFuncSeparatei > n i i i i i                 : void glBlendFuncSeparatei (GLuint, GLenum, GLenum, GLenum, GLenum);
glLoadTransposeMatrixfARB > n *f                   : void glLoadTransposeMatrixfARB (GLfloat *);
glLoadTransposeMatrixdARB > n *d                   : void glLoadTransposeMatrixdARB (GLdouble *);
glMultTransposeMatrixfARB > n *f                   : void glMultTransposeMatrixfARB (GLfloat *);
glMultTransposeMatrixdARB > n *d                   : void glMultTransposeMatrixdARB (GLdouble *);
glSampleCoverageARB > n f s                        : void glSampleCoverageARB (GLclampf, GLboolean);
glCompressedTexImage3DARB > n i i i i i i i i *x   : void glCompressedTexImage3DARB (GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedTexImage2DARB > n i i i i i i i *x     : void glCompressedTexImage2DARB (GLenum, GLint, GLenum, GLsizei, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedTexImage1DARB > n i i i i i i *x       : void glCompressedTexImage1DARB (GLenum, GLint, GLenum, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedTexSubImage3DARB > n i i i i i i i i i i *x : void glCompressedTexSubImage3DARB (GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, GLvoid *);
glCompressedTexSubImage2DARB > n i i i i i i i i *x : void glCompressedTexSubImage2DARB (GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLsizei, GLvoid *);
glCompressedTexSubImage1DARB > n i i i i i i *x    : void glCompressedTexSubImage1DARB (GLenum, GLint, GLint, GLsizei, GLenum, GLsizei, GLvoid *);
glGetCompressedTexImageARB > n i i *x              : void glGetCompressedTexImageARB (GLenum, GLint, GLvoid *);
glPointParameterfARB > n i f                       : void glPointParameterfARB (GLenum, GLfloat);
glPointParameterfvARB > n i *f                     : void glPointParameterfvARB (GLenum, GLfloat *);
glWeightbvARB > n i *c                             : void glWeightbvARB (GLint, GLbyte *);
glWeightsvARB > n i *s                             : void glWeightsvARB (GLint, GLshort *);
glWeightivARB > n i *i                             : void glWeightivARB (GLint, GLint *);
glWeightfvARB > n i *f                             : void glWeightfvARB (GLint, GLfloat *);
glWeightdvARB > n i *d                             : void glWeightdvARB (GLint, GLdouble *);
glWeightubvARB > n i *c                            : void glWeightubvARB (GLint, GLubyte *);
glWeightusvARB > n i *s                            : void glWeightusvARB (GLint, GLushort *);
glWeightuivARB > n i *i                            : void glWeightuivARB (GLint, GLuint *);
glWeightPointerARB > n i i i *x                    : void glWeightPointerARB (GLint, GLenum, GLsizei, GLvoid *);
glVertexBlendARB > n i                             : void glVertexBlendARB (GLint);
glCurrentPaletteMatrixARB > n i                    : void glCurrentPaletteMatrixARB (GLint);
glMatrixIndexubvARB > n i *c                       : void glMatrixIndexubvARB (GLint, GLubyte *);
glMatrixIndexusvARB > n i *s                       : void glMatrixIndexusvARB (GLint, GLushort *);
glMatrixIndexuivARB > n i *i                       : void glMatrixIndexuivARB (GLint, GLuint *);
glMatrixIndexPointerARB > n i i i *x               : void glMatrixIndexPointerARB (GLint, GLenum, GLsizei, GLvoid *);
glWindowPos2dARB > n d d                           : void glWindowPos2dARB (GLdouble, GLdouble);
glWindowPos2dvARB > n *d                           : void glWindowPos2dvARB (GLdouble *);
glWindowPos2fARB > n f f                           : void glWindowPos2fARB (GLfloat, GLfloat);
glWindowPos2fvARB > n *f                           : void glWindowPos2fvARB (GLfloat *);
glWindowPos2iARB > n i i                           : void glWindowPos2iARB (GLint, GLint);
glWindowPos2ivARB > n *i                           : void glWindowPos2ivARB (GLint *);
glWindowPos2sARB > n s s                           : void glWindowPos2sARB (GLshort, GLshort);
glWindowPos2svARB > n *s                           : void glWindowPos2svARB (GLshort *);
glWindowPos3dARB > n d d d                         : void glWindowPos3dARB (GLdouble, GLdouble, GLdouble);
glWindowPos3dvARB > n *d                           : void glWindowPos3dvARB (GLdouble *);
glWindowPos3fARB > n f f f                         : void glWindowPos3fARB (GLfloat, GLfloat, GLfloat);
glWindowPos3fvARB > n *f                           : void glWindowPos3fvARB (GLfloat *);
glWindowPos3iARB > n i i i                         : void glWindowPos3iARB (GLint, GLint, GLint);
glWindowPos3ivARB > n *i                           : void glWindowPos3ivARB (GLint *);
glWindowPos3sARB > n s s s                         : void glWindowPos3sARB (GLshort, GLshort, GLshort);
glWindowPos3svARB > n *s                           : void glWindowPos3svARB (GLshort *);
glVertexAttrib1dARB > n i d                        : void glVertexAttrib1dARB (GLuint, GLdouble);
glVertexAttrib1dvARB > n i *d                      : void glVertexAttrib1dvARB (GLuint, GLdouble *);
glVertexAttrib1fARB > n i f                        : void glVertexAttrib1fARB (GLuint, GLfloat);
glVertexAttrib1fvARB > n i *f                      : void glVertexAttrib1fvARB (GLuint, GLfloat *);
glVertexAttrib1sARB > n i s                        : void glVertexAttrib1sARB (GLuint, GLshort);
glVertexAttrib1svARB > n i *s                      : void glVertexAttrib1svARB (GLuint, GLshort *);
glVertexAttrib2dARB > n i d d                      : void glVertexAttrib2dARB (GLuint, GLdouble, GLdouble);
glVertexAttrib2dvARB > n i *d                      : void glVertexAttrib2dvARB (GLuint, GLdouble *);
glVertexAttrib2fARB > n i f f                      : void glVertexAttrib2fARB (GLuint, GLfloat, GLfloat);
glVertexAttrib2fvARB > n i *f                      : void glVertexAttrib2fvARB (GLuint, GLfloat *);
glVertexAttrib2sARB > n i s s                      : void glVertexAttrib2sARB (GLuint, GLshort, GLshort);
glVertexAttrib2svARB > n i *s                      : void glVertexAttrib2svARB (GLuint, GLshort *);
glVertexAttrib3dARB > n i d d d                    : void glVertexAttrib3dARB (GLuint, GLdouble, GLdouble, GLdouble);
glVertexAttrib3dvARB > n i *d                      : void glVertexAttrib3dvARB (GLuint, GLdouble *);
glVertexAttrib3fARB > n i f f f                    : void glVertexAttrib3fARB (GLuint, GLfloat, GLfloat, GLfloat);
glVertexAttrib3fvARB > n i *f                      : void glVertexAttrib3fvARB (GLuint, GLfloat *);
glVertexAttrib3sARB > n i s s s                    : void glVertexAttrib3sARB (GLuint, GLshort, GLshort, GLshort);
glVertexAttrib3svARB > n i *s                      : void glVertexAttrib3svARB (GLuint, GLshort *);
glVertexAttrib4NbvARB > n i *c                     : void glVertexAttrib4NbvARB (GLuint, GLbyte *);
glVertexAttrib4NivARB > n i *i                     : void glVertexAttrib4NivARB (GLuint, GLint *);
glVertexAttrib4NsvARB > n i *s                     : void glVertexAttrib4NsvARB (GLuint, GLshort *);
glVertexAttrib4NubARB > n i c c c c                : void glVertexAttrib4NubARB (GLuint, GLubyte, GLubyte, GLubyte, GLubyte);
glVertexAttrib4NubvARB > n i *c                    : void glVertexAttrib4NubvARB (GLuint, GLubyte *);
glVertexAttrib4NuivARB > n i *i                    : void glVertexAttrib4NuivARB (GLuint, GLuint *);
glVertexAttrib4NusvARB > n i *s                    : void glVertexAttrib4NusvARB (GLuint, GLushort *);
glVertexAttrib4bvARB > n i *c                      : void glVertexAttrib4bvARB (GLuint, GLbyte *);
glVertexAttrib4dARB > n i d d d d                  : void glVertexAttrib4dARB (GLuint, GLdouble, GLdouble, GLdouble, GLdouble);
glVertexAttrib4dvARB > n i *d                      : void glVertexAttrib4dvARB (GLuint, GLdouble *);
glVertexAttrib4fARB > n i f f f f                  : void glVertexAttrib4fARB (GLuint, GLfloat, GLfloat, GLfloat, GLfloat);
glVertexAttrib4fvARB > n i *f                      : void glVertexAttrib4fvARB (GLuint, GLfloat *);
glVertexAttrib4ivARB > n i *i                      : void glVertexAttrib4ivARB (GLuint, GLint *);
glVertexAttrib4sARB > n i s s s s                  : void glVertexAttrib4sARB (GLuint, GLshort, GLshort, GLshort, GLshort);
glVertexAttrib4svARB > n i *s                      : void glVertexAttrib4svARB (GLuint, GLshort *);
glVertexAttrib4ubvARB > n i *c                     : void glVertexAttrib4ubvARB (GLuint, GLubyte *);
glVertexAttrib4uivARB > n i *i                     : void glVertexAttrib4uivARB (GLuint, GLuint *);
glVertexAttrib4usvARB > n i *s                     : void glVertexAttrib4usvARB (GLuint, GLushort *);
glVertexAttribPointerARB > n i i i s i *x          : void glVertexAttribPointerARB (GLuint, GLint, GLenum, GLboolean, GLsizei, GLvoid *);
glEnableVertexAttribArrayARB > n i                 : void glEnableVertexAttribArrayARB (GLuint);
glDisableVertexAttribArrayARB > n i                : void glDisableVertexAttribArrayARB (GLuint);
glProgramStringARB > n i i i *x                    : void glProgramStringARB (GLenum, GLenum, GLsizei, GLvoid *);
glBindProgramARB > n i i                           : void glBindProgramARB (GLenum, GLuint);
glDeleteProgramsARB > n i *i                       : void glDeleteProgramsARB (GLsizei, GLuint *);
glGenProgramsARB > n i *i                          : void glGenProgramsARB (GLsizei, GLuint *);
glProgramEnvParameter4dARB > n i i d d d d         : void glProgramEnvParameter4dARB (GLenum, GLuint, GLdouble, GLdouble, GLdouble, GLdouble);
glProgramEnvParameter4dvARB > n i i *d             : void glProgramEnvParameter4dvARB (GLenum, GLuint, GLdouble *);
glProgramEnvParameter4fARB > n i i f f f f         : void glProgramEnvParameter4fARB (GLenum, GLuint, GLfloat, GLfloat, GLfloat, GLfloat);
glProgramEnvParameter4fvARB > n i i *f             : void glProgramEnvParameter4fvARB (GLenum, GLuint, GLfloat *);
glProgramLocalParameter4dARB > n i i d d d d       : void glProgramLocalParameter4dARB (GLenum, GLuint, GLdouble, GLdouble, GLdouble, GLdouble);
glProgramLocalParameter4dvARB > n i i *d           : void glProgramLocalParameter4dvARB (GLenum, GLuint, GLdouble *);
glProgramLocalParameter4fARB > n i i f f f f       : void glProgramLocalParameter4fARB (GLenum, GLuint, GLfloat, GLfloat, GLfloat, GLfloat);
glProgramLocalParameter4fvARB > n i i *f           : void glProgramLocalParameter4fvARB (GLenum, GLuint, GLfloat *);
glGetProgramEnvParameterdvARB > n i i *d           : void glGetProgramEnvParameterdvARB (GLenum, GLuint, GLdouble *);
glGetProgramEnvParameterfvARB > n i i *f           : void glGetProgramEnvParameterfvARB (GLenum, GLuint, GLfloat *);
glGetProgramLocalParameterdvARB > n i i *d         : void glGetProgramLocalParameterdvARB (GLenum, GLuint, GLdouble *);
glGetProgramLocalParameterfvARB > n i i *f         : void glGetProgramLocalParameterfvARB (GLenum, GLuint, GLfloat *);
glGetProgramivARB > n i i *i                       : void glGetProgramivARB (GLenum, GLenum, GLint *);
glGetProgramStringARB > n i i *x                   : void glGetProgramStringARB (GLenum, GLenum, GLvoid *);
glGetVertexAttribdvARB > n i i *d                  : void glGetVertexAttribdvARB (GLuint, GLenum, GLdouble *);
glGetVertexAttribfvARB > n i i *f                  : void glGetVertexAttribfvARB (GLuint, GLenum, GLfloat *);
glGetVertexAttribivARB > n i i *i                  : void glGetVertexAttribivARB (GLuint, GLenum, GLint *);
glGetVertexAttribPointervARB > n i i *x            : void glGetVertexAttribPointervARB (GLuint, GLenum, GLvoid **);
glIsProgramARB > s i                               : GLboolean glIsProgramARB (GLuint);
glBindBufferARB > n i i                            : void glBindBufferARB (GLenum, GLuint);
glDeleteBuffersARB > n i *i                        : void glDeleteBuffersARB (GLsizei, GLuint *);
glGenBuffersARB > n i *i                           : void glGenBuffersARB (GLsizei, GLuint *);
glIsBufferARB > s i                                : GLboolean glIsBufferARB (GLuint);
glBufferDataARB > n i i *x i                       : void glBufferDataARB (GLenum, GLsizeiptrARB, GLvoid *, GLenum);
glBufferSubDataARB > n i i i *x                    : void glBufferSubDataARB (GLenum, GLintptrARB, GLsizeiptrARB, GLvoid *);
glGetBufferSubDataARB > n i i i *x                 : void glGetBufferSubDataARB (GLenum, GLintptrARB, GLsizeiptrARB, GLvoid *);
glMapBufferARB > x i i                             : GLvoid *glMapBufferARB (GLenum, GLenum);
glUnmapBufferARB > s i                             : GLboolean glUnmapBufferARB (GLenum);
glGetBufferParameterivARB > n i i *i               : void glGetBufferParameterivARB (GLenum, GLenum, GLint *);
glGetBufferPointervARB > n i i *x                  : void glGetBufferPointervARB (GLenum, GLenum, GLvoid **);
glGenQueriesARB > n i *i                           : void glGenQueriesARB (GLsizei, GLuint *);
glDeleteQueriesARB > n i *i                        : void glDeleteQueriesARB (GLsizei, GLuint *);
glIsQueryARB > s i                                 : GLboolean glIsQueryARB (GLuint);
glBeginQueryARB > n i i                            : void glBeginQueryARB (GLenum, GLuint);
glEndQueryARB > n i                                : void glEndQueryARB (GLenum);
glGetQueryivARB > n i i *i                         : void glGetQueryivARB (GLenum, GLenum, GLint *);
glGetQueryObjectivARB > n i i *i                   : void glGetQueryObjectivARB (GLuint, GLenum, GLint *);
glGetQueryObjectuivARB > n i i *i                  : void glGetQueryObjectuivARB (GLuint, GLenum, GLuint *);
glDeleteObjectARB > n i                            : void glDeleteObjectARB (GLhandleARB);
glGetHandleARB > i i                               : GLhandleARB glGetHandleARB (GLenum);
glDetachObjectARB > n i i                          : void glDetachObjectARB (GLhandleARB, GLhandleARB);
glCreateShaderObjectARB > i i                      : GLhandleARB glCreateShaderObjectARB (GLenum);
glShaderSourceARB > n i i *x *i                    : void glShaderSourceARB (GLhandleARB, GLsizei, GLcharARB **, GLint *);
glCompileShaderARB > n i                           : void glCompileShaderARB (GLhandleARB);
glCreateProgramObjectARB > i                       : GLhandleARB glCreateProgramObjectARB (void);
glAttachObjectARB > n i i                          : void glAttachObjectARB (GLhandleARB, GLhandleARB);
glLinkProgramARB > n i                             : void glLinkProgramARB (GLhandleARB);
glUseProgramObjectARB > n i                        : void glUseProgramObjectARB (GLhandleARB);
glValidateProgramARB > n i                         : void glValidateProgramARB (GLhandleARB);
glUniform1fARB > n i f                             : void glUniform1fARB (GLint, GLfloat);
glUniform2fARB > n i f f                           : void glUniform2fARB (GLint, GLfloat, GLfloat);
glUniform3fARB > n i f f f                         : void glUniform3fARB (GLint, GLfloat, GLfloat, GLfloat);
glUniform4fARB > n i f f f f                       : void glUniform4fARB (GLint, GLfloat, GLfloat, GLfloat, GLfloat);
glUniform1iARB > n i i                             : void glUniform1iARB (GLint, GLint);
glUniform2iARB > n i i i                           : void glUniform2iARB (GLint, GLint, GLint);
glUniform3iARB > n i i i i                         : void glUniform3iARB (GLint, GLint, GLint, GLint);
glUniform4iARB > n i i i i i                       : void glUniform4iARB (GLint, GLint, GLint, GLint, GLint);
glUniform1fvARB > n i i *f                         : void glUniform1fvARB (GLint, GLsizei, GLfloat *);
glUniform2fvARB > n i i *f                         : void glUniform2fvARB (GLint, GLsizei, GLfloat *);
glUniform3fvARB > n i i *f                         : void glUniform3fvARB (GLint, GLsizei, GLfloat *);
glUniform4fvARB > n i i *f                         : void glUniform4fvARB (GLint, GLsizei, GLfloat *);
glUniform1ivARB > n i i *i                         : void glUniform1ivARB (GLint, GLsizei, GLint *);
glUniform2ivARB > n i i *i                         : void glUniform2ivARB (GLint, GLsizei, GLint *);
glUniform3ivARB > n i i *i                         : void glUniform3ivARB (GLint, GLsizei, GLint *);
glUniform4ivARB > n i i *i                         : void glUniform4ivARB (GLint, GLsizei, GLint *);
glUniformMatrix2fvARB > n i i s *f                 : void glUniformMatrix2fvARB (GLint, GLsizei, GLboolean, GLfloat *);
glUniformMatrix3fvARB > n i i s *f                 : void glUniformMatrix3fvARB (GLint, GLsizei, GLboolean, GLfloat *);
glUniformMatrix4fvARB > n i i s *f                 : void glUniformMatrix4fvARB (GLint, GLsizei, GLboolean, GLfloat *);
glGetObjectParameterfvARB > n i i *f               : void glGetObjectParameterfvARB (GLhandleARB, GLenum, GLfloat *);
glGetObjectParameterivARB > n i i *i               : void glGetObjectParameterivARB (GLhandleARB, GLenum, GLint *);
glGetInfoLogARB > n i i *i *c                      : void glGetInfoLogARB (GLhandleARB, GLsizei, GLsizei *, GLcharARB *);
glGetAttachedObjectsARB > n i i *i *i              : void glGetAttachedObjectsARB (GLhandleARB, GLsizei, GLsizei *, GLhandleARB *);
glGetUniformLocationARB > i i *c                   : GLint glGetUniformLocationARB (GLhandleARB, GLcharARB *);
glGetActiveUniformARB > n i i i *i *i *i *c        : void glGetActiveUniformARB (GLhandleARB, GLuint, GLsizei, GLsizei *, GLint *, GLenum *, GLcharARB *);
glGetUniformfvARB > n i i *f                       : void glGetUniformfvARB (GLhandleARB, GLint, GLfloat *);
glGetUniformivARB > n i i *i                       : void glGetUniformivARB (GLhandleARB, GLint, GLint *);
glGetShaderSourceARB > n i i *i *c                 : void glGetShaderSourceARB (GLhandleARB, GLsizei, GLsizei *, GLcharARB *);
glBindAttribLocationARB > n i i *c                 : void glBindAttribLocationARB (GLhandleARB, GLuint, GLcharARB *);
glGetActiveAttribARB > n i i i *i *i *i *c         : void glGetActiveAttribARB (GLhandleARB, GLuint, GLsizei, GLsizei *, GLint *, GLenum *, GLcharARB *);
glGetAttribLocationARB > i i *c                    : GLint glGetAttribLocationARB (GLhandleARB, GLcharARB *);
glDrawBuffersARB > n i *i                          : void glDrawBuffersARB (GLsizei, GLenum *);
glClampColorARB > n i i                            : void glClampColorARB (GLenum, GLenum);
glDrawArraysInstancedARB > n i i i i               : void glDrawArraysInstancedARB (GLenum, GLint, GLsizei, GLsizei);
glDrawElementsInstancedARB > n i i i *x i          : void glDrawElementsInstancedARB (GLenum, GLsizei, GLenum, GLvoid *, GLsizei);
glIsRenderbuffer > s i                             : GLboolean glIsRenderbuffer (GLuint);
glBindRenderbuffer > n i i                         : void glBindRenderbuffer (GLenum, GLuint);
glDeleteRenderbuffers > n i *i                     : void glDeleteRenderbuffers (GLsizei, GLuint *);
glGenRenderbuffers > n i *i                        : void glGenRenderbuffers (GLsizei, GLuint *);
glRenderbufferStorage > n i i i i                  : void glRenderbufferStorage (GLenum, GLenum, GLsizei, GLsizei);
glGetRenderbufferParameteriv > n i i *i            : void glGetRenderbufferParameteriv (GLenum, GLenum, GLint *);
glIsFramebuffer > s i                              : GLboolean glIsFramebuffer (GLuint);
glBindFramebuffer > n i i                          : void glBindFramebuffer (GLenum, GLuint);
glDeleteFramebuffers > n i *i                      : void glDeleteFramebuffers (GLsizei, GLuint *);
glGenFramebuffers > n i *i                         : void glGenFramebuffers (GLsizei, GLuint *);
glCheckFramebufferStatus > i i                     : GLenum glCheckFramebufferStatus (GLenum);
glFramebufferTexture1D > n i i i i i               : void glFramebufferTexture1D (GLenum, GLenum, GLenum, GLuint, GLint);
glFramebufferTexture2D > n i i i i i               : void glFramebufferTexture2D (GLenum, GLenum, GLenum, GLuint, GLint);
glFramebufferTexture3D > n i i i i i i             : void glFramebufferTexture3D (GLenum, GLenum, GLenum, GLuint, GLint, GLint);
glFramebufferRenderbuffer > n i i i i              : void glFramebufferRenderbuffer (GLenum, GLenum, GLenum, GLuint);
glGetFramebufferAttachmentParameteriv > n i i i *i : void glGetFramebufferAttachmentParameteriv (GLenum, GLenum, GLenum, GLint *);
glGenerateMipmap > n i                             : void glGenerateMipmap (GLenum);
glBlitFramebuffer > n i i i i i i i i i i          : void glBlitFramebuffer (GLint, GLint, GLint, GLint, GLint, GLint, GLint, GLint, GLbitfield, GLenum);
glRenderbufferStorageMultisample > n i i i i i     : void glRenderbufferStorageMultisample (GLenum, GLsizei, GLenum, GLsizei, GLsizei);
glFramebufferTextureLayer > n i i i i i            : void glFramebufferTextureLayer (GLenum, GLenum, GLuint, GLint, GLint);
glProgramParameteriARB > n i i i                   : void glProgramParameteriARB (GLuint, GLenum, GLint);
glFramebufferTextureARB > n i i i i                : void glFramebufferTextureARB (GLenum, GLenum, GLuint, GLint);
glFramebufferTextureLayerARB > n i i i i i         : void glFramebufferTextureLayerARB (GLenum, GLenum, GLuint, GLint, GLint);
glFramebufferTextureFaceARB > n i i i i i          : void glFramebufferTextureFaceARB (GLenum, GLenum, GLuint, GLint, GLenum);
glVertexAttribDivisorARB > n i i                   : void glVertexAttribDivisorARB (GLuint, GLuint);
glMapBufferRange > x i i i i                       : GLvoid *glMapBufferRange (GLenum, GLintptr, GLsizeiptr, GLbitfield);
glFlushMappedBufferRange > n i i i                 : void glFlushMappedBufferRange (GLenum, GLintptr, GLsizeiptr);
glTexBufferARB > n i i i                           : void glTexBufferARB (GLenum, GLenum, GLuint);
glBindVertexArray > n i                            : void glBindVertexArray (GLuint);
glDeleteVertexArrays > n i *i                      : void glDeleteVertexArrays (GLsizei, GLuint *);
glGenVertexArrays > n i *i                         : void glGenVertexArrays (GLsizei, GLuint *);
glIsVertexArray > s i                              : GLboolean glIsVertexArray (GLuint);
glGetUniformIndices > n i i *x *i                  : void glGetUniformIndices (GLuint, GLsizei, GLchar **, GLuint *);
glGetActiveUniformsiv > n i i *i i *i              : void glGetActiveUniformsiv (GLuint, GLsizei, GLuint *, GLenum, GLint *);
glGetActiveUniformName > n i i i *i *c             : void glGetActiveUniformName (GLuint, GLuint, GLsizei, GLsizei *, GLchar *);
glGetUniformBlockIndex > i i *c                    : GLuint glGetUniformBlockIndex (GLuint, GLchar *);
glGetActiveUniformBlockiv > n i i i *i             : void glGetActiveUniformBlockiv (GLuint, GLuint, GLenum, GLint *);
glGetActiveUniformBlockName > n i i i *i *c        : void glGetActiveUniformBlockName (GLuint, GLuint, GLsizei, GLsizei *, GLchar *);
glUniformBlockBinding > n i i i                    : void glUniformBlockBinding (GLuint, GLuint, GLuint);
glCopyBufferSubData > n i i i i i                  : void glCopyBufferSubData (GLenum, GLenum, GLintptr, GLintptr, GLsizeiptr);
glDrawElementsBaseVertex > n i i i *x i            : void glDrawElementsBaseVertex (GLenum, GLsizei, GLenum, GLvoid *, GLint);
glDrawRangeElementsBaseVertex > n i i i i i *x i   : void glDrawRangeElementsBaseVertex (GLenum, GLuint, GLuint, GLsizei, GLenum, GLvoid *, GLint);
glDrawElementsInstancedBaseVertex > n i i i *x i i : void glDrawElementsInstancedBaseVertex (GLenum, GLsizei, GLenum, GLvoid *, GLsizei, GLint);
glMultiDrawElementsBaseVertex > n i *i i *x i *i   : void glMultiDrawElementsBaseVertex (GLenum, GLsizei *, GLenum, GLvoid **, GLsizei, GLint *);
glProvokingVertex > n i                            : void glProvokingVertex (GLenum);
glFenceSync > x i i                                : GLsync glFenceSync (GLenum, GLbitfield);
glIsSync > s x                                     : GLboolean glIsSync (GLsync);
glDeleteSync > n x                                 : void glDeleteSync (GLsync);
glClientWaitSync > i x i l                         : GLenum glClientWaitSync (GLsync, GLbitfield, GLuint64);
glWaitSync > n x i l                               : void glWaitSync (GLsync, GLbitfield, GLuint64);
glGetInteger64v > n i *l                           : void glGetInteger64v (GLenum, GLint64 *);
glGetSynciv > n x i i *i *i                        : void glGetSynciv (GLsync, GLenum, GLsizei, GLsizei *, GLint *);
glTexImage2DMultisample > n i i i i i s            : void glTexImage2DMultisample (GLenum, GLsizei, GLint, GLsizei, GLsizei, GLboolean);
glTexImage3DMultisample > n i i i i i i s          : void glTexImage3DMultisample (GLenum, GLsizei, GLint, GLsizei, GLsizei, GLsizei, GLboolean);
glGetMultisamplefv > n i i *f                      : void glGetMultisamplefv (GLenum, GLuint, GLfloat *);
glSampleMaski > n i i                              : void glSampleMaski (GLuint, GLbitfield);
glBlendEquationiARB > n i i                        : void glBlendEquationiARB (GLuint, GLenum);
glBlendEquationSeparateiARB > n i i i              : void glBlendEquationSeparateiARB (GLuint, GLenum, GLenum);
glBlendFunciARB > n i i i                          : void glBlendFunciARB (GLuint, GLenum, GLenum);
glBlendFuncSeparateiARB > n i i i i i              : void glBlendFuncSeparateiARB (GLuint, GLenum, GLenum, GLenum, GLenum);
glMinSampleShadingARB > n f                        : void glMinSampleShadingARB (GLclampf);
glNamedStringARB > n i i *c i *c                   : void glNamedStringARB (GLenum, GLint, GLchar *, GLint, GLchar *);
glDeleteNamedStringARB > n i *c                    : void glDeleteNamedStringARB (GLint, GLchar *);
glCompileShaderIncludeARB > n i i *x *i            : void glCompileShaderIncludeARB (GLuint, GLsizei, GLchar **, GLint *);
glIsNamedStringARB > s i *c                        : GLboolean glIsNamedStringARB (GLint, GLchar *);
glGetNamedStringARB > n i *c i *i *c               : void glGetNamedStringARB (GLint, GLchar *, GLsizei, GLint *, GLchar *);
glGetNamedStringivARB > n i *c i *i                : void glGetNamedStringivARB (GLint, GLchar *, GLenum, GLint *);
glBindFragDataLocationIndexed > n i i i *c         : void glBindFragDataLocationIndexed (GLuint, GLuint, GLuint, GLchar *);
glGetFragDataIndex > i i *c                        : GLint glGetFragDataIndex (GLuint, GLchar *);
glGenSamplers > n i *i                             : void glGenSamplers (GLsizei, GLuint *);
glDeleteSamplers > n i *i                          : void glDeleteSamplers (GLsizei, GLuint *);
glIsSampler > s i                                  : GLboolean glIsSampler (GLuint);
glBindSampler > n i i                              : void glBindSampler (GLuint, GLuint);
glSamplerParameteri > n i i i                      : void glSamplerParameteri (GLuint, GLenum, GLint);
glSamplerParameteriv > n i i *i                    : void glSamplerParameteriv (GLuint, GLenum, GLint *);
glSamplerParameterf > n i i f                      : void glSamplerParameterf (GLuint, GLenum, GLfloat);
glSamplerParameterfv > n i i *f                    : void glSamplerParameterfv (GLuint, GLenum, GLfloat *);
glSamplerParameterIiv > n i i *i                   : void glSamplerParameterIiv (GLuint, GLenum, GLint *);
glSamplerParameterIuiv > n i i *i                  : void glSamplerParameterIuiv (GLuint, GLenum, GLuint *);
glGetSamplerParameteriv > n i i *i                 : void glGetSamplerParameteriv (GLuint, GLenum, GLint *);
glGetSamplerParameterIiv > n i i *i                : void glGetSamplerParameterIiv (GLuint, GLenum, GLint *);
glGetSamplerParameterfv > n i i *f                 : void glGetSamplerParameterfv (GLuint, GLenum, GLfloat *);
glGetSamplerParameterIuiv > n i i *i               : void glGetSamplerParameterIuiv (GLuint, GLenum, GLuint *);
glQueryCounter > n i i                             : void glQueryCounter (GLuint, GLenum);
glGetQueryObjecti64v > n i i *l                    : void glGetQueryObjecti64v (GLuint, GLenum, GLint64 *);
glGetQueryObjectui64v > n i i *l                   : void glGetQueryObjectui64v (GLuint, GLenum, GLuint64 *);
glVertexP2ui > n i i                               : void glVertexP2ui (GLenum, GLuint);
glVertexP2uiv > n i *i                             : void glVertexP2uiv (GLenum, GLuint *);
glVertexP3ui > n i i                               : void glVertexP3ui (GLenum, GLuint);
glVertexP3uiv > n i *i                             : void glVertexP3uiv (GLenum, GLuint *);
glVertexP4ui > n i i                               : void glVertexP4ui (GLenum, GLuint);
glVertexP4uiv > n i *i                             : void glVertexP4uiv (GLenum, GLuint *);
glTexCoordP1ui > n i i                             : void glTexCoordP1ui (GLenum, GLuint);
glTexCoordP1uiv > n i *i                           : void glTexCoordP1uiv (GLenum, GLuint *);
glTexCoordP2ui > n i i                             : void glTexCoordP2ui (GLenum, GLuint);
glTexCoordP2uiv > n i *i                           : void glTexCoordP2uiv (GLenum, GLuint *);
glTexCoordP3ui > n i i                             : void glTexCoordP3ui (GLenum, GLuint);
glTexCoordP3uiv > n i *i                           : void glTexCoordP3uiv (GLenum, GLuint *);
glTexCoordP4ui > n i i                             : void glTexCoordP4ui (GLenum, GLuint);
glTexCoordP4uiv > n i *i                           : void glTexCoordP4uiv (GLenum, GLuint *);
glMultiTexCoordP1ui > n i i i                      : void glMultiTexCoordP1ui (GLenum, GLenum, GLuint);
glMultiTexCoordP1uiv > n i i *i                    : void glMultiTexCoordP1uiv (GLenum, GLenum, GLuint *);
glMultiTexCoordP2ui > n i i i                      : void glMultiTexCoordP2ui (GLenum, GLenum, GLuint);
glMultiTexCoordP2uiv > n i i *i                    : void glMultiTexCoordP2uiv (GLenum, GLenum, GLuint *);
glMultiTexCoordP3ui > n i i i                      : void glMultiTexCoordP3ui (GLenum, GLenum, GLuint);
glMultiTexCoordP3uiv > n i i *i                    : void glMultiTexCoordP3uiv (GLenum, GLenum, GLuint *);
glMultiTexCoordP4ui > n i i i                      : void glMultiTexCoordP4ui (GLenum, GLenum, GLuint);
glMultiTexCoordP4uiv > n i i *i                    : void glMultiTexCoordP4uiv (GLenum, GLenum, GLuint *);
glNormalP3ui > n i i                               : void glNormalP3ui (GLenum, GLuint);
glNormalP3uiv > n i *i                             : void glNormalP3uiv (GLenum, GLuint *);
glColorP3ui > n i i                                : void glColorP3ui (GLenum, GLuint);
glColorP3uiv > n i *i                              : void glColorP3uiv (GLenum, GLuint *);
glColorP4ui > n i i                                : void glColorP4ui (GLenum, GLuint);
glColorP4uiv > n i *i                              : void glColorP4uiv (GLenum, GLuint *);
glSecondaryColorP3ui > n i i                       : void glSecondaryColorP3ui (GLenum, GLuint);
glSecondaryColorP3uiv > n i *i                     : void glSecondaryColorP3uiv (GLenum, GLuint *);
glVertexAttribP1ui > n i i s i                     : void glVertexAttribP1ui (GLuint, GLenum, GLboolean, GLuint);
glVertexAttribP1uiv > n i i s *i                   : void glVertexAttribP1uiv (GLuint, GLenum, GLboolean, GLuint *);
glVertexAttribP2ui > n i i s i                     : void glVertexAttribP2ui (GLuint, GLenum, GLboolean, GLuint);
glVertexAttribP2uiv > n i i s *i                   : void glVertexAttribP2uiv (GLuint, GLenum, GLboolean, GLuint *);
glVertexAttribP3ui > n i i s i                     : void glVertexAttribP3ui (GLuint, GLenum, GLboolean, GLuint);
glVertexAttribP3uiv > n i i s *i                   : void glVertexAttribP3uiv (GLuint, GLenum, GLboolean, GLuint *);
glVertexAttribP4ui > n i i s i                     : void glVertexAttribP4ui (GLuint, GLenum, GLboolean, GLuint);
glVertexAttribP4uiv > n i i s *i                   : void glVertexAttribP4uiv (GLuint, GLenum, GLboolean, GLuint *);
glDrawArraysIndirect > n i *x                      : void glDrawArraysIndirect (GLenum, GLvoid *);
glDrawElementsIndirect > n i i *x                  : void glDrawElementsIndirect (GLenum, GLenum, GLvoid *);
glUniform1d > n i d                                : void glUniform1d (GLint, GLdouble);
glUniform2d > n i d d                              : void glUniform2d (GLint, GLdouble, GLdouble);
glUniform3d > n i d d d                            : void glUniform3d (GLint, GLdouble, GLdouble, GLdouble);
glUniform4d > n i d d d d                          : void glUniform4d (GLint, GLdouble, GLdouble, GLdouble, GLdouble);
glUniform1dv > n i i *d                            : void glUniform1dv (GLint, GLsizei, GLdouble *);
glUniform2dv > n i i *d                            : void glUniform2dv (GLint, GLsizei, GLdouble *);
glUniform3dv > n i i *d                            : void glUniform3dv (GLint, GLsizei, GLdouble *);
glUniform4dv > n i i *d                            : void glUniform4dv (GLint, GLsizei, GLdouble *);
glUniformMatrix2dv > n i i s *d                    : void glUniformMatrix2dv (GLint, GLsizei, GLboolean, GLdouble *);
glUniformMatrix3dv > n i i s *d                    : void glUniformMatrix3dv (GLint, GLsizei, GLboolean, GLdouble *);
glUniformMatrix4dv > n i i s *d                    : void glUniformMatrix4dv (GLint, GLsizei, GLboolean, GLdouble *);
glUniformMatrix2x3dv > n i i s *d                  : void glUniformMatrix2x3dv (GLint, GLsizei, GLboolean, GLdouble *);
glUniformMatrix2x4dv > n i i s *d                  : void glUniformMatrix2x4dv (GLint, GLsizei, GLboolean, GLdouble *);
glUniformMatrix3x2dv > n i i s *d                  : void glUniformMatrix3x2dv (GLint, GLsizei, GLboolean, GLdouble *);
glUniformMatrix3x4dv > n i i s *d                  : void glUniformMatrix3x4dv (GLint, GLsizei, GLboolean, GLdouble *);
glUniformMatrix4x2dv > n i i s *d                  : void glUniformMatrix4x2dv (GLint, GLsizei, GLboolean, GLdouble *);
glUniformMatrix4x3dv > n i i s *d                  : void glUniformMatrix4x3dv (GLint, GLsizei, GLboolean, GLdouble *);
glGetUniformdv > n i i *d                          : void glGetUniformdv (GLuint, GLint, GLdouble *);
glGetSubroutineUniformLocation > i i i *c          : GLint glGetSubroutineUniformLocation (GLuint, GLenum, GLchar *);
glGetSubroutineIndex > i i i *c                    : GLuint glGetSubroutineIndex (GLuint, GLenum, GLchar *);
glGetActiveSubroutineUniformiv > n i i i i *i      : void glGetActiveSubroutineUniformiv (GLuint, GLenum, GLuint, GLenum, GLint *);
glGetActiveSubroutineUniformName > n i i i i *i *c : void glGetActiveSubroutineUniformName (GLuint, GLenum, GLuint, GLsizei, GLsizei *, GLchar *);
glGetActiveSubroutineName > n i i i i *i *c        : void glGetActiveSubroutineName (GLuint, GLenum, GLuint, GLsizei, GLsizei *, GLchar *);
glUniformSubroutinesuiv > n i i *i                 : void glUniformSubroutinesuiv (GLenum, GLsizei, GLuint *);
glGetUniformSubroutineuiv > n i i *i               : void glGetUniformSubroutineuiv (GLenum, GLint, GLuint *);
glGetProgramStageiv > n i i i *i                   : void glGetProgramStageiv (GLuint, GLenum, GLenum, GLint *);
glPatchParameteri > n i i                          : void glPatchParameteri (GLenum, GLint);
glPatchParameterfv > n i *f                        : void glPatchParameterfv (GLenum, GLfloat *);
glBindTransformFeedback > n i i                    : void glBindTransformFeedback (GLenum, GLuint);
glDeleteTransformFeedbacks > n i *i                : void glDeleteTransformFeedbacks (GLsizei, GLuint *);
glGenTransformFeedbacks > n i *i                   : void glGenTransformFeedbacks (GLsizei, GLuint *);
glIsTransformFeedback > s i                        : GLboolean glIsTransformFeedback (GLuint);
glPauseTransformFeedback > n                       : void glPauseTransformFeedback (void);
glResumeTransformFeedback > n                      : void glResumeTransformFeedback (void);
glDrawTransformFeedback > n i i                    : void glDrawTransformFeedback (GLenum, GLuint);
glDrawTransformFeedbackStream > n i i i            : void glDrawTransformFeedbackStream (GLenum, GLuint, GLuint);
glBeginQueryIndexed > n i i i                      : void glBeginQueryIndexed (GLenum, GLuint, GLuint);
glEndQueryIndexed > n i i                          : void glEndQueryIndexed (GLenum, GLuint);
glGetQueryIndexediv > n i i i *i                   : void glGetQueryIndexediv (GLenum, GLuint, GLenum, GLint *);
glReleaseShaderCompiler > n                        : void glReleaseShaderCompiler (void);
glShaderBinary > n i *i i *x i                     : void glShaderBinary (GLsizei, GLuint *, GLenum, GLvoid *, GLsizei);
glGetShaderPrecisionFormat > n i i *i *i           : void glGetShaderPrecisionFormat (GLenum, GLenum, GLint *, GLint *);
glDepthRangef > n f f                              : void glDepthRangef (GLclampf, GLclampf);
glClearDepthf > n f                                : void glClearDepthf (GLclampf);
glGetProgramBinary > n i i *i *i *x                : void glGetProgramBinary (GLuint, GLsizei, GLsizei *, GLenum *, GLvoid *);
glProgramBinary > n i i *x i                       : void glProgramBinary (GLuint, GLenum, GLvoid *, GLsizei);
glProgramParameteri > n i i i                      : void glProgramParameteri (GLuint, GLenum, GLint);
glUseProgramStages > n i i i                       : void glUseProgramStages (GLuint, GLbitfield, GLuint);
glActiveShaderProgram > n i i                      : void glActiveShaderProgram (GLuint, GLuint);
glCreateShaderProgramv > i i i *x                  : GLuint glCreateShaderProgramv (GLenum, GLsizei, GLchar **);
glBindProgramPipeline > n i                        : void glBindProgramPipeline (GLuint);
glDeleteProgramPipelines > n i *i                  : void glDeleteProgramPipelines (GLsizei, GLuint *);
glGenProgramPipelines > n i *i                     : void glGenProgramPipelines (GLsizei, GLuint *);
glIsProgramPipeline > s i                          : GLboolean glIsProgramPipeline (GLuint);
glGetProgramPipelineiv > n i i *i                  : void glGetProgramPipelineiv (GLuint, GLenum, GLint *);
glProgramUniform1i > n i i i                       : void glProgramUniform1i (GLuint, GLint, GLint);
glProgramUniform1iv > n i i i *i                   : void glProgramUniform1iv (GLuint, GLint, GLsizei, GLint *);
glProgramUniform1f > n i i f                       : void glProgramUniform1f (GLuint, GLint, GLfloat);
glProgramUniform1fv > n i i i *f                   : void glProgramUniform1fv (GLuint, GLint, GLsizei, GLfloat *);
glProgramUniform1d > n i i d                       : void glProgramUniform1d (GLuint, GLint, GLdouble);
glProgramUniform1dv > n i i i *d                   : void glProgramUniform1dv (GLuint, GLint, GLsizei, GLdouble *);
glProgramUniform1ui > n i i i                      : void glProgramUniform1ui (GLuint, GLint, GLuint);
glProgramUniform1uiv > n i i i *i                  : void glProgramUniform1uiv (GLuint, GLint, GLsizei, GLuint *);
glProgramUniform2i > n i i i i                     : void glProgramUniform2i (GLuint, GLint, GLint, GLint);
glProgramUniform2iv > n i i i *i                   : void glProgramUniform2iv (GLuint, GLint, GLsizei, GLint *);
glProgramUniform2f > n i i f f                     : void glProgramUniform2f (GLuint, GLint, GLfloat, GLfloat);
glProgramUniform2fv > n i i i *f                   : void glProgramUniform2fv (GLuint, GLint, GLsizei, GLfloat *);
glProgramUniform2d > n i i d d                     : void glProgramUniform2d (GLuint, GLint, GLdouble, GLdouble);
glProgramUniform2dv > n i i i *d                   : void glProgramUniform2dv (GLuint, GLint, GLsizei, GLdouble *);
glProgramUniform2ui > n i i i i                    : void glProgramUniform2ui (GLuint, GLint, GLuint, GLuint);
glProgramUniform2uiv > n i i i *i                  : void glProgramUniform2uiv (GLuint, GLint, GLsizei, GLuint *);
glProgramUniform3i > n i i i i i                   : void glProgramUniform3i (GLuint, GLint, GLint, GLint, GLint);
glProgramUniform3iv > n i i i *i                   : void glProgramUniform3iv (GLuint, GLint, GLsizei, GLint *);
glProgramUniform3f > n i i f f f                   : void glProgramUniform3f (GLuint, GLint, GLfloat, GLfloat, GLfloat);
glProgramUniform3fv > n i i i *f                   : void glProgramUniform3fv (GLuint, GLint, GLsizei, GLfloat *);
glProgramUniform3d > n i i d d d                   : void glProgramUniform3d (GLuint, GLint, GLdouble, GLdouble, GLdouble);
glProgramUniform3dv > n i i i *d                   : void glProgramUniform3dv (GLuint, GLint, GLsizei, GLdouble *);
glProgramUniform3ui > n i i i i i                  : void glProgramUniform3ui (GLuint, GLint, GLuint, GLuint, GLuint);
glProgramUniform3uiv > n i i i *i                  : void glProgramUniform3uiv (GLuint, GLint, GLsizei, GLuint *);
glProgramUniform4i > n i i i i i i                 : void glProgramUniform4i (GLuint, GLint, GLint, GLint, GLint, GLint);
glProgramUniform4iv > n i i i *i                   : void glProgramUniform4iv (GLuint, GLint, GLsizei, GLint *);
glProgramUniform4f > n i i f f f f                 : void glProgramUniform4f (GLuint, GLint, GLfloat, GLfloat, GLfloat, GLfloat);
glProgramUniform4fv > n i i i *f                   : void glProgramUniform4fv (GLuint, GLint, GLsizei, GLfloat *);
glProgramUniform4d > n i i d d d d                 : void glProgramUniform4d (GLuint, GLint, GLdouble, GLdouble, GLdouble, GLdouble);
glProgramUniform4dv > n i i i *d                   : void glProgramUniform4dv (GLuint, GLint, GLsizei, GLdouble *);
glProgramUniform4ui > n i i i i i i                : void glProgramUniform4ui (GLuint, GLint, GLuint, GLuint, GLuint, GLuint);
glProgramUniform4uiv > n i i i *i                  : void glProgramUniform4uiv (GLuint, GLint, GLsizei, GLuint *);
glProgramUniformMatrix2fv > n i i i s *f           : void glProgramUniformMatrix2fv (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix3fv > n i i i s *f           : void glProgramUniformMatrix3fv (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix4fv > n i i i s *f           : void glProgramUniformMatrix4fv (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix2dv > n i i i s *d           : void glProgramUniformMatrix2dv (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix3dv > n i i i s *d           : void glProgramUniformMatrix3dv (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix4dv > n i i i s *d           : void glProgramUniformMatrix4dv (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix2x3fv > n i i i s *f         : void glProgramUniformMatrix2x3fv (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix3x2fv > n i i i s *f         : void glProgramUniformMatrix3x2fv (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix2x4fv > n i i i s *f         : void glProgramUniformMatrix2x4fv (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix4x2fv > n i i i s *f         : void glProgramUniformMatrix4x2fv (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix3x4fv > n i i i s *f         : void glProgramUniformMatrix3x4fv (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix4x3fv > n i i i s *f         : void glProgramUniformMatrix4x3fv (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix2x3dv > n i i i s *d         : void glProgramUniformMatrix2x3dv (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix3x2dv > n i i i s *d         : void glProgramUniformMatrix3x2dv (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix2x4dv > n i i i s *d         : void glProgramUniformMatrix2x4dv (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix4x2dv > n i i i s *d         : void glProgramUniformMatrix4x2dv (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix3x4dv > n i i i s *d         : void glProgramUniformMatrix3x4dv (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix4x3dv > n i i i s *d         : void glProgramUniformMatrix4x3dv (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glValidateProgramPipeline > n i                    : void glValidateProgramPipeline (GLuint);
glGetProgramPipelineInfoLog > n i i *i *c          : void glGetProgramPipelineInfoLog (GLuint, GLsizei, GLsizei *, GLchar *);
glVertexAttribL1d > n i d                          : void glVertexAttribL1d (GLuint, GLdouble);
glVertexAttribL2d > n i d d                        : void glVertexAttribL2d (GLuint, GLdouble, GLdouble);
glVertexAttribL3d > n i d d d                      : void glVertexAttribL3d (GLuint, GLdouble, GLdouble, GLdouble);
glVertexAttribL4d > n i d d d d                    : void glVertexAttribL4d (GLuint, GLdouble, GLdouble, GLdouble, GLdouble);
glVertexAttribL1dv > n i *d                        : void glVertexAttribL1dv (GLuint, GLdouble *);
glVertexAttribL2dv > n i *d                        : void glVertexAttribL2dv (GLuint, GLdouble *);
glVertexAttribL3dv > n i *d                        : void glVertexAttribL3dv (GLuint, GLdouble *);
glVertexAttribL4dv > n i *d                        : void glVertexAttribL4dv (GLuint, GLdouble *);
glVertexAttribLPointer > n i i i i *x              : void glVertexAttribLPointer (GLuint, GLint, GLenum, GLsizei, GLvoid *);
glGetVertexAttribLdv > n i i *d                    : void glGetVertexAttribLdv (GLuint, GLenum, GLdouble *);
glViewportArrayv > n i i *f                        : void glViewportArrayv (GLuint, GLsizei, GLfloat *);
glViewportIndexedf > n i f f f f                   : void glViewportIndexedf (GLuint, GLfloat, GLfloat, GLfloat, GLfloat);
glViewportIndexedfv > n i *f                       : void glViewportIndexedfv (GLuint, GLfloat *);
glScissorArrayv > n i i *i                         : void glScissorArrayv (GLuint, GLsizei, GLint *);
glScissorIndexed > n i i i i i                     : void glScissorIndexed (GLuint, GLint, GLint, GLsizei, GLsizei);
glScissorIndexedv > n i *i                         : void glScissorIndexedv (GLuint, GLint *);
glDepthRangeArrayv > n i i *d                      : void glDepthRangeArrayv (GLuint, GLsizei, GLclampd *);
glDepthRangeIndexed > n i d d                      : void glDepthRangeIndexed (GLuint, GLclampd, GLclampd);
glGetFloati_v > n i i *f                           : void glGetFloati_v (GLenum, GLuint, GLfloat *);
glGetDoublei_v > n i i *d                          : void glGetDoublei_v (GLenum, GLuint, GLdouble *);
glCreateSyncFromCLeventARB > x *x *x i             : GLsync glCreateSyncFromCLeventARB (struct _cl_context *, struct _cl_event *, GLbitfield);
glDebugMessageControlARB > n i i i i *i s          : void glDebugMessageControlARB (GLenum, GLenum, GLenum, GLsizei, GLuint *, GLboolean);
glDebugMessageInsertARB > n i i i i i *c           : void glDebugMessageInsertARB (GLenum, GLenum, GLuint, GLenum, GLsizei, GLchar *);
glDebugMessageCallbackARB > n x *x                 : void glDebugMessageCallbackARB (GLDEBUGPROCARB, GLvoid *);
glGetDebugMessageLogARB > i i i *i *i *i *i *i *c  : GLuint glGetDebugMessageLogARB (GLuint, GLsizei, GLenum *, GLenum *, GLuint *, GLenum *, GLsizei *, GLchar *);
glGetGraphicsResetStatusARB > i                    : GLenum glGetGraphicsResetStatusARB (void);
glGetnMapdvARB > n i i i *d                        : void glGetnMapdvARB (GLenum, GLenum, GLsizei, GLdouble *);
glGetnMapfvARB > n i i i *f                        : void glGetnMapfvARB (GLenum, GLenum, GLsizei, GLfloat *);
glGetnMapivARB > n i i i *i                        : void glGetnMapivARB (GLenum, GLenum, GLsizei, GLint *);
glGetnPixelMapfvARB > n i i *f                     : void glGetnPixelMapfvARB (GLenum, GLsizei, GLfloat *);
glGetnPixelMapuivARB > n i i *i                    : void glGetnPixelMapuivARB (GLenum, GLsizei, GLuint *);
glGetnPixelMapusvARB > n i i *s                    : void glGetnPixelMapusvARB (GLenum, GLsizei, GLushort *);
glGetnPolygonStippleARB > n i *c                   : void glGetnPolygonStippleARB (GLsizei, GLubyte *);
glGetnColorTableARB > n i i i i *x                 : void glGetnColorTableARB (GLenum, GLenum, GLenum, GLsizei, GLvoid *);
glGetnConvolutionFilterARB > n i i i i *x          : void glGetnConvolutionFilterARB (GLenum, GLenum, GLenum, GLsizei, GLvoid *);
glGetnSeparableFilterARB > n i i i i *x i *x *x    : void glGetnSeparableFilterARB (GLenum, GLenum, GLenum, GLsizei, GLvoid *, GLsizei, GLvoid *, GLvoid *);
glGetnHistogramARB > n i s i i i *x                : void glGetnHistogramARB (GLenum, GLboolean, GLenum, GLenum, GLsizei, GLvoid *);
glGetnMinmaxARB > n i s i i i *x                   : void glGetnMinmaxARB (GLenum, GLboolean, GLenum, GLenum, GLsizei, GLvoid *);
glGetnTexImageARB > n i i i i i *x                 : void glGetnTexImageARB (GLenum, GLint, GLenum, GLenum, GLsizei, GLvoid *);
glReadnPixelsARB > n i i i i i i i *x              : void glReadnPixelsARB (GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, GLsizei, GLvoid *);
glGetnCompressedTexImageARB > n i i i *x           : void glGetnCompressedTexImageARB (GLenum, GLint, GLsizei, GLvoid *);
glGetnUniformfvARB > n i i i *f                    : void glGetnUniformfvARB (GLuint, GLint, GLsizei, GLfloat *);
glGetnUniformivARB > n i i i *i                    : void glGetnUniformivARB (GLuint, GLint, GLsizei, GLint *);
glGetnUniformuivARB > n i i i *i                   : void glGetnUniformuivARB (GLuint, GLint, GLsizei, GLuint *);
glGetnUniformdvARB > n i i i *d                    : void glGetnUniformdvARB (GLuint, GLint, GLsizei, GLdouble *);
glDrawArraysInstancedBaseInstance > n i i i i i    : void glDrawArraysInstancedBaseInstance (GLenum, GLint, GLsizei, GLsizei, GLuint);
glDrawElementsInstancedBaseInstance > n i i i *x i i : void glDrawElementsInstancedBaseInstance (GLenum, GLsizei, GLenum, void *, GLsizei, GLuint);
glDrawElementsInstancedBaseVertexBaseInstance > n i i i *x i i i : void glDrawElementsInstancedBaseVertexBaseInstance (GLenum, GLsizei, GLenum, void *, GLsizei, GLint, GLuint);
glDrawTransformFeedbackInstanced > n i i i         : void glDrawTransformFeedbackInstanced (GLenum, GLuint, GLsizei);
glDrawTransformFeedbackStreamInstanced > n i i i i : void glDrawTransformFeedbackStreamInstanced (GLenum, GLuint, GLuint, GLsizei);
glGetInternalformativ > n i i i i *i               : void glGetInternalformativ (GLenum, GLenum, GLenum, GLsizei, GLint *);
glGetActiveAtomicCounterBufferiv > n i i i *i      : void glGetActiveAtomicCounterBufferiv (GLuint, GLuint, GLenum, GLint *);
glBindImageTexture > n i i i s i i i               : void glBindImageTexture (GLuint, GLuint, GLint, GLboolean, GLint, GLenum, GLenum);
glMemoryBarrier > n i                              : void glMemoryBarrier (GLbitfield);
glTexStorage1D > n i i i i                         : void glTexStorage1D (GLenum, GLsizei, GLenum, GLsizei);
glTexStorage2D > n i i i i i                       : void glTexStorage2D (GLenum, GLsizei, GLenum, GLsizei, GLsizei);
glTexStorage3D > n i i i i i i                     : void glTexStorage3D (GLenum, GLsizei, GLenum, GLsizei, GLsizei, GLsizei);
glTextureStorage1DEXT > n i i i i i                : void glTextureStorage1DEXT (GLuint, GLenum, GLsizei, GLenum, GLsizei);
glTextureStorage2DEXT > n i i i i i i              : void glTextureStorage2DEXT (GLuint, GLenum, GLsizei, GLenum, GLsizei, GLsizei);
glTextureStorage3DEXT > n i i i i i i i            : void glTextureStorage3DEXT (GLuint, GLenum, GLsizei, GLenum, GLsizei, GLsizei, GLsizei);
glBlendColorEXT > n f f f f                        : void glBlendColorEXT (GLclampf, GLclampf, GLclampf, GLclampf);
glPolygonOffsetEXT > n f f                         : void glPolygonOffsetEXT (GLfloat, GLfloat);
glTexImage3DEXT > n i i i i i i i i i *x           : void glTexImage3DEXT (GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glTexSubImage3DEXT > n i i i i i i i i i i *x      : void glTexSubImage3DEXT (GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glGetTexFilterFuncSGIS > n i i *f                  : void glGetTexFilterFuncSGIS (GLenum, GLenum, GLfloat *);
glTexFilterFuncSGIS > n i i i *f                   : void glTexFilterFuncSGIS (GLenum, GLenum, GLsizei, GLfloat *);
glTexSubImage1DEXT > n i i i i i i *x              : void glTexSubImage1DEXT (GLenum, GLint, GLint, GLsizei, GLenum, GLenum, GLvoid *);
glTexSubImage2DEXT > n i i i i i i i i *x          : void glTexSubImage2DEXT (GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glCopyTexImage1DEXT > n i i i i i i i              : void glCopyTexImage1DEXT (GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLint);
glCopyTexImage2DEXT > n i i i i i i i i            : void glCopyTexImage2DEXT (GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLsizei, GLint);
glCopyTexSubImage1DEXT > n i i i i i i             : void glCopyTexSubImage1DEXT (GLenum, GLint, GLint, GLint, GLint, GLsizei);
glCopyTexSubImage2DEXT > n i i i i i i i i         : void glCopyTexSubImage2DEXT (GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
glCopyTexSubImage3DEXT > n i i i i i i i i i       : void glCopyTexSubImage3DEXT (GLenum, GLint, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
glGetHistogramEXT > n i s i i *x                   : void glGetHistogramEXT (GLenum, GLboolean, GLenum, GLenum, GLvoid *);
glGetHistogramParameterfvEXT > n i i *f            : void glGetHistogramParameterfvEXT (GLenum, GLenum, GLfloat *);
glGetHistogramParameterivEXT > n i i *i            : void glGetHistogramParameterivEXT (GLenum, GLenum, GLint *);
glGetMinmaxEXT > n i s i i *x                      : void glGetMinmaxEXT (GLenum, GLboolean, GLenum, GLenum, GLvoid *);
glGetMinmaxParameterfvEXT > n i i *f               : void glGetMinmaxParameterfvEXT (GLenum, GLenum, GLfloat *);
glGetMinmaxParameterivEXT > n i i *i               : void glGetMinmaxParameterivEXT (GLenum, GLenum, GLint *);
glHistogramEXT > n i i i s                         : void glHistogramEXT (GLenum, GLsizei, GLenum, GLboolean);
glMinmaxEXT > n i i s                              : void glMinmaxEXT (GLenum, GLenum, GLboolean);
glResetHistogramEXT > n i                          : void glResetHistogramEXT (GLenum);
glResetMinmaxEXT > n i                             : void glResetMinmaxEXT (GLenum);
glConvolutionFilter1DEXT > n i i i i i *x          : void glConvolutionFilter1DEXT (GLenum, GLenum, GLsizei, GLenum, GLenum, GLvoid *);
glConvolutionFilter2DEXT > n i i i i i i *x        : void glConvolutionFilter2DEXT (GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glConvolutionParameterfEXT > n i i f               : void glConvolutionParameterfEXT (GLenum, GLenum, GLfloat);
glConvolutionParameterfvEXT > n i i *f             : void glConvolutionParameterfvEXT (GLenum, GLenum, GLfloat *);
glConvolutionParameteriEXT > n i i i               : void glConvolutionParameteriEXT (GLenum, GLenum, GLint);
glConvolutionParameterivEXT > n i i *i             : void glConvolutionParameterivEXT (GLenum, GLenum, GLint *);
glCopyConvolutionFilter1DEXT > n i i i i i         : void glCopyConvolutionFilter1DEXT (GLenum, GLenum, GLint, GLint, GLsizei);
glCopyConvolutionFilter2DEXT > n i i i i i i       : void glCopyConvolutionFilter2DEXT (GLenum, GLenum, GLint, GLint, GLsizei, GLsizei);
glGetConvolutionFilterEXT > n i i i *x             : void glGetConvolutionFilterEXT (GLenum, GLenum, GLenum, GLvoid *);
glGetConvolutionParameterfvEXT > n i i *f          : void glGetConvolutionParameterfvEXT (GLenum, GLenum, GLfloat *);
glGetConvolutionParameterivEXT > n i i *i          : void glGetConvolutionParameterivEXT (GLenum, GLenum, GLint *);
glGetSeparableFilterEXT > n i i i *x *x *x         : void glGetSeparableFilterEXT (GLenum, GLenum, GLenum, GLvoid *, GLvoid *, GLvoid *);
glSeparableFilter2DEXT > n i i i i i i *x *x       : void glSeparableFilter2DEXT (GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid *, GLvoid *);
glColorTableSGI > n i i i i i *x                   : void glColorTableSGI (GLenum, GLenum, GLsizei, GLenum, GLenum, GLvoid *);
glColorTableParameterfvSGI > n i i *f              : void glColorTableParameterfvSGI (GLenum, GLenum, GLfloat *);
glColorTableParameterivSGI > n i i *i              : void glColorTableParameterivSGI (GLenum, GLenum, GLint *);
glCopyColorTableSGI > n i i i i i                  : void glCopyColorTableSGI (GLenum, GLenum, GLint, GLint, GLsizei);
glGetColorTableSGI > n i i i *x                    : void glGetColorTableSGI (GLenum, GLenum, GLenum, GLvoid *);
glGetColorTableParameterfvSGI > n i i *f           : void glGetColorTableParameterfvSGI (GLenum, GLenum, GLfloat *);
glGetColorTableParameterivSGI > n i i *i           : void glGetColorTableParameterivSGI (GLenum, GLenum, GLint *);
glPixelTexGenSGIX > n i                            : void glPixelTexGenSGIX (GLenum);
glPixelTexGenParameteriSGIS > n i i                : void glPixelTexGenParameteriSGIS (GLenum, GLint);
glPixelTexGenParameterivSGIS > n i *i              : void glPixelTexGenParameterivSGIS (GLenum, GLint *);
glPixelTexGenParameterfSGIS > n i f                : void glPixelTexGenParameterfSGIS (GLenum, GLfloat);
glPixelTexGenParameterfvSGIS > n i *f              : void glPixelTexGenParameterfvSGIS (GLenum, GLfloat *);
glGetPixelTexGenParameterivSGIS > n i *i           : void glGetPixelTexGenParameterivSGIS (GLenum, GLint *);
glGetPixelTexGenParameterfvSGIS > n i *f           : void glGetPixelTexGenParameterfvSGIS (GLenum, GLfloat *);
glTexImage4DSGIS > n i i i i i i i i i i *x        : void glTexImage4DSGIS (GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glTexSubImage4DSGIS > n i i i i i i i i i i i i *x : void glTexSubImage4DSGIS (GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glAreTexturesResidentEXT > s i *i *s               : GLboolean glAreTexturesResidentEXT (GLsizei, GLuint *, GLboolean *);
glBindTextureEXT > n i i                           : void glBindTextureEXT (GLenum, GLuint);
glDeleteTexturesEXT > n i *i                       : void glDeleteTexturesEXT (GLsizei, GLuint *);
glGenTexturesEXT > n i *i                          : void glGenTexturesEXT (GLsizei, GLuint *);
glIsTextureEXT > s i                               : GLboolean glIsTextureEXT (GLuint);
glPrioritizeTexturesEXT > n i *i *f                : void glPrioritizeTexturesEXT (GLsizei, GLuint *, GLclampf *);
glDetailTexFuncSGIS > n i i *f                     : void glDetailTexFuncSGIS (GLenum, GLsizei, GLfloat *);
glGetDetailTexFuncSGIS > n i *f                    : void glGetDetailTexFuncSGIS (GLenum, GLfloat *);
glSharpenTexFuncSGIS > n i i *f                    : void glSharpenTexFuncSGIS (GLenum, GLsizei, GLfloat *);
glGetSharpenTexFuncSGIS > n i *f                   : void glGetSharpenTexFuncSGIS (GLenum, GLfloat *);
glSampleMaskSGIS > n f s                           : void glSampleMaskSGIS (GLclampf, GLboolean);
glSamplePatternSGIS > n i                          : void glSamplePatternSGIS (GLenum);
glArrayElementEXT > n i                            : void glArrayElementEXT (GLint);
glColorPointerEXT > n i i i i *x                   : void glColorPointerEXT (GLint, GLenum, GLsizei, GLsizei, GLvoid *);
glDrawArraysEXT > n i i i                          : void glDrawArraysEXT (GLenum, GLint, GLsizei);
glEdgeFlagPointerEXT > n i i *s                    : void glEdgeFlagPointerEXT (GLsizei, GLsizei, GLboolean *);
glGetPointervEXT > n i *x                          : void glGetPointervEXT (GLenum, GLvoid **);
glIndexPointerEXT > n i i i *x                     : void glIndexPointerEXT (GLenum, GLsizei, GLsizei, GLvoid *);
glNormalPointerEXT > n i i i *x                    : void glNormalPointerEXT (GLenum, GLsizei, GLsizei, GLvoid *);
glTexCoordPointerEXT > n i i i i *x                : void glTexCoordPointerEXT (GLint, GLenum, GLsizei, GLsizei, GLvoid *);
glVertexPointerEXT > n i i i i *x                  : void glVertexPointerEXT (GLint, GLenum, GLsizei, GLsizei, GLvoid *);
glBlendEquationEXT > n i                           : void glBlendEquationEXT (GLenum);
glSpriteParameterfSGIX > n i f                     : void glSpriteParameterfSGIX (GLenum, GLfloat);
glSpriteParameterfvSGIX > n i *f                   : void glSpriteParameterfvSGIX (GLenum, GLfloat *);
glSpriteParameteriSGIX > n i i                     : void glSpriteParameteriSGIX (GLenum, GLint);
glSpriteParameterivSGIX > n i *i                   : void glSpriteParameterivSGIX (GLenum, GLint *);
glPointParameterfEXT > n i f                       : void glPointParameterfEXT (GLenum, GLfloat);
glPointParameterfvEXT > n i *f                     : void glPointParameterfvEXT (GLenum, GLfloat *);
glPointParameterfSGIS > n i f                      : void glPointParameterfSGIS (GLenum, GLfloat);
glPointParameterfvSGIS > n i *f                    : void glPointParameterfvSGIS (GLenum, GLfloat *);
glGetInstrumentsSGIX > i                           : GLint glGetInstrumentsSGIX (void);
glInstrumentsBufferSGIX > n i *i                   : void glInstrumentsBufferSGIX (GLsizei, GLint *);
glPollInstrumentsSGIX > i *i                       : GLint glPollInstrumentsSGIX (GLint *);
glReadInstrumentsSGIX > n i                        : void glReadInstrumentsSGIX (GLint);
glStartInstrumentsSGIX > n                         : void glStartInstrumentsSGIX (void);
glStopInstrumentsSGIX > n i                        : void glStopInstrumentsSGIX (GLint);
glFrameZoomSGIX > n i                              : void glFrameZoomSGIX (GLint);
glTagSampleBufferSGIX > n                          : void glTagSampleBufferSGIX (void);
glDeformationMap3dSGIX > n i d d i i d d i i d d i i *d : void glDeformationMap3dSGIX (GLenum, GLdouble, GLdouble, GLint, GLint, GLdouble, GLdouble, GLint, GLint, GLdouble, GLdouble, GLint, GLint, GLdouble *);
glDeformationMap3fSGIX > n i f f i i f f i i f f i i *f : void glDeformationMap3fSGIX (GLenum, GLfloat, GLfloat, GLint, GLint, GLfloat, GLfloat, GLint, GLint, GLfloat, GLfloat, GLint, GLint, GLfloat *);
glDeformSGIX > n i                                 : void glDeformSGIX (GLbitfield);
glLoadIdentityDeformationMapSGIX > n i             : void glLoadIdentityDeformationMapSGIX (GLbitfield);
glReferencePlaneSGIX > n *d                        : void glReferencePlaneSGIX (GLdouble *);
glFlushRasterSGIX > n                              : void glFlushRasterSGIX (void);
glFogFuncSGIS > n i *f                             : void glFogFuncSGIS (GLsizei, GLfloat *);
glGetFogFuncSGIS > n *f                            : void glGetFogFuncSGIS (GLfloat *);
glImageTransformParameteriHP > n i i i             : void glImageTransformParameteriHP (GLenum, GLenum, GLint);
glImageTransformParameterfHP > n i i f             : void glImageTransformParameterfHP (GLenum, GLenum, GLfloat);
glImageTransformParameterivHP > n i i *i           : void glImageTransformParameterivHP (GLenum, GLenum, GLint *);
glImageTransformParameterfvHP > n i i *f           : void glImageTransformParameterfvHP (GLenum, GLenum, GLfloat *);
glGetImageTransformParameterivHP > n i i *i        : void glGetImageTransformParameterivHP (GLenum, GLenum, GLint *);
glGetImageTransformParameterfvHP > n i i *f        : void glGetImageTransformParameterfvHP (GLenum, GLenum, GLfloat *);
glColorSubTableEXT > n i i i i i *x                : void glColorSubTableEXT (GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glCopyColorSubTableEXT > n i i i i i               : void glCopyColorSubTableEXT (GLenum, GLsizei, GLint, GLint, GLsizei);
glHintPGI > n i i                                  : void glHintPGI (GLenum, GLint);
glColorTableEXT > n i i i i i *x                   : void glColorTableEXT (GLenum, GLenum, GLsizei, GLenum, GLenum, GLvoid *);
glGetColorTableEXT > n i i i *x                    : void glGetColorTableEXT (GLenum, GLenum, GLenum, GLvoid *);
glGetColorTableParameterivEXT > n i i *i           : void glGetColorTableParameterivEXT (GLenum, GLenum, GLint *);
glGetColorTableParameterfvEXT > n i i *f           : void glGetColorTableParameterfvEXT (GLenum, GLenum, GLfloat *);
glGetListParameterfvSGIX > n i i *f                : void glGetListParameterfvSGIX (GLuint, GLenum, GLfloat *);
glGetListParameterivSGIX > n i i *i                : void glGetListParameterivSGIX (GLuint, GLenum, GLint *);
glListParameterfSGIX > n i i f                     : void glListParameterfSGIX (GLuint, GLenum, GLfloat);
glListParameterfvSGIX > n i i *f                   : void glListParameterfvSGIX (GLuint, GLenum, GLfloat *);
glListParameteriSGIX > n i i i                     : void glListParameteriSGIX (GLuint, GLenum, GLint);
glListParameterivSGIX > n i i *i                   : void glListParameterivSGIX (GLuint, GLenum, GLint *);
glIndexMaterialEXT > n i i                         : void glIndexMaterialEXT (GLenum, GLenum);
glIndexFuncEXT > n i f                             : void glIndexFuncEXT (GLenum, GLclampf);
glLockArraysEXT > n i i                            : void glLockArraysEXT (GLint, GLsizei);
glUnlockArraysEXT > n                              : void glUnlockArraysEXT (void);
glCullParameterdvEXT > n i *d                      : void glCullParameterdvEXT (GLenum, GLdouble *);
glCullParameterfvEXT > n i *f                      : void glCullParameterfvEXT (GLenum, GLfloat *);
glFragmentColorMaterialSGIX > n i i                : void glFragmentColorMaterialSGIX (GLenum, GLenum);
glFragmentLightfSGIX > n i i f                     : void glFragmentLightfSGIX (GLenum, GLenum, GLfloat);
glFragmentLightfvSGIX > n i i *f                   : void glFragmentLightfvSGIX (GLenum, GLenum, GLfloat *);
glFragmentLightiSGIX > n i i i                     : void glFragmentLightiSGIX (GLenum, GLenum, GLint);
glFragmentLightivSGIX > n i i *i                   : void glFragmentLightivSGIX (GLenum, GLenum, GLint *);
glFragmentLightModelfSGIX > n i f                  : void glFragmentLightModelfSGIX (GLenum, GLfloat);
glFragmentLightModelfvSGIX > n i *f                : void glFragmentLightModelfvSGIX (GLenum, GLfloat *);
glFragmentLightModeliSGIX > n i i                  : void glFragmentLightModeliSGIX (GLenum, GLint);
glFragmentLightModelivSGIX > n i *i                : void glFragmentLightModelivSGIX (GLenum, GLint *);
glFragmentMaterialfSGIX > n i i f                  : void glFragmentMaterialfSGIX (GLenum, GLenum, GLfloat);
glFragmentMaterialfvSGIX > n i i *f                : void glFragmentMaterialfvSGIX (GLenum, GLenum, GLfloat *);
glFragmentMaterialiSGIX > n i i i                  : void glFragmentMaterialiSGIX (GLenum, GLenum, GLint);
glFragmentMaterialivSGIX > n i i *i                : void glFragmentMaterialivSGIX (GLenum, GLenum, GLint *);
glGetFragmentLightfvSGIX > n i i *f                : void glGetFragmentLightfvSGIX (GLenum, GLenum, GLfloat *);
glGetFragmentLightivSGIX > n i i *i                : void glGetFragmentLightivSGIX (GLenum, GLenum, GLint *);
glGetFragmentMaterialfvSGIX > n i i *f             : void glGetFragmentMaterialfvSGIX (GLenum, GLenum, GLfloat *);
glGetFragmentMaterialivSGIX > n i i *i             : void glGetFragmentMaterialivSGIX (GLenum, GLenum, GLint *);
glLightEnviSGIX > n i i                            : void glLightEnviSGIX (GLenum, GLint);
glDrawRangeElementsEXT > n i i i i i *x            : void glDrawRangeElementsEXT (GLenum, GLuint, GLuint, GLsizei, GLenum, GLvoid *);
glApplyTextureEXT > n i                            : void glApplyTextureEXT (GLenum);
glTextureLightEXT > n i                            : void glTextureLightEXT (GLenum);
glTextureMaterialEXT > n i i                       : void glTextureMaterialEXT (GLenum, GLenum);
glAsyncMarkerSGIX > n i                            : void glAsyncMarkerSGIX (GLuint);
glFinishAsyncSGIX > i *i                           : GLint glFinishAsyncSGIX (GLuint *);
glPollAsyncSGIX > i *i                             : GLint glPollAsyncSGIX (GLuint *);
glGenAsyncMarkersSGIX > i i                        : GLuint glGenAsyncMarkersSGIX (GLsizei);
glDeleteAsyncMarkersSGIX > n i i                   : void glDeleteAsyncMarkersSGIX (GLuint, GLsizei);
glIsAsyncMarkerSGIX > s i                          : GLboolean glIsAsyncMarkerSGIX (GLuint);
glVertexPointervINTEL > n i i *x                   : void glVertexPointervINTEL (GLint, GLenum, GLvoid **);
glNormalPointervINTEL > n i *x                     : void glNormalPointervINTEL (GLenum, GLvoid **);
glColorPointervINTEL > n i i *x                    : void glColorPointervINTEL (GLint, GLenum, GLvoid **);
glTexCoordPointervINTEL > n i i *x                 : void glTexCoordPointervINTEL (GLint, GLenum, GLvoid **);
glPixelTransformParameteriEXT > n i i i            : void glPixelTransformParameteriEXT (GLenum, GLenum, GLint);
glPixelTransformParameterfEXT > n i i f            : void glPixelTransformParameterfEXT (GLenum, GLenum, GLfloat);
glPixelTransformParameterivEXT > n i i *i          : void glPixelTransformParameterivEXT (GLenum, GLenum, GLint *);
glPixelTransformParameterfvEXT > n i i *f          : void glPixelTransformParameterfvEXT (GLenum, GLenum, GLfloat *);
glSecondaryColor3bEXT > n c c c                    : void glSecondaryColor3bEXT (GLbyte, GLbyte, GLbyte);
glSecondaryColor3bvEXT > n *c                      : void glSecondaryColor3bvEXT (GLbyte *);
glSecondaryColor3dEXT > n d d d                    : void glSecondaryColor3dEXT (GLdouble, GLdouble, GLdouble);
glSecondaryColor3dvEXT > n *d                      : void glSecondaryColor3dvEXT (GLdouble *);
glSecondaryColor3fEXT > n f f f                    : void glSecondaryColor3fEXT (GLfloat, GLfloat, GLfloat);
glSecondaryColor3fvEXT > n *f                      : void glSecondaryColor3fvEXT (GLfloat *);
glSecondaryColor3iEXT > n i i i                    : void glSecondaryColor3iEXT (GLint, GLint, GLint);
glSecondaryColor3ivEXT > n *i                      : void glSecondaryColor3ivEXT (GLint *);
glSecondaryColor3sEXT > n s s s                    : void glSecondaryColor3sEXT (GLshort, GLshort, GLshort);
glSecondaryColor3svEXT > n *s                      : void glSecondaryColor3svEXT (GLshort *);
glSecondaryColor3ubEXT > n c c c                   : void glSecondaryColor3ubEXT (GLubyte, GLubyte, GLubyte);
glSecondaryColor3ubvEXT > n *c                     : void glSecondaryColor3ubvEXT (GLubyte *);
glSecondaryColor3uiEXT > n i i i                   : void glSecondaryColor3uiEXT (GLuint, GLuint, GLuint);
glSecondaryColor3uivEXT > n *i                     : void glSecondaryColor3uivEXT (GLuint *);
glSecondaryColor3usEXT > n s s s                   : void glSecondaryColor3usEXT (GLushort, GLushort, GLushort);
glSecondaryColor3usvEXT > n *s                     : void glSecondaryColor3usvEXT (GLushort *);
glSecondaryColorPointerEXT > n i i i *x            : void glSecondaryColorPointerEXT (GLint, GLenum, GLsizei, GLvoid *);
glTextureNormalEXT > n i                           : void glTextureNormalEXT (GLenum);
glMultiDrawArraysEXT > n i *i *i i                 : void glMultiDrawArraysEXT (GLenum, GLint *, GLsizei *, GLsizei);
glMultiDrawElementsEXT > n i *i i *x i             : void glMultiDrawElementsEXT (GLenum, GLsizei *, GLenum, GLvoid **, GLsizei);
glFogCoordfEXT > n f                               : void glFogCoordfEXT (GLfloat);
glFogCoordfvEXT > n *f                             : void glFogCoordfvEXT (GLfloat *);
glFogCoorddEXT > n d                               : void glFogCoorddEXT (GLdouble);
glFogCoorddvEXT > n *d                             : void glFogCoorddvEXT (GLdouble *);
glFogCoordPointerEXT > n i i *x                    : void glFogCoordPointerEXT (GLenum, GLsizei, GLvoid *);
glTangent3bEXT > n c c c                           : void glTangent3bEXT (GLbyte, GLbyte, GLbyte);
glTangent3bvEXT > n *c                             : void glTangent3bvEXT (GLbyte *);
glTangent3dEXT > n d d d                           : void glTangent3dEXT (GLdouble, GLdouble, GLdouble);
glTangent3dvEXT > n *d                             : void glTangent3dvEXT (GLdouble *);
glTangent3fEXT > n f f f                           : void glTangent3fEXT (GLfloat, GLfloat, GLfloat);
glTangent3fvEXT > n *f                             : void glTangent3fvEXT (GLfloat *);
glTangent3iEXT > n i i i                           : void glTangent3iEXT (GLint, GLint, GLint);
glTangent3ivEXT > n *i                             : void glTangent3ivEXT (GLint *);
glTangent3sEXT > n s s s                           : void glTangent3sEXT (GLshort, GLshort, GLshort);
glTangent3svEXT > n *s                             : void glTangent3svEXT (GLshort *);
glBinormal3bEXT > n c c c                          : void glBinormal3bEXT (GLbyte, GLbyte, GLbyte);
glBinormal3bvEXT > n *c                            : void glBinormal3bvEXT (GLbyte *);
glBinormal3dEXT > n d d d                          : void glBinormal3dEXT (GLdouble, GLdouble, GLdouble);
glBinormal3dvEXT > n *d                            : void glBinormal3dvEXT (GLdouble *);
glBinormal3fEXT > n f f f                          : void glBinormal3fEXT (GLfloat, GLfloat, GLfloat);
glBinormal3fvEXT > n *f                            : void glBinormal3fvEXT (GLfloat *);
glBinormal3iEXT > n i i i                          : void glBinormal3iEXT (GLint, GLint, GLint);
glBinormal3ivEXT > n *i                            : void glBinormal3ivEXT (GLint *);
glBinormal3sEXT > n s s s                          : void glBinormal3sEXT (GLshort, GLshort, GLshort);
glBinormal3svEXT > n *s                            : void glBinormal3svEXT (GLshort *);
glTangentPointerEXT > n i i *x                     : void glTangentPointerEXT (GLenum, GLsizei, GLvoid *);
glBinormalPointerEXT > n i i *x                    : void glBinormalPointerEXT (GLenum, GLsizei, GLvoid *);
glFinishTextureSUNX > n                            : void glFinishTextureSUNX (void);
glGlobalAlphaFactorbSUN > n c                      : void glGlobalAlphaFactorbSUN (GLbyte);
glGlobalAlphaFactorsSUN > n s                      : void glGlobalAlphaFactorsSUN (GLshort);
glGlobalAlphaFactoriSUN > n i                      : void glGlobalAlphaFactoriSUN (GLint);
glGlobalAlphaFactorfSUN > n f                      : void glGlobalAlphaFactorfSUN (GLfloat);
glGlobalAlphaFactordSUN > n d                      : void glGlobalAlphaFactordSUN (GLdouble);
glGlobalAlphaFactorubSUN > n c                     : void glGlobalAlphaFactorubSUN (GLubyte);
glGlobalAlphaFactorusSUN > n s                     : void glGlobalAlphaFactorusSUN (GLushort);
glGlobalAlphaFactoruiSUN > n i                     : void glGlobalAlphaFactoruiSUN (GLuint);
glReplacementCodeuiSUN > n i                       : void glReplacementCodeuiSUN (GLuint);
glReplacementCodeusSUN > n s                       : void glReplacementCodeusSUN (GLushort);
glReplacementCodeubSUN > n c                       : void glReplacementCodeubSUN (GLubyte);
glReplacementCodeuivSUN > n *i                     : void glReplacementCodeuivSUN (GLuint *);
glReplacementCodeusvSUN > n *s                     : void glReplacementCodeusvSUN (GLushort *);
glReplacementCodeubvSUN > n *c                     : void glReplacementCodeubvSUN (GLubyte *);
glReplacementCodePointerSUN > n i i *x             : void glReplacementCodePointerSUN (GLenum, GLsizei, GLvoid **);
glColor4ubVertex2fSUN > n c c c c f f              : void glColor4ubVertex2fSUN (GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat);
glColor4ubVertex2fvSUN > n *c *f                   : void glColor4ubVertex2fvSUN (GLubyte *, GLfloat *);
glColor4ubVertex3fSUN > n c c c c f f f            : void glColor4ubVertex3fSUN (GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat, GLfloat);
glColor4ubVertex3fvSUN > n *c *f                   : void glColor4ubVertex3fvSUN (GLubyte *, GLfloat *);
glColor3fVertex3fSUN > n f f f f f f               : void glColor3fVertex3fSUN (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glColor3fVertex3fvSUN > n *f *f                    : void glColor3fVertex3fvSUN (GLfloat *, GLfloat *);
glNormal3fVertex3fSUN > n f f f f f f              : void glNormal3fVertex3fSUN (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glNormal3fVertex3fvSUN > n *f *f                   : void glNormal3fVertex3fvSUN (GLfloat *, GLfloat *);
glColor4fNormal3fVertex3fSUN > n f f f f f f f f f f : void glColor4fNormal3fVertex3fSUN (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glColor4fNormal3fVertex3fvSUN > n *f *f *f         : void glColor4fNormal3fVertex3fvSUN (GLfloat *, GLfloat *, GLfloat *);
glTexCoord2fVertex3fSUN > n f f f f f              : void glTexCoord2fVertex3fSUN (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glTexCoord2fVertex3fvSUN > n *f *f                 : void glTexCoord2fVertex3fvSUN (GLfloat *, GLfloat *);
glTexCoord4fVertex4fSUN > n f f f f f f f f        : void glTexCoord4fVertex4fSUN (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glTexCoord4fVertex4fvSUN > n *f *f                 : void glTexCoord4fVertex4fvSUN (GLfloat *, GLfloat *);
glTexCoord2fColor4ubVertex3fSUN > n f f c c c c f f f : void glTexCoord2fColor4ubVertex3fSUN (GLfloat, GLfloat, GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat, GLfloat);
glTexCoord2fColor4ubVertex3fvSUN > n *f *c *f      : void glTexCoord2fColor4ubVertex3fvSUN (GLfloat *, GLubyte *, GLfloat *);
glTexCoord2fColor3fVertex3fSUN > n f f f f f f f f : void glTexCoord2fColor3fVertex3fSUN (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glTexCoord2fColor3fVertex3fvSUN > n *f *f *f       : void glTexCoord2fColor3fVertex3fvSUN (GLfloat *, GLfloat *, GLfloat *);
glTexCoord2fNormal3fVertex3fSUN > n f f f f f f f f : void glTexCoord2fNormal3fVertex3fSUN (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glTexCoord2fNormal3fVertex3fvSUN > n *f *f *f      : void glTexCoord2fNormal3fVertex3fvSUN (GLfloat *, GLfloat *, GLfloat *);
glTexCoord2fColor4fNormal3fVertex3fSUN > n f f f f f f f f f f f f : void glTexCoord2fColor4fNormal3fVertex3fSUN (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glTexCoord2fColor4fNormal3fVertex3fvSUN > n *f *f *f *f : void glTexCoord2fColor4fNormal3fVertex3fvSUN (GLfloat *, GLfloat *, GLfloat *, GLfloat *);
glTexCoord4fColor4fNormal3fVertex4fSUN > n f f f f f f f f f f f f f f f : void glTexCoord4fColor4fNormal3fVertex4fSUN (GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glTexCoord4fColor4fNormal3fVertex4fvSUN > n *f *f *f *f : void glTexCoord4fColor4fNormal3fVertex4fvSUN (GLfloat *, GLfloat *, GLfloat *, GLfloat *);
glReplacementCodeuiVertex3fSUN > n i f f f         : void glReplacementCodeuiVertex3fSUN (GLuint, GLfloat, GLfloat, GLfloat);
glReplacementCodeuiVertex3fvSUN > n *i *f          : void glReplacementCodeuiVertex3fvSUN (GLuint *, GLfloat *);
glReplacementCodeuiColor4ubVertex3fSUN > n i c c c c f f f : void glReplacementCodeuiColor4ubVertex3fSUN (GLuint, GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat, GLfloat);
glReplacementCodeuiColor4ubVertex3fvSUN > n *i *c *f : void glReplacementCodeuiColor4ubVertex3fvSUN (GLuint *, GLubyte *, GLfloat *);
glReplacementCodeuiColor3fVertex3fSUN > n i f f f f f f : void glReplacementCodeuiColor3fVertex3fSUN (GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glReplacementCodeuiColor3fVertex3fvSUN > n *i *f *f : void glReplacementCodeuiColor3fVertex3fvSUN (GLuint *, GLfloat *, GLfloat *);
glReplacementCodeuiNormal3fVertex3fSUN > n i f f f f f f : void glReplacementCodeuiNormal3fVertex3fSUN (GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glReplacementCodeuiNormal3fVertex3fvSUN > n *i *f *f : void glReplacementCodeuiNormal3fVertex3fvSUN (GLuint *, GLfloat *, GLfloat *);
glReplacementCodeuiColor4fNormal3fVertex3fSUN > n i f f f f f f f f f f : void glReplacementCodeuiColor4fNormal3fVertex3fSUN (GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glReplacementCodeuiColor4fNormal3fVertex3fvSUN > n *i *f *f *f : void glReplacementCodeuiColor4fNormal3fVertex3fvSUN (GLuint *, GLfloat *, GLfloat *, GLfloat *);
glReplacementCodeuiTexCoord2fVertex3fSUN > n i f f f f f : void glReplacementCodeuiTexCoord2fVertex3fSUN (GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glReplacementCodeuiTexCoord2fVertex3fvSUN > n *i *f *f : void glReplacementCodeuiTexCoord2fVertex3fvSUN (GLuint *, GLfloat *, GLfloat *);
glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN > n i f f f f f f f f : void glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN (GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN > n *i *f *f *f : void glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN (GLuint *, GLfloat *, GLfloat *, GLfloat *);
glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN > n i f f f f f f f f f f f f : void glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN (GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat);
glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN > n *i *f *f *f *f : void glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN (GLuint *, GLfloat *, GLfloat *, GLfloat *, GLfloat *);
glBlendFuncSeparateEXT > n i i i i                 : void glBlendFuncSeparateEXT (GLenum, GLenum, GLenum, GLenum);
glBlendFuncSeparateINGR > n i i i i                : void glBlendFuncSeparateINGR (GLenum, GLenum, GLenum, GLenum);
glVertexWeightfEXT > n f                           : void glVertexWeightfEXT (GLfloat);
glVertexWeightfvEXT > n *f                         : void glVertexWeightfvEXT (GLfloat *);
glVertexWeightPointerEXT > n i i i *x              : void glVertexWeightPointerEXT (GLsizei, GLenum, GLsizei, GLvoid *);
glFlushVertexArrayRangeNV > n                      : void glFlushVertexArrayRangeNV (void);
glVertexArrayRangeNV > n i *x                      : void glVertexArrayRangeNV (GLsizei, GLvoid *);
glCombinerParameterfvNV > n i *f                   : void glCombinerParameterfvNV (GLenum, GLfloat *);
glCombinerParameterfNV > n i f                     : void glCombinerParameterfNV (GLenum, GLfloat);
glCombinerParameterivNV > n i *i                   : void glCombinerParameterivNV (GLenum, GLint *);
glCombinerParameteriNV > n i i                     : void glCombinerParameteriNV (GLenum, GLint);
glCombinerInputNV > n i i i i i i                  : void glCombinerInputNV (GLenum, GLenum, GLenum, GLenum, GLenum, GLenum);
glCombinerOutputNV > n i i i i i i i s s s         : void glCombinerOutputNV (GLenum, GLenum, GLenum, GLenum, GLenum, GLenum, GLenum, GLboolean, GLboolean, GLboolean);
glFinalCombinerInputNV > n i i i i                 : void glFinalCombinerInputNV (GLenum, GLenum, GLenum, GLenum);
glGetCombinerInputParameterfvNV > n i i i i *f     : void glGetCombinerInputParameterfvNV (GLenum, GLenum, GLenum, GLenum, GLfloat *);
glGetCombinerInputParameterivNV > n i i i i *i     : void glGetCombinerInputParameterivNV (GLenum, GLenum, GLenum, GLenum, GLint *);
glGetCombinerOutputParameterfvNV > n i i i *f      : void glGetCombinerOutputParameterfvNV (GLenum, GLenum, GLenum, GLfloat *);
glGetCombinerOutputParameterivNV > n i i i *i      : void glGetCombinerOutputParameterivNV (GLenum, GLenum, GLenum, GLint *);
glGetFinalCombinerInputParameterfvNV > n i i *f    : void glGetFinalCombinerInputParameterfvNV (GLenum, GLenum, GLfloat *);
glGetFinalCombinerInputParameterivNV > n i i *i    : void glGetFinalCombinerInputParameterivNV (GLenum, GLenum, GLint *);
glResizeBuffersMESA > n                            : void glResizeBuffersMESA (void);
glWindowPos2dMESA > n d d                          : void glWindowPos2dMESA (GLdouble, GLdouble);
glWindowPos2dvMESA > n *d                          : void glWindowPos2dvMESA (GLdouble *);
glWindowPos2fMESA > n f f                          : void glWindowPos2fMESA (GLfloat, GLfloat);
glWindowPos2fvMESA > n *f                          : void glWindowPos2fvMESA (GLfloat *);
glWindowPos2iMESA > n i i                          : void glWindowPos2iMESA (GLint, GLint);
glWindowPos2ivMESA > n *i                          : void glWindowPos2ivMESA (GLint *);
glWindowPos2sMESA > n s s                          : void glWindowPos2sMESA (GLshort, GLshort);
glWindowPos2svMESA > n *s                          : void glWindowPos2svMESA (GLshort *);
glWindowPos3dMESA > n d d d                        : void glWindowPos3dMESA (GLdouble, GLdouble, GLdouble);
glWindowPos3dvMESA > n *d                          : void glWindowPos3dvMESA (GLdouble *);
glWindowPos3fMESA > n f f f                        : void glWindowPos3fMESA (GLfloat, GLfloat, GLfloat);
glWindowPos3fvMESA > n *f                          : void glWindowPos3fvMESA (GLfloat *);
glWindowPos3iMESA > n i i i                        : void glWindowPos3iMESA (GLint, GLint, GLint);
glWindowPos3ivMESA > n *i                          : void glWindowPos3ivMESA (GLint *);
glWindowPos3sMESA > n s s s                        : void glWindowPos3sMESA (GLshort, GLshort, GLshort);
glWindowPos3svMESA > n *s                          : void glWindowPos3svMESA (GLshort *);
glWindowPos4dMESA > n d d d d                      : void glWindowPos4dMESA (GLdouble, GLdouble, GLdouble, GLdouble);
glWindowPos4dvMESA > n *d                          : void glWindowPos4dvMESA (GLdouble *);
glWindowPos4fMESA > n f f f f                      : void glWindowPos4fMESA (GLfloat, GLfloat, GLfloat, GLfloat);
glWindowPos4fvMESA > n *f                          : void glWindowPos4fvMESA (GLfloat *);
glWindowPos4iMESA > n i i i i                      : void glWindowPos4iMESA (GLint, GLint, GLint, GLint);
glWindowPos4ivMESA > n *i                          : void glWindowPos4ivMESA (GLint *);
glWindowPos4sMESA > n s s s s                      : void glWindowPos4sMESA (GLshort, GLshort, GLshort, GLshort);
glWindowPos4svMESA > n *s                          : void glWindowPos4svMESA (GLshort *);
glMultiModeDrawArraysIBM > n *i *i *i i i          : void glMultiModeDrawArraysIBM (GLenum *, GLint *, GLsizei *, GLsizei, GLint);
glMultiModeDrawElementsIBM > n *i *i i *x i i      : void glMultiModeDrawElementsIBM (GLenum *, GLsizei *, GLenum, GLvoid *const *, GLsizei, GLint);
glColorPointerListIBM > n i i i *x i               : void glColorPointerListIBM (GLint, GLenum, GLint, GLvoid **, GLint);
glSecondaryColorPointerListIBM > n i i i *x i      : void glSecondaryColorPointerListIBM (GLint, GLenum, GLint, GLvoid **, GLint);
glEdgeFlagPointerListIBM > n i *x i                : void glEdgeFlagPointerListIBM (GLint, GLboolean **, GLint);
glFogCoordPointerListIBM > n i i *x i              : void glFogCoordPointerListIBM (GLenum, GLint, GLvoid **, GLint);
glIndexPointerListIBM > n i i *x i                 : void glIndexPointerListIBM (GLenum, GLint, GLvoid **, GLint);
glNormalPointerListIBM > n i i *x i                : void glNormalPointerListIBM (GLenum, GLint, GLvoid **, GLint);
glTexCoordPointerListIBM > n i i i *x i            : void glTexCoordPointerListIBM (GLint, GLenum, GLint, GLvoid **, GLint);
glVertexPointerListIBM > n i i i *x i              : void glVertexPointerListIBM (GLint, GLenum, GLint, GLvoid **, GLint);
glTbufferMask3DFX > n i                            : void glTbufferMask3DFX (GLuint);
glSampleMaskEXT > n f s                            : void glSampleMaskEXT (GLclampf, GLboolean);
glSamplePatternEXT > n i                           : void glSamplePatternEXT (GLenum);
glTextureColorMaskSGIS > n s s s s                 : void glTextureColorMaskSGIS (GLboolean, GLboolean, GLboolean, GLboolean);
glIglooInterfaceSGIX > n i *x                      : void glIglooInterfaceSGIX (GLenum, GLvoid *);
glDeleteFencesNV > n i *i                          : void glDeleteFencesNV (GLsizei, GLuint *);
glGenFencesNV > n i *i                             : void glGenFencesNV (GLsizei, GLuint *);
glIsFenceNV > s i                                  : GLboolean glIsFenceNV (GLuint);
glTestFenceNV > s i                                : GLboolean glTestFenceNV (GLuint);
glGetFenceivNV > n i i *i                          : void glGetFenceivNV (GLuint, GLenum, GLint *);
glFinishFenceNV > n i                              : void glFinishFenceNV (GLuint);
glSetFenceNV > n i i                               : void glSetFenceNV (GLuint, GLenum);
glMapControlPointsNV > n i i i i i i i s *x        : void glMapControlPointsNV (GLenum, GLuint, GLenum, GLsizei, GLsizei, GLint, GLint, GLboolean, GLvoid *);
glMapParameterivNV > n i i *i                      : void glMapParameterivNV (GLenum, GLenum, GLint *);
glMapParameterfvNV > n i i *f                      : void glMapParameterfvNV (GLenum, GLenum, GLfloat *);
glGetMapControlPointsNV > n i i i i i s *x         : void glGetMapControlPointsNV (GLenum, GLuint, GLenum, GLsizei, GLsizei, GLboolean, GLvoid *);
glGetMapParameterivNV > n i i *i                   : void glGetMapParameterivNV (GLenum, GLenum, GLint *);
glGetMapParameterfvNV > n i i *f                   : void glGetMapParameterfvNV (GLenum, GLenum, GLfloat *);
glGetMapAttribParameterivNV > n i i i *i           : void glGetMapAttribParameterivNV (GLenum, GLuint, GLenum, GLint *);
glGetMapAttribParameterfvNV > n i i i *f           : void glGetMapAttribParameterfvNV (GLenum, GLuint, GLenum, GLfloat *);
glEvalMapsNV > n i i                               : void glEvalMapsNV (GLenum, GLenum);
glCombinerStageParameterfvNV > n i i *f            : void glCombinerStageParameterfvNV (GLenum, GLenum, GLfloat *);
glGetCombinerStageParameterfvNV > n i i *f         : void glGetCombinerStageParameterfvNV (GLenum, GLenum, GLfloat *);
glAreProgramsResidentNV > s i *i *s                : GLboolean glAreProgramsResidentNV (GLsizei, GLuint *, GLboolean *);
glBindProgramNV > n i i                            : void glBindProgramNV (GLenum, GLuint);
glDeleteProgramsNV > n i *i                        : void glDeleteProgramsNV (GLsizei, GLuint *);
glExecuteProgramNV > n i i *f                      : void glExecuteProgramNV (GLenum, GLuint, GLfloat *);
glGenProgramsNV > n i *i                           : void glGenProgramsNV (GLsizei, GLuint *);
glGetProgramParameterdvNV > n i i i *d             : void glGetProgramParameterdvNV (GLenum, GLuint, GLenum, GLdouble *);
glGetProgramParameterfvNV > n i i i *f             : void glGetProgramParameterfvNV (GLenum, GLuint, GLenum, GLfloat *);
glGetProgramivNV > n i i *i                        : void glGetProgramivNV (GLuint, GLenum, GLint *);
glGetProgramStringNV > n i i *c                    : void glGetProgramStringNV (GLuint, GLenum, GLubyte *);
glGetTrackMatrixivNV > n i i i *i                  : void glGetTrackMatrixivNV (GLenum, GLuint, GLenum, GLint *);
glGetVertexAttribdvNV > n i i *d                   : void glGetVertexAttribdvNV (GLuint, GLenum, GLdouble *);
glGetVertexAttribfvNV > n i i *f                   : void glGetVertexAttribfvNV (GLuint, GLenum, GLfloat *);
glGetVertexAttribivNV > n i i *i                   : void glGetVertexAttribivNV (GLuint, GLenum, GLint *);
glGetVertexAttribPointervNV > n i i *x             : void glGetVertexAttribPointervNV (GLuint, GLenum, GLvoid **);
glIsProgramNV > s i                                : GLboolean glIsProgramNV (GLuint);
glLoadProgramNV > n i i i *c                       : void glLoadProgramNV (GLenum, GLuint, GLsizei, GLubyte *);
glProgramParameter4dNV > n i i d d d d             : void glProgramParameter4dNV (GLenum, GLuint, GLdouble, GLdouble, GLdouble, GLdouble);
glProgramParameter4dvNV > n i i *d                 : void glProgramParameter4dvNV (GLenum, GLuint, GLdouble *);
glProgramParameter4fNV > n i i f f f f             : void glProgramParameter4fNV (GLenum, GLuint, GLfloat, GLfloat, GLfloat, GLfloat);
glProgramParameter4fvNV > n i i *f                 : void glProgramParameter4fvNV (GLenum, GLuint, GLfloat *);
glProgramParameters4dvNV > n i i i *d              : void glProgramParameters4dvNV (GLenum, GLuint, GLsizei, GLdouble *);
glProgramParameters4fvNV > n i i i *f              : void glProgramParameters4fvNV (GLenum, GLuint, GLsizei, GLfloat *);
glRequestResidentProgramsNV > n i *i               : void glRequestResidentProgramsNV (GLsizei, GLuint *);
glTrackMatrixNV > n i i i i                        : void glTrackMatrixNV (GLenum, GLuint, GLenum, GLenum);
glVertexAttribPointerNV > n i i i i *x             : void glVertexAttribPointerNV (GLuint, GLint, GLenum, GLsizei, GLvoid *);
glVertexAttrib1dNV > n i d                         : void glVertexAttrib1dNV (GLuint, GLdouble);
glVertexAttrib1dvNV > n i *d                       : void glVertexAttrib1dvNV (GLuint, GLdouble *);
glVertexAttrib1fNV > n i f                         : void glVertexAttrib1fNV (GLuint, GLfloat);
glVertexAttrib1fvNV > n i *f                       : void glVertexAttrib1fvNV (GLuint, GLfloat *);
glVertexAttrib1sNV > n i s                         : void glVertexAttrib1sNV (GLuint, GLshort);
glVertexAttrib1svNV > n i *s                       : void glVertexAttrib1svNV (GLuint, GLshort *);
glVertexAttrib2dNV > n i d d                       : void glVertexAttrib2dNV (GLuint, GLdouble, GLdouble);
glVertexAttrib2dvNV > n i *d                       : void glVertexAttrib2dvNV (GLuint, GLdouble *);
glVertexAttrib2fNV > n i f f                       : void glVertexAttrib2fNV (GLuint, GLfloat, GLfloat);
glVertexAttrib2fvNV > n i *f                       : void glVertexAttrib2fvNV (GLuint, GLfloat *);
glVertexAttrib2sNV > n i s s                       : void glVertexAttrib2sNV (GLuint, GLshort, GLshort);
glVertexAttrib2svNV > n i *s                       : void glVertexAttrib2svNV (GLuint, GLshort *);
glVertexAttrib3dNV > n i d d d                     : void glVertexAttrib3dNV (GLuint, GLdouble, GLdouble, GLdouble);
glVertexAttrib3dvNV > n i *d                       : void glVertexAttrib3dvNV (GLuint, GLdouble *);
glVertexAttrib3fNV > n i f f f                     : void glVertexAttrib3fNV (GLuint, GLfloat, GLfloat, GLfloat);
glVertexAttrib3fvNV > n i *f                       : void glVertexAttrib3fvNV (GLuint, GLfloat *);
glVertexAttrib3sNV > n i s s s                     : void glVertexAttrib3sNV (GLuint, GLshort, GLshort, GLshort);
glVertexAttrib3svNV > n i *s                       : void glVertexAttrib3svNV (GLuint, GLshort *);
glVertexAttrib4dNV > n i d d d d                   : void glVertexAttrib4dNV (GLuint, GLdouble, GLdouble, GLdouble, GLdouble);
glVertexAttrib4dvNV > n i *d                       : void glVertexAttrib4dvNV (GLuint, GLdouble *);
glVertexAttrib4fNV > n i f f f f                   : void glVertexAttrib4fNV (GLuint, GLfloat, GLfloat, GLfloat, GLfloat);
glVertexAttrib4fvNV > n i *f                       : void glVertexAttrib4fvNV (GLuint, GLfloat *);
glVertexAttrib4sNV > n i s s s s                   : void glVertexAttrib4sNV (GLuint, GLshort, GLshort, GLshort, GLshort);
glVertexAttrib4svNV > n i *s                       : void glVertexAttrib4svNV (GLuint, GLshort *);
glVertexAttrib4ubNV > n i c c c c                  : void glVertexAttrib4ubNV (GLuint, GLubyte, GLubyte, GLubyte, GLubyte);
glVertexAttrib4ubvNV > n i *c                      : void glVertexAttrib4ubvNV (GLuint, GLubyte *);
glVertexAttribs1dvNV > n i i *d                    : void glVertexAttribs1dvNV (GLuint, GLsizei, GLdouble *);
glVertexAttribs1fvNV > n i i *f                    : void glVertexAttribs1fvNV (GLuint, GLsizei, GLfloat *);
glVertexAttribs1svNV > n i i *s                    : void glVertexAttribs1svNV (GLuint, GLsizei, GLshort *);
glVertexAttribs2dvNV > n i i *d                    : void glVertexAttribs2dvNV (GLuint, GLsizei, GLdouble *);
glVertexAttribs2fvNV > n i i *f                    : void glVertexAttribs2fvNV (GLuint, GLsizei, GLfloat *);
glVertexAttribs2svNV > n i i *s                    : void glVertexAttribs2svNV (GLuint, GLsizei, GLshort *);
glVertexAttribs3dvNV > n i i *d                    : void glVertexAttribs3dvNV (GLuint, GLsizei, GLdouble *);
glVertexAttribs3fvNV > n i i *f                    : void glVertexAttribs3fvNV (GLuint, GLsizei, GLfloat *);
glVertexAttribs3svNV > n i i *s                    : void glVertexAttribs3svNV (GLuint, GLsizei, GLshort *);
glVertexAttribs4dvNV > n i i *d                    : void glVertexAttribs4dvNV (GLuint, GLsizei, GLdouble *);
glVertexAttribs4fvNV > n i i *f                    : void glVertexAttribs4fvNV (GLuint, GLsizei, GLfloat *);
glVertexAttribs4svNV > n i i *s                    : void glVertexAttribs4svNV (GLuint, GLsizei, GLshort *);
glVertexAttribs4ubvNV > n i i *c                   : void glVertexAttribs4ubvNV (GLuint, GLsizei, GLubyte *);
glTexBumpParameterivATI > n i *i                   : void glTexBumpParameterivATI (GLenum, GLint *);
glTexBumpParameterfvATI > n i *f                   : void glTexBumpParameterfvATI (GLenum, GLfloat *);
glGetTexBumpParameterivATI > n i *i                : void glGetTexBumpParameterivATI (GLenum, GLint *);
glGetTexBumpParameterfvATI > n i *f                : void glGetTexBumpParameterfvATI (GLenum, GLfloat *);
glGenFragmentShadersATI > i i                      : GLuint glGenFragmentShadersATI (GLuint);
glBindFragmentShaderATI > n i                      : void glBindFragmentShaderATI (GLuint);
glDeleteFragmentShaderATI > n i                    : void glDeleteFragmentShaderATI (GLuint);
glBeginFragmentShaderATI > n                       : void glBeginFragmentShaderATI (void);
glEndFragmentShaderATI > n                         : void glEndFragmentShaderATI (void);
glPassTexCoordATI > n i i i                        : void glPassTexCoordATI (GLuint, GLuint, GLenum);
glSampleMapATI > n i i i                           : void glSampleMapATI (GLuint, GLuint, GLenum);
glColorFragmentOp1ATI > n i i i i i i i            : void glColorFragmentOp1ATI (GLenum, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint);
glColorFragmentOp2ATI > n i i i i i i i i i i      : void glColorFragmentOp2ATI (GLenum, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint);
glColorFragmentOp3ATI > n i i i i i i i i i i i i i : void glColorFragmentOp3ATI (GLenum, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint);
glAlphaFragmentOp1ATI > n i i i i i i              : void glAlphaFragmentOp1ATI (GLenum, GLuint, GLuint, GLuint, GLuint, GLuint);
glAlphaFragmentOp2ATI > n i i i i i i i i i        : void glAlphaFragmentOp2ATI (GLenum, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint);
glAlphaFragmentOp3ATI > n i i i i i i i i i i i i  : void glAlphaFragmentOp3ATI (GLenum, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint);
glSetFragmentShaderConstantATI > n i *f            : void glSetFragmentShaderConstantATI (GLuint, GLfloat *);
glPNTrianglesiATI > n i i                          : void glPNTrianglesiATI (GLenum, GLint);
glPNTrianglesfATI > n i f                          : void glPNTrianglesfATI (GLenum, GLfloat);
glNewObjectBufferATI > i i *x i                    : GLuint glNewObjectBufferATI (GLsizei, GLvoid *, GLenum);
glIsObjectBufferATI > s i                          : GLboolean glIsObjectBufferATI (GLuint);
glUpdateObjectBufferATI > n i i i *x i             : void glUpdateObjectBufferATI (GLuint, GLuint, GLsizei, GLvoid *, GLenum);
glGetObjectBufferfvATI > n i i *f                  : void glGetObjectBufferfvATI (GLuint, GLenum, GLfloat *);
glGetObjectBufferivATI > n i i *i                  : void glGetObjectBufferivATI (GLuint, GLenum, GLint *);
glFreeObjectBufferATI > n i                        : void glFreeObjectBufferATI (GLuint);
glArrayObjectATI > n i i i i i i                   : void glArrayObjectATI (GLenum, GLint, GLenum, GLsizei, GLuint, GLuint);
glGetArrayObjectfvATI > n i i *f                   : void glGetArrayObjectfvATI (GLenum, GLenum, GLfloat *);
glGetArrayObjectivATI > n i i *i                   : void glGetArrayObjectivATI (GLenum, GLenum, GLint *);
glVariantArrayObjectATI > n i i i i i              : void glVariantArrayObjectATI (GLuint, GLenum, GLsizei, GLuint, GLuint);
glGetVariantArrayObjectfvATI > n i i *f            : void glGetVariantArrayObjectfvATI (GLuint, GLenum, GLfloat *);
glGetVariantArrayObjectivATI > n i i *i            : void glGetVariantArrayObjectivATI (GLuint, GLenum, GLint *);
glBeginVertexShaderEXT > n                         : void glBeginVertexShaderEXT (void);
glEndVertexShaderEXT > n                           : void glEndVertexShaderEXT (void);
glBindVertexShaderEXT > n i                        : void glBindVertexShaderEXT (GLuint);
glGenVertexShadersEXT > i i                        : GLuint glGenVertexShadersEXT (GLuint);
glDeleteVertexShaderEXT > n i                      : void glDeleteVertexShaderEXT (GLuint);
glShaderOp1EXT > n i i i                           : void glShaderOp1EXT (GLenum, GLuint, GLuint);
glShaderOp2EXT > n i i i i                         : void glShaderOp2EXT (GLenum, GLuint, GLuint, GLuint);
glShaderOp3EXT > n i i i i i                       : void glShaderOp3EXT (GLenum, GLuint, GLuint, GLuint, GLuint);
glSwizzleEXT > n i i i i i i                       : void glSwizzleEXT (GLuint, GLuint, GLenum, GLenum, GLenum, GLenum);
glWriteMaskEXT > n i i i i i i                     : void glWriteMaskEXT (GLuint, GLuint, GLenum, GLenum, GLenum, GLenum);
glInsertComponentEXT > n i i i                     : void glInsertComponentEXT (GLuint, GLuint, GLuint);
glExtractComponentEXT > n i i i                    : void glExtractComponentEXT (GLuint, GLuint, GLuint);
glGenSymbolsEXT > i i i i i                        : GLuint glGenSymbolsEXT (GLenum, GLenum, GLenum, GLuint);
glSetInvariantEXT > n i i *x                       : void glSetInvariantEXT (GLuint, GLenum, GLvoid *);
glSetLocalConstantEXT > n i i *x                   : void glSetLocalConstantEXT (GLuint, GLenum, GLvoid *);
glVariantbvEXT > n i *c                            : void glVariantbvEXT (GLuint, GLbyte *);
glVariantsvEXT > n i *s                            : void glVariantsvEXT (GLuint, GLshort *);
glVariantivEXT > n i *i                            : void glVariantivEXT (GLuint, GLint *);
glVariantfvEXT > n i *f                            : void glVariantfvEXT (GLuint, GLfloat *);
glVariantdvEXT > n i *d                            : void glVariantdvEXT (GLuint, GLdouble *);
glVariantubvEXT > n i *c                           : void glVariantubvEXT (GLuint, GLubyte *);
glVariantusvEXT > n i *s                           : void glVariantusvEXT (GLuint, GLushort *);
glVariantuivEXT > n i *i                           : void glVariantuivEXT (GLuint, GLuint *);
glVariantPointerEXT > n i i i *x                   : void glVariantPointerEXT (GLuint, GLenum, GLuint, GLvoid *);
glEnableVariantClientStateEXT > n i                : void glEnableVariantClientStateEXT (GLuint);
glDisableVariantClientStateEXT > n i               : void glDisableVariantClientStateEXT (GLuint);
glBindLightParameterEXT > i i i                    : GLuint glBindLightParameterEXT (GLenum, GLenum);
glBindMaterialParameterEXT > i i i                 : GLuint glBindMaterialParameterEXT (GLenum, GLenum);
glBindTexGenParameterEXT > i i i i                 : GLuint glBindTexGenParameterEXT (GLenum, GLenum, GLenum);
glBindTextureUnitParameterEXT > i i i              : GLuint glBindTextureUnitParameterEXT (GLenum, GLenum);
glBindParameterEXT > i i                           : GLuint glBindParameterEXT (GLenum);
glIsVariantEnabledEXT > s i i                      : GLboolean glIsVariantEnabledEXT (GLuint, GLenum);
glGetVariantBooleanvEXT > n i i *s                 : void glGetVariantBooleanvEXT (GLuint, GLenum, GLboolean *);
glGetVariantIntegervEXT > n i i *i                 : void glGetVariantIntegervEXT (GLuint, GLenum, GLint *);
glGetVariantFloatvEXT > n i i *f                   : void glGetVariantFloatvEXT (GLuint, GLenum, GLfloat *);
glGetVariantPointervEXT > n i i *x                 : void glGetVariantPointervEXT (GLuint, GLenum, GLvoid **);
glGetInvariantBooleanvEXT > n i i *s               : void glGetInvariantBooleanvEXT (GLuint, GLenum, GLboolean *);
glGetInvariantIntegervEXT > n i i *i               : void glGetInvariantIntegervEXT (GLuint, GLenum, GLint *);
glGetInvariantFloatvEXT > n i i *f                 : void glGetInvariantFloatvEXT (GLuint, GLenum, GLfloat *);
glGetLocalConstantBooleanvEXT > n i i *s           : void glGetLocalConstantBooleanvEXT (GLuint, GLenum, GLboolean *);
glGetLocalConstantIntegervEXT > n i i *i           : void glGetLocalConstantIntegervEXT (GLuint, GLenum, GLint *);
glGetLocalConstantFloatvEXT > n i i *f             : void glGetLocalConstantFloatvEXT (GLuint, GLenum, GLfloat *);
glVertexStream1sATI > n i s                        : void glVertexStream1sATI (GLenum, GLshort);
glVertexStream1svATI > n i *s                      : void glVertexStream1svATI (GLenum, GLshort *);
glVertexStream1iATI > n i i                        : void glVertexStream1iATI (GLenum, GLint);
glVertexStream1ivATI > n i *i                      : void glVertexStream1ivATI (GLenum, GLint *);
glVertexStream1fATI > n i f                        : void glVertexStream1fATI (GLenum, GLfloat);
glVertexStream1fvATI > n i *f                      : void glVertexStream1fvATI (GLenum, GLfloat *);
glVertexStream1dATI > n i d                        : void glVertexStream1dATI (GLenum, GLdouble);
glVertexStream1dvATI > n i *d                      : void glVertexStream1dvATI (GLenum, GLdouble *);
glVertexStream2sATI > n i s s                      : void glVertexStream2sATI (GLenum, GLshort, GLshort);
glVertexStream2svATI > n i *s                      : void glVertexStream2svATI (GLenum, GLshort *);
glVertexStream2iATI > n i i i                      : void glVertexStream2iATI (GLenum, GLint, GLint);
glVertexStream2ivATI > n i *i                      : void glVertexStream2ivATI (GLenum, GLint *);
glVertexStream2fATI > n i f f                      : void glVertexStream2fATI (GLenum, GLfloat, GLfloat);
glVertexStream2fvATI > n i *f                      : void glVertexStream2fvATI (GLenum, GLfloat *);
glVertexStream2dATI > n i d d                      : void glVertexStream2dATI (GLenum, GLdouble, GLdouble);
glVertexStream2dvATI > n i *d                      : void glVertexStream2dvATI (GLenum, GLdouble *);
glVertexStream3sATI > n i s s s                    : void glVertexStream3sATI (GLenum, GLshort, GLshort, GLshort);
glVertexStream3svATI > n i *s                      : void glVertexStream3svATI (GLenum, GLshort *);
glVertexStream3iATI > n i i i i                    : void glVertexStream3iATI (GLenum, GLint, GLint, GLint);
glVertexStream3ivATI > n i *i                      : void glVertexStream3ivATI (GLenum, GLint *);
glVertexStream3fATI > n i f f f                    : void glVertexStream3fATI (GLenum, GLfloat, GLfloat, GLfloat);
glVertexStream3fvATI > n i *f                      : void glVertexStream3fvATI (GLenum, GLfloat *);
glVertexStream3dATI > n i d d d                    : void glVertexStream3dATI (GLenum, GLdouble, GLdouble, GLdouble);
glVertexStream3dvATI > n i *d                      : void glVertexStream3dvATI (GLenum, GLdouble *);
glVertexStream4sATI > n i s s s s                  : void glVertexStream4sATI (GLenum, GLshort, GLshort, GLshort, GLshort);
glVertexStream4svATI > n i *s                      : void glVertexStream4svATI (GLenum, GLshort *);
glVertexStream4iATI > n i i i i i                  : void glVertexStream4iATI (GLenum, GLint, GLint, GLint, GLint);
glVertexStream4ivATI > n i *i                      : void glVertexStream4ivATI (GLenum, GLint *);
glVertexStream4fATI > n i f f f f                  : void glVertexStream4fATI (GLenum, GLfloat, GLfloat, GLfloat, GLfloat);
glVertexStream4fvATI > n i *f                      : void glVertexStream4fvATI (GLenum, GLfloat *);
glVertexStream4dATI > n i d d d d                  : void glVertexStream4dATI (GLenum, GLdouble, GLdouble, GLdouble, GLdouble);
glVertexStream4dvATI > n i *d                      : void glVertexStream4dvATI (GLenum, GLdouble *);
glNormalStream3bATI > n i c c c                    : void glNormalStream3bATI (GLenum, GLbyte, GLbyte, GLbyte);
glNormalStream3bvATI > n i *c                      : void glNormalStream3bvATI (GLenum, GLbyte *);
glNormalStream3sATI > n i s s s                    : void glNormalStream3sATI (GLenum, GLshort, GLshort, GLshort);
glNormalStream3svATI > n i *s                      : void glNormalStream3svATI (GLenum, GLshort *);
glNormalStream3iATI > n i i i i                    : void glNormalStream3iATI (GLenum, GLint, GLint, GLint);
glNormalStream3ivATI > n i *i                      : void glNormalStream3ivATI (GLenum, GLint *);
glNormalStream3fATI > n i f f f                    : void glNormalStream3fATI (GLenum, GLfloat, GLfloat, GLfloat);
glNormalStream3fvATI > n i *f                      : void glNormalStream3fvATI (GLenum, GLfloat *);
glNormalStream3dATI > n i d d d                    : void glNormalStream3dATI (GLenum, GLdouble, GLdouble, GLdouble);
glNormalStream3dvATI > n i *d                      : void glNormalStream3dvATI (GLenum, GLdouble *);
glClientActiveVertexStreamATI > n i                : void glClientActiveVertexStreamATI (GLenum);
glVertexBlendEnviATI > n i i                       : void glVertexBlendEnviATI (GLenum, GLint);
glVertexBlendEnvfATI > n i f                       : void glVertexBlendEnvfATI (GLenum, GLfloat);
glElementPointerATI > n i *x                       : void glElementPointerATI (GLenum, GLvoid *);
glDrawElementArrayATI > n i i                      : void glDrawElementArrayATI (GLenum, GLsizei);
glDrawRangeElementArrayATI > n i i i i             : void glDrawRangeElementArrayATI (GLenum, GLuint, GLuint, GLsizei);
glDrawMeshArraysSUN > n i i i i                    : void glDrawMeshArraysSUN (GLenum, GLint, GLsizei, GLsizei);
glGenOcclusionQueriesNV > n i *i                   : void glGenOcclusionQueriesNV (GLsizei, GLuint *);
glDeleteOcclusionQueriesNV > n i *i                : void glDeleteOcclusionQueriesNV (GLsizei, GLuint *);
glIsOcclusionQueryNV > s i                         : GLboolean glIsOcclusionQueryNV (GLuint);
glBeginOcclusionQueryNV > n i                      : void glBeginOcclusionQueryNV (GLuint);
glEndOcclusionQueryNV > n                          : void glEndOcclusionQueryNV (void);
glGetOcclusionQueryivNV > n i i *i                 : void glGetOcclusionQueryivNV (GLuint, GLenum, GLint *);
glGetOcclusionQueryuivNV > n i i *i                : void glGetOcclusionQueryuivNV (GLuint, GLenum, GLuint *);
glPointParameteriNV > n i i                        : void glPointParameteriNV (GLenum, GLint);
glPointParameterivNV > n i *i                      : void glPointParameterivNV (GLenum, GLint *);
glActiveStencilFaceEXT > n i                       : void glActiveStencilFaceEXT (GLenum);
glElementPointerAPPLE > n i *x                     : void glElementPointerAPPLE (GLenum, GLvoid *);
glDrawElementArrayAPPLE > n i i i                  : void glDrawElementArrayAPPLE (GLenum, GLint, GLsizei);
glDrawRangeElementArrayAPPLE > n i i i i i         : void glDrawRangeElementArrayAPPLE (GLenum, GLuint, GLuint, GLint, GLsizei);
glMultiDrawElementArrayAPPLE > n i *i *i i         : void glMultiDrawElementArrayAPPLE (GLenum, GLint *, GLsizei *, GLsizei);
glMultiDrawRangeElementArrayAPPLE > n i i i *i *i i : void glMultiDrawRangeElementArrayAPPLE (GLenum, GLuint, GLuint, GLint *, GLsizei *, GLsizei);
glGenFencesAPPLE > n i *i                          : void glGenFencesAPPLE (GLsizei, GLuint *);
glDeleteFencesAPPLE > n i *i                       : void glDeleteFencesAPPLE (GLsizei, GLuint *);
glSetFenceAPPLE > n i                              : void glSetFenceAPPLE (GLuint);
glIsFenceAPPLE > s i                               : GLboolean glIsFenceAPPLE (GLuint);
glTestFenceAPPLE > s i                             : GLboolean glTestFenceAPPLE (GLuint);
glFinishFenceAPPLE > n i                           : void glFinishFenceAPPLE (GLuint);
glTestObjectAPPLE > s i i                          : GLboolean glTestObjectAPPLE (GLenum, GLuint);
glFinishObjectAPPLE > n i i                        : void glFinishObjectAPPLE (GLenum, GLint);
glBindVertexArrayAPPLE > n i                       : void glBindVertexArrayAPPLE (GLuint);
glDeleteVertexArraysAPPLE > n i *i                 : void glDeleteVertexArraysAPPLE (GLsizei, GLuint *);
glGenVertexArraysAPPLE > n i *i                    : void glGenVertexArraysAPPLE (GLsizei, GLuint *);
glIsVertexArrayAPPLE > s i                         : GLboolean glIsVertexArrayAPPLE (GLuint);
glVertexArrayRangeAPPLE > n i *x                   : void glVertexArrayRangeAPPLE (GLsizei, GLvoid *);
glFlushVertexArrayRangeAPPLE > n i *x              : void glFlushVertexArrayRangeAPPLE (GLsizei, GLvoid *);
glVertexArrayParameteriAPPLE > n i i               : void glVertexArrayParameteriAPPLE (GLenum, GLint);
glDrawBuffersATI > n i *i                          : void glDrawBuffersATI (GLsizei, GLenum *);
glProgramNamedParameter4fNV > n i i *c f f f f     : void glProgramNamedParameter4fNV (GLuint, GLsizei, GLubyte *, GLfloat, GLfloat, GLfloat, GLfloat);
glProgramNamedParameter4dNV > n i i *c d d d d     : void glProgramNamedParameter4dNV (GLuint, GLsizei, GLubyte *, GLdouble, GLdouble, GLdouble, GLdouble);
glProgramNamedParameter4fvNV > n i i *c *f         : void glProgramNamedParameter4fvNV (GLuint, GLsizei, GLubyte *, GLfloat *);
glProgramNamedParameter4dvNV > n i i *c *d         : void glProgramNamedParameter4dvNV (GLuint, GLsizei, GLubyte *, GLdouble *);
glGetProgramNamedParameterfvNV > n i i *c *f       : void glGetProgramNamedParameterfvNV (GLuint, GLsizei, GLubyte *, GLfloat *);
glGetProgramNamedParameterdvNV > n i i *c *d       : void glGetProgramNamedParameterdvNV (GLuint, GLsizei, GLubyte *, GLdouble *);
glVertex2hNV > n x x                               : void glVertex2hNV (GLhalfNV, GLhalfNV);
glVertex2hvNV > n *x                               : void glVertex2hvNV (GLhalfNV *);
glVertex3hNV > n x x x                             : void glVertex3hNV (GLhalfNV, GLhalfNV, GLhalfNV);
glVertex3hvNV > n *x                               : void glVertex3hvNV (GLhalfNV *);
glVertex4hNV > n x x x x                           : void glVertex4hNV (GLhalfNV, GLhalfNV, GLhalfNV, GLhalfNV);
glVertex4hvNV > n *x                               : void glVertex4hvNV (GLhalfNV *);
glNormal3hNV > n x x x                             : void glNormal3hNV (GLhalfNV, GLhalfNV, GLhalfNV);
glNormal3hvNV > n *x                               : void glNormal3hvNV (GLhalfNV *);
glColor3hNV > n x x x                              : void glColor3hNV (GLhalfNV, GLhalfNV, GLhalfNV);
glColor3hvNV > n *x                                : void glColor3hvNV (GLhalfNV *);
glColor4hNV > n x x x x                            : void glColor4hNV (GLhalfNV, GLhalfNV, GLhalfNV, GLhalfNV);
glColor4hvNV > n *x                                : void glColor4hvNV (GLhalfNV *);
glTexCoord1hNV > n x                               : void glTexCoord1hNV (GLhalfNV);
glTexCoord1hvNV > n *x                             : void glTexCoord1hvNV (GLhalfNV *);
glTexCoord2hNV > n x x                             : void glTexCoord2hNV (GLhalfNV, GLhalfNV);
glTexCoord2hvNV > n *x                             : void glTexCoord2hvNV (GLhalfNV *);
glTexCoord3hNV > n x x x                           : void glTexCoord3hNV (GLhalfNV, GLhalfNV, GLhalfNV);
glTexCoord3hvNV > n *x                             : void glTexCoord3hvNV (GLhalfNV *);
glTexCoord4hNV > n x x x x                         : void glTexCoord4hNV (GLhalfNV, GLhalfNV, GLhalfNV, GLhalfNV);
glTexCoord4hvNV > n *x                             : void glTexCoord4hvNV (GLhalfNV *);
glMultiTexCoord1hNV > n i x                        : void glMultiTexCoord1hNV (GLenum, GLhalfNV);
glMultiTexCoord1hvNV > n i *x                      : void glMultiTexCoord1hvNV (GLenum, GLhalfNV *);
glMultiTexCoord2hNV > n i x x                      : void glMultiTexCoord2hNV (GLenum, GLhalfNV, GLhalfNV);
glMultiTexCoord2hvNV > n i *x                      : void glMultiTexCoord2hvNV (GLenum, GLhalfNV *);
glMultiTexCoord3hNV > n i x x x                    : void glMultiTexCoord3hNV (GLenum, GLhalfNV, GLhalfNV, GLhalfNV);
glMultiTexCoord3hvNV > n i *x                      : void glMultiTexCoord3hvNV (GLenum, GLhalfNV *);
glMultiTexCoord4hNV > n i x x x x                  : void glMultiTexCoord4hNV (GLenum, GLhalfNV, GLhalfNV, GLhalfNV, GLhalfNV);
glMultiTexCoord4hvNV > n i *x                      : void glMultiTexCoord4hvNV (GLenum, GLhalfNV *);
glFogCoordhNV > n x                                : void glFogCoordhNV (GLhalfNV);
glFogCoordhvNV > n *x                              : void glFogCoordhvNV (GLhalfNV *);
glSecondaryColor3hNV > n x x x                     : void glSecondaryColor3hNV (GLhalfNV, GLhalfNV, GLhalfNV);
glSecondaryColor3hvNV > n *x                       : void glSecondaryColor3hvNV (GLhalfNV *);
glVertexWeighthNV > n x                            : void glVertexWeighthNV (GLhalfNV);
glVertexWeighthvNV > n *x                          : void glVertexWeighthvNV (GLhalfNV *);
glVertexAttrib1hNV > n i x                         : void glVertexAttrib1hNV (GLuint, GLhalfNV);
glVertexAttrib1hvNV > n i *x                       : void glVertexAttrib1hvNV (GLuint, GLhalfNV *);
glVertexAttrib2hNV > n i x x                       : void glVertexAttrib2hNV (GLuint, GLhalfNV, GLhalfNV);
glVertexAttrib2hvNV > n i *x                       : void glVertexAttrib2hvNV (GLuint, GLhalfNV *);
glVertexAttrib3hNV > n i x x x                     : void glVertexAttrib3hNV (GLuint, GLhalfNV, GLhalfNV, GLhalfNV);
glVertexAttrib3hvNV > n i *x                       : void glVertexAttrib3hvNV (GLuint, GLhalfNV *);
glVertexAttrib4hNV > n i x x x x                   : void glVertexAttrib4hNV (GLuint, GLhalfNV, GLhalfNV, GLhalfNV, GLhalfNV);
glVertexAttrib4hvNV > n i *x                       : void glVertexAttrib4hvNV (GLuint, GLhalfNV *);
glVertexAttribs1hvNV > n i i *x                    : void glVertexAttribs1hvNV (GLuint, GLsizei, GLhalfNV *);
glVertexAttribs2hvNV > n i i *x                    : void glVertexAttribs2hvNV (GLuint, GLsizei, GLhalfNV *);
glVertexAttribs3hvNV > n i i *x                    : void glVertexAttribs3hvNV (GLuint, GLsizei, GLhalfNV *);
glVertexAttribs4hvNV > n i i *x                    : void glVertexAttribs4hvNV (GLuint, GLsizei, GLhalfNV *);
glPixelDataRangeNV > n i i *x                      : void glPixelDataRangeNV (GLenum, GLsizei, GLvoid *);
glFlushPixelDataRangeNV > n i                      : void glFlushPixelDataRangeNV (GLenum);
glPrimitiveRestartNV > n                           : void glPrimitiveRestartNV (void);
glPrimitiveRestartIndexNV > n i                    : void glPrimitiveRestartIndexNV (GLuint);
glMapObjectBufferATI > x i                         : GLvoid *glMapObjectBufferATI (GLuint);
glUnmapObjectBufferATI > n i                       : void glUnmapObjectBufferATI (GLuint);
glStencilOpSeparateATI > n i i i i                 : void glStencilOpSeparateATI (GLenum, GLenum, GLenum, GLenum);
glStencilFuncSeparateATI > n i i i i               : void glStencilFuncSeparateATI (GLenum, GLenum, GLint, GLuint);
glVertexAttribArrayObjectATI > n i i i s i i i     : void glVertexAttribArrayObjectATI (GLuint, GLint, GLenum, GLboolean, GLsizei, GLuint, GLuint);
glGetVertexAttribArrayObjectfvATI > n i i *f       : void glGetVertexAttribArrayObjectfvATI (GLuint, GLenum, GLfloat *);
glGetVertexAttribArrayObjectivATI > n i i *i       : void glGetVertexAttribArrayObjectivATI (GLuint, GLenum, GLint *);
glDepthBoundsEXT > n d d                           : void glDepthBoundsEXT (GLclampd, GLclampd);
glBlendEquationSeparateEXT > n i i                 : void glBlendEquationSeparateEXT (GLenum, GLenum);
glIsRenderbufferEXT > s i                          : GLboolean glIsRenderbufferEXT (GLuint);
glBindRenderbufferEXT > n i i                      : void glBindRenderbufferEXT (GLenum, GLuint);
glDeleteRenderbuffersEXT > n i *i                  : void glDeleteRenderbuffersEXT (GLsizei, GLuint *);
glGenRenderbuffersEXT > n i *i                     : void glGenRenderbuffersEXT (GLsizei, GLuint *);
glRenderbufferStorageEXT > n i i i i               : void glRenderbufferStorageEXT (GLenum, GLenum, GLsizei, GLsizei);
glGetRenderbufferParameterivEXT > n i i *i         : void glGetRenderbufferParameterivEXT (GLenum, GLenum, GLint *);
glIsFramebufferEXT > s i                           : GLboolean glIsFramebufferEXT (GLuint);
glBindFramebufferEXT > n i i                       : void glBindFramebufferEXT (GLenum, GLuint);
glDeleteFramebuffersEXT > n i *i                   : void glDeleteFramebuffersEXT (GLsizei, GLuint *);
glGenFramebuffersEXT > n i *i                      : void glGenFramebuffersEXT (GLsizei, GLuint *);
glCheckFramebufferStatusEXT > i i                  : GLenum glCheckFramebufferStatusEXT (GLenum);
glFramebufferTexture1DEXT > n i i i i i            : void glFramebufferTexture1DEXT (GLenum, GLenum, GLenum, GLuint, GLint);
glFramebufferTexture2DEXT > n i i i i i            : void glFramebufferTexture2DEXT (GLenum, GLenum, GLenum, GLuint, GLint);
glFramebufferTexture3DEXT > n i i i i i i          : void glFramebufferTexture3DEXT (GLenum, GLenum, GLenum, GLuint, GLint, GLint);
glFramebufferRenderbufferEXT > n i i i i           : void glFramebufferRenderbufferEXT (GLenum, GLenum, GLenum, GLuint);
glGetFramebufferAttachmentParameterivEXT > n i i i *i : void glGetFramebufferAttachmentParameterivEXT (GLenum, GLenum, GLenum, GLint *);
glGenerateMipmapEXT > n i                          : void glGenerateMipmapEXT (GLenum);
glStringMarkerGREMEDY > n i *x                     : void glStringMarkerGREMEDY (GLsizei, GLvoid *);
glStencilClearTagEXT > n i i                       : void glStencilClearTagEXT (GLsizei, GLuint);
glBlitFramebufferEXT > n i i i i i i i i i i       : void glBlitFramebufferEXT (GLint, GLint, GLint, GLint, GLint, GLint, GLint, GLint, GLbitfield, GLenum);
glRenderbufferStorageMultisampleEXT > n i i i i i  : void glRenderbufferStorageMultisampleEXT (GLenum, GLsizei, GLenum, GLsizei, GLsizei);
glGetQueryObjecti64vEXT > n i i *l                 : void glGetQueryObjecti64vEXT (GLuint, GLenum, GLint64EXT *);
glGetQueryObjectui64vEXT > n i i *l                : void glGetQueryObjectui64vEXT (GLuint, GLenum, GLuint64EXT *);
glProgramEnvParameters4fvEXT > n i i i *f          : void glProgramEnvParameters4fvEXT (GLenum, GLuint, GLsizei, GLfloat *);
glProgramLocalParameters4fvEXT > n i i i *f        : void glProgramLocalParameters4fvEXT (GLenum, GLuint, GLsizei, GLfloat *);
glBufferParameteriAPPLE > n i i i                  : void glBufferParameteriAPPLE (GLenum, GLenum, GLint);
glFlushMappedBufferRangeAPPLE > n i i i            : void glFlushMappedBufferRangeAPPLE (GLenum, GLintptr, GLsizeiptr);
glProgramLocalParameterI4iNV > n i i i i i i       : void glProgramLocalParameterI4iNV (GLenum, GLuint, GLint, GLint, GLint, GLint);
glProgramLocalParameterI4ivNV > n i i *i           : void glProgramLocalParameterI4ivNV (GLenum, GLuint, GLint *);
glProgramLocalParametersI4ivNV > n i i i *i        : void glProgramLocalParametersI4ivNV (GLenum, GLuint, GLsizei, GLint *);
glProgramLocalParameterI4uiNV > n i i i i i i      : void glProgramLocalParameterI4uiNV (GLenum, GLuint, GLuint, GLuint, GLuint, GLuint);
glProgramLocalParameterI4uivNV > n i i *i          : void glProgramLocalParameterI4uivNV (GLenum, GLuint, GLuint *);
glProgramLocalParametersI4uivNV > n i i i *i       : void glProgramLocalParametersI4uivNV (GLenum, GLuint, GLsizei, GLuint *);
glProgramEnvParameterI4iNV > n i i i i i i         : void glProgramEnvParameterI4iNV (GLenum, GLuint, GLint, GLint, GLint, GLint);
glProgramEnvParameterI4ivNV > n i i *i             : void glProgramEnvParameterI4ivNV (GLenum, GLuint, GLint *);
glProgramEnvParametersI4ivNV > n i i i *i          : void glProgramEnvParametersI4ivNV (GLenum, GLuint, GLsizei, GLint *);
glProgramEnvParameterI4uiNV > n i i i i i i        : void glProgramEnvParameterI4uiNV (GLenum, GLuint, GLuint, GLuint, GLuint, GLuint);
glProgramEnvParameterI4uivNV > n i i *i            : void glProgramEnvParameterI4uivNV (GLenum, GLuint, GLuint *);
glProgramEnvParametersI4uivNV > n i i i *i         : void glProgramEnvParametersI4uivNV (GLenum, GLuint, GLsizei, GLuint *);
glGetProgramLocalParameterIivNV > n i i *i         : void glGetProgramLocalParameterIivNV (GLenum, GLuint, GLint *);
glGetProgramLocalParameterIuivNV > n i i *i        : void glGetProgramLocalParameterIuivNV (GLenum, GLuint, GLuint *);
glGetProgramEnvParameterIivNV > n i i *i           : void glGetProgramEnvParameterIivNV (GLenum, GLuint, GLint *);
glGetProgramEnvParameterIuivNV > n i i *i          : void glGetProgramEnvParameterIuivNV (GLenum, GLuint, GLuint *);
glProgramVertexLimitNV > n i i                     : void glProgramVertexLimitNV (GLenum, GLint);
glFramebufferTextureEXT > n i i i i                : void glFramebufferTextureEXT (GLenum, GLenum, GLuint, GLint);
glFramebufferTextureLayerEXT > n i i i i i         : void glFramebufferTextureLayerEXT (GLenum, GLenum, GLuint, GLint, GLint);
glFramebufferTextureFaceEXT > n i i i i i          : void glFramebufferTextureFaceEXT (GLenum, GLenum, GLuint, GLint, GLenum);
glProgramParameteriEXT > n i i i                   : void glProgramParameteriEXT (GLuint, GLenum, GLint);
glVertexAttribI1iEXT > n i i                       : void glVertexAttribI1iEXT (GLuint, GLint);
glVertexAttribI2iEXT > n i i i                     : void glVertexAttribI2iEXT (GLuint, GLint, GLint);
glVertexAttribI3iEXT > n i i i i                   : void glVertexAttribI3iEXT (GLuint, GLint, GLint, GLint);
glVertexAttribI4iEXT > n i i i i i                 : void glVertexAttribI4iEXT (GLuint, GLint, GLint, GLint, GLint);
glVertexAttribI1uiEXT > n i i                      : void glVertexAttribI1uiEXT (GLuint, GLuint);
glVertexAttribI2uiEXT > n i i i                    : void glVertexAttribI2uiEXT (GLuint, GLuint, GLuint);
glVertexAttribI3uiEXT > n i i i i                  : void glVertexAttribI3uiEXT (GLuint, GLuint, GLuint, GLuint);
glVertexAttribI4uiEXT > n i i i i i                : void glVertexAttribI4uiEXT (GLuint, GLuint, GLuint, GLuint, GLuint);
glVertexAttribI1ivEXT > n i *i                     : void glVertexAttribI1ivEXT (GLuint, GLint *);
glVertexAttribI2ivEXT > n i *i                     : void glVertexAttribI2ivEXT (GLuint, GLint *);
glVertexAttribI3ivEXT > n i *i                     : void glVertexAttribI3ivEXT (GLuint, GLint *);
glVertexAttribI4ivEXT > n i *i                     : void glVertexAttribI4ivEXT (GLuint, GLint *);
glVertexAttribI1uivEXT > n i *i                    : void glVertexAttribI1uivEXT (GLuint, GLuint *);
glVertexAttribI2uivEXT > n i *i                    : void glVertexAttribI2uivEXT (GLuint, GLuint *);
glVertexAttribI3uivEXT > n i *i                    : void glVertexAttribI3uivEXT (GLuint, GLuint *);
glVertexAttribI4uivEXT > n i *i                    : void glVertexAttribI4uivEXT (GLuint, GLuint *);
glVertexAttribI4bvEXT > n i *c                     : void glVertexAttribI4bvEXT (GLuint, GLbyte *);
glVertexAttribI4svEXT > n i *s                     : void glVertexAttribI4svEXT (GLuint, GLshort *);
glVertexAttribI4ubvEXT > n i *c                    : void glVertexAttribI4ubvEXT (GLuint, GLubyte *);
glVertexAttribI4usvEXT > n i *s                    : void glVertexAttribI4usvEXT (GLuint, GLushort *);
glVertexAttribIPointerEXT > n i i i i *x           : void glVertexAttribIPointerEXT (GLuint, GLint, GLenum, GLsizei, GLvoid *);
glGetVertexAttribIivEXT > n i i *i                 : void glGetVertexAttribIivEXT (GLuint, GLenum, GLint *);
glGetVertexAttribIuivEXT > n i i *i                : void glGetVertexAttribIuivEXT (GLuint, GLenum, GLuint *);
glGetUniformuivEXT > n i i *i                      : void glGetUniformuivEXT (GLuint, GLint, GLuint *);
glBindFragDataLocationEXT > n i i *c               : void glBindFragDataLocationEXT (GLuint, GLuint, GLchar *);
glGetFragDataLocationEXT > i i *c                  : GLint glGetFragDataLocationEXT (GLuint, GLchar *);
glUniform1uiEXT > n i i                            : void glUniform1uiEXT (GLint, GLuint);
glUniform2uiEXT > n i i i                          : void glUniform2uiEXT (GLint, GLuint, GLuint);
glUniform3uiEXT > n i i i i                        : void glUniform3uiEXT (GLint, GLuint, GLuint, GLuint);
glUniform4uiEXT > n i i i i i                      : void glUniform4uiEXT (GLint, GLuint, GLuint, GLuint, GLuint);
glUniform1uivEXT > n i i *i                        : void glUniform1uivEXT (GLint, GLsizei, GLuint *);
glUniform2uivEXT > n i i *i                        : void glUniform2uivEXT (GLint, GLsizei, GLuint *);
glUniform3uivEXT > n i i *i                        : void glUniform3uivEXT (GLint, GLsizei, GLuint *);
glUniform4uivEXT > n i i *i                        : void glUniform4uivEXT (GLint, GLsizei, GLuint *);
glDrawArraysInstancedEXT > n i i i i               : void glDrawArraysInstancedEXT (GLenum, GLint, GLsizei, GLsizei);
glDrawElementsInstancedEXT > n i i i *x i          : void glDrawElementsInstancedEXT (GLenum, GLsizei, GLenum, GLvoid *, GLsizei);
glTexBufferEXT > n i i i                           : void glTexBufferEXT (GLenum, GLenum, GLuint);
glDepthRangedNV > n d d                            : void glDepthRangedNV (GLdouble, GLdouble);
glClearDepthdNV > n d                              : void glClearDepthdNV (GLdouble);
glDepthBoundsdNV > n d d                           : void glDepthBoundsdNV (GLdouble, GLdouble);
glRenderbufferStorageMultisampleCoverageNV > n i i i i i i : void glRenderbufferStorageMultisampleCoverageNV (GLenum, GLsizei, GLsizei, GLenum, GLsizei, GLsizei);
glProgramBufferParametersfvNV > n i i i i *f       : void glProgramBufferParametersfvNV (GLenum, GLuint, GLuint, GLsizei, GLfloat *);
glProgramBufferParametersIivNV > n i i i i *i      : void glProgramBufferParametersIivNV (GLenum, GLuint, GLuint, GLsizei, GLint *);
glProgramBufferParametersIuivNV > n i i i i *i     : void glProgramBufferParametersIuivNV (GLenum, GLuint, GLuint, GLsizei, GLuint *);
glColorMaskIndexedEXT > n i s s s s                : void glColorMaskIndexedEXT (GLuint, GLboolean, GLboolean, GLboolean, GLboolean);
glGetBooleanIndexedvEXT > n i i *s                 : void glGetBooleanIndexedvEXT (GLenum, GLuint, GLboolean *);
glGetIntegerIndexedvEXT > n i i *i                 : void glGetIntegerIndexedvEXT (GLenum, GLuint, GLint *);
glEnableIndexedEXT > n i i                         : void glEnableIndexedEXT (GLenum, GLuint);
glDisableIndexedEXT > n i i                        : void glDisableIndexedEXT (GLenum, GLuint);
glIsEnabledIndexedEXT > s i i                      : GLboolean glIsEnabledIndexedEXT (GLenum, GLuint);
glBeginTransformFeedbackNV > n i                   : void glBeginTransformFeedbackNV (GLenum);
glEndTransformFeedbackNV > n                       : void glEndTransformFeedbackNV (void);
glTransformFeedbackAttribsNV > n i *i i            : void glTransformFeedbackAttribsNV (GLuint, GLint *, GLenum);
glBindBufferRangeNV > n i i i i i                  : void glBindBufferRangeNV (GLenum, GLuint, GLuint, GLintptr, GLsizeiptr);
glBindBufferOffsetNV > n i i i i                   : void glBindBufferOffsetNV (GLenum, GLuint, GLuint, GLintptr);
glBindBufferBaseNV > n i i i                       : void glBindBufferBaseNV (GLenum, GLuint, GLuint);
glTransformFeedbackVaryingsNV > n i i *i i         : void glTransformFeedbackVaryingsNV (GLuint, GLsizei, GLint *, GLenum);
glActiveVaryingNV > n i *c                         : void glActiveVaryingNV (GLuint, GLchar *);
glGetVaryingLocationNV > i i *c                    : GLint glGetVaryingLocationNV (GLuint, GLchar *);
glGetActiveVaryingNV > n i i i *i *i *i *c         : void glGetActiveVaryingNV (GLuint, GLuint, GLsizei, GLsizei *, GLsizei *, GLenum *, GLchar *);
glGetTransformFeedbackVaryingNV > n i i *i         : void glGetTransformFeedbackVaryingNV (GLuint, GLuint, GLint *);
glTransformFeedbackStreamAttribsNV > n i *i i *i i : void glTransformFeedbackStreamAttribsNV (GLsizei, GLint *, GLsizei, GLint *, GLenum);
glUniformBufferEXT > n i i i                       : void glUniformBufferEXT (GLuint, GLint, GLuint);
glGetUniformBufferSizeEXT > i i i                  : GLint glGetUniformBufferSizeEXT (GLuint, GLint);
glGetUniformOffsetEXT > i i i                      : GLintptr glGetUniformOffsetEXT (GLuint, GLint);
glTexParameterIivEXT > n i i *i                    : void glTexParameterIivEXT (GLenum, GLenum, GLint *);
glTexParameterIuivEXT > n i i *i                   : void glTexParameterIuivEXT (GLenum, GLenum, GLuint *);
glGetTexParameterIivEXT > n i i *i                 : void glGetTexParameterIivEXT (GLenum, GLenum, GLint *);
glGetTexParameterIuivEXT > n i i *i                : void glGetTexParameterIuivEXT (GLenum, GLenum, GLuint *);
glClearColorIiEXT > n i i i i                      : void glClearColorIiEXT (GLint, GLint, GLint, GLint);
glClearColorIuiEXT > n i i i i                     : void glClearColorIuiEXT (GLuint, GLuint, GLuint, GLuint);
glFrameTerminatorGREMEDY > n                       : void glFrameTerminatorGREMEDY (void);
glBeginConditionalRenderNV > n i i                 : void glBeginConditionalRenderNV (GLuint, GLenum);
glEndConditionalRenderNV > n                       : void glEndConditionalRenderNV (void);
glPresentFrameKeyedNV > n i l i i i i i i i i i    : void glPresentFrameKeyedNV (GLuint, GLuint64EXT, GLuint, GLuint, GLenum, GLenum, GLuint, GLuint, GLenum, GLuint, GLuint);
glPresentFrameDualFillNV > n i l i i i i i i i i i i i : void glPresentFrameDualFillNV (GLuint, GLuint64EXT, GLuint, GLuint, GLenum, GLenum, GLuint, GLenum, GLuint, GLenum, GLuint, GLenum, GLuint);
glGetVideoivNV > n i i *i                          : void glGetVideoivNV (GLuint, GLenum, GLint *);
glGetVideouivNV > n i i *i                         : void glGetVideouivNV (GLuint, GLenum, GLuint *);
glGetVideoi64vNV > n i i *l                        : void glGetVideoi64vNV (GLuint, GLenum, GLint64EXT *);
glGetVideoui64vNV > n i i *l                       : void glGetVideoui64vNV (GLuint, GLenum, GLuint64EXT *);
glBeginTransformFeedbackEXT > n i                  : void glBeginTransformFeedbackEXT (GLenum);
glEndTransformFeedbackEXT > n                      : void glEndTransformFeedbackEXT (void);
glBindBufferRangeEXT > n i i i i i                 : void glBindBufferRangeEXT (GLenum, GLuint, GLuint, GLintptr, GLsizeiptr);
glBindBufferOffsetEXT > n i i i i                  : void glBindBufferOffsetEXT (GLenum, GLuint, GLuint, GLintptr);
glBindBufferBaseEXT > n i i i                      : void glBindBufferBaseEXT (GLenum, GLuint, GLuint);
glTransformFeedbackVaryingsEXT > n i i *x i        : void glTransformFeedbackVaryingsEXT (GLuint, GLsizei, GLchar **, GLenum);
glGetTransformFeedbackVaryingEXT > n i i i *i *i *i *c : void glGetTransformFeedbackVaryingEXT (GLuint, GLuint, GLsizei, GLsizei *, GLsizei *, GLenum *, GLchar *);
glClientAttribDefaultEXT > n i                     : void glClientAttribDefaultEXT (GLbitfield);
glPushClientAttribDefaultEXT > n i                 : void glPushClientAttribDefaultEXT (GLbitfield);
glMatrixLoadfEXT > n i *f                          : void glMatrixLoadfEXT (GLenum, GLfloat *);
glMatrixLoaddEXT > n i *d                          : void glMatrixLoaddEXT (GLenum, GLdouble *);
glMatrixMultfEXT > n i *f                          : void glMatrixMultfEXT (GLenum, GLfloat *);
glMatrixMultdEXT > n i *d                          : void glMatrixMultdEXT (GLenum, GLdouble *);
glMatrixLoadIdentityEXT > n i                      : void glMatrixLoadIdentityEXT (GLenum);
glMatrixRotatefEXT > n i f f f f                   : void glMatrixRotatefEXT (GLenum, GLfloat, GLfloat, GLfloat, GLfloat);
glMatrixRotatedEXT > n i d d d d                   : void glMatrixRotatedEXT (GLenum, GLdouble, GLdouble, GLdouble, GLdouble);
glMatrixScalefEXT > n i f f f                      : void glMatrixScalefEXT (GLenum, GLfloat, GLfloat, GLfloat);
glMatrixScaledEXT > n i d d d                      : void glMatrixScaledEXT (GLenum, GLdouble, GLdouble, GLdouble);
glMatrixTranslatefEXT > n i f f f                  : void glMatrixTranslatefEXT (GLenum, GLfloat, GLfloat, GLfloat);
glMatrixTranslatedEXT > n i d d d                  : void glMatrixTranslatedEXT (GLenum, GLdouble, GLdouble, GLdouble);
glMatrixFrustumEXT > n i d d d d d d               : void glMatrixFrustumEXT (GLenum, GLdouble, GLdouble, GLdouble, GLdouble, GLdouble, GLdouble);
glMatrixOrthoEXT > n i d d d d d d                 : void glMatrixOrthoEXT (GLenum, GLdouble, GLdouble, GLdouble, GLdouble, GLdouble, GLdouble);
glMatrixPopEXT > n i                               : void glMatrixPopEXT (GLenum);
glMatrixPushEXT > n i                              : void glMatrixPushEXT (GLenum);
glMatrixLoadTransposefEXT > n i *f                 : void glMatrixLoadTransposefEXT (GLenum, GLfloat *);
glMatrixLoadTransposedEXT > n i *d                 : void glMatrixLoadTransposedEXT (GLenum, GLdouble *);
glMatrixMultTransposefEXT > n i *f                 : void glMatrixMultTransposefEXT (GLenum, GLfloat *);
glMatrixMultTransposedEXT > n i *d                 : void glMatrixMultTransposedEXT (GLenum, GLdouble *);
glTextureParameterfEXT > n i i i f                 : void glTextureParameterfEXT (GLuint, GLenum, GLenum, GLfloat);
glTextureParameterfvEXT > n i i i *f               : void glTextureParameterfvEXT (GLuint, GLenum, GLenum, GLfloat *);
glTextureParameteriEXT > n i i i i                 : void glTextureParameteriEXT (GLuint, GLenum, GLenum, GLint);
glTextureParameterivEXT > n i i i *i               : void glTextureParameterivEXT (GLuint, GLenum, GLenum, GLint *);
glTextureImage1DEXT > n i i i i i i i i *x         : void glTextureImage1DEXT (GLuint, GLenum, GLint, GLenum, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glTextureImage2DEXT > n i i i i i i i i i *x       : void glTextureImage2DEXT (GLuint, GLenum, GLint, GLenum, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glTextureSubImage1DEXT > n i i i i i i i *x        : void glTextureSubImage1DEXT (GLuint, GLenum, GLint, GLint, GLsizei, GLenum, GLenum, GLvoid *);
glTextureSubImage2DEXT > n i i i i i i i i i *x    : void glTextureSubImage2DEXT (GLuint, GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glCopyTextureImage1DEXT > n i i i i i i i i        : void glCopyTextureImage1DEXT (GLuint, GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLint);
glCopyTextureImage2DEXT > n i i i i i i i i i      : void glCopyTextureImage2DEXT (GLuint, GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLsizei, GLint);
glCopyTextureSubImage1DEXT > n i i i i i i i       : void glCopyTextureSubImage1DEXT (GLuint, GLenum, GLint, GLint, GLint, GLint, GLsizei);
glCopyTextureSubImage2DEXT > n i i i i i i i i i   : void glCopyTextureSubImage2DEXT (GLuint, GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
glGetTextureImageEXT > n i i i i i *x              : void glGetTextureImageEXT (GLuint, GLenum, GLint, GLenum, GLenum, GLvoid *);
glGetTextureParameterfvEXT > n i i i *f            : void glGetTextureParameterfvEXT (GLuint, GLenum, GLenum, GLfloat *);
glGetTextureParameterivEXT > n i i i *i            : void glGetTextureParameterivEXT (GLuint, GLenum, GLenum, GLint *);
glGetTextureLevelParameterfvEXT > n i i i i *f     : void glGetTextureLevelParameterfvEXT (GLuint, GLenum, GLint, GLenum, GLfloat *);
glGetTextureLevelParameterivEXT > n i i i i *i     : void glGetTextureLevelParameterivEXT (GLuint, GLenum, GLint, GLenum, GLint *);
glTextureImage3DEXT > n i i i i i i i i i i *x     : void glTextureImage3DEXT (GLuint, GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glTextureSubImage3DEXT > n i i i i i i i i i i i *x : void glTextureSubImage3DEXT (GLuint, GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glCopyTextureSubImage3DEXT > n i i i i i i i i i i : void glCopyTextureSubImage3DEXT (GLuint, GLenum, GLint, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
glMultiTexParameterfEXT > n i i i f                : void glMultiTexParameterfEXT (GLenum, GLenum, GLenum, GLfloat);
glMultiTexParameterfvEXT > n i i i *f              : void glMultiTexParameterfvEXT (GLenum, GLenum, GLenum, GLfloat *);
glMultiTexParameteriEXT > n i i i i                : void glMultiTexParameteriEXT (GLenum, GLenum, GLenum, GLint);
glMultiTexParameterivEXT > n i i i *i              : void glMultiTexParameterivEXT (GLenum, GLenum, GLenum, GLint *);
glMultiTexImage1DEXT > n i i i i i i i i *x        : void glMultiTexImage1DEXT (GLenum, GLenum, GLint, GLenum, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glMultiTexImage2DEXT > n i i i i i i i i i *x      : void glMultiTexImage2DEXT (GLenum, GLenum, GLint, GLenum, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glMultiTexSubImage1DEXT > n i i i i i i i *x       : void glMultiTexSubImage1DEXT (GLenum, GLenum, GLint, GLint, GLsizei, GLenum, GLenum, GLvoid *);
glMultiTexSubImage2DEXT > n i i i i i i i i i *x   : void glMultiTexSubImage2DEXT (GLenum, GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glCopyMultiTexImage1DEXT > n i i i i i i i i       : void glCopyMultiTexImage1DEXT (GLenum, GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLint);
glCopyMultiTexImage2DEXT > n i i i i i i i i i     : void glCopyMultiTexImage2DEXT (GLenum, GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLsizei, GLint);
glCopyMultiTexSubImage1DEXT > n i i i i i i i      : void glCopyMultiTexSubImage1DEXT (GLenum, GLenum, GLint, GLint, GLint, GLint, GLsizei);
glCopyMultiTexSubImage2DEXT > n i i i i i i i i i  : void glCopyMultiTexSubImage2DEXT (GLenum, GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
glGetMultiTexImageEXT > n i i i i i *x             : void glGetMultiTexImageEXT (GLenum, GLenum, GLint, GLenum, GLenum, GLvoid *);
glGetMultiTexParameterfvEXT > n i i i *f           : void glGetMultiTexParameterfvEXT (GLenum, GLenum, GLenum, GLfloat *);
glGetMultiTexParameterivEXT > n i i i *i           : void glGetMultiTexParameterivEXT (GLenum, GLenum, GLenum, GLint *);
glGetMultiTexLevelParameterfvEXT > n i i i i *f    : void glGetMultiTexLevelParameterfvEXT (GLenum, GLenum, GLint, GLenum, GLfloat *);
glGetMultiTexLevelParameterivEXT > n i i i i *i    : void glGetMultiTexLevelParameterivEXT (GLenum, GLenum, GLint, GLenum, GLint *);
glMultiTexImage3DEXT > n i i i i i i i i i i *x    : void glMultiTexImage3DEXT (GLenum, GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glMultiTexSubImage3DEXT > n i i i i i i i i i i i *x : void glMultiTexSubImage3DEXT (GLenum, GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glCopyMultiTexSubImage3DEXT > n i i i i i i i i i i : void glCopyMultiTexSubImage3DEXT (GLenum, GLenum, GLint, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
glBindMultiTextureEXT > n i i i                    : void glBindMultiTextureEXT (GLenum, GLenum, GLuint);
glEnableClientStateIndexedEXT > n i i              : void glEnableClientStateIndexedEXT (GLenum, GLuint);
glDisableClientStateIndexedEXT > n i i             : void glDisableClientStateIndexedEXT (GLenum, GLuint);
glMultiTexCoordPointerEXT > n i i i i *x           : void glMultiTexCoordPointerEXT (GLenum, GLint, GLenum, GLsizei, GLvoid *);
glMultiTexEnvfEXT > n i i i f                      : void glMultiTexEnvfEXT (GLenum, GLenum, GLenum, GLfloat);
glMultiTexEnvfvEXT > n i i i *f                    : void glMultiTexEnvfvEXT (GLenum, GLenum, GLenum, GLfloat *);
glMultiTexEnviEXT > n i i i i                      : void glMultiTexEnviEXT (GLenum, GLenum, GLenum, GLint);
glMultiTexEnvivEXT > n i i i *i                    : void glMultiTexEnvivEXT (GLenum, GLenum, GLenum, GLint *);
glMultiTexGendEXT > n i i i d                      : void glMultiTexGendEXT (GLenum, GLenum, GLenum, GLdouble);
glMultiTexGendvEXT > n i i i *d                    : void glMultiTexGendvEXT (GLenum, GLenum, GLenum, GLdouble *);
glMultiTexGenfEXT > n i i i f                      : void glMultiTexGenfEXT (GLenum, GLenum, GLenum, GLfloat);
glMultiTexGenfvEXT > n i i i *f                    : void glMultiTexGenfvEXT (GLenum, GLenum, GLenum, GLfloat *);
glMultiTexGeniEXT > n i i i i                      : void glMultiTexGeniEXT (GLenum, GLenum, GLenum, GLint);
glMultiTexGenivEXT > n i i i *i                    : void glMultiTexGenivEXT (GLenum, GLenum, GLenum, GLint *);
glGetMultiTexEnvfvEXT > n i i i *f                 : void glGetMultiTexEnvfvEXT (GLenum, GLenum, GLenum, GLfloat *);
glGetMultiTexEnvivEXT > n i i i *i                 : void glGetMultiTexEnvivEXT (GLenum, GLenum, GLenum, GLint *);
glGetMultiTexGendvEXT > n i i i *d                 : void glGetMultiTexGendvEXT (GLenum, GLenum, GLenum, GLdouble *);
glGetMultiTexGenfvEXT > n i i i *f                 : void glGetMultiTexGenfvEXT (GLenum, GLenum, GLenum, GLfloat *);
glGetMultiTexGenivEXT > n i i i *i                 : void glGetMultiTexGenivEXT (GLenum, GLenum, GLenum, GLint *);
glGetFloatIndexedvEXT > n i i *f                   : void glGetFloatIndexedvEXT (GLenum, GLuint, GLfloat *);
glGetDoubleIndexedvEXT > n i i *d                  : void glGetDoubleIndexedvEXT (GLenum, GLuint, GLdouble *);
glGetPointerIndexedvEXT > n i i *x                 : void glGetPointerIndexedvEXT (GLenum, GLuint, GLvoid **);
glCompressedTextureImage3DEXT > n i i i i i i i i i *x : void glCompressedTextureImage3DEXT (GLuint, GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedTextureImage2DEXT > n i i i i i i i i *x : void glCompressedTextureImage2DEXT (GLuint, GLenum, GLint, GLenum, GLsizei, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedTextureImage1DEXT > n i i i i i i i *x : void glCompressedTextureImage1DEXT (GLuint, GLenum, GLint, GLenum, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedTextureSubImage3DEXT > n i i i i i i i i i i i *x : void glCompressedTextureSubImage3DEXT (GLuint, GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, GLvoid *);
glCompressedTextureSubImage2DEXT > n i i i i i i i i i *x : void glCompressedTextureSubImage2DEXT (GLuint, GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLsizei, GLvoid *);
glCompressedTextureSubImage1DEXT > n i i i i i i i *x : void glCompressedTextureSubImage1DEXT (GLuint, GLenum, GLint, GLint, GLsizei, GLenum, GLsizei, GLvoid *);
glGetCompressedTextureImageEXT > n i i i *x        : void glGetCompressedTextureImageEXT (GLuint, GLenum, GLint, GLvoid *);
glCompressedMultiTexImage3DEXT > n i i i i i i i i i *x : void glCompressedMultiTexImage3DEXT (GLenum, GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedMultiTexImage2DEXT > n i i i i i i i i *x : void glCompressedMultiTexImage2DEXT (GLenum, GLenum, GLint, GLenum, GLsizei, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedMultiTexImage1DEXT > n i i i i i i i *x : void glCompressedMultiTexImage1DEXT (GLenum, GLenum, GLint, GLenum, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedMultiTexSubImage3DEXT > n i i i i i i i i i i i *x : void glCompressedMultiTexSubImage3DEXT (GLenum, GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, GLvoid *);
glCompressedMultiTexSubImage2DEXT > n i i i i i i i i i *x : void glCompressedMultiTexSubImage2DEXT (GLenum, GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLsizei, GLvoid *);
glCompressedMultiTexSubImage1DEXT > n i i i i i i i *x : void glCompressedMultiTexSubImage1DEXT (GLenum, GLenum, GLint, GLint, GLsizei, GLenum, GLsizei, GLvoid *);
glGetCompressedMultiTexImageEXT > n i i i *x       : void glGetCompressedMultiTexImageEXT (GLenum, GLenum, GLint, GLvoid *);
glNamedProgramStringEXT > n i i i i *x             : void glNamedProgramStringEXT (GLuint, GLenum, GLenum, GLsizei, GLvoid *);
glNamedProgramLocalParameter4dEXT > n i i i d d d d : void glNamedProgramLocalParameter4dEXT (GLuint, GLenum, GLuint, GLdouble, GLdouble, GLdouble, GLdouble);
glNamedProgramLocalParameter4dvEXT > n i i i *d    : void glNamedProgramLocalParameter4dvEXT (GLuint, GLenum, GLuint, GLdouble *);
glNamedProgramLocalParameter4fEXT > n i i i f f f f : void glNamedProgramLocalParameter4fEXT (GLuint, GLenum, GLuint, GLfloat, GLfloat, GLfloat, GLfloat);
glNamedProgramLocalParameter4fvEXT > n i i i *f    : void glNamedProgramLocalParameter4fvEXT (GLuint, GLenum, GLuint, GLfloat *);
glGetNamedProgramLocalParameterdvEXT > n i i i *d  : void glGetNamedProgramLocalParameterdvEXT (GLuint, GLenum, GLuint, GLdouble *);
glGetNamedProgramLocalParameterfvEXT > n i i i *f  : void glGetNamedProgramLocalParameterfvEXT (GLuint, GLenum, GLuint, GLfloat *);
glGetNamedProgramivEXT > n i i i *i                : void glGetNamedProgramivEXT (GLuint, GLenum, GLenum, GLint *);
glGetNamedProgramStringEXT > n i i i *x            : void glGetNamedProgramStringEXT (GLuint, GLenum, GLenum, GLvoid *);
glNamedProgramLocalParameters4fvEXT > n i i i i *f : void glNamedProgramLocalParameters4fvEXT (GLuint, GLenum, GLuint, GLsizei, GLfloat *);
glNamedProgramLocalParameterI4iEXT > n i i i i i i i : void glNamedProgramLocalParameterI4iEXT (GLuint, GLenum, GLuint, GLint, GLint, GLint, GLint);
glNamedProgramLocalParameterI4ivEXT > n i i i *i   : void glNamedProgramLocalParameterI4ivEXT (GLuint, GLenum, GLuint, GLint *);
glNamedProgramLocalParametersI4ivEXT > n i i i i *i : void glNamedProgramLocalParametersI4ivEXT (GLuint, GLenum, GLuint, GLsizei, GLint *);
glNamedProgramLocalParameterI4uiEXT > n i i i i i i i : void glNamedProgramLocalParameterI4uiEXT (GLuint, GLenum, GLuint, GLuint, GLuint, GLuint, GLuint);
glNamedProgramLocalParameterI4uivEXT > n i i i *i  : void glNamedProgramLocalParameterI4uivEXT (GLuint, GLenum, GLuint, GLuint *);
glNamedProgramLocalParametersI4uivEXT > n i i i i *i : void glNamedProgramLocalParametersI4uivEXT (GLuint, GLenum, GLuint, GLsizei, GLuint *);
glGetNamedProgramLocalParameterIivEXT > n i i i *i : void glGetNamedProgramLocalParameterIivEXT (GLuint, GLenum, GLuint, GLint *);
glGetNamedProgramLocalParameterIuivEXT > n i i i *i : void glGetNamedProgramLocalParameterIuivEXT (GLuint, GLenum, GLuint, GLuint *);
glTextureParameterIivEXT > n i i i *i              : void glTextureParameterIivEXT (GLuint, GLenum, GLenum, GLint *);
glTextureParameterIuivEXT > n i i i *i             : void glTextureParameterIuivEXT (GLuint, GLenum, GLenum, GLuint *);
glGetTextureParameterIivEXT > n i i i *i           : void glGetTextureParameterIivEXT (GLuint, GLenum, GLenum, GLint *);
glGetTextureParameterIuivEXT > n i i i *i          : void glGetTextureParameterIuivEXT (GLuint, GLenum, GLenum, GLuint *);
glMultiTexParameterIivEXT > n i i i *i             : void glMultiTexParameterIivEXT (GLenum, GLenum, GLenum, GLint *);
glMultiTexParameterIuivEXT > n i i i *i            : void glMultiTexParameterIuivEXT (GLenum, GLenum, GLenum, GLuint *);
glGetMultiTexParameterIivEXT > n i i i *i          : void glGetMultiTexParameterIivEXT (GLenum, GLenum, GLenum, GLint *);
glGetMultiTexParameterIuivEXT > n i i i *i         : void glGetMultiTexParameterIuivEXT (GLenum, GLenum, GLenum, GLuint *);
glProgramUniform1fEXT > n i i f                    : void glProgramUniform1fEXT (GLuint, GLint, GLfloat);
glProgramUniform2fEXT > n i i f f                  : void glProgramUniform2fEXT (GLuint, GLint, GLfloat, GLfloat);
glProgramUniform3fEXT > n i i f f f                : void glProgramUniform3fEXT (GLuint, GLint, GLfloat, GLfloat, GLfloat);
glProgramUniform4fEXT > n i i f f f f              : void glProgramUniform4fEXT (GLuint, GLint, GLfloat, GLfloat, GLfloat, GLfloat);
glProgramUniform1iEXT > n i i i                    : void glProgramUniform1iEXT (GLuint, GLint, GLint);
glProgramUniform2iEXT > n i i i i                  : void glProgramUniform2iEXT (GLuint, GLint, GLint, GLint);
glProgramUniform3iEXT > n i i i i i                : void glProgramUniform3iEXT (GLuint, GLint, GLint, GLint, GLint);
glProgramUniform4iEXT > n i i i i i i              : void glProgramUniform4iEXT (GLuint, GLint, GLint, GLint, GLint, GLint);
glProgramUniform1fvEXT > n i i i *f                : void glProgramUniform1fvEXT (GLuint, GLint, GLsizei, GLfloat *);
glProgramUniform2fvEXT > n i i i *f                : void glProgramUniform2fvEXT (GLuint, GLint, GLsizei, GLfloat *);
glProgramUniform3fvEXT > n i i i *f                : void glProgramUniform3fvEXT (GLuint, GLint, GLsizei, GLfloat *);
glProgramUniform4fvEXT > n i i i *f                : void glProgramUniform4fvEXT (GLuint, GLint, GLsizei, GLfloat *);
glProgramUniform1ivEXT > n i i i *i                : void glProgramUniform1ivEXT (GLuint, GLint, GLsizei, GLint *);
glProgramUniform2ivEXT > n i i i *i                : void glProgramUniform2ivEXT (GLuint, GLint, GLsizei, GLint *);
glProgramUniform3ivEXT > n i i i *i                : void glProgramUniform3ivEXT (GLuint, GLint, GLsizei, GLint *);
glProgramUniform4ivEXT > n i i i *i                : void glProgramUniform4ivEXT (GLuint, GLint, GLsizei, GLint *);
glProgramUniformMatrix2fvEXT > n i i i s *f        : void glProgramUniformMatrix2fvEXT (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix3fvEXT > n i i i s *f        : void glProgramUniformMatrix3fvEXT (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix4fvEXT > n i i i s *f        : void glProgramUniformMatrix4fvEXT (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix2x3fvEXT > n i i i s *f      : void glProgramUniformMatrix2x3fvEXT (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix3x2fvEXT > n i i i s *f      : void glProgramUniformMatrix3x2fvEXT (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix2x4fvEXT > n i i i s *f      : void glProgramUniformMatrix2x4fvEXT (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix4x2fvEXT > n i i i s *f      : void glProgramUniformMatrix4x2fvEXT (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix3x4fvEXT > n i i i s *f      : void glProgramUniformMatrix3x4fvEXT (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniformMatrix4x3fvEXT > n i i i s *f      : void glProgramUniformMatrix4x3fvEXT (GLuint, GLint, GLsizei, GLboolean, GLfloat *);
glProgramUniform1uiEXT > n i i i                   : void glProgramUniform1uiEXT (GLuint, GLint, GLuint);
glProgramUniform2uiEXT > n i i i i                 : void glProgramUniform2uiEXT (GLuint, GLint, GLuint, GLuint);
glProgramUniform3uiEXT > n i i i i i               : void glProgramUniform3uiEXT (GLuint, GLint, GLuint, GLuint, GLuint);
glProgramUniform4uiEXT > n i i i i i i             : void glProgramUniform4uiEXT (GLuint, GLint, GLuint, GLuint, GLuint, GLuint);
glProgramUniform1uivEXT > n i i i *i               : void glProgramUniform1uivEXT (GLuint, GLint, GLsizei, GLuint *);
glProgramUniform2uivEXT > n i i i *i               : void glProgramUniform2uivEXT (GLuint, GLint, GLsizei, GLuint *);
glProgramUniform3uivEXT > n i i i *i               : void glProgramUniform3uivEXT (GLuint, GLint, GLsizei, GLuint *);
glProgramUniform4uivEXT > n i i i *i               : void glProgramUniform4uivEXT (GLuint, GLint, GLsizei, GLuint *);
glNamedBufferDataEXT > n i i *x i                  : void glNamedBufferDataEXT (GLuint, GLsizeiptr, GLvoid *, GLenum);
glNamedBufferSubDataEXT > n i i i *x               : void glNamedBufferSubDataEXT (GLuint, GLintptr, GLsizeiptr, GLvoid *);
glMapNamedBufferEXT > x i i                        : GLvoid *glMapNamedBufferEXT (GLuint, GLenum);
glUnmapNamedBufferEXT > s i                        : GLboolean glUnmapNamedBufferEXT (GLuint);
glMapNamedBufferRangeEXT > x i i i i               : GLvoid *glMapNamedBufferRangeEXT (GLuint, GLintptr, GLsizeiptr, GLbitfield);
glFlushMappedNamedBufferRangeEXT > n i i i         : void glFlushMappedNamedBufferRangeEXT (GLuint, GLintptr, GLsizeiptr);
glNamedCopyBufferSubDataEXT > n i i i i i          : void glNamedCopyBufferSubDataEXT (GLuint, GLuint, GLintptr, GLintptr, GLsizeiptr);
glGetNamedBufferParameterivEXT > n i i *i          : void glGetNamedBufferParameterivEXT (GLuint, GLenum, GLint *);
glGetNamedBufferPointervEXT > n i i *x             : void glGetNamedBufferPointervEXT (GLuint, GLenum, GLvoid **);
glGetNamedBufferSubDataEXT > n i i i *x            : void glGetNamedBufferSubDataEXT (GLuint, GLintptr, GLsizeiptr, GLvoid *);
glTextureBufferEXT > n i i i i                     : void glTextureBufferEXT (GLuint, GLenum, GLenum, GLuint);
glMultiTexBufferEXT > n i i i i                    : void glMultiTexBufferEXT (GLenum, GLenum, GLenum, GLuint);
glNamedRenderbufferStorageEXT > n i i i i          : void glNamedRenderbufferStorageEXT (GLuint, GLenum, GLsizei, GLsizei);
glGetNamedRenderbufferParameterivEXT > n i i *i    : void glGetNamedRenderbufferParameterivEXT (GLuint, GLenum, GLint *);
glCheckNamedFramebufferStatusEXT > i i i           : GLenum glCheckNamedFramebufferStatusEXT (GLuint, GLenum);
glNamedFramebufferTexture1DEXT > n i i i i i       : void glNamedFramebufferTexture1DEXT (GLuint, GLenum, GLenum, GLuint, GLint);
glNamedFramebufferTexture2DEXT > n i i i i i       : void glNamedFramebufferTexture2DEXT (GLuint, GLenum, GLenum, GLuint, GLint);
glNamedFramebufferTexture3DEXT > n i i i i i i     : void glNamedFramebufferTexture3DEXT (GLuint, GLenum, GLenum, GLuint, GLint, GLint);
glNamedFramebufferRenderbufferEXT > n i i i i      : void glNamedFramebufferRenderbufferEXT (GLuint, GLenum, GLenum, GLuint);
glGetNamedFramebufferAttachmentParameterivEXT > n i i i *i : void glGetNamedFramebufferAttachmentParameterivEXT (GLuint, GLenum, GLenum, GLint *);
glGenerateTextureMipmapEXT > n i i                 : void glGenerateTextureMipmapEXT (GLuint, GLenum);
glGenerateMultiTexMipmapEXT > n i i                : void glGenerateMultiTexMipmapEXT (GLenum, GLenum);
glFramebufferDrawBufferEXT > n i i                 : void glFramebufferDrawBufferEXT (GLuint, GLenum);
glFramebufferDrawBuffersEXT > n i i *i             : void glFramebufferDrawBuffersEXT (GLuint, GLsizei, GLenum *);
glFramebufferReadBufferEXT > n i i                 : void glFramebufferReadBufferEXT (GLuint, GLenum);
glGetFramebufferParameterivEXT > n i i *i          : void glGetFramebufferParameterivEXT (GLuint, GLenum, GLint *);
glNamedRenderbufferStorageMultisampleEXT > n i i i i i : void glNamedRenderbufferStorageMultisampleEXT (GLuint, GLsizei, GLenum, GLsizei, GLsizei);
glNamedRenderbufferStorageMultisampleCoverageEXT > n i i i i i i : void glNamedRenderbufferStorageMultisampleCoverageEXT (GLuint, GLsizei, GLsizei, GLenum, GLsizei, GLsizei);
glNamedFramebufferTextureEXT > n i i i i           : void glNamedFramebufferTextureEXT (GLuint, GLenum, GLuint, GLint);
glNamedFramebufferTextureLayerEXT > n i i i i i    : void glNamedFramebufferTextureLayerEXT (GLuint, GLenum, GLuint, GLint, GLint);
glNamedFramebufferTextureFaceEXT > n i i i i i     : void glNamedFramebufferTextureFaceEXT (GLuint, GLenum, GLuint, GLint, GLenum);
glTextureRenderbufferEXT > n i i i                 : void glTextureRenderbufferEXT (GLuint, GLenum, GLuint);
glMultiTexRenderbufferEXT > n i i i                : void glMultiTexRenderbufferEXT (GLenum, GLenum, GLuint);
glProgramUniform1dEXT > n i i d                    : void glProgramUniform1dEXT (GLuint, GLint, GLdouble);
glProgramUniform2dEXT > n i i d d                  : void glProgramUniform2dEXT (GLuint, GLint, GLdouble, GLdouble);
glProgramUniform3dEXT > n i i d d d                : void glProgramUniform3dEXT (GLuint, GLint, GLdouble, GLdouble, GLdouble);
glProgramUniform4dEXT > n i i d d d d              : void glProgramUniform4dEXT (GLuint, GLint, GLdouble, GLdouble, GLdouble, GLdouble);
glProgramUniform1dvEXT > n i i i *d                : void glProgramUniform1dvEXT (GLuint, GLint, GLsizei, GLdouble *);
glProgramUniform2dvEXT > n i i i *d                : void glProgramUniform2dvEXT (GLuint, GLint, GLsizei, GLdouble *);
glProgramUniform3dvEXT > n i i i *d                : void glProgramUniform3dvEXT (GLuint, GLint, GLsizei, GLdouble *);
glProgramUniform4dvEXT > n i i i *d                : void glProgramUniform4dvEXT (GLuint, GLint, GLsizei, GLdouble *);
glProgramUniformMatrix2dvEXT > n i i i s *d        : void glProgramUniformMatrix2dvEXT (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix3dvEXT > n i i i s *d        : void glProgramUniformMatrix3dvEXT (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix4dvEXT > n i i i s *d        : void glProgramUniformMatrix4dvEXT (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix2x3dvEXT > n i i i s *d      : void glProgramUniformMatrix2x3dvEXT (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix2x4dvEXT > n i i i s *d      : void glProgramUniformMatrix2x4dvEXT (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix3x2dvEXT > n i i i s *d      : void glProgramUniformMatrix3x2dvEXT (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix3x4dvEXT > n i i i s *d      : void glProgramUniformMatrix3x4dvEXT (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix4x2dvEXT > n i i i s *d      : void glProgramUniformMatrix4x2dvEXT (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glProgramUniformMatrix4x3dvEXT > n i i i s *d      : void glProgramUniformMatrix4x3dvEXT (GLuint, GLint, GLsizei, GLboolean, GLdouble *);
glGetMultisamplefvNV > n i i *f                    : void glGetMultisamplefvNV (GLenum, GLuint, GLfloat *);
glSampleMaskIndexedNV > n i i                      : void glSampleMaskIndexedNV (GLuint, GLbitfield);
glTexRenderbufferNV > n i i                        : void glTexRenderbufferNV (GLenum, GLuint);
glBindTransformFeedbackNV > n i i                  : void glBindTransformFeedbackNV (GLenum, GLuint);
glDeleteTransformFeedbacksNV > n i *i              : void glDeleteTransformFeedbacksNV (GLsizei, GLuint *);
glGenTransformFeedbacksNV > n i *i                 : void glGenTransformFeedbacksNV (GLsizei, GLuint *);
glIsTransformFeedbackNV > s i                      : GLboolean glIsTransformFeedbackNV (GLuint);
glPauseTransformFeedbackNV > n                     : void glPauseTransformFeedbackNV (void);
glResumeTransformFeedbackNV > n                    : void glResumeTransformFeedbackNV (void);
glDrawTransformFeedbackNV > n i i                  : void glDrawTransformFeedbackNV (GLenum, GLuint);
glGetPerfMonitorGroupsAMD > n *i i *i              : void glGetPerfMonitorGroupsAMD (GLint *, GLsizei, GLuint *);
glGetPerfMonitorCountersAMD > n i *i *i i *i       : void glGetPerfMonitorCountersAMD (GLuint, GLint *, GLint *, GLsizei, GLuint *);
glGetPerfMonitorGroupStringAMD > n i i *i *c       : void glGetPerfMonitorGroupStringAMD (GLuint, GLsizei, GLsizei *, GLchar *);
glGetPerfMonitorCounterStringAMD > n i i i *i *c   : void glGetPerfMonitorCounterStringAMD (GLuint, GLuint, GLsizei, GLsizei *, GLchar *);
glGetPerfMonitorCounterInfoAMD > n i i i *x        : void glGetPerfMonitorCounterInfoAMD (GLuint, GLuint, GLenum, GLvoid *);
glGenPerfMonitorsAMD > n i *i                      : void glGenPerfMonitorsAMD (GLsizei, GLuint *);
glDeletePerfMonitorsAMD > n i *i                   : void glDeletePerfMonitorsAMD (GLsizei, GLuint *);
glSelectPerfMonitorCountersAMD > n i s i i *i      : void glSelectPerfMonitorCountersAMD (GLuint, GLboolean, GLuint, GLint, GLuint *);
glBeginPerfMonitorAMD > n i                        : void glBeginPerfMonitorAMD (GLuint);
glEndPerfMonitorAMD > n i                          : void glEndPerfMonitorAMD (GLuint);
glGetPerfMonitorCounterDataAMD > n i i i *i *i     : void glGetPerfMonitorCounterDataAMD (GLuint, GLenum, GLsizei, GLuint *, GLint *);
glTessellationFactorAMD > n f                      : void glTessellationFactorAMD (GLfloat);
glTessellationModeAMD > n i                        : void glTessellationModeAMD (GLenum);
glProvokingVertexEXT > n i                         : void glProvokingVertexEXT (GLenum);
glBlendFuncIndexedAMD > n i i i                    : void glBlendFuncIndexedAMD (GLuint, GLenum, GLenum);
glBlendFuncSeparateIndexedAMD > n i i i i i        : void glBlendFuncSeparateIndexedAMD (GLuint, GLenum, GLenum, GLenum, GLenum);
glBlendEquationIndexedAMD > n i i                  : void glBlendEquationIndexedAMD (GLuint, GLenum);
glBlendEquationSeparateIndexedAMD > n i i i        : void glBlendEquationSeparateIndexedAMD (GLuint, GLenum, GLenum);
glTextureRangeAPPLE > n i i *x                     : void glTextureRangeAPPLE (GLenum, GLsizei, GLvoid *);
glGetTexParameterPointervAPPLE > n i i *x          : void glGetTexParameterPointervAPPLE (GLenum, GLenum, GLvoid **);
glEnableVertexAttribAPPLE > n i i                  : void glEnableVertexAttribAPPLE (GLuint, GLenum);
glDisableVertexAttribAPPLE > n i i                 : void glDisableVertexAttribAPPLE (GLuint, GLenum);
glIsVertexAttribEnabledAPPLE > s i i               : GLboolean glIsVertexAttribEnabledAPPLE (GLuint, GLenum);
glMapVertexAttrib1dAPPLE > n i i d d i i *d        : void glMapVertexAttrib1dAPPLE (GLuint, GLuint, GLdouble, GLdouble, GLint, GLint, GLdouble *);
glMapVertexAttrib1fAPPLE > n i i f f i i *f        : void glMapVertexAttrib1fAPPLE (GLuint, GLuint, GLfloat, GLfloat, GLint, GLint, GLfloat *);
glMapVertexAttrib2dAPPLE > n i i d d i i d d i i *d : void glMapVertexAttrib2dAPPLE (GLuint, GLuint, GLdouble, GLdouble, GLint, GLint, GLdouble, GLdouble, GLint, GLint, GLdouble *);
glMapVertexAttrib2fAPPLE > n i i f f i i f f i i *f : void glMapVertexAttrib2fAPPLE (GLuint, GLuint, GLfloat, GLfloat, GLint, GLint, GLfloat, GLfloat, GLint, GLint, GLfloat *);
glObjectPurgeableAPPLE > i i i i                   : GLenum glObjectPurgeableAPPLE (GLenum, GLuint, GLenum);
glObjectUnpurgeableAPPLE > i i i i                 : GLenum glObjectUnpurgeableAPPLE (GLenum, GLuint, GLenum);
glGetObjectParameterivAPPLE > n i i i *i           : void glGetObjectParameterivAPPLE (GLenum, GLuint, GLenum, GLint *);
glBeginVideoCaptureNV > n i                        : void glBeginVideoCaptureNV (GLuint);
glBindVideoCaptureStreamBufferNV > n i i i i       : void glBindVideoCaptureStreamBufferNV (GLuint, GLuint, GLenum, GLintptrARB);
glBindVideoCaptureStreamTextureNV > n i i i i i    : void glBindVideoCaptureStreamTextureNV (GLuint, GLuint, GLenum, GLenum, GLuint);
glEndVideoCaptureNV > n i                          : void glEndVideoCaptureNV (GLuint);
glGetVideoCaptureivNV > n i i *i                   : void glGetVideoCaptureivNV (GLuint, GLenum, GLint *);
glGetVideoCaptureStreamivNV > n i i i *i           : void glGetVideoCaptureStreamivNV (GLuint, GLuint, GLenum, GLint *);
glGetVideoCaptureStreamfvNV > n i i i *f           : void glGetVideoCaptureStreamfvNV (GLuint, GLuint, GLenum, GLfloat *);
glGetVideoCaptureStreamdvNV > n i i i *d           : void glGetVideoCaptureStreamdvNV (GLuint, GLuint, GLenum, GLdouble *);
glVideoCaptureNV > i i *i *l                       : GLenum glVideoCaptureNV (GLuint, GLuint *, GLuint64EXT *);
glVideoCaptureStreamParameterivNV > n i i i *i     : void glVideoCaptureStreamParameterivNV (GLuint, GLuint, GLenum, GLint *);
glVideoCaptureStreamParameterfvNV > n i i i *f     : void glVideoCaptureStreamParameterfvNV (GLuint, GLuint, GLenum, GLfloat *);
glVideoCaptureStreamParameterdvNV > n i i i *d     : void glVideoCaptureStreamParameterdvNV (GLuint, GLuint, GLenum, GLdouble *);
glCopyImageSubDataNV > n i i i i i i i i i i i i i i i : void glCopyImageSubDataNV (GLuint, GLenum, GLint, GLint, GLint, GLint, GLuint, GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei);
glUseShaderProgramEXT > n i i                      : void glUseShaderProgramEXT (GLenum, GLuint);
glActiveProgramEXT > n i                           : void glActiveProgramEXT (GLuint);
glCreateShaderProgramEXT > i i *c                  : GLuint glCreateShaderProgramEXT (GLenum, GLchar *);
glMakeBufferResidentNV > n i i                     : void glMakeBufferResidentNV (GLenum, GLenum);
glMakeBufferNonResidentNV > n i                    : void glMakeBufferNonResidentNV (GLenum);
glIsBufferResidentNV > s i                         : GLboolean glIsBufferResidentNV (GLenum);
glMakeNamedBufferResidentNV > n i i                : void glMakeNamedBufferResidentNV (GLuint, GLenum);
glMakeNamedBufferNonResidentNV > n i               : void glMakeNamedBufferNonResidentNV (GLuint);
glIsNamedBufferResidentNV > s i                    : GLboolean glIsNamedBufferResidentNV (GLuint);
glGetBufferParameterui64vNV > n i i *l             : void glGetBufferParameterui64vNV (GLenum, GLenum, GLuint64EXT *);
glGetNamedBufferParameterui64vNV > n i i *l        : void glGetNamedBufferParameterui64vNV (GLuint, GLenum, GLuint64EXT *);
glGetIntegerui64vNV > n i *l                       : void glGetIntegerui64vNV (GLenum, GLuint64EXT *);
glUniformui64NV > n i l                            : void glUniformui64NV (GLint, GLuint64EXT);
glUniformui64vNV > n i i *l                        : void glUniformui64vNV (GLint, GLsizei, GLuint64EXT *);
glGetUniformui64vNV > n i i *l                     : void glGetUniformui64vNV (GLuint, GLint, GLuint64EXT *);
glProgramUniformui64NV > n i i l                   : void glProgramUniformui64NV (GLuint, GLint, GLuint64EXT);
glProgramUniformui64vNV > n i i i *l               : void glProgramUniformui64vNV (GLuint, GLint, GLsizei, GLuint64EXT *);
glBufferAddressRangeNV > n i i l i                 : void glBufferAddressRangeNV (GLenum, GLuint, GLuint64EXT, GLsizeiptr);
glVertexFormatNV > n i i i                         : void glVertexFormatNV (GLint, GLenum, GLsizei);
glNormalFormatNV > n i i                           : void glNormalFormatNV (GLenum, GLsizei);
glColorFormatNV > n i i i                          : void glColorFormatNV (GLint, GLenum, GLsizei);
glIndexFormatNV > n i i                            : void glIndexFormatNV (GLenum, GLsizei);
glTexCoordFormatNV > n i i i                       : void glTexCoordFormatNV (GLint, GLenum, GLsizei);
glEdgeFlagFormatNV > n i                           : void glEdgeFlagFormatNV (GLsizei);
glSecondaryColorFormatNV > n i i i                 : void glSecondaryColorFormatNV (GLint, GLenum, GLsizei);
glFogCoordFormatNV > n i i                         : void glFogCoordFormatNV (GLenum, GLsizei);
glVertexAttribFormatNV > n i i i s i               : void glVertexAttribFormatNV (GLuint, GLint, GLenum, GLboolean, GLsizei);
glVertexAttribIFormatNV > n i i i i                : void glVertexAttribIFormatNV (GLuint, GLint, GLenum, GLsizei);
glGetIntegerui64i_vNV > n i i *l                   : void glGetIntegerui64i_vNV (GLenum, GLuint, GLuint64EXT *);
glTextureBarrierNV > n                             : void glTextureBarrierNV (void);
glBindImageTextureEXT > n i i i s i i i            : void glBindImageTextureEXT (GLuint, GLuint, GLint, GLboolean, GLint, GLenum, GLint);
glMemoryBarrierEXT > n i                           : void glMemoryBarrierEXT (GLbitfield);
glVertexAttribL1dEXT > n i d                       : void glVertexAttribL1dEXT (GLuint, GLdouble);
glVertexAttribL2dEXT > n i d d                     : void glVertexAttribL2dEXT (GLuint, GLdouble, GLdouble);
glVertexAttribL3dEXT > n i d d d                   : void glVertexAttribL3dEXT (GLuint, GLdouble, GLdouble, GLdouble);
glVertexAttribL4dEXT > n i d d d d                 : void glVertexAttribL4dEXT (GLuint, GLdouble, GLdouble, GLdouble, GLdouble);
glVertexAttribL1dvEXT > n i *d                     : void glVertexAttribL1dvEXT (GLuint, GLdouble *);
glVertexAttribL2dvEXT > n i *d                     : void glVertexAttribL2dvEXT (GLuint, GLdouble *);
glVertexAttribL3dvEXT > n i *d                     : void glVertexAttribL3dvEXT (GLuint, GLdouble *);
glVertexAttribL4dvEXT > n i *d                     : void glVertexAttribL4dvEXT (GLuint, GLdouble *);
glVertexAttribLPointerEXT > n i i i i *x           : void glVertexAttribLPointerEXT (GLuint, GLint, GLenum, GLsizei, GLvoid *);
glGetVertexAttribLdvEXT > n i i *d                 : void glGetVertexAttribLdvEXT (GLuint, GLenum, GLdouble *);
glVertexArrayVertexAttribLOffsetEXT > n i i i i i i i : void glVertexArrayVertexAttribLOffsetEXT (GLuint, GLuint, GLuint, GLint, GLenum, GLsizei, GLintptr);
glProgramSubroutineParametersuivNV > n i i *i      : void glProgramSubroutineParametersuivNV (GLenum, GLsizei, GLuint *);
glGetProgramSubroutineParameteruivNV > n i i *i    : void glGetProgramSubroutineParameteruivNV (GLenum, GLuint, GLuint *);
glUniform1i64NV > n i l                            : void glUniform1i64NV (GLint, GLint64EXT);
glUniform2i64NV > n i l l                          : void glUniform2i64NV (GLint, GLint64EXT, GLint64EXT);
glUniform3i64NV > n i l l l                        : void glUniform3i64NV (GLint, GLint64EXT, GLint64EXT, GLint64EXT);
glUniform4i64NV > n i l l l l                      : void glUniform4i64NV (GLint, GLint64EXT, GLint64EXT, GLint64EXT, GLint64EXT);
glUniform1i64vNV > n i i *l                        : void glUniform1i64vNV (GLint, GLsizei, GLint64EXT *);
glUniform2i64vNV > n i i *l                        : void glUniform2i64vNV (GLint, GLsizei, GLint64EXT *);
glUniform3i64vNV > n i i *l                        : void glUniform3i64vNV (GLint, GLsizei, GLint64EXT *);
glUniform4i64vNV > n i i *l                        : void glUniform4i64vNV (GLint, GLsizei, GLint64EXT *);
glUniform1ui64NV > n i l                           : void glUniform1ui64NV (GLint, GLuint64EXT);
glUniform2ui64NV > n i l l                         : void glUniform2ui64NV (GLint, GLuint64EXT, GLuint64EXT);
glUniform3ui64NV > n i l l l                       : void glUniform3ui64NV (GLint, GLuint64EXT, GLuint64EXT, GLuint64EXT);
glUniform4ui64NV > n i l l l l                     : void glUniform4ui64NV (GLint, GLuint64EXT, GLuint64EXT, GLuint64EXT, GLuint64EXT);
glUniform1ui64vNV > n i i *l                       : void glUniform1ui64vNV (GLint, GLsizei, GLuint64EXT *);
glUniform2ui64vNV > n i i *l                       : void glUniform2ui64vNV (GLint, GLsizei, GLuint64EXT *);
glUniform3ui64vNV > n i i *l                       : void glUniform3ui64vNV (GLint, GLsizei, GLuint64EXT *);
glUniform4ui64vNV > n i i *l                       : void glUniform4ui64vNV (GLint, GLsizei, GLuint64EXT *);
glGetUniformi64vNV > n i i *l                      : void glGetUniformi64vNV (GLuint, GLint, GLint64EXT *);
glProgramUniform1i64NV > n i i l                   : void glProgramUniform1i64NV (GLuint, GLint, GLint64EXT);
glProgramUniform2i64NV > n i i l l                 : void glProgramUniform2i64NV (GLuint, GLint, GLint64EXT, GLint64EXT);
glProgramUniform3i64NV > n i i l l l               : void glProgramUniform3i64NV (GLuint, GLint, GLint64EXT, GLint64EXT, GLint64EXT);
glProgramUniform4i64NV > n i i l l l l             : void glProgramUniform4i64NV (GLuint, GLint, GLint64EXT, GLint64EXT, GLint64EXT, GLint64EXT);
glProgramUniform1i64vNV > n i i i *l               : void glProgramUniform1i64vNV (GLuint, GLint, GLsizei, GLint64EXT *);
glProgramUniform2i64vNV > n i i i *l               : void glProgramUniform2i64vNV (GLuint, GLint, GLsizei, GLint64EXT *);
glProgramUniform3i64vNV > n i i i *l               : void glProgramUniform3i64vNV (GLuint, GLint, GLsizei, GLint64EXT *);
glProgramUniform4i64vNV > n i i i *l               : void glProgramUniform4i64vNV (GLuint, GLint, GLsizei, GLint64EXT *);
glProgramUniform1ui64NV > n i i l                  : void glProgramUniform1ui64NV (GLuint, GLint, GLuint64EXT);
glProgramUniform2ui64NV > n i i l l                : void glProgramUniform2ui64NV (GLuint, GLint, GLuint64EXT, GLuint64EXT);
glProgramUniform3ui64NV > n i i l l l              : void glProgramUniform3ui64NV (GLuint, GLint, GLuint64EXT, GLuint64EXT, GLuint64EXT);
glProgramUniform4ui64NV > n i i l l l l            : void glProgramUniform4ui64NV (GLuint, GLint, GLuint64EXT, GLuint64EXT, GLuint64EXT, GLuint64EXT);
glProgramUniform1ui64vNV > n i i i *l              : void glProgramUniform1ui64vNV (GLuint, GLint, GLsizei, GLuint64EXT *);
glProgramUniform2ui64vNV > n i i i *l              : void glProgramUniform2ui64vNV (GLuint, GLint, GLsizei, GLuint64EXT *);
glProgramUniform3ui64vNV > n i i i *l              : void glProgramUniform3ui64vNV (GLuint, GLint, GLsizei, GLuint64EXT *);
glProgramUniform4ui64vNV > n i i i *l              : void glProgramUniform4ui64vNV (GLuint, GLint, GLsizei, GLuint64EXT *);
glVertexAttribL1i64NV > n i l                      : void glVertexAttribL1i64NV (GLuint, GLint64EXT);
glVertexAttribL2i64NV > n i l l                    : void glVertexAttribL2i64NV (GLuint, GLint64EXT, GLint64EXT);
glVertexAttribL3i64NV > n i l l l                  : void glVertexAttribL3i64NV (GLuint, GLint64EXT, GLint64EXT, GLint64EXT);
glVertexAttribL4i64NV > n i l l l l                : void glVertexAttribL4i64NV (GLuint, GLint64EXT, GLint64EXT, GLint64EXT, GLint64EXT);
glVertexAttribL1i64vNV > n i *l                    : void glVertexAttribL1i64vNV (GLuint, GLint64EXT *);
glVertexAttribL2i64vNV > n i *l                    : void glVertexAttribL2i64vNV (GLuint, GLint64EXT *);
glVertexAttribL3i64vNV > n i *l                    : void glVertexAttribL3i64vNV (GLuint, GLint64EXT *);
glVertexAttribL4i64vNV > n i *l                    : void glVertexAttribL4i64vNV (GLuint, GLint64EXT *);
glVertexAttribL1ui64NV > n i l                     : void glVertexAttribL1ui64NV (GLuint, GLuint64EXT);
glVertexAttribL2ui64NV > n i l l                   : void glVertexAttribL2ui64NV (GLuint, GLuint64EXT, GLuint64EXT);
glVertexAttribL3ui64NV > n i l l l                 : void glVertexAttribL3ui64NV (GLuint, GLuint64EXT, GLuint64EXT, GLuint64EXT);
glVertexAttribL4ui64NV > n i l l l l               : void glVertexAttribL4ui64NV (GLuint, GLuint64EXT, GLuint64EXT, GLuint64EXT, GLuint64EXT);
glVertexAttribL1ui64vNV > n i *l                   : void glVertexAttribL1ui64vNV (GLuint, GLuint64EXT *);
glVertexAttribL2ui64vNV > n i *l                   : void glVertexAttribL2ui64vNV (GLuint, GLuint64EXT *);
glVertexAttribL3ui64vNV > n i *l                   : void glVertexAttribL3ui64vNV (GLuint, GLuint64EXT *);
glVertexAttribL4ui64vNV > n i *l                   : void glVertexAttribL4ui64vNV (GLuint, GLuint64EXT *);
glGetVertexAttribLi64vNV > n i i *l                : void glGetVertexAttribLi64vNV (GLuint, GLenum, GLint64EXT *);
glGetVertexAttribLui64vNV > n i i *l               : void glGetVertexAttribLui64vNV (GLuint, GLenum, GLuint64EXT *);
glVertexAttribLFormatNV > n i i i i                : void glVertexAttribLFormatNV (GLuint, GLint, GLenum, GLsizei);
glGenNamesAMD > n i i *i                           : void glGenNamesAMD (GLenum, GLuint, GLuint *);
glDeleteNamesAMD > n i i *i                        : void glDeleteNamesAMD (GLenum, GLuint, GLuint *);
glIsNameAMD > s i i                                : GLboolean glIsNameAMD (GLenum, GLuint);
glDebugMessageEnableAMD > n i i i *i s             : void glDebugMessageEnableAMD (GLenum, GLenum, GLsizei, GLuint *, GLboolean);
glDebugMessageInsertAMD > n i i i i *c             : void glDebugMessageInsertAMD (GLenum, GLenum, GLuint, GLsizei, GLchar *);
glDebugMessageCallbackAMD > n x *x                 : void glDebugMessageCallbackAMD (GLDEBUGPROCAMD, GLvoid *);
glGetDebugMessageLogAMD > i i i *i *i *i *i *c     : GLuint glGetDebugMessageLogAMD (GLuint, GLsizei, GLenum *, GLuint *, GLuint *, GLsizei *, GLchar *);
glVDPAUInitNV > n *x *x                            : void glVDPAUInitNV (GLvoid *, GLvoid *);
glVDPAUFiniNV > n                                  : void glVDPAUFiniNV (void);
glVDPAURegisterVideoSurfaceNV > x *x i i *i        : GLvdpauSurfaceNV glVDPAURegisterVideoSurfaceNV (GLvoid *, GLenum, GLsizei, GLuint *);
glVDPAURegisterOutputSurfaceNV > x *x i i *i       : GLvdpauSurfaceNV glVDPAURegisterOutputSurfaceNV (GLvoid *, GLenum, GLsizei, GLuint *);
glVDPAUIsSurfaceNV > n x                           : void glVDPAUIsSurfaceNV (GLvdpauSurfaceNV);
glVDPAUUnregisterSurfaceNV > n x                   : void glVDPAUUnregisterSurfaceNV (GLvdpauSurfaceNV);
glVDPAUGetSurfaceivNV > n x i i *i *i              : void glVDPAUGetSurfaceivNV (GLvdpauSurfaceNV, GLenum, GLsizei, GLsizei *, GLint *);
glVDPAUSurfaceAccessNV > n x i                     : void glVDPAUSurfaceAccessNV (GLvdpauSurfaceNV, GLenum);
glVDPAUMapSurfacesNV > n i *x                      : void glVDPAUMapSurfacesNV (GLsizei, GLvdpauSurfaceNV *);
glVDPAUUnmapSurfacesNV > n i *x                    : void glVDPAUUnmapSurfacesNV (GLsizei, GLvdpauSurfaceNV *);
glTexImage2DMultisampleCoverageNV > n i i i i i i s : void glTexImage2DMultisampleCoverageNV (GLenum, GLsizei, GLsizei, GLint, GLsizei, GLsizei, GLboolean);
glTexImage3DMultisampleCoverageNV > n i i i i i i i s : void glTexImage3DMultisampleCoverageNV (GLenum, GLsizei, GLsizei, GLint, GLsizei, GLsizei, GLsizei, GLboolean);
glTextureImage2DMultisampleNV > n i i i i i i s    : void glTextureImage2DMultisampleNV (GLuint, GLenum, GLsizei, GLint, GLsizei, GLsizei, GLboolean);
glTextureImage3DMultisampleNV > n i i i i i i i s  : void glTextureImage3DMultisampleNV (GLuint, GLenum, GLsizei, GLint, GLsizei, GLsizei, GLsizei, GLboolean);
glTextureImage2DMultisampleCoverageNV > n i i i i i i i s : void glTextureImage2DMultisampleCoverageNV (GLuint, GLenum, GLsizei, GLsizei, GLint, GLsizei, GLsizei, GLboolean);
glTextureImage3DMultisampleCoverageNV > n i i i i i i i i s : void glTextureImage3DMultisampleCoverageNV (GLuint, GLenum, GLsizei, GLsizei, GLint, GLsizei, GLsizei, GLsizei, GLboolean);
glSetMultisamplefvAMD > n i i *f                   : void glSetMultisamplefvAMD (GLenum, GLuint, GLfloat *);
glImportSyncEXT > x i i i                          : GLsync glImportSyncEXT (GLenum, GLintptr, GLbitfield);
glMultiDrawArraysIndirectAMD > n i *x i i          : void glMultiDrawArraysIndirectAMD (GLenum, GLvoid *, GLsizei, GLsizei);
glMultiDrawElementsIndirectAMD > n i i *x i i      : void glMultiDrawElementsIndirectAMD (GLenum, GLenum, GLvoid *, GLsizei, GLsizei);
glCreateDebugObjectMESA > i                        : GLhandleARB glCreateDebugObjectMESA (void);
glClearDebugLogMESA > n i i i                      : void glClearDebugLogMESA (GLhandleARB, GLenum, GLenum);
glGetDebugLogMESA > n i i i i *i *c                : void glGetDebugLogMESA (GLhandleARB, GLenum, GLenum, GLsizei, GLsizei *, GLcharARB *);
glGetDebugLogLengthMESA > i i i i                  : GLsizei glGetDebugLogLengthMESA (GLhandleARB, GLenum, GLenum);
glProgramCallbackMESA > n i x *x                   : void glProgramCallbackMESA (GLenum, GLprogramcallbackMESA, GLvoid *);
glGetProgramRegisterfvMESA > n i i *c *f           : void glGetProgramRegisterfvMESA (GLenum, GLsizei, GLubyte *, GLfloat *);
glBlendEquationSeparateATI > n i i                 : void glBlendEquationSeparateATI (GLenum, GLenum);
glEGLImageTargetTexture2DOES > n i x               : void glEGLImageTargetTexture2DOES (GLenum, GLeglImageOES);
glEGLImageTargetRenderbufferStorageOES > n i x     : void glEGLImageTargetRenderbufferStorageOES (GLenum, GLeglImageOES);
)
GLES_FUNC_ES2=: 0 : 0
glActiveTexture > n i                              : void glActiveTexture (GLenum);
glAttachShader > n i i                             : void glAttachShader (GLuint, GLuint);
glBindAttribLocation > n i i *c                    : void glBindAttribLocation (GLuint, GLuint, GLchar *);
glBindBuffer > n i i                               : void glBindBuffer (GLenum, GLuint);
glBindFramebuffer > n i i                          : void glBindFramebuffer (GLenum, GLuint);
glBindRenderbuffer > n i i                         : void glBindRenderbuffer (GLenum, GLuint);
glBindTexture > n i i                              : void glBindTexture (GLenum, GLuint);
glBlendColor > n f f f f                           : void glBlendColor (GLclampf, GLclampf, GLclampf, GLclampf);
glBlendEquation > n i                              : void glBlendEquation (GLenum);
glBlendEquationSeparate > n i i                    : void glBlendEquationSeparate (GLenum, GLenum);
glBlendFunc > n i i                                : void glBlendFunc (GLenum, GLenum);
glBlendFuncSeparate > n i i i i                    : void glBlendFuncSeparate (GLenum, GLenum, GLenum, GLenum);
glBufferData > n i i *x i                          : void glBufferData (GLenum, GLsizeiptr, GLvoid *, GLenum);
glBufferSubData > n i i i *x                       : void glBufferSubData (GLenum, GLintptr, GLsizeiptr, GLvoid *);
glCheckFramebufferStatus > i i                     : GLenum glCheckFramebufferStatus (GLenum);
glClear > n i                                      : void glClear (GLbitfield);
glClearColor > n f f f f                           : void glClearColor (GLclampf, GLclampf, GLclampf, GLclampf);
glClearDepthf > n f                                : void glClearDepthf (GLclampf);
glClearStencil > n i                               : void glClearStencil (GLint);
glColorMask > n s s s s                            : void glColorMask (GLboolean, GLboolean, GLboolean, GLboolean);
glCompileShader > n i                              : void glCompileShader (GLuint);
glCompressedTexImage2D > n i i i i i i i *x        : void glCompressedTexImage2D (GLenum, GLint, GLenum, GLsizei, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedTexSubImage2D > n i i i i i i i i *x   : void glCompressedTexSubImage2D (GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLsizei, GLvoid *);
glCopyTexImage2D > n i i i i i i i i               : void glCopyTexImage2D (GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLsizei, GLint);
glCopyTexSubImage2D > n i i i i i i i i            : void glCopyTexSubImage2D (GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
glCreateProgram > i                                : GLuint glCreateProgram (void);
glCreateShader > i i                               : GLuint glCreateShader (GLenum);
glCullFace > n i                                   : void glCullFace (GLenum);
glDeleteBuffers > n i *i                           : void glDeleteBuffers (GLsizei, GLuint *);
glDeleteFramebuffers > n i *i                      : void glDeleteFramebuffers (GLsizei, GLuint *);
glDeleteProgram > n i                              : void glDeleteProgram (GLuint);
glDeleteRenderbuffers > n i *i                     : void glDeleteRenderbuffers (GLsizei, GLuint *);
glDeleteShader > n i                               : void glDeleteShader (GLuint);
glDeleteTextures > n i *i                          : void glDeleteTextures (GLsizei, GLuint *);
glDepthFunc > n i                                  : void glDepthFunc (GLenum);
glDepthMask > n s                                  : void glDepthMask (GLboolean);
glDepthRangef > n f f                              : void glDepthRangef (GLclampf, GLclampf);
glDetachShader > n i i                             : void glDetachShader (GLuint, GLuint);
glDisable > n i                                    : void glDisable (GLenum);
glDisableVertexAttribArray > n i                   : void glDisableVertexAttribArray (GLuint);
glDrawArrays > n i i i                             : void glDrawArrays (GLenum, GLint, GLsizei);
glDrawElements > n i i i *x                        : void glDrawElements (GLenum, GLsizei, GLenum, GLvoid *);
glEnable > n i                                     : void glEnable (GLenum);
glEnableVertexAttribArray > n i                    : void glEnableVertexAttribArray (GLuint);
glFinish > n                                       : void glFinish (void);
glFlush > n                                        : void glFlush (void);
glFramebufferRenderbuffer > n i i i i              : void glFramebufferRenderbuffer (GLenum, GLenum, GLenum, GLuint);
glFramebufferTexture2D > n i i i i i               : void glFramebufferTexture2D (GLenum, GLenum, GLenum, GLuint, GLint);
glFrontFace > n i                                  : void glFrontFace (GLenum);
glGenBuffers > n i *i                              : void glGenBuffers (GLsizei, GLuint *);
glGenerateMipmap > n i                             : void glGenerateMipmap (GLenum);
glGenFramebuffers > n i *i                         : void glGenFramebuffers (GLsizei, GLuint *);
glGenRenderbuffers > n i *i                        : void glGenRenderbuffers (GLsizei, GLuint *);
glGenTextures > n i *i                             : void glGenTextures (GLsizei, GLuint *);
glGetActiveAttrib > n i i i *i *i *i *c            : void glGetActiveAttrib (GLuint, GLuint, GLsizei, GLsizei *, GLint *, GLenum *, GLchar *);
glGetActiveUniform > n i i i *i *i *i *c           : void glGetActiveUniform (GLuint, GLuint, GLsizei, GLsizei *, GLint *, GLenum *, GLchar *);
glGetAttachedShaders > n i i *i *i                 : void glGetAttachedShaders (GLuint, GLsizei, GLsizei *, GLuint *);
glGetAttribLocation > i i *c                       : int glGetAttribLocation (GLuint, GLchar *);
glGetBooleanv > n i *s                             : void glGetBooleanv (GLenum, GLboolean *);
glGetBufferParameteriv > n i i *i                  : void glGetBufferParameteriv (GLenum, GLenum, GLint *);
glGetError > i                                     : GLenum glGetError (void);
glGetFloatv > n i *f                               : void glGetFloatv (GLenum, GLfloat *);
glGetFramebufferAttachmentParameteriv > n i i i *i : void glGetFramebufferAttachmentParameteriv (GLenum, GLenum, GLenum, GLint *);
glGetIntegerv > n i *i                             : void glGetIntegerv (GLenum, GLint *);
glGetProgramiv > n i i *i                          : void glGetProgramiv (GLuint, GLenum, GLint *);
glGetProgramInfoLog > n i i *i *c                  : void glGetProgramInfoLog (GLuint, GLsizei, GLsizei *, GLchar *);
glGetRenderbufferParameteriv > n i i *i            : void glGetRenderbufferParameteriv (GLenum, GLenum, GLint *);
glGetShaderiv > n i i *i                           : void glGetShaderiv (GLuint, GLenum, GLint *);
glGetShaderInfoLog > n i i *i *c                   : void glGetShaderInfoLog (GLuint, GLsizei, GLsizei *, GLchar *);
glGetShaderPrecisionFormat > n i i *i *i           : void glGetShaderPrecisionFormat (GLenum, GLenum, GLint *, GLint *);
glGetShaderSource > n i i *i *c                    : void glGetShaderSource (GLuint, GLsizei, GLsizei *, GLchar *);
glGetString > x i                                  : GLubyte *glGetString (GLenum);
glGetTexParameterfv > n i i *f                     : void glGetTexParameterfv (GLenum, GLenum, GLfloat *);
glGetTexParameteriv > n i i *i                     : void glGetTexParameteriv (GLenum, GLenum, GLint *);
glGetUniformfv > n i i *f                          : void glGetUniformfv (GLuint, GLint, GLfloat *);
glGetUniformiv > n i i *i                          : void glGetUniformiv (GLuint, GLint, GLint *);
glGetUniformLocation > i i *c                      : int glGetUniformLocation (GLuint, GLchar *);
glGetVertexAttribfv > n i i *f                     : void glGetVertexAttribfv (GLuint, GLenum, GLfloat *);
glGetVertexAttribiv > n i i *i                     : void glGetVertexAttribiv (GLuint, GLenum, GLint *);
glGetVertexAttribPointerv > n i i *x               : void glGetVertexAttribPointerv (GLuint, GLenum, GLvoid **);
glHint > n i i                                     : void glHint (GLenum, GLenum);
glIsBuffer > s i                                   : GLboolean glIsBuffer (GLuint);
glIsEnabled > s i                                  : GLboolean glIsEnabled (GLenum);
glIsFramebuffer > s i                              : GLboolean glIsFramebuffer (GLuint);
glIsProgram > s i                                  : GLboolean glIsProgram (GLuint);
glIsRenderbuffer > s i                             : GLboolean glIsRenderbuffer (GLuint);
glIsShader > s i                                   : GLboolean glIsShader (GLuint);
glIsTexture > s i                                  : GLboolean glIsTexture (GLuint);
glLineWidth > n f                                  : void glLineWidth (GLfloat);
glLinkProgram > n i                                : void glLinkProgram (GLuint);
glPixelStorei > n i i                              : void glPixelStorei (GLenum, GLint);
glPolygonOffset > n f f                            : void glPolygonOffset (GLfloat, GLfloat);
glReadPixels > n i i i i i i *x                    : void glReadPixels (GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glReleaseShaderCompiler > n                        : void glReleaseShaderCompiler (void);
glRenderbufferStorage > n i i i i                  : void glRenderbufferStorage (GLenum, GLenum, GLsizei, GLsizei);
glSampleCoverage > n f s                           : void glSampleCoverage (GLclampf, GLboolean);
glScissor > n i i i i                              : void glScissor (GLint, GLint, GLsizei, GLsizei);
glShaderBinary > n i *i i *x i                     : void glShaderBinary (GLsizei, GLuint *, GLenum, GLvoid *, GLsizei);
glShaderSource > n i i *x *i                       : void glShaderSource (GLuint, GLsizei, GLchar **, GLint *);
glStencilFunc > n i i i                            : void glStencilFunc (GLenum, GLint, GLuint);
glStencilFuncSeparate > n i i i i                  : void glStencilFuncSeparate (GLenum, GLenum, GLint, GLuint);
glStencilMask > n i                                : void glStencilMask (GLuint);
glStencilMaskSeparate > n i i                      : void glStencilMaskSeparate (GLenum, GLuint);
glStencilOp > n i i i                              : void glStencilOp (GLenum, GLenum, GLenum);
glStencilOpSeparate > n i i i i                    : void glStencilOpSeparate (GLenum, GLenum, GLenum, GLenum);
glTexImage2D > n i i i i i i i i *x                : void glTexImage2D (GLenum, GLint, GLint, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glTexParameterf > n i i f                          : void glTexParameterf (GLenum, GLenum, GLfloat);
glTexParameterfv > n i i *f                        : void glTexParameterfv (GLenum, GLenum, GLfloat *);
glTexParameteri > n i i i                          : void glTexParameteri (GLenum, GLenum, GLint);
glTexParameteriv > n i i *i                        : void glTexParameteriv (GLenum, GLenum, GLint *);
glTexSubImage2D > n i i i i i i i i *x             : void glTexSubImage2D (GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glUniform1f > n i f                                : void glUniform1f (GLint, GLfloat);
glUniform1fv > n i i *f                            : void glUniform1fv (GLint, GLsizei, GLfloat *);
glUniform1i > n i i                                : void glUniform1i (GLint, GLint);
glUniform1iv > n i i *i                            : void glUniform1iv (GLint, GLsizei, GLint *);
glUniform2f > n i f f                              : void glUniform2f (GLint, GLfloat, GLfloat);
glUniform2fv > n i i *f                            : void glUniform2fv (GLint, GLsizei, GLfloat *);
glUniform2i > n i i i                              : void glUniform2i (GLint, GLint, GLint);
glUniform2iv > n i i *i                            : void glUniform2iv (GLint, GLsizei, GLint *);
glUniform3f > n i f f f                            : void glUniform3f (GLint, GLfloat, GLfloat, GLfloat);
glUniform3fv > n i i *f                            : void glUniform3fv (GLint, GLsizei, GLfloat *);
glUniform3i > n i i i i                            : void glUniform3i (GLint, GLint, GLint, GLint);
glUniform3iv > n i i *i                            : void glUniform3iv (GLint, GLsizei, GLint *);
glUniform4f > n i f f f f                          : void glUniform4f (GLint, GLfloat, GLfloat, GLfloat, GLfloat);
glUniform4fv > n i i *f                            : void glUniform4fv (GLint, GLsizei, GLfloat *);
glUniform4i > n i i i i i                          : void glUniform4i (GLint, GLint, GLint, GLint, GLint);
glUniform4iv > n i i *i                            : void glUniform4iv (GLint, GLsizei, GLint *);
glUniformMatrix2fv > n i i s *f                    : void glUniformMatrix2fv (GLint, GLsizei, GLboolean, GLfloat *);
glUniformMatrix3fv > n i i s *f                    : void glUniformMatrix3fv (GLint, GLsizei, GLboolean, GLfloat *);
glUniformMatrix4fv > n i i s *f                    : void glUniformMatrix4fv (GLint, GLsizei, GLboolean, GLfloat *);
glUseProgram > n i                                 : void glUseProgram (GLuint);
glValidateProgram > n i                            : void glValidateProgram (GLuint);
glVertexAttrib1f > n i f                           : void glVertexAttrib1f (GLuint, GLfloat);
glVertexAttrib1fv > n i *f                         : void glVertexAttrib1fv (GLuint, GLfloat *);
glVertexAttrib2f > n i f f                         : void glVertexAttrib2f (GLuint, GLfloat, GLfloat);
glVertexAttrib2fv > n i *f                         : void glVertexAttrib2fv (GLuint, GLfloat *);
glVertexAttrib3f > n i f f f                       : void glVertexAttrib3f (GLuint, GLfloat, GLfloat, GLfloat);
glVertexAttrib3fv > n i *f                         : void glVertexAttrib3fv (GLuint, GLfloat *);
glVertexAttrib4f > n i f f f f                     : void glVertexAttrib4f (GLuint, GLfloat, GLfloat, GLfloat, GLfloat);
glVertexAttrib4fv > n i *f                         : void glVertexAttrib4fv (GLuint, GLfloat *);
glVertexAttribPointer > n i i i s i *x             : void glVertexAttribPointer (GLuint, GLint, GLenum, GLboolean, GLsizei, GLvoid *);
glViewport > n i i i i                             : void glViewport (GLint, GLint, GLsizei, GLsizei);
glEGLImageTargetTexture2DOES > n i x               : void glEGLImageTargetTexture2DOES (GLenum, GLeglImageOES);
glEGLImageTargetRenderbufferStorageOES > n i x     : void glEGLImageTargetRenderbufferStorageOES (GLenum, GLeglImageOES);
glGetProgramBinaryOES > n i i *i *i *x             : void glGetProgramBinaryOES (GLuint, GLsizei, GLsizei *, GLenum *, GLvoid *);
glProgramBinaryOES > n i i *x i                    : void glProgramBinaryOES (GLuint, GLenum, GLvoid *, GLint);
glMapBufferOES > x i i                             : void *glMapBufferOES (GLenum, GLenum);
glUnmapBufferOES > s i                             : GLboolean glUnmapBufferOES (GLenum);
glGetBufferPointervOES > n i i *x                  : void glGetBufferPointervOES (GLenum, GLenum, GLvoid **);
glTexImage3DOES > n i i i i i i i i i *x           : void glTexImage3DOES (GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid *);
glTexSubImage3DOES > n i i i i i i i i i i *x      : void glTexSubImage3DOES (GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glCopyTexSubImage3DOES > n i i i i i i i i i       : void glCopyTexSubImage3DOES (GLenum, GLint, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei);
glCompressedTexImage3DOES > n i i i i i i i i *x   : void glCompressedTexImage3DOES (GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLsizei, GLvoid *);
glCompressedTexSubImage3DOES > n i i i i i i i i i i *x : void glCompressedTexSubImage3DOES (GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, GLvoid *);
glFramebufferTexture3DOES > n i i i i i i          : void glFramebufferTexture3DOES (GLenum, GLenum, GLenum, GLuint, GLint, GLint);
glBindVertexArrayOES > n i                         : void glBindVertexArrayOES (GLuint);
glDeleteVertexArraysOES > n i *i                   : void glDeleteVertexArraysOES (GLsizei, GLuint *);
glGenVertexArraysOES > n i *i                      : void glGenVertexArraysOES (GLsizei, GLuint *);
glIsVertexArrayOES > s i                           : GLboolean glIsVertexArrayOES (GLuint);
glGetPerfMonitorGroupsAMD > n *i i *i              : void glGetPerfMonitorGroupsAMD (GLint *, GLsizei, GLuint *);
glGetPerfMonitorCountersAMD > n i *i *i i *i       : void glGetPerfMonitorCountersAMD (GLuint, GLint *, GLint *, GLsizei, GLuint *);
glGetPerfMonitorGroupStringAMD > n i i *i *c       : void glGetPerfMonitorGroupStringAMD (GLuint, GLsizei, GLsizei *, GLchar *);
glGetPerfMonitorCounterStringAMD > n i i i *i *c   : void glGetPerfMonitorCounterStringAMD (GLuint, GLuint, GLsizei, GLsizei *, GLchar *);
glGetPerfMonitorCounterInfoAMD > n i i i *x        : void glGetPerfMonitorCounterInfoAMD (GLuint, GLuint, GLenum, GLvoid *);
glGenPerfMonitorsAMD > n i *i                      : void glGenPerfMonitorsAMD (GLsizei, GLuint *);
glDeletePerfMonitorsAMD > n i *i                   : void glDeletePerfMonitorsAMD (GLsizei, GLuint *);
glSelectPerfMonitorCountersAMD > n i s i i *i      : void glSelectPerfMonitorCountersAMD (GLuint, GLboolean, GLuint, GLint, GLuint *);
glBeginPerfMonitorAMD > n i                        : void glBeginPerfMonitorAMD (GLuint);
glEndPerfMonitorAMD > n i                          : void glEndPerfMonitorAMD (GLuint);
glGetPerfMonitorCounterDataAMD > n i i i *i *i     : void glGetPerfMonitorCounterDataAMD (GLuint, GLenum, GLsizei, GLuint *, GLint *);
glBlitFramebufferANGLE > n i i i i i i i i i i     : void glBlitFramebufferANGLE (GLint, GLint, GLint, GLint, GLint, GLint, GLint, GLint, GLbitfield, GLenum);
glRenderbufferStorageMultisampleANGLE > n i i i i i : void glRenderbufferStorageMultisampleANGLE (GLenum, GLsizei, GLenum, GLsizei, GLsizei);
glRenderbufferStorageMultisampleAPPLE > n i i i i i : void glRenderbufferStorageMultisampleAPPLE (GLenum, GLsizei, GLenum, GLsizei, GLsizei);
glResolveMultisampleFramebufferAPPLE > n           : void glResolveMultisampleFramebufferAPPLE (void);
glDiscardFramebufferEXT > n i i *i                 : void glDiscardFramebufferEXT (GLenum, GLsizei, GLenum *);
glMultiDrawArraysEXT > n i *i *i i                 : void glMultiDrawArraysEXT (GLenum, GLint *, GLsizei *, GLsizei);
glMultiDrawElementsEXT > n i *i i *x i             : void glMultiDrawElementsEXT (GLenum, GLsizei *, GLenum, GLvoid **, GLsizei);
glRenderbufferStorageMultisampleIMG > n i i i i i  : void glRenderbufferStorageMultisampleIMG (GLenum, GLsizei, GLenum, GLsizei, GLsizei);
glFramebufferTexture2DMultisampleIMG > n i i i i i i : void glFramebufferTexture2DMultisampleIMG (GLenum, GLenum, GLenum, GLuint, GLint, GLsizei);
glCoverageMaskNV > n s                             : void glCoverageMaskNV (GLboolean);
glCoverageOperationNV > n i                        : void glCoverageOperationNV (GLenum);
glDrawBuffersNV > n i *i                           : void glDrawBuffersNV (GLsizei, GLenum *);
glDeleteFencesNV > n i *i                          : void glDeleteFencesNV (GLsizei, GLuint *);
glGenFencesNV > n i *i                             : void glGenFencesNV (GLsizei, GLuint *);
glIsFenceNV > s i                                  : GLboolean glIsFenceNV (GLuint);
glTestFenceNV > s i                                : GLboolean glTestFenceNV (GLuint);
glGetFenceivNV > n i i *i                          : void glGetFenceivNV (GLuint, GLenum, GLint *);
glFinishFenceNV > n i                              : void glFinishFenceNV (GLuint);
glSetFenceNV > n i i                               : void glSetFenceNV (GLuint, GLenum);
glReadBufferNV > n i                               : void glReadBufferNV (GLenum);
glAlphaFuncQCOM > n i f                            : void glAlphaFuncQCOM (GLenum, GLclampf);
glGetDriverControlsQCOM > n *i i *i                : void glGetDriverControlsQCOM (GLint *, GLsizei, GLuint *);
glGetDriverControlStringQCOM > n i i *i *c         : void glGetDriverControlStringQCOM (GLuint, GLsizei, GLsizei *, GLchar *);
glEnableDriverControlQCOM > n i                    : void glEnableDriverControlQCOM (GLuint);
glDisableDriverControlQCOM > n i                   : void glDisableDriverControlQCOM (GLuint);
glExtGetTexturesQCOM > n *i i *i                   : void glExtGetTexturesQCOM (GLuint *, GLint, GLint *);
glExtGetBuffersQCOM > n *i i *i                    : void glExtGetBuffersQCOM (GLuint *, GLint, GLint *);
glExtGetRenderbuffersQCOM > n *i i *i              : void glExtGetRenderbuffersQCOM (GLuint *, GLint, GLint *);
glExtGetFramebuffersQCOM > n *i i *i               : void glExtGetFramebuffersQCOM (GLuint *, GLint, GLint *);
glExtGetTexLevelParameterivQCOM > n i i i i *i     : void glExtGetTexLevelParameterivQCOM (GLuint, GLenum, GLint, GLenum, GLint *);
glExtTexObjectStateOverrideiQCOM > n i i i         : void glExtTexObjectStateOverrideiQCOM (GLenum, GLenum, GLint);
glExtGetTexSubImageQCOM > n i i i i i i i i i i *x : void glExtGetTexSubImageQCOM (GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, GLvoid *);
glExtGetBufferPointervQCOM > n i *x                : void glExtGetBufferPointervQCOM (GLenum, GLvoid **);
glExtGetShadersQCOM > n *i i *i                    : void glExtGetShadersQCOM (GLuint *, GLint, GLint *);
glExtGetProgramsQCOM > n *i i *i                   : void glExtGetProgramsQCOM (GLuint *, GLint, GLint *);
glExtIsProgramBinaryQCOM > s i                     : GLboolean glExtIsProgramBinaryQCOM (GLuint);
glExtGetProgramBinarySourceQCOM > n i i *c *i      : void glExtGetProgramBinarySourceQCOM (GLuint, GLenum, GLchar *, GLint *);
glStartTilingQCOM > n i i i i i                    : void glStartTilingQCOM (GLuint, GLuint, GLuint, GLuint, GLbitfield);
glEndTilingQCOM > n i                              : void glEndTilingQCOM (GLbitfield);
)
libgles cddefgl &.> GLES_FUNC=: <@dtb@({.~ i.&':');._2 (EMU_GLES+.IFIOS+.'Android'-:UNAME){::GLES_FUNC_2;GLES_FUNC_ES2
4!:55 'GLES_FUNC_2';'GLES_FUNC_ES2'
3 : 0''
if. EMU_GLES+.IFIOS+.'Android'-:UNAME do.
  GL_ES_VERSION_2_0=: 1
  GL_DEPTH_BUFFER_BIT=: 16b00000100
  GL_STENCIL_BUFFER_BIT=: 16b00000400
  GL_COLOR_BUFFER_BIT=: 16b00004000
  GL_FALSE=: 0
  GL_TRUE=: 1
  GL_POINTS=: 16b0000
  GL_LINES=: 16b0001
  GL_LINE_LOOP=: 16b0002
  GL_LINE_STRIP=: 16b0003
  GL_TRIANGLES=: 16b0004
  GL_TRIANGLE_STRIP=: 16b0005
  GL_TRIANGLE_FAN=: 16b0006
  GL_ZERO=: 0
  GL_ONE=: 1
  GL_SRC_COLOR=: 16b0300
  GL_ONE_MINUS_SRC_COLOR=: 16b0301
  GL_SRC_ALPHA=: 16b0302
  GL_ONE_MINUS_SRC_ALPHA=: 16b0303
  GL_DST_ALPHA=: 16b0304
  GL_ONE_MINUS_DST_ALPHA=: 16b0305
  GL_DST_COLOR=: 16b0306
  GL_ONE_MINUS_DST_COLOR=: 16b0307
  GL_SRC_ALPHA_SATURATE=: 16b0308
  GL_FUNC_ADD=: 16b8006
  GL_BLEND_EQUATION=: 16b8009
  GL_BLEND_EQUATION_RGB=: 16b8009
  GL_BLEND_EQUATION_ALPHA=: 16b883d
  GL_FUNC_SUBTRACT=: 16b800a
  GL_FUNC_REVERSE_SUBTRACT=: 16b800b
  GL_BLEND_DST_RGB=: 16b80c8
  GL_BLEND_SRC_RGB=: 16b80c9
  GL_BLEND_DST_ALPHA=: 16b80ca
  GL_BLEND_SRC_ALPHA=: 16b80cb
  GL_CONSTANT_COLOR=: 16b8001
  GL_ONE_MINUS_CONSTANT_COLOR=: 16b8002
  GL_CONSTANT_ALPHA=: 16b8003
  GL_ONE_MINUS_CONSTANT_ALPHA=: 16b8004
  GL_BLEND_COLOR=: 16b8005
  GL_ARRAY_BUFFER=: 16b8892
  GL_ELEMENT_ARRAY_BUFFER=: 16b8893
  GL_ARRAY_BUFFER_BINDING=: 16b8894
  GL_ELEMENT_ARRAY_BUFFER_BINDING=: 16b8895
  GL_STREAM_DRAW=: 16b88e0
  GL_STATIC_DRAW=: 16b88e4
  GL_DYNAMIC_DRAW=: 16b88e8
  GL_BUFFER_SIZE=: 16b8764
  GL_BUFFER_USAGE=: 16b8765
  GL_CURRENT_VERTEX_ATTRIB=: 16b8626
  GL_FRONT=: 16b0404
  GL_BACK=: 16b0405
  GL_FRONT_AND_BACK=: 16b0408
  GL_TEXTURE_2D=: 16b0de1
  GL_CULL_FACE=: 16b0b44
  GL_BLEND=: 16b0be2
  GL_DITHER=: 16b0bd0
  GL_STENCIL_TEST=: 16b0b90
  GL_DEPTH_TEST=: 16b0b71
  GL_SCISSOR_TEST=: 16b0c11
  GL_POLYGON_OFFSET_FILL=: 16b8037
  GL_SAMPLE_ALPHA_TO_COVERAGE=: 16b809e
  GL_SAMPLE_COVERAGE=: 16b80a0
  GL_NO_ERROR=: 0
  GL_INVALID_ENUM=: 16b0500
  GL_INVALID_VALUE=: 16b0501
  GL_INVALID_OPERATION=: 16b0502
  GL_OUT_OF_MEMORY=: 16b0505
  GL_CW=: 16b0900
  GL_CCW=: 16b0901
  GL_LINE_WIDTH=: 16b0b21
  GL_ALIASED_POINT_SIZE_RANGE=: 16b846d
  GL_ALIASED_LINE_WIDTH_RANGE=: 16b846e
  GL_CULL_FACE_MODE=: 16b0b45
  GL_FRONT_FACE=: 16b0b46
  GL_DEPTH_RANGE=: 16b0b70
  GL_DEPTH_WRITEMASK=: 16b0b72
  GL_DEPTH_CLEAR_VALUE=: 16b0b73
  GL_DEPTH_FUNC=: 16b0b74
  GL_STENCIL_CLEAR_VALUE=: 16b0b91
  GL_STENCIL_FUNC=: 16b0b92
  GL_STENCIL_FAIL=: 16b0b94
  GL_STENCIL_PASS_DEPTH_FAIL=: 16b0b95
  GL_STENCIL_PASS_DEPTH_PASS=: 16b0b96
  GL_STENCIL_REF=: 16b0b97
  GL_STENCIL_VALUE_MASK=: 16b0b93
  GL_STENCIL_WRITEMASK=: 16b0b98
  GL_STENCIL_BACK_FUNC=: 16b8800
  GL_STENCIL_BACK_FAIL=: 16b8801
  GL_STENCIL_BACK_PASS_DEPTH_FAIL=: 16b8802
  GL_STENCIL_BACK_PASS_DEPTH_PASS=: 16b8803
  GL_STENCIL_BACK_REF=: 16b8ca3
  GL_STENCIL_BACK_VALUE_MASK=: 16b8ca4
  GL_STENCIL_BACK_WRITEMASK=: 16b8ca5
  GL_VIEWPORT=: 16b0ba2
  GL_SCISSOR_BOX=: 16b0c10
  GL_COLOR_CLEAR_VALUE=: 16b0c22
  GL_COLOR_WRITEMASK=: 16b0c23
  GL_UNPACK_ALIGNMENT=: 16b0cf5
  GL_PACK_ALIGNMENT=: 16b0d05
  GL_MAX_TEXTURE_SIZE=: 16b0d33
  GL_MAX_VIEWPORT_DIMS=: 16b0d3a
  GL_SUBPIXEL_BITS=: 16b0d50
  GL_RED_BITS=: 16b0d52
  GL_GREEN_BITS=: 16b0d53
  GL_BLUE_BITS=: 16b0d54
  GL_ALPHA_BITS=: 16b0d55
  GL_DEPTH_BITS=: 16b0d56
  GL_STENCIL_BITS=: 16b0d57
  GL_POLYGON_OFFSET_UNITS=: 16b2a00
  GL_POLYGON_OFFSET_FACTOR=: 16b8038
  GL_TEXTURE_BINDING_2D=: 16b8069
  GL_SAMPLE_BUFFERS=: 16b80a8
  GL_SAMPLES=: 16b80a9
  GL_SAMPLE_COVERAGE_VALUE=: 16b80aa
  GL_SAMPLE_COVERAGE_INVERT=: 16b80ab
  GL_NUM_COMPRESSED_TEXTURE_FORMATS=: 16b86a2
  GL_COMPRESSED_TEXTURE_FORMATS=: 16b86a3
  GL_DONT_CARE=: 16b1100
  GL_FASTEST=: 16b1101
  GL_NICEST=: 16b1102
  GL_GENERATE_MIPMAP_HINT=: 16b8192
  GL_BYTE=: 16b1400
  GL_UNSIGNED_BYTE=: 16b1401
  GL_SHORT=: 16b1402
  GL_UNSIGNED_SHORT=: 16b1403
  GL_INT=: 16b1404
  GL_UNSIGNED_INT=: 16b1405
  GL_FLOAT=: 16b1406
  GL_FIXED=: 16b140c
  GL_DEPTH_COMPONENT=: 16b1902
  GL_ALPHA=: 16b1906
  GL_RGB=: 16b1907
  GL_RGBA=: 16b1908
  GL_LUMINANCE=: 16b1909
  GL_LUMINANCE_ALPHA=: 16b190a
  GL_UNSIGNED_SHORT_4_4_4_4=: 16b8033
  GL_UNSIGNED_SHORT_5_5_5_1=: 16b8034
  GL_UNSIGNED_SHORT_5_6_5=: 16b8363
  GL_FRAGMENT_SHADER=: 16b8b30
  GL_VERTEX_SHADER=: 16b8b31
  GL_MAX_VERTEX_ATTRIBS=: 16b8869
  GL_MAX_VERTEX_UNIFORM_VECTORS=: 16b8dfb
  GL_MAX_VARYING_VECTORS=: 16b8dfc
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS=: 16b8b4d
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS=: 16b8b4c
  GL_MAX_TEXTURE_IMAGE_UNITS=: 16b8872
  GL_MAX_FRAGMENT_UNIFORM_VECTORS=: 16b8dfd
  GL_SHADER_TYPE=: 16b8b4f
  GL_DELETE_STATUS=: 16b8b80
  GL_LINK_STATUS=: 16b8b82
  GL_VALIDATE_STATUS=: 16b8b83
  GL_ATTACHED_SHADERS=: 16b8b85
  GL_ACTIVE_UNIFORMS=: 16b8b86
  GL_ACTIVE_UNIFORM_MAX_LENGTH=: 16b8b87
  GL_ACTIVE_ATTRIBUTES=: 16b8b89
  GL_ACTIVE_ATTRIBUTE_MAX_LENGTH=: 16b8b8a
  GL_SHADING_LANGUAGE_VERSION=: 16b8b8c
  GL_CURRENT_PROGRAM=: 16b8b8d
  GL_NEVER=: 16b0200
  GL_LESS=: 16b0201
  GL_EQUAL=: 16b0202
  GL_LEQUAL=: 16b0203
  GL_GREATER=: 16b0204
  GL_NOTEQUAL=: 16b0205
  GL_GEQUAL=: 16b0206
  GL_ALWAYS=: 16b0207
  GL_KEEP=: 16b1e00
  GL_REPLACE=: 16b1e01
  GL_INCR=: 16b1e02
  GL_DECR=: 16b1e03
  GL_INVERT=: 16b150a
  GL_INCR_WRAP=: 16b8507
  GL_DECR_WRAP=: 16b8508
  GL_VENDOR=: 16b1f00
  GL_RENDERER=: 16b1f01
  GL_VERSION=: 16b1f02
  GL_EXTENSIONS=: 16b1f03
  GL_NEAREST=: 16b2600
  GL_LINEAR=: 16b2601
  GL_NEAREST_MIPMAP_NEAREST=: 16b2700
  GL_LINEAR_MIPMAP_NEAREST=: 16b2701
  GL_NEAREST_MIPMAP_LINEAR=: 16b2702
  GL_LINEAR_MIPMAP_LINEAR=: 16b2703
  GL_TEXTURE_MAG_FILTER=: 16b2800
  GL_TEXTURE_MIN_FILTER=: 16b2801
  GL_TEXTURE_WRAP_S=: 16b2802
  GL_TEXTURE_WRAP_T=: 16b2803
  GL_TEXTURE=: 16b1702
  GL_TEXTURE_CUBE_MAP=: 16b8513
  GL_TEXTURE_BINDING_CUBE_MAP=: 16b8514
  GL_TEXTURE_CUBE_MAP_POSITIVE_X=: 16b8515
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X=: 16b8516
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y=: 16b8517
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y=: 16b8518
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z=: 16b8519
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z=: 16b851a
  GL_MAX_CUBE_MAP_TEXTURE_SIZE=: 16b851c
  GL_TEXTURE0=: 16b84c0
  GL_TEXTURE1=: 16b84c1
  GL_TEXTURE2=: 16b84c2
  GL_TEXTURE3=: 16b84c3
  GL_TEXTURE4=: 16b84c4
  GL_TEXTURE5=: 16b84c5
  GL_TEXTURE6=: 16b84c6
  GL_TEXTURE7=: 16b84c7
  GL_TEXTURE8=: 16b84c8
  GL_TEXTURE9=: 16b84c9
  GL_TEXTURE10=: 16b84ca
  GL_TEXTURE11=: 16b84cb
  GL_TEXTURE12=: 16b84cc
  GL_TEXTURE13=: 16b84cd
  GL_TEXTURE14=: 16b84ce
  GL_TEXTURE15=: 16b84cf
  GL_TEXTURE16=: 16b84d0
  GL_TEXTURE17=: 16b84d1
  GL_TEXTURE18=: 16b84d2
  GL_TEXTURE19=: 16b84d3
  GL_TEXTURE20=: 16b84d4
  GL_TEXTURE21=: 16b84d5
  GL_TEXTURE22=: 16b84d6
  GL_TEXTURE23=: 16b84d7
  GL_TEXTURE24=: 16b84d8
  GL_TEXTURE25=: 16b84d9
  GL_TEXTURE26=: 16b84da
  GL_TEXTURE27=: 16b84db
  GL_TEXTURE28=: 16b84dc
  GL_TEXTURE29=: 16b84dd
  GL_TEXTURE30=: 16b84de
  GL_TEXTURE31=: 16b84df
  GL_ACTIVE_TEXTURE=: 16b84e0
  GL_REPEAT=: 16b2901
  GL_CLAMP_TO_EDGE=: 16b812f
  GL_MIRRORED_REPEAT=: 16b8370
  GL_FLOAT_VEC2=: 16b8b50
  GL_FLOAT_VEC3=: 16b8b51
  GL_FLOAT_VEC4=: 16b8b52
  GL_INT_VEC2=: 16b8b53
  GL_INT_VEC3=: 16b8b54
  GL_INT_VEC4=: 16b8b55
  GL_BOOL=: 16b8b56
  GL_BOOL_VEC2=: 16b8b57
  GL_BOOL_VEC3=: 16b8b58
  GL_BOOL_VEC4=: 16b8b59
  GL_FLOAT_MAT2=: 16b8b5a
  GL_FLOAT_MAT3=: 16b8b5b
  GL_FLOAT_MAT4=: 16b8b5c
  GL_SAMPLER_2D=: 16b8b5e
  GL_SAMPLER_CUBE=: 16b8b60
  GL_VERTEX_ATTRIB_ARRAY_ENABLED=: 16b8622
  GL_VERTEX_ATTRIB_ARRAY_SIZE=: 16b8623
  GL_VERTEX_ATTRIB_ARRAY_STRIDE=: 16b8624
  GL_VERTEX_ATTRIB_ARRAY_TYPE=: 16b8625
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED=: 16b886a
  GL_VERTEX_ATTRIB_ARRAY_POINTER=: 16b8645
  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING=: 16b889f
  GL_IMPLEMENTATION_COLOR_READ_TYPE=: 16b8b9a
  GL_IMPLEMENTATION_COLOR_READ_FORMAT=: 16b8b9b
  GL_COMPILE_STATUS=: 16b8b81
  GL_INFO_LOG_LENGTH=: 16b8b84
  GL_SHADER_SOURCE_LENGTH=: 16b8b88
  GL_SHADER_COMPILER=: 16b8dfa
  GL_SHADER_BINARY_FORMATS=: 16b8df8
  GL_NUM_SHADER_BINARY_FORMATS=: 16b8df9
  GL_LOW_FLOAT=: 16b8df0
  GL_MEDIUM_FLOAT=: 16b8df1
  GL_HIGH_FLOAT=: 16b8df2
  GL_LOW_INT=: 16b8df3
  GL_MEDIUM_INT=: 16b8df4
  GL_HIGH_INT=: 16b8df5
  GL_FRAMEBUFFER=: 16b8d40
  GL_RENDERBUFFER=: 16b8d41
  GL_RGBA4=: 16b8056
  GL_RGB5_A1=: 16b8057
  GL_RGB565=: 16b8d62
  GL_DEPTH_COMPONENT16=: 16b81a5
  GL_STENCIL_INDEX=: 16b1901
  GL_STENCIL_INDEX8=: 16b8d48
  GL_RENDERBUFFER_WIDTH=: 16b8d42
  GL_RENDERBUFFER_HEIGHT=: 16b8d43
  GL_RENDERBUFFER_INTERNAL_FORMAT=: 16b8d44
  GL_RENDERBUFFER_RED_SIZE=: 16b8d50
  GL_RENDERBUFFER_GREEN_SIZE=: 16b8d51
  GL_RENDERBUFFER_BLUE_SIZE=: 16b8d52
  GL_RENDERBUFFER_ALPHA_SIZE=: 16b8d53
  GL_RENDERBUFFER_DEPTH_SIZE=: 16b8d54
  GL_RENDERBUFFER_STENCIL_SIZE=: 16b8d55
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE=: 16b8cd0
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME=: 16b8cd1
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL=: 16b8cd2
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE=: 16b8cd3
  GL_COLOR_ATTACHMENT0=: 16b8ce0
  GL_DEPTH_ATTACHMENT=: 16b8d00
  GL_STENCIL_ATTACHMENT=: 16b8d20
  GL_NONE=: 0
  GL_FRAMEBUFFER_COMPLETE=: 16b8cd5
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT=: 16b8cd6
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT=: 16b8cd7
  GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS=: 16b8cd9
  GL_FRAMEBUFFER_UNSUPPORTED=: 16b8cdd
  GL_FRAMEBUFFER_BINDING=: 16b8ca6
  GL_RENDERBUFFER_BINDING=: 16b8ca7
  GL_MAX_RENDERBUFFER_SIZE=: 16b84e8
  GL_INVALID_FRAMEBUFFER_OPERATION=: 16b0506
  GL_ETC1_RGB8_OES=: 16b8d64
  GL_PALETTE4_RGB8_OES=: 16b8b90
  GL_PALETTE4_RGBA8_OES=: 16b8b91
  GL_PALETTE4_R5_G6_B5_OES=: 16b8b92
  GL_PALETTE4_RGBA4_OES=: 16b8b93
  GL_PALETTE4_RGB5_A1_OES=: 16b8b94
  GL_PALETTE8_RGB8_OES=: 16b8b95
  GL_PALETTE8_RGBA8_OES=: 16b8b96
  GL_PALETTE8_R5_G6_B5_OES=: 16b8b97
  GL_PALETTE8_RGBA4_OES=: 16b8b98
  GL_PALETTE8_RGB5_A1_OES=: 16b8b99
  GL_DEPTH_COMPONENT24_OES=: 16b81a6
  GL_DEPTH_COMPONENT32_OES=: 16b81a7
  GL_TEXTURE_EXTERNAL_OES=: 16b8d65
  GL_SAMPLER_EXTERNAL_OES=: 16b8d66
  GL_TEXTURE_BINDING_EXTERNAL_OES=: 16b8d67
  GL_REQUIRED_TEXTURE_IMAGE_UNITS_OES=: 16b8d68
  GL_UNSIGNED_INT=: 16b1405
  GL_PROGRAM_BINARY_LENGTH_OES=: 16b8741
  GL_NUM_PROGRAM_BINARY_FORMATS_OES=: 16b87fe
  GL_PROGRAM_BINARY_FORMATS_OES=: 16b87ff
  GL_WRITE_ONLY_OES=: 16b88b9
  GL_BUFFER_ACCESS_OES=: 16b88bb
  GL_BUFFER_MAPPED_OES=: 16b88bc
  GL_BUFFER_MAP_POINTER_OES=: 16b88bd
  GL_DEPTH_STENCIL_OES=: 16b84f9
  GL_UNSIGNED_INT_24_8_OES=: 16b84fa
  GL_DEPTH24_STENCIL8_OES=: 16b88f0
  GL_RGB8_OES=: 16b8051
  GL_RGBA8_OES=: 16b8058
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT_OES=: 16b8b8b
  GL_STENCIL_INDEX1_OES=: 16b8d46
  GL_STENCIL_INDEX4_OES=: 16b8d47
  GL_TEXTURE_WRAP_R_OES=: 16b8072
  GL_TEXTURE_3D_OES=: 16b806f
  GL_TEXTURE_BINDING_3D_OES=: 16b806a
  GL_MAX_3D_TEXTURE_SIZE_OES=: 16b8073
  GL_SAMPLER_3D_OES=: 16b8b5f
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_3D_ZOFFSET_OES=: 16b8cd4
  GL_HALF_FLOAT_OES=: 16b8d61
  GL_VERTEX_ARRAY_BINDING_OES=: 16b85b5
  GL_UNSIGNED_INT_10_10_10_2_OES=: 16b8df6
  GL_INT_10_10_10_2_OES=: 16b8df7
  GL_3DC_X_AMD=: 16b87f9
  GL_3DC_XY_AMD=: 16b87fa
  GL_ATC_RGB_AMD=: 16b8c92
  GL_ATC_RGBA_EXPLICIT_ALPHA_AMD=: 16b8c93
  GL_ATC_RGBA_INTERPOLATED_ALPHA_AMD=: 16b87ee
  GL_COUNTER_TYPE_AMD=: 16b8bc0
  GL_COUNTER_RANGE_AMD=: 16b8bc1
  GL_UNSIGNED_INT64_AMD=: 16b8bc2
  GL_PERCENTAGE_AMD=: 16b8bc3
  GL_PERFMON_RESULT_AVAILABLE_AMD=: 16b8bc4
  GL_PERFMON_RESULT_SIZE_AMD=: 16b8bc5
  GL_PERFMON_RESULT_AMD=: 16b8bc6
  GL_Z400_BINARY_AMD=: 16b8740
  GL_READ_FRAMEBUFFER_ANGLE=: 16b8ca8
  GL_DRAW_FRAMEBUFFER_ANGLE=: 16b8ca9
  GL_DRAW_FRAMEBUFFER_BINDING_ANGLE=: 16b8ca6
  GL_READ_FRAMEBUFFER_BINDING_ANGLE=: 16b8caa
  GL_RENDERBUFFER_SAMPLES_ANGLE=: 16b8cab
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_ANGLE=: 16b8d56
  GL_MAX_SAMPLES_ANGLE=: 16b8d57
  GL_RGB_422_APPLE=: 16b8a1f
  GL_UNSIGNED_SHORT_8_8_APPLE=: 16b85ba
  GL_UNSIGNED_SHORT_8_8_REV_APPLE=: 16b85bb
  GL_RENDERBUFFER_SAMPLES_APPLE=: 16b8cab
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_APPLE=: 16b8d56
  GL_MAX_SAMPLES_APPLE=: 16b8d57
  GL_READ_FRAMEBUFFER_APPLE=: 16b8ca8
  GL_DRAW_FRAMEBUFFER_APPLE=: 16b8ca9
  GL_DRAW_FRAMEBUFFER_BINDING_APPLE=: 16b8ca6
  GL_READ_FRAMEBUFFER_BINDING_APPLE=: 16b8caa
  GL_BGRA_EXT=: 16b80e1
  GL_TEXTURE_MAX_LEVEL_APPLE=: 16b813d
  GL_MALI_SHADER_BINARY_ARM=: 16b8f60
  GL_MIN_EXT=: 16b8007
  GL_MAX_EXT=: 16b8008
  GL_COLOR_EXT=: 16b1800
  GL_DEPTH_EXT=: 16b1801
  GL_STENCIL_EXT=: 16b1802
  GL_BGRA_EXT=: 16b80e1
  GL_UNSIGNED_SHORT_4_4_4_4_REV_EXT=: 16b8365
  GL_UNSIGNED_SHORT_1_5_5_5_REV_EXT=: 16b8366
  GL_TEXTURE_MAX_ANISOTROPY_EXT=: 16b84fe
  GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT=: 16b84ff
  GL_BGRA_EXT=: 16b80e1
  GL_UNSIGNED_INT_2_10_10_10_REV_EXT=: 16b8368
  GL_COMPRESSED_RGB_S3TC_DXT1_EXT=: 16b83f0
  GL_COMPRESSED_RGBA_S3TC_DXT1_EXT=: 16b83f1
  GL_UNPACK_ROW_LENGTH=: 16b0cf2
  GL_UNPACK_SKIP_ROWS=: 16b0cf3
  GL_UNPACK_SKIP_PIXELS=: 16b0cf4
  GL_SHADER_BINARY_DMP=: 16b9250
  GL_SGX_PROGRAM_BINARY_IMG=: 16b9130
  GL_BGRA_IMG=: 16b80e1
  GL_UNSIGNED_SHORT_4_4_4_4_REV_IMG=: 16b8365
  GL_SGX_BINARY_IMG=: 16b8c0a
  GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG=: 16b8c00
  GL_COMPRESSED_RGB_PVRTC_2BPPV1_IMG=: 16b8c01
  GL_COMPRESSED_RGBA_PVRTC_4BPPV1_IMG=: 16b8c02
  GL_COMPRESSED_RGBA_PVRTC_2BPPV1_IMG=: 16b8c03
  GL_RENDERBUFFER_SAMPLES_IMG=: 16b9133
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_IMG=: 16b9134
  GL_MAX_SAMPLES_IMG=: 16b9135
  GL_TEXTURE_SAMPLES_IMG=: 16b9136
  GL_COVERAGE_COMPONENT_NV=: 16b8ed0
  GL_COVERAGE_COMPONENT4_NV=: 16b8ed1
  GL_COVERAGE_ATTACHMENT_NV=: 16b8ed2
  GL_COVERAGE_BUFFERS_NV=: 16b8ed3
  GL_COVERAGE_SAMPLES_NV=: 16b8ed4
  GL_COVERAGE_ALL_FRAGMENTS_NV=: 16b8ed5
  GL_COVERAGE_EDGE_FRAGMENTS_NV=: 16b8ed6
  GL_COVERAGE_AUTOMATIC_NV=: 16b8ed7
  GL_COVERAGE_BUFFER_BIT_NV=: 16b8000
  GL_DEPTH_COMPONENT16_NONLINEAR_NV=: 16b8e2c
  GL_MAX_DRAW_BUFFERS_NV=: 16b8824
  GL_DRAW_BUFFER0_NV=: 16b8825
  GL_DRAW_BUFFER1_NV=: 16b8826
  GL_DRAW_BUFFER2_NV=: 16b8827
  GL_DRAW_BUFFER3_NV=: 16b8828
  GL_DRAW_BUFFER4_NV=: 16b8829
  GL_DRAW_BUFFER5_NV=: 16b882a
  GL_DRAW_BUFFER6_NV=: 16b882b
  GL_DRAW_BUFFER7_NV=: 16b882c
  GL_DRAW_BUFFER8_NV=: 16b882d
  GL_DRAW_BUFFER9_NV=: 16b882e
  GL_DRAW_BUFFER10_NV=: 16b882f
  GL_DRAW_BUFFER11_NV=: 16b8830
  GL_DRAW_BUFFER12_NV=: 16b8831
  GL_DRAW_BUFFER13_NV=: 16b8832
  GL_DRAW_BUFFER14_NV=: 16b8833
  GL_DRAW_BUFFER15_NV=: 16b8834
  GL_COLOR_ATTACHMENT0_NV=: 16b8ce0
  GL_COLOR_ATTACHMENT1_NV=: 16b8ce1
  GL_COLOR_ATTACHMENT2_NV=: 16b8ce2
  GL_COLOR_ATTACHMENT3_NV=: 16b8ce3
  GL_COLOR_ATTACHMENT4_NV=: 16b8ce4
  GL_COLOR_ATTACHMENT5_NV=: 16b8ce5
  GL_COLOR_ATTACHMENT6_NV=: 16b8ce6
  GL_COLOR_ATTACHMENT7_NV=: 16b8ce7
  GL_COLOR_ATTACHMENT8_NV=: 16b8ce8
  GL_COLOR_ATTACHMENT9_NV=: 16b8ce9
  GL_COLOR_ATTACHMENT10_NV=: 16b8cea
  GL_COLOR_ATTACHMENT11_NV=: 16b8ceb
  GL_COLOR_ATTACHMENT12_NV=: 16b8cec
  GL_COLOR_ATTACHMENT13_NV=: 16b8ced
  GL_COLOR_ATTACHMENT14_NV=: 16b8cee
  GL_COLOR_ATTACHMENT15_NV=: 16b8cef
  GL_MAX_COLOR_ATTACHMENTS_NV=: 16b8cdf
  GL_ALL_COMPLETED_NV=: 16b84f2
  GL_FENCE_STATUS_NV=: 16b84f3
  GL_FENCE_CONDITION_NV=: 16b84f4
  GL_READ_BUFFER_NV=: 16b0c02
  GL_ALPHA_TEST_QCOM=: 16b0bc0
  GL_ALPHA_TEST_FUNC_QCOM=: 16b0bc1
  GL_ALPHA_TEST_REF_QCOM=: 16b0bc2
  GL_TEXTURE_WIDTH_QCOM=: 16b8bd2
  GL_TEXTURE_HEIGHT_QCOM=: 16b8bd3
  GL_TEXTURE_DEPTH_QCOM=: 16b8bd4
  GL_TEXTURE_INTERNAL_FORMAT_QCOM=: 16b8bd5
  GL_TEXTURE_FORMAT_QCOM=: 16b8bd6
  GL_TEXTURE_TYPE_QCOM=: 16b8bd7
  GL_TEXTURE_IMAGE_VALID_QCOM=: 16b8bd8
  GL_TEXTURE_NUM_LEVELS_QCOM=: 16b8bd9
  GL_TEXTURE_TARGET_QCOM=: 16b8bda
  GL_TEXTURE_OBJECT_VALID_QCOM=: 16b8bdb
  GL_STATE_RESTORE=: 16b8bdc
  GL_PERFMON_GLOBAL_MODE_QCOM=: 16b8fa0
  GL_WRITEONLY_RENDERING_QCOM=: 16b8823
  GL_COLOR_BUFFER_BIT0_QCOM=: 16b00000001
  GL_COLOR_BUFFER_BIT1_QCOM=: 16b00000002
  GL_COLOR_BUFFER_BIT2_QCOM=: 16b00000004
  GL_COLOR_BUFFER_BIT3_QCOM=: 16b00000008
  GL_COLOR_BUFFER_BIT4_QCOM=: 16b00000010
  GL_COLOR_BUFFER_BIT5_QCOM=: 16b00000020
  GL_COLOR_BUFFER_BIT6_QCOM=: 16b00000040
  GL_COLOR_BUFFER_BIT7_QCOM=: 16b00000080
  GL_DEPTH_BUFFER_BIT0_QCOM=: 16b00000100
  GL_DEPTH_BUFFER_BIT1_QCOM=: 16b00000200
  GL_DEPTH_BUFFER_BIT2_QCOM=: 16b00000400
  GL_DEPTH_BUFFER_BIT3_QCOM=: 16b00000800
  GL_DEPTH_BUFFER_BIT4_QCOM=: 16b00001000
  GL_DEPTH_BUFFER_BIT5_QCOM=: 16b00002000
  GL_DEPTH_BUFFER_BIT6_QCOM=: 16b00004000
  GL_DEPTH_BUFFER_BIT7_QCOM=: 16b00008000
  GL_STENCIL_BUFFER_BIT0_QCOM=: 16b00010000
  GL_STENCIL_BUFFER_BIT1_QCOM=: 16b00020000
  GL_STENCIL_BUFFER_BIT2_QCOM=: 16b00040000
  GL_STENCIL_BUFFER_BIT3_QCOM=: 16b00080000
  GL_STENCIL_BUFFER_BIT4_QCOM=: 16b00100000
  GL_STENCIL_BUFFER_BIT5_QCOM=: 16b00200000
  GL_STENCIL_BUFFER_BIT6_QCOM=: 16b00400000
  GL_STENCIL_BUFFER_BIT7_QCOM=: 16b00800000
  GL_MULTISAMPLE_BUFFER_BIT0_QCOM=: 16b01000000
  GL_MULTISAMPLE_BUFFER_BIT1_QCOM=: 16b02000000
  GL_MULTISAMPLE_BUFFER_BIT2_QCOM=: 16b04000000
  GL_MULTISAMPLE_BUFFER_BIT3_QCOM=: 16b08000000
  GL_MULTISAMPLE_BUFFER_BIT4_QCOM=: 16b10000000
  GL_MULTISAMPLE_BUFFER_BIT5_QCOM=: 16b20000000
  GL_MULTISAMPLE_BUFFER_BIT6_QCOM=: 16b40000000
  GL_MULTISAMPLE_BUFFER_BIT7_QCOM=: 16b80000000
  GL_SHADER_BINARY_VIV=: 16b8fc4
  GL_OES_compressed_ETC1_RGB8_texture=: 1
  GL_OES_compressed_paletted_texture=: 1
  GL_OES_depth24=: 1
  GL_OES_depth32=: 1
  GL_OES_depth_texture=: 1
  GL_OES_EGL_image=: 1
  GL_OES_EGL_image_external=: 1
  GL_OES_element_index_uint=: 1
  GL_OES_fbo_render_mipmap=: 1
  GL_OES_fragment_precision_high=: 1
  GL_OES_get_program_binary=: 1
  GL_OES_mapbuffer=: 1
  GL_OES_packed_depth_stencil=: 1
  GL_OES_rgb8_rgba8=: 1
  GL_OES_standard_derivatives=: 1
  GL_OES_stencil1=: 1
  GL_OES_stencil4=: 1
  GL_OES_texture_3D=: 1
  GL_OES_texture_float=: 1
  GL_OES_texture_float_linear=: 1
  GL_OES_texture_half_float=: 1
  GL_OES_texture_half_float_linear=: 1
  GL_OES_texture_npot=: 1
  GL_OES_vertex_array_object=: 1
  GL_OES_vertex_half_float=: 1
  GL_OES_vertex_type_10_10_10_2=: 1
  GL_AMD_compressed_3DC_texture=: 1
  GL_AMD_compressed_ATC_texture=: 1
  GL_AMD_performance_monitor=: 1
  GL_AMD_program_binary_Z400=: 1
  GL_ANGLE_framebuffer_blit=: 1
  GL_ANGLE_framebuffer_multisample=: 1
  GL_APPLE_rgb_422=: 1
  GL_APPLE_framebuffer_multisample=: 1
  GL_APPLE_texture_format_BGRA8888=: 1
  GL_APPLE_texture_max_level=: 1
  GL_ARM_mali_shader_binary=: 1
  GL_ARM_rgba8=: 1
  GL_EXT_blend_minmax=: 1
  GL_EXT_discard_framebuffer=: 1
  GL_EXT_multi_draw_arrays=: 1
  GL_EXT_read_format_bgra=: 1
  GL_EXT_shader_texture_lod=: 1
  GL_EXT_texture_filter_anisotropic=: 1
  GL_EXT_texture_format_BGRA8888=: 1
  GL_EXT_texture_type_2_10_10_10_REV=: 1
  GL_EXT_texture_compression_dxt1=: 1
  GL_EXT_unpack_subimage=: 1
  GL_DMP_shader_binary=: 1
  GL_IMG_program_binary=: 1
  GL_IMG_read_format=: 1
  GL_IMG_shader_binary=: 1
  GL_IMG_texture_compression_pvrtc=: 1
  GL_IMG_multisampled_render_to_texture=: 1
  GL_NV_coverage_sample=: 1
  GL_NV_depth_nonlinear=: 1
  GL_NV_draw_buffers=: 1
  GL_NV_fbo_color_attachments=: 1
  GL_NV_fence=: 1
  GL_NV_read_buffer=: 1
  GL_NV_read_buffer_front=: 1
  GL_NV_read_depth=: 1
  GL_NV_read_depth_stencil=: 1
  GL_NV_read_stencil=: 1
  GL_NV_texture_compression_s3tc_update=: 1
  GL_NV_texture_npot_2D_mipmap=: 1
  GL_QCOM_alpha_test=: 1
  GL_QCOM_driver_control=: 1
  GL_QCOM_extended_get=: 1
  GL_QCOM_extended_get2=: 1
  GL_QCOM_perfmon_global_mode=: 1
  GL_QCOM_writeonly_rendering=: 1
  GL_QCOM_tiled_rendering=: 1
  GL_VIV_shader_binary=: 1
else.
  GL_ES_VERSION_2_0=: 0
  GL_ARB_imaging=: 1
  GL_FALSE=: 16b0
  GL_TRUE=: 16b1
  GL_BYTE=: 16b1400
  GL_UNSIGNED_BYTE=: 16b1401
  GL_SHORT=: 16b1402
  GL_UNSIGNED_SHORT=: 16b1403
  GL_INT=: 16b1404
  GL_UNSIGNED_INT=: 16b1405
  GL_FLOAT=: 16b1406
  GL_2_BYTES=: 16b1407
  GL_3_BYTES=: 16b1408
  GL_4_BYTES=: 16b1409
  GL_DOUBLE=: 16b140a
  GL_POINTS=: 16b0000
  GL_LINES=: 16b0001
  GL_LINE_LOOP=: 16b0002
  GL_LINE_STRIP=: 16b0003
  GL_TRIANGLES=: 16b0004
  GL_TRIANGLE_STRIP=: 16b0005
  GL_TRIANGLE_FAN=: 16b0006
  GL_QUADS=: 16b0007
  GL_QUAD_STRIP=: 16b0008
  GL_POLYGON=: 16b0009
  GL_VERTEX_ARRAY=: 16b8074
  GL_NORMAL_ARRAY=: 16b8075
  GL_COLOR_ARRAY=: 16b8076
  GL_INDEX_ARRAY=: 16b8077
  GL_TEXTURE_COORD_ARRAY=: 16b8078
  GL_EDGE_FLAG_ARRAY=: 16b8079
  GL_VERTEX_ARRAY_SIZE=: 16b807a
  GL_VERTEX_ARRAY_TYPE=: 16b807b
  GL_VERTEX_ARRAY_STRIDE=: 16b807c
  GL_NORMAL_ARRAY_TYPE=: 16b807e
  GL_NORMAL_ARRAY_STRIDE=: 16b807f
  GL_COLOR_ARRAY_SIZE=: 16b8081
  GL_COLOR_ARRAY_TYPE=: 16b8082
  GL_COLOR_ARRAY_STRIDE=: 16b8083
  GL_INDEX_ARRAY_TYPE=: 16b8085
  GL_INDEX_ARRAY_STRIDE=: 16b8086
  GL_TEXTURE_COORD_ARRAY_SIZE=: 16b8088
  GL_TEXTURE_COORD_ARRAY_TYPE=: 16b8089
  GL_TEXTURE_COORD_ARRAY_STRIDE=: 16b808a
  GL_EDGE_FLAG_ARRAY_STRIDE=: 16b808c
  GL_VERTEX_ARRAY_POINTER=: 16b808e
  GL_NORMAL_ARRAY_POINTER=: 16b808f
  GL_COLOR_ARRAY_POINTER=: 16b8090
  GL_INDEX_ARRAY_POINTER=: 16b8091
  GL_TEXTURE_COORD_ARRAY_POINTER=: 16b8092
  GL_EDGE_FLAG_ARRAY_POINTER=: 16b8093
  GL_V2F=: 16b2a20
  GL_V3F=: 16b2a21
  GL_C4UB_V2F=: 16b2a22
  GL_C4UB_V3F=: 16b2a23
  GL_C3F_V3F=: 16b2a24
  GL_N3F_V3F=: 16b2a25
  GL_C4F_N3F_V3F=: 16b2a26
  GL_T2F_V3F=: 16b2a27
  GL_T4F_V4F=: 16b2a28
  GL_T2F_C4UB_V3F=: 16b2a29
  GL_T2F_C3F_V3F=: 16b2a2a
  GL_T2F_N3F_V3F=: 16b2a2b
  GL_T2F_C4F_N3F_V3F=: 16b2a2c
  GL_T4F_C4F_N3F_V4F=: 16b2a2d
  GL_MATRIX_MODE=: 16b0ba0
  GL_MODELVIEW=: 16b1700
  GL_PROJECTION=: 16b1701
  GL_TEXTURE=: 16b1702
  GL_POINT_SMOOTH=: 16b0b10
  GL_POINT_SIZE=: 16b0b11
  GL_POINT_SIZE_GRANULARITY=: 16b0b13
  GL_POINT_SIZE_RANGE=: 16b0b12
  GL_LINE_SMOOTH=: 16b0b20
  GL_LINE_STIPPLE=: 16b0b24
  GL_LINE_STIPPLE_PATTERN=: 16b0b25
  GL_LINE_STIPPLE_REPEAT=: 16b0b26
  GL_LINE_WIDTH=: 16b0b21
  GL_LINE_WIDTH_GRANULARITY=: 16b0b23
  GL_LINE_WIDTH_RANGE=: 16b0b22
  GL_POINT=: 16b1b00
  GL_LINE=: 16b1b01
  GL_FILL=: 16b1b02
  GL_CW=: 16b0900
  GL_CCW=: 16b0901
  GL_FRONT=: 16b0404
  GL_BACK=: 16b0405
  GL_POLYGON_MODE=: 16b0b40
  GL_POLYGON_SMOOTH=: 16b0b41
  GL_POLYGON_STIPPLE=: 16b0b42
  GL_EDGE_FLAG=: 16b0b43
  GL_CULL_FACE=: 16b0b44
  GL_CULL_FACE_MODE=: 16b0b45
  GL_FRONT_FACE=: 16b0b46
  GL_POLYGON_OFFSET_FACTOR=: 16b8038
  GL_POLYGON_OFFSET_UNITS=: 16b2a00
  GL_POLYGON_OFFSET_POINT=: 16b2a01
  GL_POLYGON_OFFSET_LINE=: 16b2a02
  GL_POLYGON_OFFSET_FILL=: 16b8037
  GL_COMPILE=: 16b1300
  GL_COMPILE_AND_EXECUTE=: 16b1301
  GL_LIST_BASE=: 16b0b32
  GL_LIST_INDEX=: 16b0b33
  GL_LIST_MODE=: 16b0b30
  GL_NEVER=: 16b0200
  GL_LESS=: 16b0201
  GL_EQUAL=: 16b0202
  GL_LEQUAL=: 16b0203
  GL_GREATER=: 16b0204
  GL_NOTEQUAL=: 16b0205
  GL_GEQUAL=: 16b0206
  GL_ALWAYS=: 16b0207
  GL_DEPTH_TEST=: 16b0b71
  GL_DEPTH_BITS=: 16b0d56
  GL_DEPTH_CLEAR_VALUE=: 16b0b73
  GL_DEPTH_FUNC=: 16b0b74
  GL_DEPTH_RANGE=: 16b0b70
  GL_DEPTH_WRITEMASK=: 16b0b72
  GL_DEPTH_COMPONENT=: 16b1902
  GL_LIGHTING=: 16b0b50
  GL_LIGHT0=: 16b4000
  GL_LIGHT1=: 16b4001
  GL_LIGHT2=: 16b4002
  GL_LIGHT3=: 16b4003
  GL_LIGHT4=: 16b4004
  GL_LIGHT5=: 16b4005
  GL_LIGHT6=: 16b4006
  GL_LIGHT7=: 16b4007
  GL_SPOT_EXPONENT=: 16b1205
  GL_SPOT_CUTOFF=: 16b1206
  GL_CONSTANT_ATTENUATION=: 16b1207
  GL_LINEAR_ATTENUATION=: 16b1208
  GL_QUADRATIC_ATTENUATION=: 16b1209
  GL_AMBIENT=: 16b1200
  GL_DIFFUSE=: 16b1201
  GL_SPECULAR=: 16b1202
  GL_SHININESS=: 16b1601
  GL_EMISSION=: 16b1600
  GL_POSITION=: 16b1203
  GL_SPOT_DIRECTION=: 16b1204
  GL_AMBIENT_AND_DIFFUSE=: 16b1602
  GL_COLOR_INDEXES=: 16b1603
  GL_LIGHT_MODEL_TWO_SIDE=: 16b0b52
  GL_LIGHT_MODEL_LOCAL_VIEWER=: 16b0b51
  GL_LIGHT_MODEL_AMBIENT=: 16b0b53
  GL_FRONT_AND_BACK=: 16b0408
  GL_SHADE_MODEL=: 16b0b54
  GL_FLAT=: 16b1d00
  GL_SMOOTH=: 16b1d01
  GL_COLOR_MATERIAL=: 16b0b57
  GL_COLOR_MATERIAL_FACE=: 16b0b55
  GL_COLOR_MATERIAL_PARAMETER=: 16b0b56
  GL_NORMALIZE=: 16b0ba1
  GL_CLIP_PLANE0=: 16b3000
  GL_CLIP_PLANE1=: 16b3001
  GL_CLIP_PLANE2=: 16b3002
  GL_CLIP_PLANE3=: 16b3003
  GL_CLIP_PLANE4=: 16b3004
  GL_CLIP_PLANE5=: 16b3005
  GL_ACCUM_RED_BITS=: 16b0d58
  GL_ACCUM_GREEN_BITS=: 16b0d59
  GL_ACCUM_BLUE_BITS=: 16b0d5a
  GL_ACCUM_ALPHA_BITS=: 16b0d5b
  GL_ACCUM_CLEAR_VALUE=: 16b0b80
  GL_ACCUM=: 16b0100
  GL_ADD=: 16b0104
  GL_LOAD=: 16b0101
  GL_MULT=: 16b0103
  GL_RETURN=: 16b0102
  GL_ALPHA_TEST=: 16b0bc0
  GL_ALPHA_TEST_REF=: 16b0bc2
  GL_ALPHA_TEST_FUNC=: 16b0bc1
  GL_BLEND=: 16b0be2
  GL_BLEND_SRC=: 16b0be1
  GL_BLEND_DST=: 16b0be0
  GL_ZERO=: 16b0
  GL_ONE=: 16b1
  GL_SRC_COLOR=: 16b0300
  GL_ONE_MINUS_SRC_COLOR=: 16b0301
  GL_SRC_ALPHA=: 16b0302
  GL_ONE_MINUS_SRC_ALPHA=: 16b0303
  GL_DST_ALPHA=: 16b0304
  GL_ONE_MINUS_DST_ALPHA=: 16b0305
  GL_DST_COLOR=: 16b0306
  GL_ONE_MINUS_DST_COLOR=: 16b0307
  GL_SRC_ALPHA_SATURATE=: 16b0308
  GL_FEEDBACK=: 16b1c01
  GL_RENDER=: 16b1c00
  GL_SELECT=: 16b1c02
  GL_2D=: 16b0600
  GL_3D=: 16b0601
  GL_3D_COLOR=: 16b0602
  GL_3D_COLOR_TEXTURE=: 16b0603
  GL_4D_COLOR_TEXTURE=: 16b0604
  GL_POINT_TOKEN=: 16b0701
  GL_LINE_TOKEN=: 16b0702
  GL_LINE_RESET_TOKEN=: 16b0707
  GL_POLYGON_TOKEN=: 16b0703
  GL_BITMAP_TOKEN=: 16b0704
  GL_DRAW_PIXEL_TOKEN=: 16b0705
  GL_COPY_PIXEL_TOKEN=: 16b0706
  GL_PASS_THROUGH_TOKEN=: 16b0700
  GL_FEEDBACK_BUFFER_POINTER=: 16b0df0
  GL_FEEDBACK_BUFFER_SIZE=: 16b0df1
  GL_FEEDBACK_BUFFER_TYPE=: 16b0df2
  GL_SELECTION_BUFFER_POINTER=: 16b0df3
  GL_SELECTION_BUFFER_SIZE=: 16b0df4
  GL_FOG=: 16b0b60
  GL_FOG_MODE=: 16b0b65
  GL_FOG_DENSITY=: 16b0b62
  GL_FOG_COLOR=: 16b0b66
  GL_FOG_INDEX=: 16b0b61
  GL_FOG_START=: 16b0b63
  GL_FOG_END=: 16b0b64
  GL_LINEAR=: 16b2601
  GL_EXP=: 16b0800
  GL_EXP2=: 16b0801
  GL_LOGIC_OP=: 16b0bf1
  GL_INDEX_LOGIC_OP=: 16b0bf1
  GL_COLOR_LOGIC_OP=: 16b0bf2
  GL_LOGIC_OP_MODE=: 16b0bf0
  GL_CLEAR=: 16b1500
  GL_SET=: 16b150f
  GL_COPY=: 16b1503
  GL_COPY_INVERTED=: 16b150c
  GL_NOOP=: 16b1505
  GL_INVERT=: 16b150a
  GL_AND=: 16b1501
  GL_NAND=: 16b150e
  GL_OR=: 16b1507
  GL_NOR=: 16b1508
  GL_XOR=: 16b1506
  GL_EQUIV=: 16b1509
  GL_AND_REVERSE=: 16b1502
  GL_AND_INVERTED=: 16b1504
  GL_OR_REVERSE=: 16b150b
  GL_OR_INVERTED=: 16b150d
  GL_STENCIL_BITS=: 16b0d57
  GL_STENCIL_TEST=: 16b0b90
  GL_STENCIL_CLEAR_VALUE=: 16b0b91
  GL_STENCIL_FUNC=: 16b0b92
  GL_STENCIL_VALUE_MASK=: 16b0b93
  GL_STENCIL_FAIL=: 16b0b94
  GL_STENCIL_PASS_DEPTH_FAIL=: 16b0b95
  GL_STENCIL_PASS_DEPTH_PASS=: 16b0b96
  GL_STENCIL_REF=: 16b0b97
  GL_STENCIL_WRITEMASK=: 16b0b98
  GL_STENCIL_INDEX=: 16b1901
  GL_KEEP=: 16b1e00
  GL_REPLACE=: 16b1e01
  GL_INCR=: 16b1e02
  GL_DECR=: 16b1e03
  GL_NONE=: 16b0
  GL_LEFT=: 16b0406
  GL_RIGHT=: 16b0407
  GL_FRONT_LEFT=: 16b0400
  GL_FRONT_RIGHT=: 16b0401
  GL_BACK_LEFT=: 16b0402
  GL_BACK_RIGHT=: 16b0403
  GL_AUX0=: 16b0409
  GL_AUX1=: 16b040a
  GL_AUX2=: 16b040b
  GL_AUX3=: 16b040c
  GL_COLOR_INDEX=: 16b1900
  GL_RED=: 16b1903
  GL_GREEN=: 16b1904
  GL_BLUE=: 16b1905
  GL_ALPHA=: 16b1906
  GL_LUMINANCE=: 16b1909
  GL_LUMINANCE_ALPHA=: 16b190a
  GL_ALPHA_BITS=: 16b0d55
  GL_RED_BITS=: 16b0d52
  GL_GREEN_BITS=: 16b0d53
  GL_BLUE_BITS=: 16b0d54
  GL_INDEX_BITS=: 16b0d51
  GL_SUBPIXEL_BITS=: 16b0d50
  GL_AUX_BUFFERS=: 16b0c00
  GL_READ_BUFFER=: 16b0c02
  GL_DRAW_BUFFER=: 16b0c01
  GL_DOUBLEBUFFER=: 16b0c32
  GL_STEREO=: 16b0c33
  GL_BITMAP=: 16b1a00
  GL_COLOR=: 16b1800
  GL_DEPTH=: 16b1801
  GL_STENCIL=: 16b1802
  GL_DITHER=: 16b0bd0
  GL_RGB=: 16b1907
  GL_RGBA=: 16b1908
  GL_MAX_LIST_NESTING=: 16b0b31
  GL_MAX_EVAL_ORDER=: 16b0d30
  GL_MAX_LIGHTS=: 16b0d31
  GL_MAX_CLIP_PLANES=: 16b0d32
  GL_MAX_TEXTURE_SIZE=: 16b0d33
  GL_MAX_PIXEL_MAP_TABLE=: 16b0d34
  GL_MAX_ATTRIB_STACK_DEPTH=: 16b0d35
  GL_MAX_MODELVIEW_STACK_DEPTH=: 16b0d36
  GL_MAX_NAME_STACK_DEPTH=: 16b0d37
  GL_MAX_PROJECTION_STACK_DEPTH=: 16b0d38
  GL_MAX_TEXTURE_STACK_DEPTH=: 16b0d39
  GL_MAX_VIEWPORT_DIMS=: 16b0d3a
  GL_MAX_CLIENT_ATTRIB_STACK_DEPTH=: 16b0d3b
  GL_ATTRIB_STACK_DEPTH=: 16b0bb0
  GL_CLIENT_ATTRIB_STACK_DEPTH=: 16b0bb1
  GL_COLOR_CLEAR_VALUE=: 16b0c22
  GL_COLOR_WRITEMASK=: 16b0c23
  GL_CURRENT_INDEX=: 16b0b01
  GL_CURRENT_COLOR=: 16b0b00
  GL_CURRENT_NORMAL=: 16b0b02
  GL_CURRENT_RASTER_COLOR=: 16b0b04
  GL_CURRENT_RASTER_DISTANCE=: 16b0b09
  GL_CURRENT_RASTER_INDEX=: 16b0b05
  GL_CURRENT_RASTER_POSITION=: 16b0b07
  GL_CURRENT_RASTER_TEXTURE_COORDS=: 16b0b06
  GL_CURRENT_RASTER_POSITION_VALID=: 16b0b08
  GL_CURRENT_TEXTURE_COORDS=: 16b0b03
  GL_INDEX_CLEAR_VALUE=: 16b0c20
  GL_INDEX_MODE=: 16b0c30
  GL_INDEX_WRITEMASK=: 16b0c21
  GL_MODELVIEW_MATRIX=: 16b0ba6
  GL_MODELVIEW_STACK_DEPTH=: 16b0ba3
  GL_NAME_STACK_DEPTH=: 16b0d70
  GL_PROJECTION_MATRIX=: 16b0ba7
  GL_PROJECTION_STACK_DEPTH=: 16b0ba4
  GL_RENDER_MODE=: 16b0c40
  GL_RGBA_MODE=: 16b0c31
  GL_TEXTURE_MATRIX=: 16b0ba8
  GL_TEXTURE_STACK_DEPTH=: 16b0ba5
  GL_VIEWPORT=: 16b0ba2
  GL_AUTO_NORMAL=: 16b0d80
  GL_MAP1_COLOR_4=: 16b0d90
  GL_MAP1_INDEX=: 16b0d91
  GL_MAP1_NORMAL=: 16b0d92
  GL_MAP1_TEXTURE_COORD_1=: 16b0d93
  GL_MAP1_TEXTURE_COORD_2=: 16b0d94
  GL_MAP1_TEXTURE_COORD_3=: 16b0d95
  GL_MAP1_TEXTURE_COORD_4=: 16b0d96
  GL_MAP1_VERTEX_3=: 16b0d97
  GL_MAP1_VERTEX_4=: 16b0d98
  GL_MAP2_COLOR_4=: 16b0db0
  GL_MAP2_INDEX=: 16b0db1
  GL_MAP2_NORMAL=: 16b0db2
  GL_MAP2_TEXTURE_COORD_1=: 16b0db3
  GL_MAP2_TEXTURE_COORD_2=: 16b0db4
  GL_MAP2_TEXTURE_COORD_3=: 16b0db5
  GL_MAP2_TEXTURE_COORD_4=: 16b0db6
  GL_MAP2_VERTEX_3=: 16b0db7
  GL_MAP2_VERTEX_4=: 16b0db8
  GL_MAP1_GRID_DOMAIN=: 16b0dd0
  GL_MAP1_GRID_SEGMENTS=: 16b0dd1
  GL_MAP2_GRID_DOMAIN=: 16b0dd2
  GL_MAP2_GRID_SEGMENTS=: 16b0dd3
  GL_COEFF=: 16b0a00
  GL_ORDER=: 16b0a01
  GL_DOMAIN=: 16b0a02
  GL_PERSPECTIVE_CORRECTION_HINT=: 16b0c50
  GL_POINT_SMOOTH_HINT=: 16b0c51
  GL_LINE_SMOOTH_HINT=: 16b0c52
  GL_POLYGON_SMOOTH_HINT=: 16b0c53
  GL_FOG_HINT=: 16b0c54
  GL_DONT_CARE=: 16b1100
  GL_FASTEST=: 16b1101
  GL_NICEST=: 16b1102
  GL_SCISSOR_BOX=: 16b0c10
  GL_SCISSOR_TEST=: 16b0c11
  GL_MAP_COLOR=: 16b0d10
  GL_MAP_STENCIL=: 16b0d11
  GL_INDEX_SHIFT=: 16b0d12
  GL_INDEX_OFFSET=: 16b0d13
  GL_RED_SCALE=: 16b0d14
  GL_RED_BIAS=: 16b0d15
  GL_GREEN_SCALE=: 16b0d18
  GL_GREEN_BIAS=: 16b0d19
  GL_BLUE_SCALE=: 16b0d1a
  GL_BLUE_BIAS=: 16b0d1b
  GL_ALPHA_SCALE=: 16b0d1c
  GL_ALPHA_BIAS=: 16b0d1d
  GL_DEPTH_SCALE=: 16b0d1e
  GL_DEPTH_BIAS=: 16b0d1f
  GL_PIXEL_MAP_S_TO_S_SIZE=: 16b0cb1
  GL_PIXEL_MAP_I_TO_I_SIZE=: 16b0cb0
  GL_PIXEL_MAP_I_TO_R_SIZE=: 16b0cb2
  GL_PIXEL_MAP_I_TO_G_SIZE=: 16b0cb3
  GL_PIXEL_MAP_I_TO_B_SIZE=: 16b0cb4
  GL_PIXEL_MAP_I_TO_A_SIZE=: 16b0cb5
  GL_PIXEL_MAP_R_TO_R_SIZE=: 16b0cb6
  GL_PIXEL_MAP_G_TO_G_SIZE=: 16b0cb7
  GL_PIXEL_MAP_B_TO_B_SIZE=: 16b0cb8
  GL_PIXEL_MAP_A_TO_A_SIZE=: 16b0cb9
  GL_PIXEL_MAP_S_TO_S=: 16b0c71
  GL_PIXEL_MAP_I_TO_I=: 16b0c70
  GL_PIXEL_MAP_I_TO_R=: 16b0c72
  GL_PIXEL_MAP_I_TO_G=: 16b0c73
  GL_PIXEL_MAP_I_TO_B=: 16b0c74
  GL_PIXEL_MAP_I_TO_A=: 16b0c75
  GL_PIXEL_MAP_R_TO_R=: 16b0c76
  GL_PIXEL_MAP_G_TO_G=: 16b0c77
  GL_PIXEL_MAP_B_TO_B=: 16b0c78
  GL_PIXEL_MAP_A_TO_A=: 16b0c79
  GL_PACK_ALIGNMENT=: 16b0d05
  GL_PACK_LSB_FIRST=: 16b0d01
  GL_PACK_ROW_LENGTH=: 16b0d02
  GL_PACK_SKIP_PIXELS=: 16b0d04
  GL_PACK_SKIP_ROWS=: 16b0d03
  GL_PACK_SWAP_BYTES=: 16b0d00
  GL_UNPACK_ALIGNMENT=: 16b0cf5
  GL_UNPACK_LSB_FIRST=: 16b0cf1
  GL_UNPACK_ROW_LENGTH=: 16b0cf2
  GL_UNPACK_SKIP_PIXELS=: 16b0cf4
  GL_UNPACK_SKIP_ROWS=: 16b0cf3
  GL_UNPACK_SWAP_BYTES=: 16b0cf0
  GL_ZOOM_X=: 16b0d16
  GL_ZOOM_Y=: 16b0d17
  GL_TEXTURE_ENV=: 16b2300
  GL_TEXTURE_ENV_MODE=: 16b2200
  GL_TEXTURE_1D=: 16b0de0
  GL_TEXTURE_2D=: 16b0de1
  GL_TEXTURE_WRAP_S=: 16b2802
  GL_TEXTURE_WRAP_T=: 16b2803
  GL_TEXTURE_MAG_FILTER=: 16b2800
  GL_TEXTURE_MIN_FILTER=: 16b2801
  GL_TEXTURE_ENV_COLOR=: 16b2201
  GL_TEXTURE_GEN_S=: 16b0c60
  GL_TEXTURE_GEN_T=: 16b0c61
  GL_TEXTURE_GEN_R=: 16b0c62
  GL_TEXTURE_GEN_Q=: 16b0c63
  GL_TEXTURE_GEN_MODE=: 16b2500
  GL_TEXTURE_BORDER_COLOR=: 16b1004
  GL_TEXTURE_WIDTH=: 16b1000
  GL_TEXTURE_HEIGHT=: 16b1001
  GL_TEXTURE_BORDER=: 16b1005
  GL_TEXTURE_COMPONENTS=: 16b1003
  GL_TEXTURE_RED_SIZE=: 16b805c
  GL_TEXTURE_GREEN_SIZE=: 16b805d
  GL_TEXTURE_BLUE_SIZE=: 16b805e
  GL_TEXTURE_ALPHA_SIZE=: 16b805f
  GL_TEXTURE_LUMINANCE_SIZE=: 16b8060
  GL_TEXTURE_INTENSITY_SIZE=: 16b8061
  GL_NEAREST_MIPMAP_NEAREST=: 16b2700
  GL_NEAREST_MIPMAP_LINEAR=: 16b2702
  GL_LINEAR_MIPMAP_NEAREST=: 16b2701
  GL_LINEAR_MIPMAP_LINEAR=: 16b2703
  GL_OBJECT_LINEAR=: 16b2401
  GL_OBJECT_PLANE=: 16b2501
  GL_EYE_LINEAR=: 16b2400
  GL_EYE_PLANE=: 16b2502
  GL_SPHERE_MAP=: 16b2402
  GL_DECAL=: 16b2101
  GL_MODULATE=: 16b2100
  GL_NEAREST=: 16b2600
  GL_REPEAT=: 16b2901
  GL_CLAMP=: 16b2900
  GL_S=: 16b2000
  GL_T=: 16b2001
  GL_R=: 16b2002
  GL_Q=: 16b2003
  GL_VENDOR=: 16b1f00
  GL_RENDERER=: 16b1f01
  GL_VERSION=: 16b1f02
  GL_EXTENSIONS=: 16b1f03
  GL_NO_ERROR=: 16b0
  GL_INVALID_ENUM=: 16b0500
  GL_INVALID_VALUE=: 16b0501
  GL_INVALID_OPERATION=: 16b0502
  GL_STACK_OVERFLOW=: 16b0503
  GL_STACK_UNDERFLOW=: 16b0504
  GL_OUT_OF_MEMORY=: 16b0505
  GL_CURRENT_BIT=: 16b00000001
  GL_POINT_BIT=: 16b00000002
  GL_LINE_BIT=: 16b00000004
  GL_POLYGON_BIT=: 16b00000008
  GL_POLYGON_STIPPLE_BIT=: 16b00000010
  GL_PIXEL_MODE_BIT=: 16b00000020
  GL_LIGHTING_BIT=: 16b00000040
  GL_FOG_BIT=: 16b00000080
  GL_DEPTH_BUFFER_BIT=: 16b00000100
  GL_ACCUM_BUFFER_BIT=: 16b00000200
  GL_STENCIL_BUFFER_BIT=: 16b00000400
  GL_VIEWPORT_BIT=: 16b00000800
  GL_TRANSFORM_BIT=: 16b00001000
  GL_ENABLE_BIT=: 16b00002000
  GL_COLOR_BUFFER_BIT=: 16b00004000
  GL_HINT_BIT=: 16b00008000
  GL_EVAL_BIT=: 16b00010000
  GL_LIST_BIT=: 16b00020000
  GL_TEXTURE_BIT=: 16b00040000
  GL_SCISSOR_BIT=: 16b00080000
  GL_ALL_ATTRIB_BITS=: 16b000fffff
  GL_PROXY_TEXTURE_1D=: 16b8063
  GL_PROXY_TEXTURE_2D=: 16b8064
  GL_TEXTURE_PRIORITY=: 16b8066
  GL_TEXTURE_RESIDENT=: 16b8067
  GL_TEXTURE_BINDING_1D=: 16b8068
  GL_TEXTURE_BINDING_2D=: 16b8069
  GL_TEXTURE_INTERNAL_FORMAT=: 16b1003
  GL_ALPHA4=: 16b803b
  GL_ALPHA8=: 16b803c
  GL_ALPHA12=: 16b803d
  GL_ALPHA16=: 16b803e
  GL_LUMINANCE4=: 16b803f
  GL_LUMINANCE8=: 16b8040
  GL_LUMINANCE12=: 16b8041
  GL_LUMINANCE16=: 16b8042
  GL_LUMINANCE4_ALPHA4=: 16b8043
  GL_LUMINANCE6_ALPHA2=: 16b8044
  GL_LUMINANCE8_ALPHA8=: 16b8045
  GL_LUMINANCE12_ALPHA4=: 16b8046
  GL_LUMINANCE12_ALPHA12=: 16b8047
  GL_LUMINANCE16_ALPHA16=: 16b8048
  GL_INTENSITY=: 16b8049
  GL_INTENSITY4=: 16b804a
  GL_INTENSITY8=: 16b804b
  GL_INTENSITY12=: 16b804c
  GL_INTENSITY16=: 16b804d
  GL_R3_G3_B2=: 16b2a10
  GL_RGB4=: 16b804f
  GL_RGB5=: 16b8050
  GL_RGB8=: 16b8051
  GL_RGB10=: 16b8052
  GL_RGB12=: 16b8053
  GL_RGB16=: 16b8054
  GL_RGBA2=: 16b8055
  GL_RGBA4=: 16b8056
  GL_RGB5_A1=: 16b8057
  GL_RGBA8=: 16b8058
  GL_RGB10_A2=: 16b8059
  GL_RGBA12=: 16b805a
  GL_RGBA16=: 16b805b
  GL_CLIENT_PIXEL_STORE_BIT=: 16b00000001
  GL_CLIENT_VERTEX_ARRAY_BIT=: 16b00000002
  GL_ALL_CLIENT_ATTRIB_BITS=: _1
  GL_CLIENT_ALL_ATTRIB_BITS=: _1
  GL_RESCALE_NORMAL=: 16b803a
  GL_CLAMP_TO_EDGE=: 16b812f
  GL_MAX_ELEMENTS_VERTICES=: 16b80e8
  GL_MAX_ELEMENTS_INDICES=: 16b80e9
  GL_BGR=: 16b80e0
  GL_BGRA=: 16b80e1
  GL_UNSIGNED_BYTE_3_3_2=: 16b8032
  GL_UNSIGNED_BYTE_2_3_3_REV=: 16b8362
  GL_UNSIGNED_SHORT_5_6_5=: 16b8363
  GL_UNSIGNED_SHORT_5_6_5_REV=: 16b8364
  GL_UNSIGNED_SHORT_4_4_4_4=: 16b8033
  GL_UNSIGNED_SHORT_4_4_4_4_REV=: 16b8365
  GL_UNSIGNED_SHORT_5_5_5_1=: 16b8034
  GL_UNSIGNED_SHORT_1_5_5_5_REV=: 16b8366
  GL_UNSIGNED_INT_8_8_8_8=: 16b8035
  GL_UNSIGNED_INT_8_8_8_8_REV=: 16b8367
  GL_UNSIGNED_INT_10_10_10_2=: 16b8036
  GL_UNSIGNED_INT_2_10_10_10_REV=: 16b8368
  GL_LIGHT_MODEL_COLOR_CONTROL=: 16b81f8
  GL_SINGLE_COLOR=: 16b81f9
  GL_SEPARATE_SPECULAR_COLOR=: 16b81fa
  GL_TEXTURE_MIN_LOD=: 16b813a
  GL_TEXTURE_MAX_LOD=: 16b813b
  GL_TEXTURE_BASE_LEVEL=: 16b813c
  GL_TEXTURE_MAX_LEVEL=: 16b813d
  GL_SMOOTH_POINT_SIZE_RANGE=: 16b0b12
  GL_SMOOTH_POINT_SIZE_GRANULARITY=: 16b0b13
  GL_SMOOTH_LINE_WIDTH_RANGE=: 16b0b22
  GL_SMOOTH_LINE_WIDTH_GRANULARITY=: 16b0b23
  GL_ALIASED_POINT_SIZE_RANGE=: 16b846d
  GL_ALIASED_LINE_WIDTH_RANGE=: 16b846e
  GL_PACK_SKIP_IMAGES=: 16b806b
  GL_PACK_IMAGE_HEIGHT=: 16b806c
  GL_UNPACK_SKIP_IMAGES=: 16b806d
  GL_UNPACK_IMAGE_HEIGHT=: 16b806e
  GL_TEXTURE_3D=: 16b806f
  GL_PROXY_TEXTURE_3D=: 16b8070
  GL_TEXTURE_DEPTH=: 16b8071
  GL_TEXTURE_WRAP_R=: 16b8072
  GL_MAX_3D_TEXTURE_SIZE=: 16b8073
  GL_TEXTURE_BINDING_3D=: 16b806a
  GL_CONSTANT_COLOR=: 16b8001
  GL_ONE_MINUS_CONSTANT_COLOR=: 16b8002
  GL_CONSTANT_ALPHA=: 16b8003
  GL_ONE_MINUS_CONSTANT_ALPHA=: 16b8004
  GL_COLOR_TABLE=: 16b80d0
  GL_POST_CONVOLUTION_COLOR_TABLE=: 16b80d1
  GL_POST_COLOR_MATRIX_COLOR_TABLE=: 16b80d2
  GL_PROXY_COLOR_TABLE=: 16b80d3
  GL_PROXY_POST_CONVOLUTION_COLOR_TABLE=: 16b80d4
  GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE=: 16b80d5
  GL_COLOR_TABLE_SCALE=: 16b80d6
  GL_COLOR_TABLE_BIAS=: 16b80d7
  GL_COLOR_TABLE_FORMAT=: 16b80d8
  GL_COLOR_TABLE_WIDTH=: 16b80d9
  GL_COLOR_TABLE_RED_SIZE=: 16b80da
  GL_COLOR_TABLE_GREEN_SIZE=: 16b80db
  GL_COLOR_TABLE_BLUE_SIZE=: 16b80dc
  GL_COLOR_TABLE_ALPHA_SIZE=: 16b80dd
  GL_COLOR_TABLE_LUMINANCE_SIZE=: 16b80de
  GL_COLOR_TABLE_INTENSITY_SIZE=: 16b80df
  GL_CONVOLUTION_1D=: 16b8010
  GL_CONVOLUTION_2D=: 16b8011
  GL_SEPARABLE_2D=: 16b8012
  GL_CONVOLUTION_BORDER_MODE=: 16b8013
  GL_CONVOLUTION_FILTER_SCALE=: 16b8014
  GL_CONVOLUTION_FILTER_BIAS=: 16b8015
  GL_REDUCE=: 16b8016
  GL_CONVOLUTION_FORMAT=: 16b8017
  GL_CONVOLUTION_WIDTH=: 16b8018
  GL_CONVOLUTION_HEIGHT=: 16b8019
  GL_MAX_CONVOLUTION_WIDTH=: 16b801a
  GL_MAX_CONVOLUTION_HEIGHT=: 16b801b
  GL_POST_CONVOLUTION_RED_SCALE=: 16b801c
  GL_POST_CONVOLUTION_GREEN_SCALE=: 16b801d
  GL_POST_CONVOLUTION_BLUE_SCALE=: 16b801e
  GL_POST_CONVOLUTION_ALPHA_SCALE=: 16b801f
  GL_POST_CONVOLUTION_RED_BIAS=: 16b8020
  GL_POST_CONVOLUTION_GREEN_BIAS=: 16b8021
  GL_POST_CONVOLUTION_BLUE_BIAS=: 16b8022
  GL_POST_CONVOLUTION_ALPHA_BIAS=: 16b8023
  GL_CONSTANT_BORDER=: 16b8151
  GL_REPLICATE_BORDER=: 16b8153
  GL_CONVOLUTION_BORDER_COLOR=: 16b8154
  GL_COLOR_MATRIX=: 16b80b1
  GL_COLOR_MATRIX_STACK_DEPTH=: 16b80b2
  GL_MAX_COLOR_MATRIX_STACK_DEPTH=: 16b80b3
  GL_POST_COLOR_MATRIX_RED_SCALE=: 16b80b4
  GL_POST_COLOR_MATRIX_GREEN_SCALE=: 16b80b5
  GL_POST_COLOR_MATRIX_BLUE_SCALE=: 16b80b6
  GL_POST_COLOR_MATRIX_ALPHA_SCALE=: 16b80b7
  GL_POST_COLOR_MATRIX_RED_BIAS=: 16b80b8
  GL_POST_COLOR_MATRIX_GREEN_BIAS=: 16b80b9
  GL_POST_COLOR_MATRIX_BLUE_BIAS=: 16b80ba
  GL_POST_COLOR_MATRIX_ALPHA_BIAS=: 16b80bb
  GL_HISTOGRAM=: 16b8024
  GL_PROXY_HISTOGRAM=: 16b8025
  GL_HISTOGRAM_WIDTH=: 16b8026
  GL_HISTOGRAM_FORMAT=: 16b8027
  GL_HISTOGRAM_RED_SIZE=: 16b8028
  GL_HISTOGRAM_GREEN_SIZE=: 16b8029
  GL_HISTOGRAM_BLUE_SIZE=: 16b802a
  GL_HISTOGRAM_ALPHA_SIZE=: 16b802b
  GL_HISTOGRAM_LUMINANCE_SIZE=: 16b802c
  GL_HISTOGRAM_SINK=: 16b802d
  GL_MINMAX=: 16b802e
  GL_MINMAX_FORMAT=: 16b802f
  GL_MINMAX_SINK=: 16b8030
  GL_TABLE_TOO_LARGE=: 16b8031
  GL_BLEND_EQUATION=: 16b8009
  GL_MIN=: 16b8007
  GL_MAX=: 16b8008
  GL_FUNC_ADD=: 16b8006
  GL_FUNC_SUBTRACT=: 16b800a
  GL_FUNC_REVERSE_SUBTRACT=: 16b800b
  GL_BLEND_COLOR=: 16b8005
  GL_TEXTURE0=: 16b84c0
  GL_TEXTURE1=: 16b84c1
  GL_TEXTURE2=: 16b84c2
  GL_TEXTURE3=: 16b84c3
  GL_TEXTURE4=: 16b84c4
  GL_TEXTURE5=: 16b84c5
  GL_TEXTURE6=: 16b84c6
  GL_TEXTURE7=: 16b84c7
  GL_TEXTURE8=: 16b84c8
  GL_TEXTURE9=: 16b84c9
  GL_TEXTURE10=: 16b84ca
  GL_TEXTURE11=: 16b84cb
  GL_TEXTURE12=: 16b84cc
  GL_TEXTURE13=: 16b84cd
  GL_TEXTURE14=: 16b84ce
  GL_TEXTURE15=: 16b84cf
  GL_TEXTURE16=: 16b84d0
  GL_TEXTURE17=: 16b84d1
  GL_TEXTURE18=: 16b84d2
  GL_TEXTURE19=: 16b84d3
  GL_TEXTURE20=: 16b84d4
  GL_TEXTURE21=: 16b84d5
  GL_TEXTURE22=: 16b84d6
  GL_TEXTURE23=: 16b84d7
  GL_TEXTURE24=: 16b84d8
  GL_TEXTURE25=: 16b84d9
  GL_TEXTURE26=: 16b84da
  GL_TEXTURE27=: 16b84db
  GL_TEXTURE28=: 16b84dc
  GL_TEXTURE29=: 16b84dd
  GL_TEXTURE30=: 16b84de
  GL_TEXTURE31=: 16b84df
  GL_ACTIVE_TEXTURE=: 16b84e0
  GL_CLIENT_ACTIVE_TEXTURE=: 16b84e1
  GL_MAX_TEXTURE_UNITS=: 16b84e2
  GL_NORMAL_MAP=: 16b8511
  GL_REFLECTION_MAP=: 16b8512
  GL_TEXTURE_CUBE_MAP=: 16b8513
  GL_TEXTURE_BINDING_CUBE_MAP=: 16b8514
  GL_TEXTURE_CUBE_MAP_POSITIVE_X=: 16b8515
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X=: 16b8516
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y=: 16b8517
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y=: 16b8518
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z=: 16b8519
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z=: 16b851a
  GL_PROXY_TEXTURE_CUBE_MAP=: 16b851b
  GL_MAX_CUBE_MAP_TEXTURE_SIZE=: 16b851c
  GL_COMPRESSED_ALPHA=: 16b84e9
  GL_COMPRESSED_LUMINANCE=: 16b84ea
  GL_COMPRESSED_LUMINANCE_ALPHA=: 16b84eb
  GL_COMPRESSED_INTENSITY=: 16b84ec
  GL_COMPRESSED_RGB=: 16b84ed
  GL_COMPRESSED_RGBA=: 16b84ee
  GL_TEXTURE_COMPRESSION_HINT=: 16b84ef
  GL_TEXTURE_COMPRESSED_IMAGE_SIZE=: 16b86a0
  GL_TEXTURE_COMPRESSED=: 16b86a1
  GL_NUM_COMPRESSED_TEXTURE_FORMATS=: 16b86a2
  GL_COMPRESSED_TEXTURE_FORMATS=: 16b86a3
  GL_MULTISAMPLE=: 16b809d
  GL_SAMPLE_ALPHA_TO_COVERAGE=: 16b809e
  GL_SAMPLE_ALPHA_TO_ONE=: 16b809f
  GL_SAMPLE_COVERAGE=: 16b80a0
  GL_SAMPLE_BUFFERS=: 16b80a8
  GL_SAMPLES=: 16b80a9
  GL_SAMPLE_COVERAGE_VALUE=: 16b80aa
  GL_SAMPLE_COVERAGE_INVERT=: 16b80ab
  GL_MULTISAMPLE_BIT=: 16b20000000
  GL_TRANSPOSE_MODELVIEW_MATRIX=: 16b84e3
  GL_TRANSPOSE_PROJECTION_MATRIX=: 16b84e4
  GL_TRANSPOSE_TEXTURE_MATRIX=: 16b84e5
  GL_TRANSPOSE_COLOR_MATRIX=: 16b84e6
  GL_COMBINE=: 16b8570
  GL_COMBINE_RGB=: 16b8571
  GL_COMBINE_ALPHA=: 16b8572
  GL_SOURCE0_RGB=: 16b8580
  GL_SOURCE1_RGB=: 16b8581
  GL_SOURCE2_RGB=: 16b8582
  GL_SOURCE0_ALPHA=: 16b8588
  GL_SOURCE1_ALPHA=: 16b8589
  GL_SOURCE2_ALPHA=: 16b858a
  GL_OPERAND0_RGB=: 16b8590
  GL_OPERAND1_RGB=: 16b8591
  GL_OPERAND2_RGB=: 16b8592
  GL_OPERAND0_ALPHA=: 16b8598
  GL_OPERAND1_ALPHA=: 16b8599
  GL_OPERAND2_ALPHA=: 16b859a
  GL_RGB_SCALE=: 16b8573
  GL_ADD_SIGNED=: 16b8574
  GL_INTERPOLATE=: 16b8575
  GL_SUBTRACT=: 16b84e7
  GL_CONSTANT=: 16b8576
  GL_PRIMARY_COLOR=: 16b8577
  GL_PREVIOUS=: 16b8578
  GL_DOT3_RGB=: 16b86ae
  GL_DOT3_RGBA=: 16b86af
  GL_CLAMP_TO_BORDER=: 16b812d
  GL_ARB_multitexture=: 1
  GL_TEXTURE0_ARB=: 16b84c0
  GL_TEXTURE1_ARB=: 16b84c1
  GL_TEXTURE2_ARB=: 16b84c2
  GL_TEXTURE3_ARB=: 16b84c3
  GL_TEXTURE4_ARB=: 16b84c4
  GL_TEXTURE5_ARB=: 16b84c5
  GL_TEXTURE6_ARB=: 16b84c6
  GL_TEXTURE7_ARB=: 16b84c7
  GL_TEXTURE8_ARB=: 16b84c8
  GL_TEXTURE9_ARB=: 16b84c9
  GL_TEXTURE10_ARB=: 16b84ca
  GL_TEXTURE11_ARB=: 16b84cb
  GL_TEXTURE12_ARB=: 16b84cc
  GL_TEXTURE13_ARB=: 16b84cd
  GL_TEXTURE14_ARB=: 16b84ce
  GL_TEXTURE15_ARB=: 16b84cf
  GL_TEXTURE16_ARB=: 16b84d0
  GL_TEXTURE17_ARB=: 16b84d1
  GL_TEXTURE18_ARB=: 16b84d2
  GL_TEXTURE19_ARB=: 16b84d3
  GL_TEXTURE20_ARB=: 16b84d4
  GL_TEXTURE21_ARB=: 16b84d5
  GL_TEXTURE22_ARB=: 16b84d6
  GL_TEXTURE23_ARB=: 16b84d7
  GL_TEXTURE24_ARB=: 16b84d8
  GL_TEXTURE25_ARB=: 16b84d9
  GL_TEXTURE26_ARB=: 16b84da
  GL_TEXTURE27_ARB=: 16b84db
  GL_TEXTURE28_ARB=: 16b84dc
  GL_TEXTURE29_ARB=: 16b84dd
  GL_TEXTURE30_ARB=: 16b84de
  GL_TEXTURE31_ARB=: 16b84df
  GL_ACTIVE_TEXTURE_ARB=: 16b84e0
  GL_CLIENT_ACTIVE_TEXTURE_ARB=: 16b84e1
  GL_MAX_TEXTURE_UNITS_ARB=: 16b84e2
  GL_MESA_shader_debug=: 1
  GL_DEBUG_OBJECT_MESA=: 16b8759
  GL_DEBUG_PRINT_MESA=: 16b875a
  GL_DEBUG_ASSERT_MESA=: 16b875b
  GL_MESA_packed_depth_stencil=: 1
  GL_DEPTH_STENCIL_MESA=: 16b8750
  GL_UNSIGNED_INT_24_8_MESA=: 16b8751
  GL_UNSIGNED_INT_8_24_REV_MESA=: 16b8752
  GL_UNSIGNED_SHORT_15_1_MESA=: 16b8753
  GL_UNSIGNED_SHORT_1_15_REV_MESA=: 16b8754
  GL_MESA_program_debug=: 1
  GL_FRAGMENT_PROGRAM_POSITION_MESA=: 16b8bb0
  GL_FRAGMENT_PROGRAM_CALLBACK_MESA=: 16b8bb1
  GL_FRAGMENT_PROGRAM_CALLBACK_FUNC_MESA=: 16b8bb2
  GL_FRAGMENT_PROGRAM_CALLBACK_DATA_MESA=: 16b8bb3
  GL_VERTEX_PROGRAM_POSITION_MESA=: 16b8bb4
  GL_VERTEX_PROGRAM_CALLBACK_MESA=: 16b8bb5
  GL_VERTEX_PROGRAM_CALLBACK_FUNC_MESA=: 16b8bb6
  GL_VERTEX_PROGRAM_CALLBACK_DATA_MESA=: 16b8bb7
  GL_MESA_texture_array=: 1
  GL_TEXTURE_1D_ARRAY_EXT=: 16b8c18
  GL_PROXY_TEXTURE_1D_ARRAY_EXT=: 16b8c19
  GL_TEXTURE_2D_ARRAY_EXT=: 16b8c1a
  GL_PROXY_TEXTURE_2D_ARRAY_EXT=: 16b8c1b
  GL_TEXTURE_BINDING_1D_ARRAY_EXT=: 16b8c1c
  GL_TEXTURE_BINDING_2D_ARRAY_EXT=: 16b8c1d
  GL_MAX_ARRAY_TEXTURE_LAYERS_EXT=: 16b88ff
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT=: 16b8cd4
  GL_ATI_blend_equation_separate=: 1
  GL_ALPHA_BLEND_EQUATION_ATI=: 16b883d
  GL_OES_EGL_image=: 1
  GL_UNSIGNED_BYTE_3_3_2=: 16b8032
  GL_UNSIGNED_SHORT_4_4_4_4=: 16b8033
  GL_UNSIGNED_SHORT_5_5_5_1=: 16b8034
  GL_UNSIGNED_INT_8_8_8_8=: 16b8035
  GL_UNSIGNED_INT_10_10_10_2=: 16b8036
  GL_TEXTURE_BINDING_3D=: 16b806a
  GL_PACK_SKIP_IMAGES=: 16b806b
  GL_PACK_IMAGE_HEIGHT=: 16b806c
  GL_UNPACK_SKIP_IMAGES=: 16b806d
  GL_UNPACK_IMAGE_HEIGHT=: 16b806e
  GL_TEXTURE_3D=: 16b806f
  GL_PROXY_TEXTURE_3D=: 16b8070
  GL_TEXTURE_DEPTH=: 16b8071
  GL_TEXTURE_WRAP_R=: 16b8072
  GL_MAX_3D_TEXTURE_SIZE=: 16b8073
  GL_UNSIGNED_BYTE_2_3_3_REV=: 16b8362
  GL_UNSIGNED_SHORT_5_6_5=: 16b8363
  GL_UNSIGNED_SHORT_5_6_5_REV=: 16b8364
  GL_UNSIGNED_SHORT_4_4_4_4_REV=: 16b8365
  GL_UNSIGNED_SHORT_1_5_5_5_REV=: 16b8366
  GL_UNSIGNED_INT_8_8_8_8_REV=: 16b8367
  GL_UNSIGNED_INT_2_10_10_10_REV=: 16b8368
  GL_BGR=: 16b80e0
  GL_BGRA=: 16b80e1
  GL_MAX_ELEMENTS_VERTICES=: 16b80e8
  GL_MAX_ELEMENTS_INDICES=: 16b80e9
  GL_CLAMP_TO_EDGE=: 16b812f
  GL_TEXTURE_MIN_LOD=: 16b813a
  GL_TEXTURE_MAX_LOD=: 16b813b
  GL_TEXTURE_BASE_LEVEL=: 16b813c
  GL_TEXTURE_MAX_LEVEL=: 16b813d
  GL_SMOOTH_POINT_SIZE_RANGE=: 16b0b12
  GL_SMOOTH_POINT_SIZE_GRANULARITY=: 16b0b13
  GL_SMOOTH_LINE_WIDTH_RANGE=: 16b0b22
  GL_SMOOTH_LINE_WIDTH_GRANULARITY=: 16b0b23
  GL_ALIASED_LINE_WIDTH_RANGE=: 16b846e
  GL_RESCALE_NORMAL=: 16b803a
  GL_LIGHT_MODEL_COLOR_CONTROL=: 16b81f8
  GL_SINGLE_COLOR=: 16b81f9
  GL_SEPARATE_SPECULAR_COLOR=: 16b81fa
  GL_ALIASED_POINT_SIZE_RANGE=: 16b846d
  GL_CONSTANT_COLOR=: 16b8001
  GL_ONE_MINUS_CONSTANT_COLOR=: 16b8002
  GL_CONSTANT_ALPHA=: 16b8003
  GL_ONE_MINUS_CONSTANT_ALPHA=: 16b8004
  GL_BLEND_COLOR=: 16b8005
  GL_FUNC_ADD=: 16b8006
  GL_MIN=: 16b8007
  GL_MAX=: 16b8008
  GL_BLEND_EQUATION=: 16b8009
  GL_FUNC_SUBTRACT=: 16b800a
  GL_FUNC_REVERSE_SUBTRACT=: 16b800b
  GL_CONVOLUTION_1D=: 16b8010
  GL_CONVOLUTION_2D=: 16b8011
  GL_SEPARABLE_2D=: 16b8012
  GL_CONVOLUTION_BORDER_MODE=: 16b8013
  GL_CONVOLUTION_FILTER_SCALE=: 16b8014
  GL_CONVOLUTION_FILTER_BIAS=: 16b8015
  GL_REDUCE=: 16b8016
  GL_CONVOLUTION_FORMAT=: 16b8017
  GL_CONVOLUTION_WIDTH=: 16b8018
  GL_CONVOLUTION_HEIGHT=: 16b8019
  GL_MAX_CONVOLUTION_WIDTH=: 16b801a
  GL_MAX_CONVOLUTION_HEIGHT=: 16b801b
  GL_POST_CONVOLUTION_RED_SCALE=: 16b801c
  GL_POST_CONVOLUTION_GREEN_SCALE=: 16b801d
  GL_POST_CONVOLUTION_BLUE_SCALE=: 16b801e
  GL_POST_CONVOLUTION_ALPHA_SCALE=: 16b801f
  GL_POST_CONVOLUTION_RED_BIAS=: 16b8020
  GL_POST_CONVOLUTION_GREEN_BIAS=: 16b8021
  GL_POST_CONVOLUTION_BLUE_BIAS=: 16b8022
  GL_POST_CONVOLUTION_ALPHA_BIAS=: 16b8023
  GL_HISTOGRAM=: 16b8024
  GL_PROXY_HISTOGRAM=: 16b8025
  GL_HISTOGRAM_WIDTH=: 16b8026
  GL_HISTOGRAM_FORMAT=: 16b8027
  GL_HISTOGRAM_RED_SIZE=: 16b8028
  GL_HISTOGRAM_GREEN_SIZE=: 16b8029
  GL_HISTOGRAM_BLUE_SIZE=: 16b802a
  GL_HISTOGRAM_ALPHA_SIZE=: 16b802b
  GL_HISTOGRAM_LUMINANCE_SIZE=: 16b802c
  GL_HISTOGRAM_SINK=: 16b802d
  GL_MINMAX=: 16b802e
  GL_MINMAX_FORMAT=: 16b802f
  GL_MINMAX_SINK=: 16b8030
  GL_TABLE_TOO_LARGE=: 16b8031
  GL_COLOR_MATRIX=: 16b80b1
  GL_COLOR_MATRIX_STACK_DEPTH=: 16b80b2
  GL_MAX_COLOR_MATRIX_STACK_DEPTH=: 16b80b3
  GL_POST_COLOR_MATRIX_RED_SCALE=: 16b80b4
  GL_POST_COLOR_MATRIX_GREEN_SCALE=: 16b80b5
  GL_POST_COLOR_MATRIX_BLUE_SCALE=: 16b80b6
  GL_POST_COLOR_MATRIX_ALPHA_SCALE=: 16b80b7
  GL_POST_COLOR_MATRIX_RED_BIAS=: 16b80b8
  GL_POST_COLOR_MATRIX_GREEN_BIAS=: 16b80b9
  GL_POST_COLOR_MATRIX_BLUE_BIAS=: 16b80ba
  GL_POST_COLOR_MATRIX_ALPHA_BIAS=: 16b80bb
  GL_COLOR_TABLE=: 16b80d0
  GL_POST_CONVOLUTION_COLOR_TABLE=: 16b80d1
  GL_POST_COLOR_MATRIX_COLOR_TABLE=: 16b80d2
  GL_PROXY_COLOR_TABLE=: 16b80d3
  GL_PROXY_POST_CONVOLUTION_COLOR_TABLE=: 16b80d4
  GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE=: 16b80d5
  GL_COLOR_TABLE_SCALE=: 16b80d6
  GL_COLOR_TABLE_BIAS=: 16b80d7
  GL_COLOR_TABLE_FORMAT=: 16b80d8
  GL_COLOR_TABLE_WIDTH=: 16b80d9
  GL_COLOR_TABLE_RED_SIZE=: 16b80da
  GL_COLOR_TABLE_GREEN_SIZE=: 16b80db
  GL_COLOR_TABLE_BLUE_SIZE=: 16b80dc
  GL_COLOR_TABLE_ALPHA_SIZE=: 16b80dd
  GL_COLOR_TABLE_LUMINANCE_SIZE=: 16b80de
  GL_COLOR_TABLE_INTENSITY_SIZE=: 16b80df
  GL_CONSTANT_BORDER=: 16b8151
  GL_REPLICATE_BORDER=: 16b8153
  GL_CONVOLUTION_BORDER_COLOR=: 16b8154
  GL_TEXTURE0=: 16b84c0
  GL_TEXTURE1=: 16b84c1
  GL_TEXTURE2=: 16b84c2
  GL_TEXTURE3=: 16b84c3
  GL_TEXTURE4=: 16b84c4
  GL_TEXTURE5=: 16b84c5
  GL_TEXTURE6=: 16b84c6
  GL_TEXTURE7=: 16b84c7
  GL_TEXTURE8=: 16b84c8
  GL_TEXTURE9=: 16b84c9
  GL_TEXTURE10=: 16b84ca
  GL_TEXTURE11=: 16b84cb
  GL_TEXTURE12=: 16b84cc
  GL_TEXTURE13=: 16b84cd
  GL_TEXTURE14=: 16b84ce
  GL_TEXTURE15=: 16b84cf
  GL_TEXTURE16=: 16b84d0
  GL_TEXTURE17=: 16b84d1
  GL_TEXTURE18=: 16b84d2
  GL_TEXTURE19=: 16b84d3
  GL_TEXTURE20=: 16b84d4
  GL_TEXTURE21=: 16b84d5
  GL_TEXTURE22=: 16b84d6
  GL_TEXTURE23=: 16b84d7
  GL_TEXTURE24=: 16b84d8
  GL_TEXTURE25=: 16b84d9
  GL_TEXTURE26=: 16b84da
  GL_TEXTURE27=: 16b84db
  GL_TEXTURE28=: 16b84dc
  GL_TEXTURE29=: 16b84dd
  GL_TEXTURE30=: 16b84de
  GL_TEXTURE31=: 16b84df
  GL_ACTIVE_TEXTURE=: 16b84e0
  GL_MULTISAMPLE=: 16b809d
  GL_SAMPLE_ALPHA_TO_COVERAGE=: 16b809e
  GL_SAMPLE_ALPHA_TO_ONE=: 16b809f
  GL_SAMPLE_COVERAGE=: 16b80a0
  GL_SAMPLE_BUFFERS=: 16b80a8
  GL_SAMPLES=: 16b80a9
  GL_SAMPLE_COVERAGE_VALUE=: 16b80aa
  GL_SAMPLE_COVERAGE_INVERT=: 16b80ab
  GL_TEXTURE_CUBE_MAP=: 16b8513
  GL_TEXTURE_BINDING_CUBE_MAP=: 16b8514
  GL_TEXTURE_CUBE_MAP_POSITIVE_X=: 16b8515
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X=: 16b8516
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y=: 16b8517
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y=: 16b8518
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z=: 16b8519
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z=: 16b851a
  GL_PROXY_TEXTURE_CUBE_MAP=: 16b851b
  GL_MAX_CUBE_MAP_TEXTURE_SIZE=: 16b851c
  GL_COMPRESSED_RGB=: 16b84ed
  GL_COMPRESSED_RGBA=: 16b84ee
  GL_TEXTURE_COMPRESSION_HINT=: 16b84ef
  GL_TEXTURE_COMPRESSED_IMAGE_SIZE=: 16b86a0
  GL_TEXTURE_COMPRESSED=: 16b86a1
  GL_NUM_COMPRESSED_TEXTURE_FORMATS=: 16b86a2
  GL_COMPRESSED_TEXTURE_FORMATS=: 16b86a3
  GL_CLAMP_TO_BORDER=: 16b812d
  GL_CLIENT_ACTIVE_TEXTURE=: 16b84e1
  GL_MAX_TEXTURE_UNITS=: 16b84e2
  GL_TRANSPOSE_MODELVIEW_MATRIX=: 16b84e3
  GL_TRANSPOSE_PROJECTION_MATRIX=: 16b84e4
  GL_TRANSPOSE_TEXTURE_MATRIX=: 16b84e5
  GL_TRANSPOSE_COLOR_MATRIX=: 16b84e6
  GL_MULTISAMPLE_BIT=: 16b20000000
  GL_NORMAL_MAP=: 16b8511
  GL_REFLECTION_MAP=: 16b8512
  GL_COMPRESSED_ALPHA=: 16b84e9
  GL_COMPRESSED_LUMINANCE=: 16b84ea
  GL_COMPRESSED_LUMINANCE_ALPHA=: 16b84eb
  GL_COMPRESSED_INTENSITY=: 16b84ec
  GL_COMBINE=: 16b8570
  GL_COMBINE_RGB=: 16b8571
  GL_COMBINE_ALPHA=: 16b8572
  GL_SOURCE0_RGB=: 16b8580
  GL_SOURCE1_RGB=: 16b8581
  GL_SOURCE2_RGB=: 16b8582
  GL_SOURCE0_ALPHA=: 16b8588
  GL_SOURCE1_ALPHA=: 16b8589
  GL_SOURCE2_ALPHA=: 16b858a
  GL_OPERAND0_RGB=: 16b8590
  GL_OPERAND1_RGB=: 16b8591
  GL_OPERAND2_RGB=: 16b8592
  GL_OPERAND0_ALPHA=: 16b8598
  GL_OPERAND1_ALPHA=: 16b8599
  GL_OPERAND2_ALPHA=: 16b859a
  GL_RGB_SCALE=: 16b8573
  GL_ADD_SIGNED=: 16b8574
  GL_INTERPOLATE=: 16b8575
  GL_SUBTRACT=: 16b84e7
  GL_CONSTANT=: 16b8576
  GL_PRIMARY_COLOR=: 16b8577
  GL_PREVIOUS=: 16b8578
  GL_DOT3_RGB=: 16b86ae
  GL_DOT3_RGBA=: 16b86af
  GL_BLEND_DST_RGB=: 16b80c8
  GL_BLEND_SRC_RGB=: 16b80c9
  GL_BLEND_DST_ALPHA=: 16b80ca
  GL_BLEND_SRC_ALPHA=: 16b80cb
  GL_POINT_FADE_THRESHOLD_SIZE=: 16b8128
  GL_DEPTH_COMPONENT16=: 16b81a5
  GL_DEPTH_COMPONENT24=: 16b81a6
  GL_DEPTH_COMPONENT32=: 16b81a7
  GL_MIRRORED_REPEAT=: 16b8370
  GL_MAX_TEXTURE_LOD_BIAS=: 16b84fd
  GL_TEXTURE_LOD_BIAS=: 16b8501
  GL_INCR_WRAP=: 16b8507
  GL_DECR_WRAP=: 16b8508
  GL_TEXTURE_DEPTH_SIZE=: 16b884a
  GL_TEXTURE_COMPARE_MODE=: 16b884c
  GL_TEXTURE_COMPARE_FUNC=: 16b884d
  GL_POINT_SIZE_MIN=: 16b8126
  GL_POINT_SIZE_MAX=: 16b8127
  GL_POINT_DISTANCE_ATTENUATION=: 16b8129
  GL_GENERATE_MIPMAP=: 16b8191
  GL_GENERATE_MIPMAP_HINT=: 16b8192
  GL_FOG_COORDINATE_SOURCE=: 16b8450
  GL_FOG_COORDINATE=: 16b8451
  GL_FRAGMENT_DEPTH=: 16b8452
  GL_CURRENT_FOG_COORDINATE=: 16b8453
  GL_FOG_COORDINATE_ARRAY_TYPE=: 16b8454
  GL_FOG_COORDINATE_ARRAY_STRIDE=: 16b8455
  GL_FOG_COORDINATE_ARRAY_POINTER=: 16b8456
  GL_FOG_COORDINATE_ARRAY=: 16b8457
  GL_COLOR_SUM=: 16b8458
  GL_CURRENT_SECONDARY_COLOR=: 16b8459
  GL_SECONDARY_COLOR_ARRAY_SIZE=: 16b845a
  GL_SECONDARY_COLOR_ARRAY_TYPE=: 16b845b
  GL_SECONDARY_COLOR_ARRAY_STRIDE=: 16b845c
  GL_SECONDARY_COLOR_ARRAY_POINTER=: 16b845d
  GL_SECONDARY_COLOR_ARRAY=: 16b845e
  GL_TEXTURE_FILTER_CONTROL=: 16b8500
  GL_DEPTH_TEXTURE_MODE=: 16b884b
  GL_COMPARE_R_TO_TEXTURE=: 16b884e
  GL_BUFFER_SIZE=: 16b8764
  GL_BUFFER_USAGE=: 16b8765
  GL_QUERY_COUNTER_BITS=: 16b8864
  GL_CURRENT_QUERY=: 16b8865
  GL_QUERY_RESULT=: 16b8866
  GL_QUERY_RESULT_AVAILABLE=: 16b8867
  GL_ARRAY_BUFFER=: 16b8892
  GL_ELEMENT_ARRAY_BUFFER=: 16b8893
  GL_ARRAY_BUFFER_BINDING=: 16b8894
  GL_ELEMENT_ARRAY_BUFFER_BINDING=: 16b8895
  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING=: 16b889f
  GL_READ_ONLY=: 16b88b8
  GL_WRITE_ONLY=: 16b88b9
  GL_READ_WRITE=: 16b88ba
  GL_BUFFER_ACCESS=: 16b88bb
  GL_BUFFER_MAPPED=: 16b88bc
  GL_BUFFER_MAP_POINTER=: 16b88bd
  GL_STREAM_DRAW=: 16b88e0
  GL_STREAM_READ=: 16b88e1
  GL_STREAM_COPY=: 16b88e2
  GL_STATIC_DRAW=: 16b88e4
  GL_STATIC_READ=: 16b88e5
  GL_STATIC_COPY=: 16b88e6
  GL_DYNAMIC_DRAW=: 16b88e8
  GL_DYNAMIC_READ=: 16b88e9
  GL_DYNAMIC_COPY=: 16b88ea
  GL_SAMPLES_PASSED=: 16b8914
  GL_VERTEX_ARRAY_BUFFER_BINDING=: 16b8896
  GL_NORMAL_ARRAY_BUFFER_BINDING=: 16b8897
  GL_COLOR_ARRAY_BUFFER_BINDING=: 16b8898
  GL_INDEX_ARRAY_BUFFER_BINDING=: 16b8899
  GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING=: 16b889a
  GL_EDGE_FLAG_ARRAY_BUFFER_BINDING=: 16b889b
  GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING=: 16b889c
  GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING=: 16b889d
  GL_WEIGHT_ARRAY_BUFFER_BINDING=: 16b889e
  GL_FOG_COORD_SRC=: 16b8450
  GL_FOG_COORD=: 16b8451
  GL_CURRENT_FOG_COORD=: 16b8453
  GL_FOG_COORD_ARRAY_TYPE=: 16b8454
  GL_FOG_COORD_ARRAY_STRIDE=: 16b8455
  GL_FOG_COORD_ARRAY_POINTER=: 16b8456
  GL_FOG_COORD_ARRAY=: 16b8457
  GL_FOG_COORD_ARRAY_BUFFER_BINDING=: 16b889d
  GL_SRC0_RGB=: 16b8580
  GL_SRC1_RGB=: 16b8581
  GL_SRC2_RGB=: 16b8582
  GL_SRC0_ALPHA=: 16b8588
  GL_SRC1_ALPHA=: 16b8589
  GL_SRC2_ALPHA=: 16b858a
  GL_BLEND_EQUATION_RGB=: 16b8009
  GL_VERTEX_ATTRIB_ARRAY_ENABLED=: 16b8622
  GL_VERTEX_ATTRIB_ARRAY_SIZE=: 16b8623
  GL_VERTEX_ATTRIB_ARRAY_STRIDE=: 16b8624
  GL_VERTEX_ATTRIB_ARRAY_TYPE=: 16b8625
  GL_CURRENT_VERTEX_ATTRIB=: 16b8626
  GL_VERTEX_PROGRAM_POINT_SIZE=: 16b8642
  GL_VERTEX_ATTRIB_ARRAY_POINTER=: 16b8645
  GL_STENCIL_BACK_FUNC=: 16b8800
  GL_STENCIL_BACK_FAIL=: 16b8801
  GL_STENCIL_BACK_PASS_DEPTH_FAIL=: 16b8802
  GL_STENCIL_BACK_PASS_DEPTH_PASS=: 16b8803
  GL_MAX_DRAW_BUFFERS=: 16b8824
  GL_DRAW_BUFFER0=: 16b8825
  GL_DRAW_BUFFER1=: 16b8826
  GL_DRAW_BUFFER2=: 16b8827
  GL_DRAW_BUFFER3=: 16b8828
  GL_DRAW_BUFFER4=: 16b8829
  GL_DRAW_BUFFER5=: 16b882a
  GL_DRAW_BUFFER6=: 16b882b
  GL_DRAW_BUFFER7=: 16b882c
  GL_DRAW_BUFFER8=: 16b882d
  GL_DRAW_BUFFER9=: 16b882e
  GL_DRAW_BUFFER10=: 16b882f
  GL_DRAW_BUFFER11=: 16b8830
  GL_DRAW_BUFFER12=: 16b8831
  GL_DRAW_BUFFER13=: 16b8832
  GL_DRAW_BUFFER14=: 16b8833
  GL_DRAW_BUFFER15=: 16b8834
  GL_BLEND_EQUATION_ALPHA=: 16b883d
  GL_MAX_VERTEX_ATTRIBS=: 16b8869
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED=: 16b886a
  GL_MAX_TEXTURE_IMAGE_UNITS=: 16b8872
  GL_FRAGMENT_SHADER=: 16b8b30
  GL_VERTEX_SHADER=: 16b8b31
  GL_MAX_FRAGMENT_UNIFORM_COMPONENTS=: 16b8b49
  GL_MAX_VERTEX_UNIFORM_COMPONENTS=: 16b8b4a
  GL_MAX_VARYING_FLOATS=: 16b8b4b
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS=: 16b8b4c
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS=: 16b8b4d
  GL_SHADER_TYPE=: 16b8b4f
  GL_FLOAT_VEC2=: 16b8b50
  GL_FLOAT_VEC3=: 16b8b51
  GL_FLOAT_VEC4=: 16b8b52
  GL_INT_VEC2=: 16b8b53
  GL_INT_VEC3=: 16b8b54
  GL_INT_VEC4=: 16b8b55
  GL_BOOL=: 16b8b56
  GL_BOOL_VEC2=: 16b8b57
  GL_BOOL_VEC3=: 16b8b58
  GL_BOOL_VEC4=: 16b8b59
  GL_FLOAT_MAT2=: 16b8b5a
  GL_FLOAT_MAT3=: 16b8b5b
  GL_FLOAT_MAT4=: 16b8b5c
  GL_SAMPLER_1D=: 16b8b5d
  GL_SAMPLER_2D=: 16b8b5e
  GL_SAMPLER_3D=: 16b8b5f
  GL_SAMPLER_CUBE=: 16b8b60
  GL_SAMPLER_1D_SHADOW=: 16b8b61
  GL_SAMPLER_2D_SHADOW=: 16b8b62
  GL_DELETE_STATUS=: 16b8b80
  GL_COMPILE_STATUS=: 16b8b81
  GL_LINK_STATUS=: 16b8b82
  GL_VALIDATE_STATUS=: 16b8b83
  GL_INFO_LOG_LENGTH=: 16b8b84
  GL_ATTACHED_SHADERS=: 16b8b85
  GL_ACTIVE_UNIFORMS=: 16b8b86
  GL_ACTIVE_UNIFORM_MAX_LENGTH=: 16b8b87
  GL_SHADER_SOURCE_LENGTH=: 16b8b88
  GL_ACTIVE_ATTRIBUTES=: 16b8b89
  GL_ACTIVE_ATTRIBUTE_MAX_LENGTH=: 16b8b8a
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT=: 16b8b8b
  GL_SHADING_LANGUAGE_VERSION=: 16b8b8c
  GL_CURRENT_PROGRAM=: 16b8b8d
  GL_POINT_SPRITE_COORD_ORIGIN=: 16b8ca0
  GL_LOWER_LEFT=: 16b8ca1
  GL_UPPER_LEFT=: 16b8ca2
  GL_STENCIL_BACK_REF=: 16b8ca3
  GL_STENCIL_BACK_VALUE_MASK=: 16b8ca4
  GL_STENCIL_BACK_WRITEMASK=: 16b8ca5
  GL_VERTEX_PROGRAM_TWO_SIDE=: 16b8643
  GL_POINT_SPRITE=: 16b8861
  GL_COORD_REPLACE=: 16b8862
  GL_MAX_TEXTURE_COORDS=: 16b8871
  GL_PIXEL_PACK_BUFFER=: 16b88eb
  GL_PIXEL_UNPACK_BUFFER=: 16b88ec
  GL_PIXEL_PACK_BUFFER_BINDING=: 16b88ed
  GL_PIXEL_UNPACK_BUFFER_BINDING=: 16b88ef
  GL_FLOAT_MAT2x3=: 16b8b65
  GL_FLOAT_MAT2x4=: 16b8b66
  GL_FLOAT_MAT3x2=: 16b8b67
  GL_FLOAT_MAT3x4=: 16b8b68
  GL_FLOAT_MAT4x2=: 16b8b69
  GL_FLOAT_MAT4x3=: 16b8b6a
  GL_SRGB=: 16b8c40
  GL_SRGB8=: 16b8c41
  GL_SRGB_ALPHA=: 16b8c42
  GL_SRGB8_ALPHA8=: 16b8c43
  GL_COMPRESSED_SRGB=: 16b8c48
  GL_COMPRESSED_SRGB_ALPHA=: 16b8c49
  GL_CURRENT_RASTER_SECONDARY_COLOR=: 16b845f
  GL_SLUMINANCE_ALPHA=: 16b8c44
  GL_SLUMINANCE8_ALPHA8=: 16b8c45
  GL_SLUMINANCE=: 16b8c46
  GL_SLUMINANCE8=: 16b8c47
  GL_COMPRESSED_SLUMINANCE=: 16b8c4a
  GL_COMPRESSED_SLUMINANCE_ALPHA=: 16b8c4b
  GL_COMPARE_REF_TO_TEXTURE=: 16b884e
  GL_CLIP_DISTANCE0=: 16b3000
  GL_CLIP_DISTANCE1=: 16b3001
  GL_CLIP_DISTANCE2=: 16b3002
  GL_CLIP_DISTANCE3=: 16b3003
  GL_CLIP_DISTANCE4=: 16b3004
  GL_CLIP_DISTANCE5=: 16b3005
  GL_CLIP_DISTANCE6=: 16b3006
  GL_CLIP_DISTANCE7=: 16b3007
  GL_MAX_CLIP_DISTANCES=: 16b0d32
  GL_MAJOR_VERSION=: 16b821b
  GL_MINOR_VERSION=: 16b821c
  GL_NUM_EXTENSIONS=: 16b821d
  GL_CONTEXT_FLAGS=: 16b821e
  GL_DEPTH_BUFFER=: 16b8223
  GL_STENCIL_BUFFER=: 16b8224
  GL_COMPRESSED_RED=: 16b8225
  GL_COMPRESSED_RG=: 16b8226
  GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT=: 16b0001
  GL_RGBA32F=: 16b8814
  GL_RGB32F=: 16b8815
  GL_RGBA16F=: 16b881a
  GL_RGB16F=: 16b881b
  GL_VERTEX_ATTRIB_ARRAY_INTEGER=: 16b88fd
  GL_MAX_ARRAY_TEXTURE_LAYERS=: 16b88ff
  GL_MIN_PROGRAM_TEXEL_OFFSET=: 16b8904
  GL_MAX_PROGRAM_TEXEL_OFFSET=: 16b8905
  GL_CLAMP_READ_COLOR=: 16b891c
  GL_FIXED_ONLY=: 16b891d
  GL_MAX_VARYING_COMPONENTS=: 16b8b4b
  GL_TEXTURE_1D_ARRAY=: 16b8c18
  GL_PROXY_TEXTURE_1D_ARRAY=: 16b8c19
  GL_TEXTURE_2D_ARRAY=: 16b8c1a
  GL_PROXY_TEXTURE_2D_ARRAY=: 16b8c1b
  GL_TEXTURE_BINDING_1D_ARRAY=: 16b8c1c
  GL_TEXTURE_BINDING_2D_ARRAY=: 16b8c1d
  GL_R11F_G11F_B10F=: 16b8c3a
  GL_UNSIGNED_INT_10F_11F_11F_REV=: 16b8c3b
  GL_RGB9_E5=: 16b8c3d
  GL_UNSIGNED_INT_5_9_9_9_REV=: 16b8c3e
  GL_TEXTURE_SHARED_SIZE=: 16b8c3f
  GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH=: 16b8c76
  GL_TRANSFORM_FEEDBACK_BUFFER_MODE=: 16b8c7f
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS=: 16b8c80
  GL_TRANSFORM_FEEDBACK_VARYINGS=: 16b8c83
  GL_TRANSFORM_FEEDBACK_BUFFER_START=: 16b8c84
  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE=: 16b8c85
  GL_PRIMITIVES_GENERATED=: 16b8c87
  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN=: 16b8c88
  GL_RASTERIZER_DISCARD=: 16b8c89
  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS=: 16b8c8a
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS=: 16b8c8b
  GL_INTERLEAVED_ATTRIBS=: 16b8c8c
  GL_SEPARATE_ATTRIBS=: 16b8c8d
  GL_TRANSFORM_FEEDBACK_BUFFER=: 16b8c8e
  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING=: 16b8c8f
  GL_RGBA32UI=: 16b8d70
  GL_RGB32UI=: 16b8d71
  GL_RGBA16UI=: 16b8d76
  GL_RGB16UI=: 16b8d77
  GL_RGBA8UI=: 16b8d7c
  GL_RGB8UI=: 16b8d7d
  GL_RGBA32I=: 16b8d82
  GL_RGB32I=: 16b8d83
  GL_RGBA16I=: 16b8d88
  GL_RGB16I=: 16b8d89
  GL_RGBA8I=: 16b8d8e
  GL_RGB8I=: 16b8d8f
  GL_RED_INTEGER=: 16b8d94
  GL_GREEN_INTEGER=: 16b8d95
  GL_BLUE_INTEGER=: 16b8d96
  GL_RGB_INTEGER=: 16b8d98
  GL_RGBA_INTEGER=: 16b8d99
  GL_BGR_INTEGER=: 16b8d9a
  GL_BGRA_INTEGER=: 16b8d9b
  GL_SAMPLER_1D_ARRAY=: 16b8dc0
  GL_SAMPLER_2D_ARRAY=: 16b8dc1
  GL_SAMPLER_1D_ARRAY_SHADOW=: 16b8dc3
  GL_SAMPLER_2D_ARRAY_SHADOW=: 16b8dc4
  GL_SAMPLER_CUBE_SHADOW=: 16b8dc5
  GL_UNSIGNED_INT_VEC2=: 16b8dc6
  GL_UNSIGNED_INT_VEC3=: 16b8dc7
  GL_UNSIGNED_INT_VEC4=: 16b8dc8
  GL_INT_SAMPLER_1D=: 16b8dc9
  GL_INT_SAMPLER_2D=: 16b8dca
  GL_INT_SAMPLER_3D=: 16b8dcb
  GL_INT_SAMPLER_CUBE=: 16b8dcc
  GL_INT_SAMPLER_1D_ARRAY=: 16b8dce
  GL_INT_SAMPLER_2D_ARRAY=: 16b8dcf
  GL_UNSIGNED_INT_SAMPLER_1D=: 16b8dd1
  GL_UNSIGNED_INT_SAMPLER_2D=: 16b8dd2
  GL_UNSIGNED_INT_SAMPLER_3D=: 16b8dd3
  GL_UNSIGNED_INT_SAMPLER_CUBE=: 16b8dd4
  GL_UNSIGNED_INT_SAMPLER_1D_ARRAY=: 16b8dd6
  GL_UNSIGNED_INT_SAMPLER_2D_ARRAY=: 16b8dd7
  GL_QUERY_WAIT=: 16b8e13
  GL_QUERY_NO_WAIT=: 16b8e14
  GL_QUERY_BY_REGION_WAIT=: 16b8e15
  GL_QUERY_BY_REGION_NO_WAIT=: 16b8e16
  GL_BUFFER_ACCESS_FLAGS=: 16b911f
  GL_BUFFER_MAP_LENGTH=: 16b9120
  GL_BUFFER_MAP_OFFSET=: 16b9121
  GL_CLAMP_VERTEX_COLOR=: 16b891a
  GL_CLAMP_FRAGMENT_COLOR=: 16b891b
  GL_ALPHA_INTEGER=: 16b8d97
  GL_SAMPLER_2D_RECT=: 16b8b63
  GL_SAMPLER_2D_RECT_SHADOW=: 16b8b64
  GL_SAMPLER_BUFFER=: 16b8dc2
  GL_INT_SAMPLER_2D_RECT=: 16b8dcd
  GL_INT_SAMPLER_BUFFER=: 16b8dd0
  GL_UNSIGNED_INT_SAMPLER_2D_RECT=: 16b8dd5
  GL_UNSIGNED_INT_SAMPLER_BUFFER=: 16b8dd8
  GL_TEXTURE_BUFFER=: 16b8c2a
  GL_MAX_TEXTURE_BUFFER_SIZE=: 16b8c2b
  GL_TEXTURE_BINDING_BUFFER=: 16b8c2c
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING=: 16b8c2d
  GL_TEXTURE_BUFFER_FORMAT=: 16b8c2e
  GL_TEXTURE_RECTANGLE=: 16b84f5
  GL_TEXTURE_BINDING_RECTANGLE=: 16b84f6
  GL_PROXY_TEXTURE_RECTANGLE=: 16b84f7
  GL_MAX_RECTANGLE_TEXTURE_SIZE=: 16b84f8
  GL_RED_SNORM=: 16b8f90
  GL_RG_SNORM=: 16b8f91
  GL_RGB_SNORM=: 16b8f92
  GL_RGBA_SNORM=: 16b8f93
  GL_R8_SNORM=: 16b8f94
  GL_RG8_SNORM=: 16b8f95
  GL_RGB8_SNORM=: 16b8f96
  GL_RGBA8_SNORM=: 16b8f97
  GL_R16_SNORM=: 16b8f98
  GL_RG16_SNORM=: 16b8f99
  GL_RGB16_SNORM=: 16b8f9a
  GL_RGBA16_SNORM=: 16b8f9b
  GL_SIGNED_NORMALIZED=: 16b8f9c
  GL_PRIMITIVE_RESTART=: 16b8f9d
  GL_PRIMITIVE_RESTART_INDEX=: 16b8f9e
  GL_CONTEXT_CORE_PROFILE_BIT=: 16b00000001
  GL_CONTEXT_COMPATIBILITY_PROFILE_BIT=: 16b00000002
  GL_LINES_ADJACENCY=: 16b000a
  GL_LINE_STRIP_ADJACENCY=: 16b000b
  GL_TRIANGLES_ADJACENCY=: 16b000c
  GL_TRIANGLE_STRIP_ADJACENCY=: 16b000d
  GL_PROGRAM_POINT_SIZE=: 16b8642
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS=: 16b8c29
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED=: 16b8da7
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS=: 16b8da8
  GL_GEOMETRY_SHADER=: 16b8dd9
  GL_GEOMETRY_VERTICES_OUT=: 16b8916
  GL_GEOMETRY_INPUT_TYPE=: 16b8917
  GL_GEOMETRY_OUTPUT_TYPE=: 16b8918
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS=: 16b8ddf
  GL_MAX_GEOMETRY_OUTPUT_VERTICES=: 16b8de0
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS=: 16b8de1
  GL_MAX_VERTEX_OUTPUT_COMPONENTS=: 16b9122
  GL_MAX_GEOMETRY_INPUT_COMPONENTS=: 16b9123
  GL_MAX_GEOMETRY_OUTPUT_COMPONENTS=: 16b9124
  GL_MAX_FRAGMENT_INPUT_COMPONENTS=: 16b9125
  GL_CONTEXT_PROFILE_MASK=: 16b9126
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR=: 16b88fe
  GL_SAMPLE_SHADING=: 16b8c36
  GL_MIN_SAMPLE_SHADING_VALUE=: 16b8c37
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET=: 16b8e5e
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET=: 16b8e5f
  GL_TEXTURE_CUBE_MAP_ARRAY=: 16b9009
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY=: 16b900a
  GL_PROXY_TEXTURE_CUBE_MAP_ARRAY=: 16b900b
  GL_SAMPLER_CUBE_MAP_ARRAY=: 16b900c
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW=: 16b900d
  GL_INT_SAMPLER_CUBE_MAP_ARRAY=: 16b900e
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY=: 16b900f
  GL_TEXTURE0_ARB=: 16b84c0
  GL_TEXTURE1_ARB=: 16b84c1
  GL_TEXTURE2_ARB=: 16b84c2
  GL_TEXTURE3_ARB=: 16b84c3
  GL_TEXTURE4_ARB=: 16b84c4
  GL_TEXTURE5_ARB=: 16b84c5
  GL_TEXTURE6_ARB=: 16b84c6
  GL_TEXTURE7_ARB=: 16b84c7
  GL_TEXTURE8_ARB=: 16b84c8
  GL_TEXTURE9_ARB=: 16b84c9
  GL_TEXTURE10_ARB=: 16b84ca
  GL_TEXTURE11_ARB=: 16b84cb
  GL_TEXTURE12_ARB=: 16b84cc
  GL_TEXTURE13_ARB=: 16b84cd
  GL_TEXTURE14_ARB=: 16b84ce
  GL_TEXTURE15_ARB=: 16b84cf
  GL_TEXTURE16_ARB=: 16b84d0
  GL_TEXTURE17_ARB=: 16b84d1
  GL_TEXTURE18_ARB=: 16b84d2
  GL_TEXTURE19_ARB=: 16b84d3
  GL_TEXTURE20_ARB=: 16b84d4
  GL_TEXTURE21_ARB=: 16b84d5
  GL_TEXTURE22_ARB=: 16b84d6
  GL_TEXTURE23_ARB=: 16b84d7
  GL_TEXTURE24_ARB=: 16b84d8
  GL_TEXTURE25_ARB=: 16b84d9
  GL_TEXTURE26_ARB=: 16b84da
  GL_TEXTURE27_ARB=: 16b84db
  GL_TEXTURE28_ARB=: 16b84dc
  GL_TEXTURE29_ARB=: 16b84dd
  GL_TEXTURE30_ARB=: 16b84de
  GL_TEXTURE31_ARB=: 16b84df
  GL_ACTIVE_TEXTURE_ARB=: 16b84e0
  GL_CLIENT_ACTIVE_TEXTURE_ARB=: 16b84e1
  GL_MAX_TEXTURE_UNITS_ARB=: 16b84e2
  GL_TRANSPOSE_MODELVIEW_MATRIX_ARB=: 16b84e3
  GL_TRANSPOSE_PROJECTION_MATRIX_ARB=: 16b84e4
  GL_TRANSPOSE_TEXTURE_MATRIX_ARB=: 16b84e5
  GL_TRANSPOSE_COLOR_MATRIX_ARB=: 16b84e6
  GL_MULTISAMPLE_ARB=: 16b809d
  GL_SAMPLE_ALPHA_TO_COVERAGE_ARB=: 16b809e
  GL_SAMPLE_ALPHA_TO_ONE_ARB=: 16b809f
  GL_SAMPLE_COVERAGE_ARB=: 16b80a0
  GL_SAMPLE_BUFFERS_ARB=: 16b80a8
  GL_SAMPLES_ARB=: 16b80a9
  GL_SAMPLE_COVERAGE_VALUE_ARB=: 16b80aa
  GL_SAMPLE_COVERAGE_INVERT_ARB=: 16b80ab
  GL_MULTISAMPLE_BIT_ARB=: 16b20000000
  GL_NORMAL_MAP_ARB=: 16b8511
  GL_REFLECTION_MAP_ARB=: 16b8512
  GL_TEXTURE_CUBE_MAP_ARB=: 16b8513
  GL_TEXTURE_BINDING_CUBE_MAP_ARB=: 16b8514
  GL_TEXTURE_CUBE_MAP_POSITIVE_X_ARB=: 16b8515
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X_ARB=: 16b8516
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y_ARB=: 16b8517
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_ARB=: 16b8518
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z_ARB=: 16b8519
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_ARB=: 16b851a
  GL_PROXY_TEXTURE_CUBE_MAP_ARB=: 16b851b
  GL_MAX_CUBE_MAP_TEXTURE_SIZE_ARB=: 16b851c
  GL_COMPRESSED_ALPHA_ARB=: 16b84e9
  GL_COMPRESSED_LUMINANCE_ARB=: 16b84ea
  GL_COMPRESSED_LUMINANCE_ALPHA_ARB=: 16b84eb
  GL_COMPRESSED_INTENSITY_ARB=: 16b84ec
  GL_COMPRESSED_RGB_ARB=: 16b84ed
  GL_COMPRESSED_RGBA_ARB=: 16b84ee
  GL_TEXTURE_COMPRESSION_HINT_ARB=: 16b84ef
  GL_TEXTURE_COMPRESSED_IMAGE_SIZE_ARB=: 16b86a0
  GL_TEXTURE_COMPRESSED_ARB=: 16b86a1
  GL_NUM_COMPRESSED_TEXTURE_FORMATS_ARB=: 16b86a2
  GL_COMPRESSED_TEXTURE_FORMATS_ARB=: 16b86a3
  GL_CLAMP_TO_BORDER_ARB=: 16b812d
  GL_POINT_SIZE_MIN_ARB=: 16b8126
  GL_POINT_SIZE_MAX_ARB=: 16b8127
  GL_POINT_FADE_THRESHOLD_SIZE_ARB=: 16b8128
  GL_POINT_DISTANCE_ATTENUATION_ARB=: 16b8129
  GL_MAX_VERTEX_UNITS_ARB=: 16b86a4
  GL_ACTIVE_VERTEX_UNITS_ARB=: 16b86a5
  GL_WEIGHT_SUM_UNITY_ARB=: 16b86a6
  GL_VERTEX_BLEND_ARB=: 16b86a7
  GL_CURRENT_WEIGHT_ARB=: 16b86a8
  GL_WEIGHT_ARRAY_TYPE_ARB=: 16b86a9
  GL_WEIGHT_ARRAY_STRIDE_ARB=: 16b86aa
  GL_WEIGHT_ARRAY_SIZE_ARB=: 16b86ab
  GL_WEIGHT_ARRAY_POINTER_ARB=: 16b86ac
  GL_WEIGHT_ARRAY_ARB=: 16b86ad
  GL_MODELVIEW0_ARB=: 16b1700
  GL_MODELVIEW1_ARB=: 16b850a
  GL_MODELVIEW2_ARB=: 16b8722
  GL_MODELVIEW3_ARB=: 16b8723
  GL_MODELVIEW4_ARB=: 16b8724
  GL_MODELVIEW5_ARB=: 16b8725
  GL_MODELVIEW6_ARB=: 16b8726
  GL_MODELVIEW7_ARB=: 16b8727
  GL_MODELVIEW8_ARB=: 16b8728
  GL_MODELVIEW9_ARB=: 16b8729
  GL_MODELVIEW10_ARB=: 16b872a
  GL_MODELVIEW11_ARB=: 16b872b
  GL_MODELVIEW12_ARB=: 16b872c
  GL_MODELVIEW13_ARB=: 16b872d
  GL_MODELVIEW14_ARB=: 16b872e
  GL_MODELVIEW15_ARB=: 16b872f
  GL_MODELVIEW16_ARB=: 16b8730
  GL_MODELVIEW17_ARB=: 16b8731
  GL_MODELVIEW18_ARB=: 16b8732
  GL_MODELVIEW19_ARB=: 16b8733
  GL_MODELVIEW20_ARB=: 16b8734
  GL_MODELVIEW21_ARB=: 16b8735
  GL_MODELVIEW22_ARB=: 16b8736
  GL_MODELVIEW23_ARB=: 16b8737
  GL_MODELVIEW24_ARB=: 16b8738
  GL_MODELVIEW25_ARB=: 16b8739
  GL_MODELVIEW26_ARB=: 16b873a
  GL_MODELVIEW27_ARB=: 16b873b
  GL_MODELVIEW28_ARB=: 16b873c
  GL_MODELVIEW29_ARB=: 16b873d
  GL_MODELVIEW30_ARB=: 16b873e
  GL_MODELVIEW31_ARB=: 16b873f
  GL_MATRIX_PALETTE_ARB=: 16b8840
  GL_MAX_MATRIX_PALETTE_STACK_DEPTH_ARB=: 16b8841
  GL_MAX_PALETTE_MATRICES_ARB=: 16b8842
  GL_CURRENT_PALETTE_MATRIX_ARB=: 16b8843
  GL_MATRIX_INDEX_ARRAY_ARB=: 16b8844
  GL_CURRENT_MATRIX_INDEX_ARB=: 16b8845
  GL_MATRIX_INDEX_ARRAY_SIZE_ARB=: 16b8846
  GL_MATRIX_INDEX_ARRAY_TYPE_ARB=: 16b8847
  GL_MATRIX_INDEX_ARRAY_STRIDE_ARB=: 16b8848
  GL_MATRIX_INDEX_ARRAY_POINTER_ARB=: 16b8849
  GL_COMBINE_ARB=: 16b8570
  GL_COMBINE_RGB_ARB=: 16b8571
  GL_COMBINE_ALPHA_ARB=: 16b8572
  GL_SOURCE0_RGB_ARB=: 16b8580
  GL_SOURCE1_RGB_ARB=: 16b8581
  GL_SOURCE2_RGB_ARB=: 16b8582
  GL_SOURCE0_ALPHA_ARB=: 16b8588
  GL_SOURCE1_ALPHA_ARB=: 16b8589
  GL_SOURCE2_ALPHA_ARB=: 16b858a
  GL_OPERAND0_RGB_ARB=: 16b8590
  GL_OPERAND1_RGB_ARB=: 16b8591
  GL_OPERAND2_RGB_ARB=: 16b8592
  GL_OPERAND0_ALPHA_ARB=: 16b8598
  GL_OPERAND1_ALPHA_ARB=: 16b8599
  GL_OPERAND2_ALPHA_ARB=: 16b859a
  GL_RGB_SCALE_ARB=: 16b8573
  GL_ADD_SIGNED_ARB=: 16b8574
  GL_INTERPOLATE_ARB=: 16b8575
  GL_SUBTRACT_ARB=: 16b84e7
  GL_CONSTANT_ARB=: 16b8576
  GL_PRIMARY_COLOR_ARB=: 16b8577
  GL_PREVIOUS_ARB=: 16b8578
  GL_DOT3_RGB_ARB=: 16b86ae
  GL_DOT3_RGBA_ARB=: 16b86af
  GL_MIRRORED_REPEAT_ARB=: 16b8370
  GL_DEPTH_COMPONENT16_ARB=: 16b81a5
  GL_DEPTH_COMPONENT24_ARB=: 16b81a6
  GL_DEPTH_COMPONENT32_ARB=: 16b81a7
  GL_TEXTURE_DEPTH_SIZE_ARB=: 16b884a
  GL_DEPTH_TEXTURE_MODE_ARB=: 16b884b
  GL_TEXTURE_COMPARE_MODE_ARB=: 16b884c
  GL_TEXTURE_COMPARE_FUNC_ARB=: 16b884d
  GL_COMPARE_R_TO_TEXTURE_ARB=: 16b884e
  GL_TEXTURE_COMPARE_FAIL_VALUE_ARB=: 16b80bf
  GL_COLOR_SUM_ARB=: 16b8458
  GL_VERTEX_PROGRAM_ARB=: 16b8620
  GL_VERTEX_ATTRIB_ARRAY_ENABLED_ARB=: 16b8622
  GL_VERTEX_ATTRIB_ARRAY_SIZE_ARB=: 16b8623
  GL_VERTEX_ATTRIB_ARRAY_STRIDE_ARB=: 16b8624
  GL_VERTEX_ATTRIB_ARRAY_TYPE_ARB=: 16b8625
  GL_CURRENT_VERTEX_ATTRIB_ARB=: 16b8626
  GL_PROGRAM_LENGTH_ARB=: 16b8627
  GL_PROGRAM_STRING_ARB=: 16b8628
  GL_MAX_PROGRAM_MATRIX_STACK_DEPTH_ARB=: 16b862e
  GL_MAX_PROGRAM_MATRICES_ARB=: 16b862f
  GL_CURRENT_MATRIX_STACK_DEPTH_ARB=: 16b8640
  GL_CURRENT_MATRIX_ARB=: 16b8641
  GL_VERTEX_PROGRAM_POINT_SIZE_ARB=: 16b8642
  GL_VERTEX_PROGRAM_TWO_SIDE_ARB=: 16b8643
  GL_VERTEX_ATTRIB_ARRAY_POINTER_ARB=: 16b8645
  GL_PROGRAM_ERROR_POSITION_ARB=: 16b864b
  GL_PROGRAM_BINDING_ARB=: 16b8677
  GL_MAX_VERTEX_ATTRIBS_ARB=: 16b8869
  GL_VERTEX_ATTRIB_ARRAY_NORMALIZED_ARB=: 16b886a
  GL_PROGRAM_ERROR_STRING_ARB=: 16b8874
  GL_PROGRAM_FORMAT_ASCII_ARB=: 16b8875
  GL_PROGRAM_FORMAT_ARB=: 16b8876
  GL_PROGRAM_INSTRUCTIONS_ARB=: 16b88a0
  GL_MAX_PROGRAM_INSTRUCTIONS_ARB=: 16b88a1
  GL_PROGRAM_NATIVE_INSTRUCTIONS_ARB=: 16b88a2
  GL_MAX_PROGRAM_NATIVE_INSTRUCTIONS_ARB=: 16b88a3
  GL_PROGRAM_TEMPORARIES_ARB=: 16b88a4
  GL_MAX_PROGRAM_TEMPORARIES_ARB=: 16b88a5
  GL_PROGRAM_NATIVE_TEMPORARIES_ARB=: 16b88a6
  GL_MAX_PROGRAM_NATIVE_TEMPORARIES_ARB=: 16b88a7
  GL_PROGRAM_PARAMETERS_ARB=: 16b88a8
  GL_MAX_PROGRAM_PARAMETERS_ARB=: 16b88a9
  GL_PROGRAM_NATIVE_PARAMETERS_ARB=: 16b88aa
  GL_MAX_PROGRAM_NATIVE_PARAMETERS_ARB=: 16b88ab
  GL_PROGRAM_ATTRIBS_ARB=: 16b88ac
  GL_MAX_PROGRAM_ATTRIBS_ARB=: 16b88ad
  GL_PROGRAM_NATIVE_ATTRIBS_ARB=: 16b88ae
  GL_MAX_PROGRAM_NATIVE_ATTRIBS_ARB=: 16b88af
  GL_PROGRAM_ADDRESS_REGISTERS_ARB=: 16b88b0
  GL_MAX_PROGRAM_ADDRESS_REGISTERS_ARB=: 16b88b1
  GL_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB=: 16b88b2
  GL_MAX_PROGRAM_NATIVE_ADDRESS_REGISTERS_ARB=: 16b88b3
  GL_MAX_PROGRAM_LOCAL_PARAMETERS_ARB=: 16b88b4
  GL_MAX_PROGRAM_ENV_PARAMETERS_ARB=: 16b88b5
  GL_PROGRAM_UNDER_NATIVE_LIMITS_ARB=: 16b88b6
  GL_TRANSPOSE_CURRENT_MATRIX_ARB=: 16b88b7
  GL_MATRIX0_ARB=: 16b88c0
  GL_MATRIX1_ARB=: 16b88c1
  GL_MATRIX2_ARB=: 16b88c2
  GL_MATRIX3_ARB=: 16b88c3
  GL_MATRIX4_ARB=: 16b88c4
  GL_MATRIX5_ARB=: 16b88c5
  GL_MATRIX6_ARB=: 16b88c6
  GL_MATRIX7_ARB=: 16b88c7
  GL_MATRIX8_ARB=: 16b88c8
  GL_MATRIX9_ARB=: 16b88c9
  GL_MATRIX10_ARB=: 16b88ca
  GL_MATRIX11_ARB=: 16b88cb
  GL_MATRIX12_ARB=: 16b88cc
  GL_MATRIX13_ARB=: 16b88cd
  GL_MATRIX14_ARB=: 16b88ce
  GL_MATRIX15_ARB=: 16b88cf
  GL_MATRIX16_ARB=: 16b88d0
  GL_MATRIX17_ARB=: 16b88d1
  GL_MATRIX18_ARB=: 16b88d2
  GL_MATRIX19_ARB=: 16b88d3
  GL_MATRIX20_ARB=: 16b88d4
  GL_MATRIX21_ARB=: 16b88d5
  GL_MATRIX22_ARB=: 16b88d6
  GL_MATRIX23_ARB=: 16b88d7
  GL_MATRIX24_ARB=: 16b88d8
  GL_MATRIX25_ARB=: 16b88d9
  GL_MATRIX26_ARB=: 16b88da
  GL_MATRIX27_ARB=: 16b88db
  GL_MATRIX28_ARB=: 16b88dc
  GL_MATRIX29_ARB=: 16b88dd
  GL_MATRIX30_ARB=: 16b88de
  GL_MATRIX31_ARB=: 16b88df
  GL_FRAGMENT_PROGRAM_ARB=: 16b8804
  GL_PROGRAM_ALU_INSTRUCTIONS_ARB=: 16b8805
  GL_PROGRAM_TEX_INSTRUCTIONS_ARB=: 16b8806
  GL_PROGRAM_TEX_INDIRECTIONS_ARB=: 16b8807
  GL_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB=: 16b8808
  GL_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB=: 16b8809
  GL_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB=: 16b880a
  GL_MAX_PROGRAM_ALU_INSTRUCTIONS_ARB=: 16b880b
  GL_MAX_PROGRAM_TEX_INSTRUCTIONS_ARB=: 16b880c
  GL_MAX_PROGRAM_TEX_INDIRECTIONS_ARB=: 16b880d
  GL_MAX_PROGRAM_NATIVE_ALU_INSTRUCTIONS_ARB=: 16b880e
  GL_MAX_PROGRAM_NATIVE_TEX_INSTRUCTIONS_ARB=: 16b880f
  GL_MAX_PROGRAM_NATIVE_TEX_INDIRECTIONS_ARB=: 16b8810
  GL_MAX_TEXTURE_COORDS_ARB=: 16b8871
  GL_MAX_TEXTURE_IMAGE_UNITS_ARB=: 16b8872
  GL_BUFFER_SIZE_ARB=: 16b8764
  GL_BUFFER_USAGE_ARB=: 16b8765
  GL_ARRAY_BUFFER_ARB=: 16b8892
  GL_ELEMENT_ARRAY_BUFFER_ARB=: 16b8893
  GL_ARRAY_BUFFER_BINDING_ARB=: 16b8894
  GL_ELEMENT_ARRAY_BUFFER_BINDING_ARB=: 16b8895
  GL_VERTEX_ARRAY_BUFFER_BINDING_ARB=: 16b8896
  GL_NORMAL_ARRAY_BUFFER_BINDING_ARB=: 16b8897
  GL_COLOR_ARRAY_BUFFER_BINDING_ARB=: 16b8898
  GL_INDEX_ARRAY_BUFFER_BINDING_ARB=: 16b8899
  GL_TEXTURE_COORD_ARRAY_BUFFER_BINDING_ARB=: 16b889a
  GL_EDGE_FLAG_ARRAY_BUFFER_BINDING_ARB=: 16b889b
  GL_SECONDARY_COLOR_ARRAY_BUFFER_BINDING_ARB=: 16b889c
  GL_FOG_COORDINATE_ARRAY_BUFFER_BINDING_ARB=: 16b889d
  GL_WEIGHT_ARRAY_BUFFER_BINDING_ARB=: 16b889e
  GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING_ARB=: 16b889f
  GL_READ_ONLY_ARB=: 16b88b8
  GL_WRITE_ONLY_ARB=: 16b88b9
  GL_READ_WRITE_ARB=: 16b88ba
  GL_BUFFER_ACCESS_ARB=: 16b88bb
  GL_BUFFER_MAPPED_ARB=: 16b88bc
  GL_BUFFER_MAP_POINTER_ARB=: 16b88bd
  GL_STREAM_DRAW_ARB=: 16b88e0
  GL_STREAM_READ_ARB=: 16b88e1
  GL_STREAM_COPY_ARB=: 16b88e2
  GL_STATIC_DRAW_ARB=: 16b88e4
  GL_STATIC_READ_ARB=: 16b88e5
  GL_STATIC_COPY_ARB=: 16b88e6
  GL_DYNAMIC_DRAW_ARB=: 16b88e8
  GL_DYNAMIC_READ_ARB=: 16b88e9
  GL_DYNAMIC_COPY_ARB=: 16b88ea
  GL_QUERY_COUNTER_BITS_ARB=: 16b8864
  GL_CURRENT_QUERY_ARB=: 16b8865
  GL_QUERY_RESULT_ARB=: 16b8866
  GL_QUERY_RESULT_AVAILABLE_ARB=: 16b8867
  GL_SAMPLES_PASSED_ARB=: 16b8914
  GL_PROGRAM_OBJECT_ARB=: 16b8b40
  GL_SHADER_OBJECT_ARB=: 16b8b48
  GL_OBJECT_TYPE_ARB=: 16b8b4e
  GL_OBJECT_SUBTYPE_ARB=: 16b8b4f
  GL_FLOAT_VEC2_ARB=: 16b8b50
  GL_FLOAT_VEC3_ARB=: 16b8b51
  GL_FLOAT_VEC4_ARB=: 16b8b52
  GL_INT_VEC2_ARB=: 16b8b53
  GL_INT_VEC3_ARB=: 16b8b54
  GL_INT_VEC4_ARB=: 16b8b55
  GL_BOOL_ARB=: 16b8b56
  GL_BOOL_VEC2_ARB=: 16b8b57
  GL_BOOL_VEC3_ARB=: 16b8b58
  GL_BOOL_VEC4_ARB=: 16b8b59
  GL_FLOAT_MAT2_ARB=: 16b8b5a
  GL_FLOAT_MAT3_ARB=: 16b8b5b
  GL_FLOAT_MAT4_ARB=: 16b8b5c
  GL_SAMPLER_1D_ARB=: 16b8b5d
  GL_SAMPLER_2D_ARB=: 16b8b5e
  GL_SAMPLER_3D_ARB=: 16b8b5f
  GL_SAMPLER_CUBE_ARB=: 16b8b60
  GL_SAMPLER_1D_SHADOW_ARB=: 16b8b61
  GL_SAMPLER_2D_SHADOW_ARB=: 16b8b62
  GL_SAMPLER_2D_RECT_ARB=: 16b8b63
  GL_SAMPLER_2D_RECT_SHADOW_ARB=: 16b8b64
  GL_OBJECT_DELETE_STATUS_ARB=: 16b8b80
  GL_OBJECT_COMPILE_STATUS_ARB=: 16b8b81
  GL_OBJECT_LINK_STATUS_ARB=: 16b8b82
  GL_OBJECT_VALIDATE_STATUS_ARB=: 16b8b83
  GL_OBJECT_INFO_LOG_LENGTH_ARB=: 16b8b84
  GL_OBJECT_ATTACHED_OBJECTS_ARB=: 16b8b85
  GL_OBJECT_ACTIVE_UNIFORMS_ARB=: 16b8b86
  GL_OBJECT_ACTIVE_UNIFORM_MAX_LENGTH_ARB=: 16b8b87
  GL_OBJECT_SHADER_SOURCE_LENGTH_ARB=: 16b8b88
  GL_VERTEX_SHADER_ARB=: 16b8b31
  GL_MAX_VERTEX_UNIFORM_COMPONENTS_ARB=: 16b8b4a
  GL_MAX_VARYING_FLOATS_ARB=: 16b8b4b
  GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS_ARB=: 16b8b4c
  GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS_ARB=: 16b8b4d
  GL_OBJECT_ACTIVE_ATTRIBUTES_ARB=: 16b8b89
  GL_OBJECT_ACTIVE_ATTRIBUTE_MAX_LENGTH_ARB=: 16b8b8a
  GL_FRAGMENT_SHADER_ARB=: 16b8b30
  GL_MAX_FRAGMENT_UNIFORM_COMPONENTS_ARB=: 16b8b49
  GL_FRAGMENT_SHADER_DERIVATIVE_HINT_ARB=: 16b8b8b
  GL_SHADING_LANGUAGE_VERSION_ARB=: 16b8b8c
  GL_POINT_SPRITE_ARB=: 16b8861
  GL_COORD_REPLACE_ARB=: 16b8862
  GL_MAX_DRAW_BUFFERS_ARB=: 16b8824
  GL_DRAW_BUFFER0_ARB=: 16b8825
  GL_DRAW_BUFFER1_ARB=: 16b8826
  GL_DRAW_BUFFER2_ARB=: 16b8827
  GL_DRAW_BUFFER3_ARB=: 16b8828
  GL_DRAW_BUFFER4_ARB=: 16b8829
  GL_DRAW_BUFFER5_ARB=: 16b882a
  GL_DRAW_BUFFER6_ARB=: 16b882b
  GL_DRAW_BUFFER7_ARB=: 16b882c
  GL_DRAW_BUFFER8_ARB=: 16b882d
  GL_DRAW_BUFFER9_ARB=: 16b882e
  GL_DRAW_BUFFER10_ARB=: 16b882f
  GL_DRAW_BUFFER11_ARB=: 16b8830
  GL_DRAW_BUFFER12_ARB=: 16b8831
  GL_DRAW_BUFFER13_ARB=: 16b8832
  GL_DRAW_BUFFER14_ARB=: 16b8833
  GL_DRAW_BUFFER15_ARB=: 16b8834
  GL_TEXTURE_RECTANGLE_ARB=: 16b84f5
  GL_TEXTURE_BINDING_RECTANGLE_ARB=: 16b84f6
  GL_PROXY_TEXTURE_RECTANGLE_ARB=: 16b84f7
  GL_MAX_RECTANGLE_TEXTURE_SIZE_ARB=: 16b84f8
  GL_RGBA_FLOAT_MODE_ARB=: 16b8820
  GL_CLAMP_VERTEX_COLOR_ARB=: 16b891a
  GL_CLAMP_FRAGMENT_COLOR_ARB=: 16b891b
  GL_CLAMP_READ_COLOR_ARB=: 16b891c
  GL_FIXED_ONLY_ARB=: 16b891d
  GL_HALF_FLOAT_ARB=: 16b140b
  GL_TEXTURE_RED_TYPE_ARB=: 16b8c10
  GL_TEXTURE_GREEN_TYPE_ARB=: 16b8c11
  GL_TEXTURE_BLUE_TYPE_ARB=: 16b8c12
  GL_TEXTURE_ALPHA_TYPE_ARB=: 16b8c13
  GL_TEXTURE_LUMINANCE_TYPE_ARB=: 16b8c14
  GL_TEXTURE_INTENSITY_TYPE_ARB=: 16b8c15
  GL_TEXTURE_DEPTH_TYPE_ARB=: 16b8c16
  GL_UNSIGNED_NORMALIZED_ARB=: 16b8c17
  GL_RGBA32F_ARB=: 16b8814
  GL_RGB32F_ARB=: 16b8815
  GL_ALPHA32F_ARB=: 16b8816
  GL_INTENSITY32F_ARB=: 16b8817
  GL_LUMINANCE32F_ARB=: 16b8818
  GL_LUMINANCE_ALPHA32F_ARB=: 16b8819
  GL_RGBA16F_ARB=: 16b881a
  GL_RGB16F_ARB=: 16b881b
  GL_ALPHA16F_ARB=: 16b881c
  GL_INTENSITY16F_ARB=: 16b881d
  GL_LUMINANCE16F_ARB=: 16b881e
  GL_LUMINANCE_ALPHA16F_ARB=: 16b881f
  GL_PIXEL_PACK_BUFFER_ARB=: 16b88eb
  GL_PIXEL_UNPACK_BUFFER_ARB=: 16b88ec
  GL_PIXEL_PACK_BUFFER_BINDING_ARB=: 16b88ed
  GL_PIXEL_UNPACK_BUFFER_BINDING_ARB=: 16b88ef
  GL_DEPTH_COMPONENT32F=: 16b8cac
  GL_DEPTH32F_STENCIL8=: 16b8cad
  GL_FLOAT_32_UNSIGNED_INT_24_8_REV=: 16b8dad
  GL_INVALID_FRAMEBUFFER_OPERATION=: 16b0506
  GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING=: 16b8210
  GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE=: 16b8211
  GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE=: 16b8212
  GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE=: 16b8213
  GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE=: 16b8214
  GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE=: 16b8215
  GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE=: 16b8216
  GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE=: 16b8217
  GL_FRAMEBUFFER_DEFAULT=: 16b8218
  GL_FRAMEBUFFER_UNDEFINED=: 16b8219
  GL_DEPTH_STENCIL_ATTACHMENT=: 16b821a
  GL_MAX_RENDERBUFFER_SIZE=: 16b84e8
  GL_DEPTH_STENCIL=: 16b84f9
  GL_UNSIGNED_INT_24_8=: 16b84fa
  GL_DEPTH24_STENCIL8=: 16b88f0
  GL_TEXTURE_STENCIL_SIZE=: 16b88f1
  GL_TEXTURE_RED_TYPE=: 16b8c10
  GL_TEXTURE_GREEN_TYPE=: 16b8c11
  GL_TEXTURE_BLUE_TYPE=: 16b8c12
  GL_TEXTURE_ALPHA_TYPE=: 16b8c13
  GL_TEXTURE_DEPTH_TYPE=: 16b8c16
  GL_UNSIGNED_NORMALIZED=: 16b8c17
  GL_FRAMEBUFFER_BINDING=: 16b8ca6
  GL_DRAW_FRAMEBUFFER_BINDING=: GL_FRAMEBUFFER_BINDING
  GL_RENDERBUFFER_BINDING=: 16b8ca7
  GL_READ_FRAMEBUFFER=: 16b8ca8
  GL_DRAW_FRAMEBUFFER=: 16b8ca9
  GL_READ_FRAMEBUFFER_BINDING=: 16b8caa
  GL_RENDERBUFFER_SAMPLES=: 16b8cab
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE=: 16b8cd0
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME=: 16b8cd1
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL=: 16b8cd2
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE=: 16b8cd3
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER=: 16b8cd4
  GL_FRAMEBUFFER_COMPLETE=: 16b8cd5
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT=: 16b8cd6
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT=: 16b8cd7
  GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER=: 16b8cdb
  GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER=: 16b8cdc
  GL_FRAMEBUFFER_UNSUPPORTED=: 16b8cdd
  GL_MAX_COLOR_ATTACHMENTS=: 16b8cdf
  GL_COLOR_ATTACHMENT0=: 16b8ce0
  GL_COLOR_ATTACHMENT1=: 16b8ce1
  GL_COLOR_ATTACHMENT2=: 16b8ce2
  GL_COLOR_ATTACHMENT3=: 16b8ce3
  GL_COLOR_ATTACHMENT4=: 16b8ce4
  GL_COLOR_ATTACHMENT5=: 16b8ce5
  GL_COLOR_ATTACHMENT6=: 16b8ce6
  GL_COLOR_ATTACHMENT7=: 16b8ce7
  GL_COLOR_ATTACHMENT8=: 16b8ce8
  GL_COLOR_ATTACHMENT9=: 16b8ce9
  GL_COLOR_ATTACHMENT10=: 16b8cea
  GL_COLOR_ATTACHMENT11=: 16b8ceb
  GL_COLOR_ATTACHMENT12=: 16b8cec
  GL_COLOR_ATTACHMENT13=: 16b8ced
  GL_COLOR_ATTACHMENT14=: 16b8cee
  GL_COLOR_ATTACHMENT15=: 16b8cef
  GL_DEPTH_ATTACHMENT=: 16b8d00
  GL_STENCIL_ATTACHMENT=: 16b8d20
  GL_FRAMEBUFFER=: 16b8d40
  GL_RENDERBUFFER=: 16b8d41
  GL_RENDERBUFFER_WIDTH=: 16b8d42
  GL_RENDERBUFFER_HEIGHT=: 16b8d43
  GL_RENDERBUFFER_INTERNAL_FORMAT=: 16b8d44
  GL_STENCIL_INDEX1=: 16b8d46
  GL_STENCIL_INDEX4=: 16b8d47
  GL_STENCIL_INDEX8=: 16b8d48
  GL_STENCIL_INDEX16=: 16b8d49
  GL_RENDERBUFFER_RED_SIZE=: 16b8d50
  GL_RENDERBUFFER_GREEN_SIZE=: 16b8d51
  GL_RENDERBUFFER_BLUE_SIZE=: 16b8d52
  GL_RENDERBUFFER_ALPHA_SIZE=: 16b8d53
  GL_RENDERBUFFER_DEPTH_SIZE=: 16b8d54
  GL_RENDERBUFFER_STENCIL_SIZE=: 16b8d55
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE=: 16b8d56
  GL_MAX_SAMPLES=: 16b8d57
  GL_INDEX=: 16b8222
  GL_TEXTURE_LUMINANCE_TYPE=: 16b8c14
  GL_TEXTURE_INTENSITY_TYPE=: 16b8c15
  GL_FRAMEBUFFER_SRGB=: 16b8db9
  GL_LINES_ADJACENCY_ARB=: 16b000a
  GL_LINE_STRIP_ADJACENCY_ARB=: 16b000b
  GL_TRIANGLES_ADJACENCY_ARB=: 16b000c
  GL_TRIANGLE_STRIP_ADJACENCY_ARB=: 16b000d
  GL_PROGRAM_POINT_SIZE_ARB=: 16b8642
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_ARB=: 16b8c29
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED_ARB=: 16b8da7
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_ARB=: 16b8da8
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_ARB=: 16b8da9
  GL_GEOMETRY_SHADER_ARB=: 16b8dd9
  GL_GEOMETRY_VERTICES_OUT_ARB=: 16b8dda
  GL_GEOMETRY_INPUT_TYPE_ARB=: 16b8ddb
  GL_GEOMETRY_OUTPUT_TYPE_ARB=: 16b8ddc
  GL_MAX_GEOMETRY_VARYING_COMPONENTS_ARB=: 16b8ddd
  GL_MAX_VERTEX_VARYING_COMPONENTS_ARB=: 16b8dde
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_ARB=: 16b8ddf
  GL_MAX_GEOMETRY_OUTPUT_VERTICES_ARB=: 16b8de0
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_ARB=: 16b8de1
  GL_HALF_FLOAT=: 16b140b
  GL_VERTEX_ATTRIB_ARRAY_DIVISOR_ARB=: 16b88fe
  GL_MAP_READ_BIT=: 16b0001
  GL_MAP_WRITE_BIT=: 16b0002
  GL_MAP_INVALIDATE_RANGE_BIT=: 16b0004
  GL_MAP_INVALIDATE_BUFFER_BIT=: 16b0008
  GL_MAP_FLUSH_EXPLICIT_BIT=: 16b0010
  GL_MAP_UNSYNCHRONIZED_BIT=: 16b0020
  GL_TEXTURE_BUFFER_ARB=: 16b8c2a
  GL_MAX_TEXTURE_BUFFER_SIZE_ARB=: 16b8c2b
  GL_TEXTURE_BINDING_BUFFER_ARB=: 16b8c2c
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING_ARB=: 16b8c2d
  GL_TEXTURE_BUFFER_FORMAT_ARB=: 16b8c2e
  GL_COMPRESSED_RED_RGTC1=: 16b8dbb
  GL_COMPRESSED_SIGNED_RED_RGTC1=: 16b8dbc
  GL_COMPRESSED_RG_RGTC2=: 16b8dbd
  GL_COMPRESSED_SIGNED_RG_RGTC2=: 16b8dbe
  GL_RG=: 16b8227
  GL_RG_INTEGER=: 16b8228
  GL_R8=: 16b8229
  GL_R16=: 16b822a
  GL_RG8=: 16b822b
  GL_RG16=: 16b822c
  GL_R16F=: 16b822d
  GL_R32F=: 16b822e
  GL_RG16F=: 16b822f
  GL_RG32F=: 16b8230
  GL_R8I=: 16b8231
  GL_R8UI=: 16b8232
  GL_R16I=: 16b8233
  GL_R16UI=: 16b8234
  GL_R32I=: 16b8235
  GL_R32UI=: 16b8236
  GL_RG8I=: 16b8237
  GL_RG8UI=: 16b8238
  GL_RG16I=: 16b8239
  GL_RG16UI=: 16b823a
  GL_RG32I=: 16b823b
  GL_RG32UI=: 16b823c
  GL_VERTEX_ARRAY_BINDING=: 16b85b5
  GL_UNIFORM_BUFFER=: 16b8a11
  GL_UNIFORM_BUFFER_BINDING=: 16b8a28
  GL_UNIFORM_BUFFER_START=: 16b8a29
  GL_UNIFORM_BUFFER_SIZE=: 16b8a2a
  GL_MAX_VERTEX_UNIFORM_BLOCKS=: 16b8a2b
  GL_MAX_GEOMETRY_UNIFORM_BLOCKS=: 16b8a2c
  GL_MAX_FRAGMENT_UNIFORM_BLOCKS=: 16b8a2d
  GL_MAX_COMBINED_UNIFORM_BLOCKS=: 16b8a2e
  GL_MAX_UNIFORM_BUFFER_BINDINGS=: 16b8a2f
  GL_MAX_UNIFORM_BLOCK_SIZE=: 16b8a30
  GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS=: 16b8a31
  GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS=: 16b8a32
  GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS=: 16b8a33
  GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT=: 16b8a34
  GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH=: 16b8a35
  GL_ACTIVE_UNIFORM_BLOCKS=: 16b8a36
  GL_UNIFORM_TYPE=: 16b8a37
  GL_UNIFORM_SIZE=: 16b8a38
  GL_UNIFORM_NAME_LENGTH=: 16b8a39
  GL_UNIFORM_BLOCK_INDEX=: 16b8a3a
  GL_UNIFORM_OFFSET=: 16b8a3b
  GL_UNIFORM_ARRAY_STRIDE=: 16b8a3c
  GL_UNIFORM_MATRIX_STRIDE=: 16b8a3d
  GL_UNIFORM_IS_ROW_MAJOR=: 16b8a3e
  GL_UNIFORM_BLOCK_BINDING=: 16b8a3f
  GL_UNIFORM_BLOCK_DATA_SIZE=: 16b8a40
  GL_UNIFORM_BLOCK_NAME_LENGTH=: 16b8a41
  GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS=: 16b8a42
  GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES=: 16b8a43
  GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER=: 16b8a44
  GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER=: 16b8a45
  GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER=: 16b8a46
  GL_INVALID_INDEX=: _1
  GL_COPY_READ_BUFFER=: 16b8f36
  GL_COPY_WRITE_BUFFER=: 16b8f37
  GL_DEPTH_CLAMP=: 16b864f
  GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION=: 16b8e4c
  GL_FIRST_VERTEX_CONVENTION=: 16b8e4d
  GL_LAST_VERTEX_CONVENTION=: 16b8e4e
  GL_PROVOKING_VERTEX=: 16b8e4f
  GL_TEXTURE_CUBE_MAP_SEAMLESS=: 16b884f
  GL_MAX_SERVER_WAIT_TIMEOUT=: 16b9111
  GL_OBJECT_TYPE=: 16b9112
  GL_SYNC_CONDITION=: 16b9113
  GL_SYNC_STATUS=: 16b9114
  GL_SYNC_FLAGS=: 16b9115
  GL_SYNC_FENCE=: 16b9116
  GL_SYNC_GPU_COMMANDS_COMPLETE=: 16b9117
  GL_UNSIGNALED=: 16b9118
  GL_SIGNALED=: 16b9119
  GL_ALREADY_SIGNALED=: 16b911a
  GL_TIMEOUT_EXPIRED=: 16b911b
  GL_CONDITION_SATISFIED=: 16b911c
  GL_WAIT_FAILED=: 16b911d
  GL_SYNC_FLUSH_COMMANDS_BIT=: 16b00000001
  GL_TIMEOUT_IGNORED=: _1
  GL_SAMPLE_POSITION=: 16b8e50
  GL_SAMPLE_MASK=: 16b8e51
  GL_SAMPLE_MASK_VALUE=: 16b8e52
  GL_MAX_SAMPLE_MASK_WORDS=: 16b8e59
  GL_TEXTURE_2D_MULTISAMPLE=: 16b9100
  GL_PROXY_TEXTURE_2D_MULTISAMPLE=: 16b9101
  GL_TEXTURE_2D_MULTISAMPLE_ARRAY=: 16b9102
  GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY=: 16b9103
  GL_TEXTURE_BINDING_2D_MULTISAMPLE=: 16b9104
  GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY=: 16b9105
  GL_TEXTURE_SAMPLES=: 16b9106
  GL_TEXTURE_FIXED_SAMPLE_LOCATIONS=: 16b9107
  GL_SAMPLER_2D_MULTISAMPLE=: 16b9108
  GL_INT_SAMPLER_2D_MULTISAMPLE=: 16b9109
  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE=: 16b910a
  GL_SAMPLER_2D_MULTISAMPLE_ARRAY=: 16b910b
  GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY=: 16b910c
  GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY=: 16b910d
  GL_MAX_COLOR_TEXTURE_SAMPLES=: 16b910e
  GL_MAX_DEPTH_TEXTURE_SAMPLES=: 16b910f
  GL_MAX_INTEGER_SAMPLES=: 16b9110
  GL_SAMPLE_SHADING_ARB=: 16b8c36
  GL_MIN_SAMPLE_SHADING_VALUE_ARB=: 16b8c37
  GL_TEXTURE_CUBE_MAP_ARRAY_ARB=: 16b9009
  GL_TEXTURE_BINDING_CUBE_MAP_ARRAY_ARB=: 16b900a
  GL_PROXY_TEXTURE_CUBE_MAP_ARRAY_ARB=: 16b900b
  GL_SAMPLER_CUBE_MAP_ARRAY_ARB=: 16b900c
  GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW_ARB=: 16b900d
  GL_INT_SAMPLER_CUBE_MAP_ARRAY_ARB=: 16b900e
  GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY_ARB=: 16b900f
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_ARB=: 16b8e5e
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_ARB=: 16b8e5f
  GL_SHADER_INCLUDE_ARB=: 16b8dae
  GL_NAMED_STRING_LENGTH_ARB=: 16b8de9
  GL_NAMED_STRING_TYPE_ARB=: 16b8dea
  GL_COMPRESSED_RGBA_BPTC_UNORM_ARB=: 16b8e8c
  GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM_ARB=: 16b8e8d
  GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT_ARB=: 16b8e8e
  GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT_ARB=: 16b8e8f
  GL_SRC1_COLOR=: 16b88f9
  GL_ONE_MINUS_SRC1_COLOR=: 16b88fa
  GL_ONE_MINUS_SRC1_ALPHA=: 16b88fb
  GL_MAX_DUAL_SOURCE_DRAW_BUFFERS=: 16b88fc
  GL_ANY_SAMPLES_PASSED=: 16b8c2f
  GL_SAMPLER_BINDING=: 16b8919
  GL_RGB10_A2UI=: 16b906f
  GL_TEXTURE_SWIZZLE_R=: 16b8e42
  GL_TEXTURE_SWIZZLE_G=: 16b8e43
  GL_TEXTURE_SWIZZLE_B=: 16b8e44
  GL_TEXTURE_SWIZZLE_A=: 16b8e45
  GL_TEXTURE_SWIZZLE_RGBA=: 16b8e46
  GL_TIME_ELAPSED=: 16b88bf
  GL_TIMESTAMP=: 16b8e28
  GL_INT_2_10_10_10_REV=: 16b8d9f
  GL_DRAW_INDIRECT_BUFFER=: 16b8f3f
  GL_DRAW_INDIRECT_BUFFER_BINDING=: 16b8f43
  GL_GEOMETRY_SHADER_INVOCATIONS=: 16b887f
  GL_MAX_GEOMETRY_SHADER_INVOCATIONS=: 16b8e5a
  GL_MIN_FRAGMENT_INTERPOLATION_OFFSET=: 16b8e5b
  GL_MAX_FRAGMENT_INTERPOLATION_OFFSET=: 16b8e5c
  GL_FRAGMENT_INTERPOLATION_OFFSET_BITS=: 16b8e5d
  GL_DOUBLE_VEC2=: 16b8ffc
  GL_DOUBLE_VEC3=: 16b8ffd
  GL_DOUBLE_VEC4=: 16b8ffe
  GL_DOUBLE_MAT2=: 16b8f46
  GL_DOUBLE_MAT3=: 16b8f47
  GL_DOUBLE_MAT4=: 16b8f48
  GL_DOUBLE_MAT2x3=: 16b8f49
  GL_DOUBLE_MAT2x4=: 16b8f4a
  GL_DOUBLE_MAT3x2=: 16b8f4b
  GL_DOUBLE_MAT3x4=: 16b8f4c
  GL_DOUBLE_MAT4x2=: 16b8f4d
  GL_DOUBLE_MAT4x3=: 16b8f4e
  GL_ACTIVE_SUBROUTINES=: 16b8de5
  GL_ACTIVE_SUBROUTINE_UNIFORMS=: 16b8de6
  GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS=: 16b8e47
  GL_ACTIVE_SUBROUTINE_MAX_LENGTH=: 16b8e48
  GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH=: 16b8e49
  GL_MAX_SUBROUTINES=: 16b8de7
  GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS=: 16b8de8
  GL_NUM_COMPATIBLE_SUBROUTINES=: 16b8e4a
  GL_COMPATIBLE_SUBROUTINES=: 16b8e4b
  GL_PATCHES=: 16b000e
  GL_PATCH_VERTICES=: 16b8e72
  GL_PATCH_DEFAULT_INNER_LEVEL=: 16b8e73
  GL_PATCH_DEFAULT_OUTER_LEVEL=: 16b8e74
  GL_TESS_CONTROL_OUTPUT_VERTICES=: 16b8e75
  GL_TESS_GEN_MODE=: 16b8e76
  GL_TESS_GEN_SPACING=: 16b8e77
  GL_TESS_GEN_VERTEX_ORDER=: 16b8e78
  GL_TESS_GEN_POINT_MODE=: 16b8e79
  GL_ISOLINES=: 16b8e7a
  GL_FRACTIONAL_ODD=: 16b8e7b
  GL_FRACTIONAL_EVEN=: 16b8e7c
  GL_MAX_PATCH_VERTICES=: 16b8e7d
  GL_MAX_TESS_GEN_LEVEL=: 16b8e7e
  GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS=: 16b8e7f
  GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS=: 16b8e80
  GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS=: 16b8e81
  GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS=: 16b8e82
  GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS=: 16b8e83
  GL_MAX_TESS_PATCH_COMPONENTS=: 16b8e84
  GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS=: 16b8e85
  GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS=: 16b8e86
  GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS=: 16b8e89
  GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS=: 16b8e8a
  GL_MAX_TESS_CONTROL_INPUT_COMPONENTS=: 16b886c
  GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS=: 16b886d
  GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS=: 16b8e1e
  GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS=: 16b8e1f
  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER=: 16b84f0
  GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER=: 16b84f1
  GL_TESS_EVALUATION_SHADER=: 16b8e87
  GL_TESS_CONTROL_SHADER=: 16b8e88
  GL_TRANSFORM_FEEDBACK=: 16b8e22
  GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED=: 16b8e23
  GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE=: 16b8e24
  GL_TRANSFORM_FEEDBACK_BINDING=: 16b8e25
  GL_MAX_TRANSFORM_FEEDBACK_BUFFERS=: 16b8e70
  GL_MAX_VERTEX_STREAMS=: 16b8e71
  GL_FIXED=: 16b140c
  GL_IMPLEMENTATION_COLOR_READ_TYPE=: 16b8b9a
  GL_IMPLEMENTATION_COLOR_READ_FORMAT=: 16b8b9b
  GL_LOW_FLOAT=: 16b8df0
  GL_MEDIUM_FLOAT=: 16b8df1
  GL_HIGH_FLOAT=: 16b8df2
  GL_LOW_INT=: 16b8df3
  GL_MEDIUM_INT=: 16b8df4
  GL_HIGH_INT=: 16b8df5
  GL_SHADER_COMPILER=: 16b8dfa
  GL_NUM_SHADER_BINARY_FORMATS=: 16b8df9
  GL_MAX_VERTEX_UNIFORM_VECTORS=: 16b8dfb
  GL_MAX_VARYING_VECTORS=: 16b8dfc
  GL_MAX_FRAGMENT_UNIFORM_VECTORS=: 16b8dfd
  GL_PROGRAM_BINARY_RETRIEVABLE_HINT=: 16b8257
  GL_PROGRAM_BINARY_LENGTH=: 16b8741
  GL_NUM_PROGRAM_BINARY_FORMATS=: 16b87fe
  GL_PROGRAM_BINARY_FORMATS=: 16b87ff
  GL_VERTEX_SHADER_BIT=: 16b00000001
  GL_FRAGMENT_SHADER_BIT=: 16b00000002
  GL_GEOMETRY_SHADER_BIT=: 16b00000004
  GL_TESS_CONTROL_SHADER_BIT=: 16b00000008
  GL_TESS_EVALUATION_SHADER_BIT=: 16b00000010
  GL_ALL_SHADER_BITS=: _1
  GL_PROGRAM_SEPARABLE=: 16b8258
  GL_ACTIVE_PROGRAM=: 16b8259
  GL_PROGRAM_PIPELINE_BINDING=: 16b825a
  GL_MAX_VIEWPORTS=: 16b825b
  GL_VIEWPORT_SUBPIXEL_BITS=: 16b825c
  GL_VIEWPORT_BOUNDS_RANGE=: 16b825d
  GL_LAYER_PROVOKING_VERTEX=: 16b825e
  GL_VIEWPORT_INDEX_PROVOKING_VERTEX=: 16b825f
  GL_UNDEFINED_VERTEX=: 16b8260
  GL_SYNC_CL_EVENT_ARB=: 16b8240
  GL_SYNC_CL_EVENT_COMPLETE_ARB=: 16b8241
  GL_DEBUG_OUTPUT_SYNCHRONOUS_ARB=: 16b8242
  GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH_ARB=: 16b8243
  GL_DEBUG_CALLBACK_FUNCTION_ARB=: 16b8244
  GL_DEBUG_CALLBACK_USER_PARAM_ARB=: 16b8245
  GL_DEBUG_SOURCE_API_ARB=: 16b8246
  GL_DEBUG_SOURCE_WINDOW_SYSTEM_ARB=: 16b8247
  GL_DEBUG_SOURCE_SHADER_COMPILER_ARB=: 16b8248
  GL_DEBUG_SOURCE_THIRD_PARTY_ARB=: 16b8249
  GL_DEBUG_SOURCE_APPLICATION_ARB=: 16b824a
  GL_DEBUG_SOURCE_OTHER_ARB=: 16b824b
  GL_DEBUG_TYPE_ERROR_ARB=: 16b824c
  GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR_ARB=: 16b824d
  GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR_ARB=: 16b824e
  GL_DEBUG_TYPE_PORTABILITY_ARB=: 16b824f
  GL_DEBUG_TYPE_PERFORMANCE_ARB=: 16b8250
  GL_DEBUG_TYPE_OTHER_ARB=: 16b8251
  GL_MAX_DEBUG_MESSAGE_LENGTH_ARB=: 16b9143
  GL_MAX_DEBUG_LOGGED_MESSAGES_ARB=: 16b9144
  GL_DEBUG_LOGGED_MESSAGES_ARB=: 16b9145
  GL_DEBUG_SEVERITY_HIGH_ARB=: 16b9146
  GL_DEBUG_SEVERITY_MEDIUM_ARB=: 16b9147
  GL_DEBUG_SEVERITY_LOW_ARB=: 16b9148
  GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT_ARB=: 16b00000004
  GL_LOSE_CONTEXT_ON_RESET_ARB=: 16b8252
  GL_GUILTY_CONTEXT_RESET_ARB=: 16b8253
  GL_INNOCENT_CONTEXT_RESET_ARB=: 16b8254
  GL_UNKNOWN_CONTEXT_RESET_ARB=: 16b8255
  GL_RESET_NOTIFICATION_STRATEGY_ARB=: 16b8256
  GL_NO_RESET_NOTIFICATION_ARB=: 16b8261
  GL_UNPACK_COMPRESSED_BLOCK_WIDTH=: 16b9127
  GL_UNPACK_COMPRESSED_BLOCK_HEIGHT=: 16b9128
  GL_UNPACK_COMPRESSED_BLOCK_DEPTH=: 16b9129
  GL_UNPACK_COMPRESSED_BLOCK_SIZE=: 16b912a
  GL_PACK_COMPRESSED_BLOCK_WIDTH=: 16b912b
  GL_PACK_COMPRESSED_BLOCK_HEIGHT=: 16b912c
  GL_PACK_COMPRESSED_BLOCK_DEPTH=: 16b912d
  GL_PACK_COMPRESSED_BLOCK_SIZE=: 16b912e
  GL_NUM_SAMPLE_COUNTS=: 16b9380
  GL_MIN_MAP_BUFFER_ALIGNMENT=: 16b90bc
  GL_ATOMIC_COUNTER_BUFFER=: 16b92c0
  GL_ATOMIC_COUNTER_BUFFER_BINDING=: 16b92c1
  GL_ATOMIC_COUNTER_BUFFER_START=: 16b92c2
  GL_ATOMIC_COUNTER_BUFFER_SIZE=: 16b92c3
  GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE=: 16b92c4
  GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS=: 16b92c5
  GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES=: 16b92c6
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER=: 16b92c7
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER=: 16b92c8
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER=: 16b92c9
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER=: 16b92ca
  GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER=: 16b92cb
  GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS=: 16b92cc
  GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS=: 16b92cd
  GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS=: 16b92ce
  GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS=: 16b92cf
  GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS=: 16b92d0
  GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS=: 16b92d1
  GL_MAX_VERTEX_ATOMIC_COUNTERS=: 16b92d2
  GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS=: 16b92d3
  GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS=: 16b92d4
  GL_MAX_GEOMETRY_ATOMIC_COUNTERS=: 16b92d5
  GL_MAX_FRAGMENT_ATOMIC_COUNTERS=: 16b92d6
  GL_MAX_COMBINED_ATOMIC_COUNTERS=: 16b92d7
  GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE=: 16b92d8
  GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS=: 16b92dc
  GL_ACTIVE_ATOMIC_COUNTER_BUFFERS=: 16b92d9
  GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX=: 16b92da
  GL_UNSIGNED_INT_ATOMIC_COUNTER=: 16b92db
  GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT=: 16b00000001
  GL_ELEMENT_ARRAY_BARRIER_BIT=: 16b00000002
  GL_UNIFORM_BARRIER_BIT=: 16b00000004
  GL_TEXTURE_FETCH_BARRIER_BIT=: 16b00000008
  GL_SHADER_IMAGE_ACCESS_BARRIER_BIT=: 16b00000020
  GL_COMMAND_BARRIER_BIT=: 16b00000040
  GL_PIXEL_BUFFER_BARRIER_BIT=: 16b00000080
  GL_TEXTURE_UPDATE_BARRIER_BIT=: 16b00000100
  GL_BUFFER_UPDATE_BARRIER_BIT=: 16b00000200
  GL_FRAMEBUFFER_BARRIER_BIT=: 16b00000400
  GL_TRANSFORM_FEEDBACK_BARRIER_BIT=: 16b00000800
  GL_ATOMIC_COUNTER_BARRIER_BIT=: 16b00001000
  GL_ALL_BARRIER_BITS=: _1
  GL_MAX_IMAGE_UNITS=: 16b8f38
  GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS=: 16b8f39
  GL_IMAGE_BINDING_NAME=: 16b8f3a
  GL_IMAGE_BINDING_LEVEL=: 16b8f3b
  GL_IMAGE_BINDING_LAYERED=: 16b8f3c
  GL_IMAGE_BINDING_LAYER=: 16b8f3d
  GL_IMAGE_BINDING_ACCESS=: 16b8f3e
  GL_IMAGE_1D=: 16b904c
  GL_IMAGE_2D=: 16b904d
  GL_IMAGE_3D=: 16b904e
  GL_IMAGE_2D_RECT=: 16b904f
  GL_IMAGE_CUBE=: 16b9050
  GL_IMAGE_BUFFER=: 16b9051
  GL_IMAGE_1D_ARRAY=: 16b9052
  GL_IMAGE_2D_ARRAY=: 16b9053
  GL_IMAGE_CUBE_MAP_ARRAY=: 16b9054
  GL_IMAGE_2D_MULTISAMPLE=: 16b9055
  GL_IMAGE_2D_MULTISAMPLE_ARRAY=: 16b9056
  GL_INT_IMAGE_1D=: 16b9057
  GL_INT_IMAGE_2D=: 16b9058
  GL_INT_IMAGE_3D=: 16b9059
  GL_INT_IMAGE_2D_RECT=: 16b905a
  GL_INT_IMAGE_CUBE=: 16b905b
  GL_INT_IMAGE_BUFFER=: 16b905c
  GL_INT_IMAGE_1D_ARRAY=: 16b905d
  GL_INT_IMAGE_2D_ARRAY=: 16b905e
  GL_INT_IMAGE_CUBE_MAP_ARRAY=: 16b905f
  GL_INT_IMAGE_2D_MULTISAMPLE=: 16b9060
  GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY=: 16b9061
  GL_UNSIGNED_INT_IMAGE_1D=: 16b9062
  GL_UNSIGNED_INT_IMAGE_2D=: 16b9063
  GL_UNSIGNED_INT_IMAGE_3D=: 16b9064
  GL_UNSIGNED_INT_IMAGE_2D_RECT=: 16b9065
  GL_UNSIGNED_INT_IMAGE_CUBE=: 16b9066
  GL_UNSIGNED_INT_IMAGE_BUFFER=: 16b9067
  GL_UNSIGNED_INT_IMAGE_1D_ARRAY=: 16b9068
  GL_UNSIGNED_INT_IMAGE_2D_ARRAY=: 16b9069
  GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY=: 16b906a
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE=: 16b906b
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY=: 16b906c
  GL_MAX_IMAGE_SAMPLES=: 16b906d
  GL_IMAGE_BINDING_FORMAT=: 16b906e
  GL_IMAGE_FORMAT_COMPATIBILITY_TYPE=: 16b90c7
  GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE=: 16b90c8
  GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS=: 16b90c9
  GL_MAX_VERTEX_IMAGE_UNIFORMS=: 16b90ca
  GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS=: 16b90cb
  GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS=: 16b90cc
  GL_MAX_GEOMETRY_IMAGE_UNIFORMS=: 16b90cd
  GL_MAX_FRAGMENT_IMAGE_UNIFORMS=: 16b90ce
  GL_MAX_COMBINED_IMAGE_UNIFORMS=: 16b90cf
  GL_TEXTURE_IMMUTABLE_FORMAT=: 16b912f
  GL_ABGR_EXT=: 16b8000
  GL_CONSTANT_COLOR_EXT=: 16b8001
  GL_ONE_MINUS_CONSTANT_COLOR_EXT=: 16b8002
  GL_CONSTANT_ALPHA_EXT=: 16b8003
  GL_ONE_MINUS_CONSTANT_ALPHA_EXT=: 16b8004
  GL_BLEND_COLOR_EXT=: 16b8005
  GL_POLYGON_OFFSET_EXT=: 16b8037
  GL_POLYGON_OFFSET_FACTOR_EXT=: 16b8038
  GL_POLYGON_OFFSET_BIAS_EXT=: 16b8039
  GL_ALPHA4_EXT=: 16b803b
  GL_ALPHA8_EXT=: 16b803c
  GL_ALPHA12_EXT=: 16b803d
  GL_ALPHA16_EXT=: 16b803e
  GL_LUMINANCE4_EXT=: 16b803f
  GL_LUMINANCE8_EXT=: 16b8040
  GL_LUMINANCE12_EXT=: 16b8041
  GL_LUMINANCE16_EXT=: 16b8042
  GL_LUMINANCE4_ALPHA4_EXT=: 16b8043
  GL_LUMINANCE6_ALPHA2_EXT=: 16b8044
  GL_LUMINANCE8_ALPHA8_EXT=: 16b8045
  GL_LUMINANCE12_ALPHA4_EXT=: 16b8046
  GL_LUMINANCE12_ALPHA12_EXT=: 16b8047
  GL_LUMINANCE16_ALPHA16_EXT=: 16b8048
  GL_INTENSITY_EXT=: 16b8049
  GL_INTENSITY4_EXT=: 16b804a
  GL_INTENSITY8_EXT=: 16b804b
  GL_INTENSITY12_EXT=: 16b804c
  GL_INTENSITY16_EXT=: 16b804d
  GL_RGB2_EXT=: 16b804e
  GL_RGB4_EXT=: 16b804f
  GL_RGB5_EXT=: 16b8050
  GL_RGB8_EXT=: 16b8051
  GL_RGB10_EXT=: 16b8052
  GL_RGB12_EXT=: 16b8053
  GL_RGB16_EXT=: 16b8054
  GL_RGBA2_EXT=: 16b8055
  GL_RGBA4_EXT=: 16b8056
  GL_RGB5_A1_EXT=: 16b8057
  GL_RGBA8_EXT=: 16b8058
  GL_RGB10_A2_EXT=: 16b8059
  GL_RGBA12_EXT=: 16b805a
  GL_RGBA16_EXT=: 16b805b
  GL_TEXTURE_RED_SIZE_EXT=: 16b805c
  GL_TEXTURE_GREEN_SIZE_EXT=: 16b805d
  GL_TEXTURE_BLUE_SIZE_EXT=: 16b805e
  GL_TEXTURE_ALPHA_SIZE_EXT=: 16b805f
  GL_TEXTURE_LUMINANCE_SIZE_EXT=: 16b8060
  GL_TEXTURE_INTENSITY_SIZE_EXT=: 16b8061
  GL_REPLACE_EXT=: 16b8062
  GL_PROXY_TEXTURE_1D_EXT=: 16b8063
  GL_PROXY_TEXTURE_2D_EXT=: 16b8064
  GL_TEXTURE_TOO_LARGE_EXT=: 16b8065
  GL_PACK_SKIP_IMAGES_EXT=: 16b806b
  GL_PACK_IMAGE_HEIGHT_EXT=: 16b806c
  GL_UNPACK_SKIP_IMAGES_EXT=: 16b806d
  GL_UNPACK_IMAGE_HEIGHT_EXT=: 16b806e
  GL_TEXTURE_3D_EXT=: 16b806f
  GL_PROXY_TEXTURE_3D_EXT=: 16b8070
  GL_TEXTURE_DEPTH_EXT=: 16b8071
  GL_TEXTURE_WRAP_R_EXT=: 16b8072
  GL_MAX_3D_TEXTURE_SIZE_EXT=: 16b8073
  GL_FILTER4_SGIS=: 16b8146
  GL_TEXTURE_FILTER4_SIZE_SGIS=: 16b8147
  GL_HISTOGRAM_EXT=: 16b8024
  GL_PROXY_HISTOGRAM_EXT=: 16b8025
  GL_HISTOGRAM_WIDTH_EXT=: 16b8026
  GL_HISTOGRAM_FORMAT_EXT=: 16b8027
  GL_HISTOGRAM_RED_SIZE_EXT=: 16b8028
  GL_HISTOGRAM_GREEN_SIZE_EXT=: 16b8029
  GL_HISTOGRAM_BLUE_SIZE_EXT=: 16b802a
  GL_HISTOGRAM_ALPHA_SIZE_EXT=: 16b802b
  GL_HISTOGRAM_LUMINANCE_SIZE_EXT=: 16b802c
  GL_HISTOGRAM_SINK_EXT=: 16b802d
  GL_MINMAX_EXT=: 16b802e
  GL_MINMAX_FORMAT_EXT=: 16b802f
  GL_MINMAX_SINK_EXT=: 16b8030
  GL_TABLE_TOO_LARGE_EXT=: 16b8031
  GL_CONVOLUTION_1D_EXT=: 16b8010
  GL_CONVOLUTION_2D_EXT=: 16b8011
  GL_SEPARABLE_2D_EXT=: 16b8012
  GL_CONVOLUTION_BORDER_MODE_EXT=: 16b8013
  GL_CONVOLUTION_FILTER_SCALE_EXT=: 16b8014
  GL_CONVOLUTION_FILTER_BIAS_EXT=: 16b8015
  GL_REDUCE_EXT=: 16b8016
  GL_CONVOLUTION_FORMAT_EXT=: 16b8017
  GL_CONVOLUTION_WIDTH_EXT=: 16b8018
  GL_CONVOLUTION_HEIGHT_EXT=: 16b8019
  GL_MAX_CONVOLUTION_WIDTH_EXT=: 16b801a
  GL_MAX_CONVOLUTION_HEIGHT_EXT=: 16b801b
  GL_POST_CONVOLUTION_RED_SCALE_EXT=: 16b801c
  GL_POST_CONVOLUTION_GREEN_SCALE_EXT=: 16b801d
  GL_POST_CONVOLUTION_BLUE_SCALE_EXT=: 16b801e
  GL_POST_CONVOLUTION_ALPHA_SCALE_EXT=: 16b801f
  GL_POST_CONVOLUTION_RED_BIAS_EXT=: 16b8020
  GL_POST_CONVOLUTION_GREEN_BIAS_EXT=: 16b8021
  GL_POST_CONVOLUTION_BLUE_BIAS_EXT=: 16b8022
  GL_POST_CONVOLUTION_ALPHA_BIAS_EXT=: 16b8023
  GL_COLOR_MATRIX_SGI=: 16b80b1
  GL_COLOR_MATRIX_STACK_DEPTH_SGI=: 16b80b2
  GL_MAX_COLOR_MATRIX_STACK_DEPTH_SGI=: 16b80b3
  GL_POST_COLOR_MATRIX_RED_SCALE_SGI=: 16b80b4
  GL_POST_COLOR_MATRIX_GREEN_SCALE_SGI=: 16b80b5
  GL_POST_COLOR_MATRIX_BLUE_SCALE_SGI=: 16b80b6
  GL_POST_COLOR_MATRIX_ALPHA_SCALE_SGI=: 16b80b7
  GL_POST_COLOR_MATRIX_RED_BIAS_SGI=: 16b80b8
  GL_POST_COLOR_MATRIX_GREEN_BIAS_SGI=: 16b80b9
  GL_POST_COLOR_MATRIX_BLUE_BIAS_SGI=: 16b80ba
  GL_POST_COLOR_MATRIX_ALPHA_BIAS_SGI=: 16b80bb
  GL_COLOR_TABLE_SGI=: 16b80d0
  GL_POST_CONVOLUTION_COLOR_TABLE_SGI=: 16b80d1
  GL_POST_COLOR_MATRIX_COLOR_TABLE_SGI=: 16b80d2
  GL_PROXY_COLOR_TABLE_SGI=: 16b80d3
  GL_PROXY_POST_CONVOLUTION_COLOR_TABLE_SGI=: 16b80d4
  GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE_SGI=: 16b80d5
  GL_COLOR_TABLE_SCALE_SGI=: 16b80d6
  GL_COLOR_TABLE_BIAS_SGI=: 16b80d7
  GL_COLOR_TABLE_FORMAT_SGI=: 16b80d8
  GL_COLOR_TABLE_WIDTH_SGI=: 16b80d9
  GL_COLOR_TABLE_RED_SIZE_SGI=: 16b80da
  GL_COLOR_TABLE_GREEN_SIZE_SGI=: 16b80db
  GL_COLOR_TABLE_BLUE_SIZE_SGI=: 16b80dc
  GL_COLOR_TABLE_ALPHA_SIZE_SGI=: 16b80dd
  GL_COLOR_TABLE_LUMINANCE_SIZE_SGI=: 16b80de
  GL_COLOR_TABLE_INTENSITY_SIZE_SGI=: 16b80df
  GL_PIXEL_TEXTURE_SGIS=: 16b8353
  GL_PIXEL_FRAGMENT_RGB_SOURCE_SGIS=: 16b8354
  GL_PIXEL_FRAGMENT_ALPHA_SOURCE_SGIS=: 16b8355
  GL_PIXEL_GROUP_COLOR_SGIS=: 16b8356
  GL_PIXEL_TEX_GEN_SGIX=: 16b8139
  GL_PIXEL_TEX_GEN_MODE_SGIX=: 16b832b
  GL_PACK_SKIP_VOLUMES_SGIS=: 16b8130
  GL_PACK_IMAGE_DEPTH_SGIS=: 16b8131
  GL_UNPACK_SKIP_VOLUMES_SGIS=: 16b8132
  GL_UNPACK_IMAGE_DEPTH_SGIS=: 16b8133
  GL_TEXTURE_4D_SGIS=: 16b8134
  GL_PROXY_TEXTURE_4D_SGIS=: 16b8135
  GL_TEXTURE_4DSIZE_SGIS=: 16b8136
  GL_TEXTURE_WRAP_Q_SGIS=: 16b8137
  GL_MAX_4D_TEXTURE_SIZE_SGIS=: 16b8138
  GL_TEXTURE_4D_BINDING_SGIS=: 16b814f
  GL_TEXTURE_COLOR_TABLE_SGI=: 16b80bc
  GL_PROXY_TEXTURE_COLOR_TABLE_SGI=: 16b80bd
  GL_CMYK_EXT=: 16b800c
  GL_CMYKA_EXT=: 16b800d
  GL_PACK_CMYK_HINT_EXT=: 16b800e
  GL_UNPACK_CMYK_HINT_EXT=: 16b800f
  GL_TEXTURE_PRIORITY_EXT=: 16b8066
  GL_TEXTURE_RESIDENT_EXT=: 16b8067
  GL_TEXTURE_1D_BINDING_EXT=: 16b8068
  GL_TEXTURE_2D_BINDING_EXT=: 16b8069
  GL_TEXTURE_3D_BINDING_EXT=: 16b806a
  GL_DETAIL_TEXTURE_2D_SGIS=: 16b8095
  GL_DETAIL_TEXTURE_2D_BINDING_SGIS=: 16b8096
  GL_LINEAR_DETAIL_SGIS=: 16b8097
  GL_LINEAR_DETAIL_ALPHA_SGIS=: 16b8098
  GL_LINEAR_DETAIL_COLOR_SGIS=: 16b8099
  GL_DETAIL_TEXTURE_LEVEL_SGIS=: 16b809a
  GL_DETAIL_TEXTURE_MODE_SGIS=: 16b809b
  GL_DETAIL_TEXTURE_FUNC_POINTS_SGIS=: 16b809c
  GL_LINEAR_SHARPEN_SGIS=: 16b80ad
  GL_LINEAR_SHARPEN_ALPHA_SGIS=: 16b80ae
  GL_LINEAR_SHARPEN_COLOR_SGIS=: 16b80af
  GL_SHARPEN_TEXTURE_FUNC_POINTS_SGIS=: 16b80b0
  GL_UNSIGNED_BYTE_3_3_2_EXT=: 16b8032
  GL_UNSIGNED_SHORT_4_4_4_4_EXT=: 16b8033
  GL_UNSIGNED_SHORT_5_5_5_1_EXT=: 16b8034
  GL_UNSIGNED_INT_8_8_8_8_EXT=: 16b8035
  GL_UNSIGNED_INT_10_10_10_2_EXT=: 16b8036
  GL_TEXTURE_MIN_LOD_SGIS=: 16b813a
  GL_TEXTURE_MAX_LOD_SGIS=: 16b813b
  GL_TEXTURE_BASE_LEVEL_SGIS=: 16b813c
  GL_TEXTURE_MAX_LEVEL_SGIS=: 16b813d
  GL_MULTISAMPLE_SGIS=: 16b809d
  GL_SAMPLE_ALPHA_TO_MASK_SGIS=: 16b809e
  GL_SAMPLE_ALPHA_TO_ONE_SGIS=: 16b809f
  GL_SAMPLE_MASK_SGIS=: 16b80a0
  GL_1PASS_SGIS=: 16b80a1
  GL_2PASS_0_SGIS=: 16b80a2
  GL_2PASS_1_SGIS=: 16b80a3
  GL_4PASS_0_SGIS=: 16b80a4
  GL_4PASS_1_SGIS=: 16b80a5
  GL_4PASS_2_SGIS=: 16b80a6
  GL_4PASS_3_SGIS=: 16b80a7
  GL_SAMPLE_BUFFERS_SGIS=: 16b80a8
  GL_SAMPLES_SGIS=: 16b80a9
  GL_SAMPLE_MASK_VALUE_SGIS=: 16b80aa
  GL_SAMPLE_MASK_INVERT_SGIS=: 16b80ab
  GL_SAMPLE_PATTERN_SGIS=: 16b80ac
  GL_RESCALE_NORMAL_EXT=: 16b803a
  GL_VERTEX_ARRAY_EXT=: 16b8074
  GL_NORMAL_ARRAY_EXT=: 16b8075
  GL_COLOR_ARRAY_EXT=: 16b8076
  GL_INDEX_ARRAY_EXT=: 16b8077
  GL_TEXTURE_COORD_ARRAY_EXT=: 16b8078
  GL_EDGE_FLAG_ARRAY_EXT=: 16b8079
  GL_VERTEX_ARRAY_SIZE_EXT=: 16b807a
  GL_VERTEX_ARRAY_TYPE_EXT=: 16b807b
  GL_VERTEX_ARRAY_STRIDE_EXT=: 16b807c
  GL_VERTEX_ARRAY_COUNT_EXT=: 16b807d
  GL_NORMAL_ARRAY_TYPE_EXT=: 16b807e
  GL_NORMAL_ARRAY_STRIDE_EXT=: 16b807f
  GL_NORMAL_ARRAY_COUNT_EXT=: 16b8080
  GL_COLOR_ARRAY_SIZE_EXT=: 16b8081
  GL_COLOR_ARRAY_TYPE_EXT=: 16b8082
  GL_COLOR_ARRAY_STRIDE_EXT=: 16b8083
  GL_COLOR_ARRAY_COUNT_EXT=: 16b8084
  GL_INDEX_ARRAY_TYPE_EXT=: 16b8085
  GL_INDEX_ARRAY_STRIDE_EXT=: 16b8086
  GL_INDEX_ARRAY_COUNT_EXT=: 16b8087
  GL_TEXTURE_COORD_ARRAY_SIZE_EXT=: 16b8088
  GL_TEXTURE_COORD_ARRAY_TYPE_EXT=: 16b8089
  GL_TEXTURE_COORD_ARRAY_STRIDE_EXT=: 16b808a
  GL_TEXTURE_COORD_ARRAY_COUNT_EXT=: 16b808b
  GL_EDGE_FLAG_ARRAY_STRIDE_EXT=: 16b808c
  GL_EDGE_FLAG_ARRAY_COUNT_EXT=: 16b808d
  GL_VERTEX_ARRAY_POINTER_EXT=: 16b808e
  GL_NORMAL_ARRAY_POINTER_EXT=: 16b808f
  GL_COLOR_ARRAY_POINTER_EXT=: 16b8090
  GL_INDEX_ARRAY_POINTER_EXT=: 16b8091
  GL_TEXTURE_COORD_ARRAY_POINTER_EXT=: 16b8092
  GL_EDGE_FLAG_ARRAY_POINTER_EXT=: 16b8093
  GL_GENERATE_MIPMAP_SGIS=: 16b8191
  GL_GENERATE_MIPMAP_HINT_SGIS=: 16b8192
  GL_LINEAR_CLIPMAP_LINEAR_SGIX=: 16b8170
  GL_TEXTURE_CLIPMAP_CENTER_SGIX=: 16b8171
  GL_TEXTURE_CLIPMAP_FRAME_SGIX=: 16b8172
  GL_TEXTURE_CLIPMAP_OFFSET_SGIX=: 16b8173
  GL_TEXTURE_CLIPMAP_VIRTUAL_DEPTH_SGIX=: 16b8174
  GL_TEXTURE_CLIPMAP_LOD_OFFSET_SGIX=: 16b8175
  GL_TEXTURE_CLIPMAP_DEPTH_SGIX=: 16b8176
  GL_MAX_CLIPMAP_DEPTH_SGIX=: 16b8177
  GL_MAX_CLIPMAP_VIRTUAL_DEPTH_SGIX=: 16b8178
  GL_NEAREST_CLIPMAP_NEAREST_SGIX=: 16b844d
  GL_NEAREST_CLIPMAP_LINEAR_SGIX=: 16b844e
  GL_LINEAR_CLIPMAP_NEAREST_SGIX=: 16b844f
  GL_TEXTURE_COMPARE_SGIX=: 16b819a
  GL_TEXTURE_COMPARE_OPERATOR_SGIX=: 16b819b
  GL_TEXTURE_LEQUAL_R_SGIX=: 16b819c
  GL_TEXTURE_GEQUAL_R_SGIX=: 16b819d
  GL_CLAMP_TO_EDGE_SGIS=: 16b812f
  GL_CLAMP_TO_BORDER_SGIS=: 16b812d
  GL_FUNC_ADD_EXT=: 16b8006
  GL_MIN_EXT=: 16b8007
  GL_MAX_EXT=: 16b8008
  GL_BLEND_EQUATION_EXT=: 16b8009
  GL_FUNC_SUBTRACT_EXT=: 16b800a
  GL_FUNC_REVERSE_SUBTRACT_EXT=: 16b800b
  GL_INTERLACE_SGIX=: 16b8094
  GL_PIXEL_TILE_BEST_ALIGNMENT_SGIX=: 16b813e
  GL_PIXEL_TILE_CACHE_INCREMENT_SGIX=: 16b813f
  GL_PIXEL_TILE_WIDTH_SGIX=: 16b8140
  GL_PIXEL_TILE_HEIGHT_SGIX=: 16b8141
  GL_PIXEL_TILE_GRID_WIDTH_SGIX=: 16b8142
  GL_PIXEL_TILE_GRID_HEIGHT_SGIX=: 16b8143
  GL_PIXEL_TILE_GRID_DEPTH_SGIX=: 16b8144
  GL_PIXEL_TILE_CACHE_SIZE_SGIX=: 16b8145
  GL_DUAL_ALPHA4_SGIS=: 16b8110
  GL_DUAL_ALPHA8_SGIS=: 16b8111
  GL_DUAL_ALPHA12_SGIS=: 16b8112
  GL_DUAL_ALPHA16_SGIS=: 16b8113
  GL_DUAL_LUMINANCE4_SGIS=: 16b8114
  GL_DUAL_LUMINANCE8_SGIS=: 16b8115
  GL_DUAL_LUMINANCE12_SGIS=: 16b8116
  GL_DUAL_LUMINANCE16_SGIS=: 16b8117
  GL_DUAL_INTENSITY4_SGIS=: 16b8118
  GL_DUAL_INTENSITY8_SGIS=: 16b8119
  GL_DUAL_INTENSITY12_SGIS=: 16b811a
  GL_DUAL_INTENSITY16_SGIS=: 16b811b
  GL_DUAL_LUMINANCE_ALPHA4_SGIS=: 16b811c
  GL_DUAL_LUMINANCE_ALPHA8_SGIS=: 16b811d
  GL_QUAD_ALPHA4_SGIS=: 16b811e
  GL_QUAD_ALPHA8_SGIS=: 16b811f
  GL_QUAD_LUMINANCE4_SGIS=: 16b8120
  GL_QUAD_LUMINANCE8_SGIS=: 16b8121
  GL_QUAD_INTENSITY4_SGIS=: 16b8122
  GL_QUAD_INTENSITY8_SGIS=: 16b8123
  GL_DUAL_TEXTURE_SELECT_SGIS=: 16b8124
  GL_QUAD_TEXTURE_SELECT_SGIS=: 16b8125
  GL_SPRITE_SGIX=: 16b8148
  GL_SPRITE_MODE_SGIX=: 16b8149
  GL_SPRITE_AXIS_SGIX=: 16b814a
  GL_SPRITE_TRANSLATION_SGIX=: 16b814b
  GL_SPRITE_AXIAL_SGIX=: 16b814c
  GL_SPRITE_OBJECT_ALIGNED_SGIX=: 16b814d
  GL_SPRITE_EYE_ALIGNED_SGIX=: 16b814e
  GL_TEXTURE_MULTI_BUFFER_HINT_SGIX=: 16b812e
  GL_POINT_SIZE_MIN_EXT=: 16b8126
  GL_POINT_SIZE_MAX_EXT=: 16b8127
  GL_POINT_FADE_THRESHOLD_SIZE_EXT=: 16b8128
  GL_DISTANCE_ATTENUATION_EXT=: 16b8129
  GL_POINT_SIZE_MIN_SGIS=: 16b8126
  GL_POINT_SIZE_MAX_SGIS=: 16b8127
  GL_POINT_FADE_THRESHOLD_SIZE_SGIS=: 16b8128
  GL_DISTANCE_ATTENUATION_SGIS=: 16b8129
  GL_INSTRUMENT_BUFFER_POINTER_SGIX=: 16b8180
  GL_INSTRUMENT_MEASUREMENTS_SGIX=: 16b8181
  GL_POST_TEXTURE_FILTER_BIAS_SGIX=: 16b8179
  GL_POST_TEXTURE_FILTER_SCALE_SGIX=: 16b817a
  GL_POST_TEXTURE_FILTER_BIAS_RANGE_SGIX=: 16b817b
  GL_POST_TEXTURE_FILTER_SCALE_RANGE_SGIX=: 16b817c
  GL_FRAMEZOOM_SGIX=: 16b818b
  GL_FRAMEZOOM_FACTOR_SGIX=: 16b818c
  GL_MAX_FRAMEZOOM_FACTOR_SGIX=: 16b818d
  GL_TEXTURE_DEFORMATION_BIT_SGIX=: 16b00000001
  GL_GEOMETRY_DEFORMATION_BIT_SGIX=: 16b00000002
  GL_GEOMETRY_DEFORMATION_SGIX=: 16b8194
  GL_TEXTURE_DEFORMATION_SGIX=: 16b8195
  GL_DEFORMATIONS_MASK_SGIX=: 16b8196
  GL_MAX_DEFORMATION_ORDER_SGIX=: 16b8197
  GL_REFERENCE_PLANE_SGIX=: 16b817d
  GL_REFERENCE_PLANE_EQUATION_SGIX=: 16b817e
  GL_DEPTH_COMPONENT16_SGIX=: 16b81a5
  GL_DEPTH_COMPONENT24_SGIX=: 16b81a6
  GL_DEPTH_COMPONENT32_SGIX=: 16b81a7
  GL_FOG_FUNC_SGIS=: 16b812a
  GL_FOG_FUNC_POINTS_SGIS=: 16b812b
  GL_MAX_FOG_FUNC_POINTS_SGIS=: 16b812c
  GL_FOG_OFFSET_SGIX=: 16b8198
  GL_FOG_OFFSET_VALUE_SGIX=: 16b8199
  GL_IMAGE_SCALE_X_HP=: 16b8155
  GL_IMAGE_SCALE_Y_HP=: 16b8156
  GL_IMAGE_TRANSLATE_X_HP=: 16b8157
  GL_IMAGE_TRANSLATE_Y_HP=: 16b8158
  GL_IMAGE_ROTATE_ANGLE_HP=: 16b8159
  GL_IMAGE_ROTATE_ORIGIN_X_HP=: 16b815a
  GL_IMAGE_ROTATE_ORIGIN_Y_HP=: 16b815b
  GL_IMAGE_MAG_FILTER_HP=: 16b815c
  GL_IMAGE_MIN_FILTER_HP=: 16b815d
  GL_IMAGE_CUBIC_WEIGHT_HP=: 16b815e
  GL_CUBIC_HP=: 16b815f
  GL_AVERAGE_HP=: 16b8160
  GL_IMAGE_TRANSFORM_2D_HP=: 16b8161
  GL_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP=: 16b8162
  GL_PROXY_POST_IMAGE_TRANSFORM_COLOR_TABLE_HP=: 16b8163
  GL_IGNORE_BORDER_HP=: 16b8150
  GL_CONSTANT_BORDER_HP=: 16b8151
  GL_REPLICATE_BORDER_HP=: 16b8153
  GL_CONVOLUTION_BORDER_COLOR_HP=: 16b8154
  GL_TEXTURE_ENV_BIAS_SGIX=: 16b80be
  GL_VERTEX_DATA_HINT_PGI=: 16b1a22a
  GL_VERTEX_CONSISTENT_HINT_PGI=: 16b1a22b
  GL_MATERIAL_SIDE_HINT_PGI=: 16b1a22c
  GL_MAX_VERTEX_HINT_PGI=: 16b1a22d
  GL_COLOR3_BIT_PGI=: 16b00010000
  GL_COLOR4_BIT_PGI=: 16b00020000
  GL_EDGEFLAG_BIT_PGI=: 16b00040000
  GL_INDEX_BIT_PGI=: 16b00080000
  GL_MAT_AMBIENT_BIT_PGI=: 16b00100000
  GL_MAT_AMBIENT_AND_DIFFUSE_BIT_PGI=: 16b00200000
  GL_MAT_DIFFUSE_BIT_PGI=: 16b00400000
  GL_MAT_EMISSION_BIT_PGI=: 16b00800000
  GL_MAT_COLOR_INDEXES_BIT_PGI=: 16b01000000
  GL_MAT_SHININESS_BIT_PGI=: 16b02000000
  GL_MAT_SPECULAR_BIT_PGI=: 16b04000000
  GL_NORMAL_BIT_PGI=: 16b08000000
  GL_TEXCOORD1_BIT_PGI=: 16b10000000
  GL_TEXCOORD2_BIT_PGI=: 16b20000000
  GL_TEXCOORD3_BIT_PGI=: 16b40000000
  GL_TEXCOORD4_BIT_PGI=: 16b80000000
  GL_VERTEX23_BIT_PGI=: 16b00000004
  GL_VERTEX4_BIT_PGI=: 16b00000008
  GL_PREFER_DOUBLEBUFFER_HINT_PGI=: 16b1a1f8
  GL_CONSERVE_MEMORY_HINT_PGI=: 16b1a1fd
  GL_RECLAIM_MEMORY_HINT_PGI=: 16b1a1fe
  GL_NATIVE_GRAPHICS_HANDLE_PGI=: 16b1a202
  GL_NATIVE_GRAPHICS_BEGIN_HINT_PGI=: 16b1a203
  GL_NATIVE_GRAPHICS_END_HINT_PGI=: 16b1a204
  GL_ALWAYS_FAST_HINT_PGI=: 16b1a20c
  GL_ALWAYS_SOFT_HINT_PGI=: 16b1a20d
  GL_ALLOW_DRAW_OBJ_HINT_PGI=: 16b1a20e
  GL_ALLOW_DRAW_WIN_HINT_PGI=: 16b1a20f
  GL_ALLOW_DRAW_FRG_HINT_PGI=: 16b1a210
  GL_ALLOW_DRAW_MEM_HINT_PGI=: 16b1a211
  GL_STRICT_DEPTHFUNC_HINT_PGI=: 16b1a216
  GL_STRICT_LIGHTING_HINT_PGI=: 16b1a217
  GL_STRICT_SCISSOR_HINT_PGI=: 16b1a218
  GL_FULL_STIPPLE_HINT_PGI=: 16b1a219
  GL_CLIP_NEAR_HINT_PGI=: 16b1a220
  GL_CLIP_FAR_HINT_PGI=: 16b1a221
  GL_WIDE_LINE_HINT_PGI=: 16b1a222
  GL_BACK_NORMALS_HINT_PGI=: 16b1a223
  GL_COLOR_INDEX1_EXT=: 16b80e2
  GL_COLOR_INDEX2_EXT=: 16b80e3
  GL_COLOR_INDEX4_EXT=: 16b80e4
  GL_COLOR_INDEX8_EXT=: 16b80e5
  GL_COLOR_INDEX12_EXT=: 16b80e6
  GL_COLOR_INDEX16_EXT=: 16b80e7
  GL_TEXTURE_INDEX_SIZE_EXT=: 16b80ed
  GL_CLIP_VOLUME_CLIPPING_HINT_EXT=: 16b80f0
  GL_LIST_PRIORITY_SGIX=: 16b8182
  GL_IR_INSTRUMENT1_SGIX=: 16b817f
  GL_CALLIGRAPHIC_FRAGMENT_SGIX=: 16b8183
  GL_TEXTURE_LOD_BIAS_S_SGIX=: 16b818e
  GL_TEXTURE_LOD_BIAS_T_SGIX=: 16b818f
  GL_TEXTURE_LOD_BIAS_R_SGIX=: 16b8190
  GL_SHADOW_AMBIENT_SGIX=: 16b80bf
  GL_INDEX_MATERIAL_EXT=: 16b81b8
  GL_INDEX_MATERIAL_PARAMETER_EXT=: 16b81b9
  GL_INDEX_MATERIAL_FACE_EXT=: 16b81ba
  GL_INDEX_TEST_EXT=: 16b81b5
  GL_INDEX_TEST_FUNC_EXT=: 16b81b6
  GL_INDEX_TEST_REF_EXT=: 16b81b7
  GL_IUI_V2F_EXT=: 16b81ad
  GL_IUI_V3F_EXT=: 16b81ae
  GL_IUI_N3F_V2F_EXT=: 16b81af
  GL_IUI_N3F_V3F_EXT=: 16b81b0
  GL_T2F_IUI_V2F_EXT=: 16b81b1
  GL_T2F_IUI_V3F_EXT=: 16b81b2
  GL_T2F_IUI_N3F_V2F_EXT=: 16b81b3
  GL_T2F_IUI_N3F_V3F_EXT=: 16b81b4
  GL_ARRAY_ELEMENT_LOCK_FIRST_EXT=: 16b81a8
  GL_ARRAY_ELEMENT_LOCK_COUNT_EXT=: 16b81a9
  GL_CULL_VERTEX_EXT=: 16b81aa
  GL_CULL_VERTEX_EYE_POSITION_EXT=: 16b81ab
  GL_CULL_VERTEX_OBJECT_POSITION_EXT=: 16b81ac
  GL_YCRCB_422_SGIX=: 16b81bb
  GL_YCRCB_444_SGIX=: 16b81bc
  GL_FRAGMENT_LIGHTING_SGIX=: 16b8400
  GL_FRAGMENT_COLOR_MATERIAL_SGIX=: 16b8401
  GL_FRAGMENT_COLOR_MATERIAL_FACE_SGIX=: 16b8402
  GL_FRAGMENT_COLOR_MATERIAL_PARAMETER_SGIX=: 16b8403
  GL_MAX_FRAGMENT_LIGHTS_SGIX=: 16b8404
  GL_MAX_ACTIVE_LIGHTS_SGIX=: 16b8405
  GL_CURRENT_RASTER_NORMAL_SGIX=: 16b8406
  GL_LIGHT_ENV_MODE_SGIX=: 16b8407
  GL_FRAGMENT_LIGHT_MODEL_LOCAL_VIEWER_SGIX=: 16b8408
  GL_FRAGMENT_LIGHT_MODEL_TWO_SIDE_SGIX=: 16b8409
  GL_FRAGMENT_LIGHT_MODEL_AMBIENT_SGIX=: 16b840a
  GL_FRAGMENT_LIGHT_MODEL_NORMAL_INTERPOLATION_SGIX=: 16b840b
  GL_FRAGMENT_LIGHT0_SGIX=: 16b840c
  GL_FRAGMENT_LIGHT1_SGIX=: 16b840d
  GL_FRAGMENT_LIGHT2_SGIX=: 16b840e
  GL_FRAGMENT_LIGHT3_SGIX=: 16b840f
  GL_FRAGMENT_LIGHT4_SGIX=: 16b8410
  GL_FRAGMENT_LIGHT5_SGIX=: 16b8411
  GL_FRAGMENT_LIGHT6_SGIX=: 16b8412
  GL_FRAGMENT_LIGHT7_SGIX=: 16b8413
  GL_RASTER_POSITION_UNCLIPPED_IBM=: 16b19262
  GL_TEXTURE_LIGHTING_MODE_HP=: 16b8167
  GL_TEXTURE_POST_SPECULAR_HP=: 16b8168
  GL_TEXTURE_PRE_SPECULAR_HP=: 16b8169
  GL_MAX_ELEMENTS_VERTICES_EXT=: 16b80e8
  GL_MAX_ELEMENTS_INDICES_EXT=: 16b80e9
  GL_PHONG_WIN=: 16b80ea
  GL_PHONG_HINT_WIN=: 16b80eb
  GL_FOG_SPECULAR_TEXTURE_WIN=: 16b80ec
  GL_FRAGMENT_MATERIAL_EXT=: 16b8349
  GL_FRAGMENT_NORMAL_EXT=: 16b834a
  GL_FRAGMENT_COLOR_EXT=: 16b834c
  GL_ATTENUATION_EXT=: 16b834d
  GL_SHADOW_ATTENUATION_EXT=: 16b834e
  GL_TEXTURE_APPLICATION_MODE_EXT=: 16b834f
  GL_TEXTURE_LIGHT_EXT=: 16b8350
  GL_TEXTURE_MATERIAL_FACE_EXT=: 16b8351
  GL_TEXTURE_MATERIAL_PARAMETER_EXT=: 16b8352
  GL_ALPHA_MIN_SGIX=: 16b8320
  GL_ALPHA_MAX_SGIX=: 16b8321
  GL_PIXEL_TEX_GEN_Q_CEILING_SGIX=: 16b8184
  GL_PIXEL_TEX_GEN_Q_ROUND_SGIX=: 16b8185
  GL_PIXEL_TEX_GEN_Q_FLOOR_SGIX=: 16b8186
  GL_PIXEL_TEX_GEN_ALPHA_REPLACE_SGIX=: 16b8187
  GL_PIXEL_TEX_GEN_ALPHA_NO_REPLACE_SGIX=: 16b8188
  GL_PIXEL_TEX_GEN_ALPHA_LS_SGIX=: 16b8189
  GL_PIXEL_TEX_GEN_ALPHA_MS_SGIX=: 16b818a
  GL_BGR_EXT=: 16b80e0
  GL_BGRA_EXT=: 16b80e1
  GL_ASYNC_MARKER_SGIX=: 16b8329
  GL_ASYNC_TEX_IMAGE_SGIX=: 16b835c
  GL_ASYNC_DRAW_PIXELS_SGIX=: 16b835d
  GL_ASYNC_READ_PIXELS_SGIX=: 16b835e
  GL_MAX_ASYNC_TEX_IMAGE_SGIX=: 16b835f
  GL_MAX_ASYNC_DRAW_PIXELS_SGIX=: 16b8360
  GL_MAX_ASYNC_READ_PIXELS_SGIX=: 16b8361
  GL_ASYNC_HISTOGRAM_SGIX=: 16b832c
  GL_MAX_ASYNC_HISTOGRAM_SGIX=: 16b832d
  GL_PARALLEL_ARRAYS_INTEL=: 16b83f4
  GL_VERTEX_ARRAY_PARALLEL_POINTERS_INTEL=: 16b83f5
  GL_NORMAL_ARRAY_PARALLEL_POINTERS_INTEL=: 16b83f6
  GL_COLOR_ARRAY_PARALLEL_POINTERS_INTEL=: 16b83f7
  GL_TEXTURE_COORD_ARRAY_PARALLEL_POINTERS_INTEL=: 16b83f8
  GL_OCCLUSION_TEST_HP=: 16b8165
  GL_OCCLUSION_TEST_RESULT_HP=: 16b8166
  GL_PIXEL_TRANSFORM_2D_EXT=: 16b8330
  GL_PIXEL_MAG_FILTER_EXT=: 16b8331
  GL_PIXEL_MIN_FILTER_EXT=: 16b8332
  GL_PIXEL_CUBIC_WEIGHT_EXT=: 16b8333
  GL_CUBIC_EXT=: 16b8334
  GL_AVERAGE_EXT=: 16b8335
  GL_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT=: 16b8336
  GL_MAX_PIXEL_TRANSFORM_2D_STACK_DEPTH_EXT=: 16b8337
  GL_PIXEL_TRANSFORM_2D_MATRIX_EXT=: 16b8338
  GL_SHARED_TEXTURE_PALETTE_EXT=: 16b81fb
  GL_LIGHT_MODEL_COLOR_CONTROL_EXT=: 16b81f8
  GL_SINGLE_COLOR_EXT=: 16b81f9
  GL_SEPARATE_SPECULAR_COLOR_EXT=: 16b81fa
  GL_COLOR_SUM_EXT=: 16b8458
  GL_CURRENT_SECONDARY_COLOR_EXT=: 16b8459
  GL_SECONDARY_COLOR_ARRAY_SIZE_EXT=: 16b845a
  GL_SECONDARY_COLOR_ARRAY_TYPE_EXT=: 16b845b
  GL_SECONDARY_COLOR_ARRAY_STRIDE_EXT=: 16b845c
  GL_SECONDARY_COLOR_ARRAY_POINTER_EXT=: 16b845d
  GL_SECONDARY_COLOR_ARRAY_EXT=: 16b845e
  GL_PERTURB_EXT=: 16b85ae
  GL_TEXTURE_NORMAL_EXT=: 16b85af
  GL_FOG_COORDINATE_SOURCE_EXT=: 16b8450
  GL_FOG_COORDINATE_EXT=: 16b8451
  GL_FRAGMENT_DEPTH_EXT=: 16b8452
  GL_CURRENT_FOG_COORDINATE_EXT=: 16b8453
  GL_FOG_COORDINATE_ARRAY_TYPE_EXT=: 16b8454
  GL_FOG_COORDINATE_ARRAY_STRIDE_EXT=: 16b8455
  GL_FOG_COORDINATE_ARRAY_POINTER_EXT=: 16b8456
  GL_FOG_COORDINATE_ARRAY_EXT=: 16b8457
  GL_SCREEN_COORDINATES_REND=: 16b8490
  GL_INVERTED_SCREEN_W_REND=: 16b8491
  GL_TANGENT_ARRAY_EXT=: 16b8439
  GL_BINORMAL_ARRAY_EXT=: 16b843a
  GL_CURRENT_TANGENT_EXT=: 16b843b
  GL_CURRENT_BINORMAL_EXT=: 16b843c
  GL_TANGENT_ARRAY_TYPE_EXT=: 16b843e
  GL_TANGENT_ARRAY_STRIDE_EXT=: 16b843f
  GL_BINORMAL_ARRAY_TYPE_EXT=: 16b8440
  GL_BINORMAL_ARRAY_STRIDE_EXT=: 16b8441
  GL_TANGENT_ARRAY_POINTER_EXT=: 16b8442
  GL_BINORMAL_ARRAY_POINTER_EXT=: 16b8443
  GL_MAP1_TANGENT_EXT=: 16b8444
  GL_MAP2_TANGENT_EXT=: 16b8445
  GL_MAP1_BINORMAL_EXT=: 16b8446
  GL_MAP2_BINORMAL_EXT=: 16b8447
  GL_COMBINE_EXT=: 16b8570
  GL_COMBINE_RGB_EXT=: 16b8571
  GL_COMBINE_ALPHA_EXT=: 16b8572
  GL_RGB_SCALE_EXT=: 16b8573
  GL_ADD_SIGNED_EXT=: 16b8574
  GL_INTERPOLATE_EXT=: 16b8575
  GL_CONSTANT_EXT=: 16b8576
  GL_PRIMARY_COLOR_EXT=: 16b8577
  GL_PREVIOUS_EXT=: 16b8578
  GL_SOURCE0_RGB_EXT=: 16b8580
  GL_SOURCE1_RGB_EXT=: 16b8581
  GL_SOURCE2_RGB_EXT=: 16b8582
  GL_SOURCE0_ALPHA_EXT=: 16b8588
  GL_SOURCE1_ALPHA_EXT=: 16b8589
  GL_SOURCE2_ALPHA_EXT=: 16b858a
  GL_OPERAND0_RGB_EXT=: 16b8590
  GL_OPERAND1_RGB_EXT=: 16b8591
  GL_OPERAND2_RGB_EXT=: 16b8592
  GL_OPERAND0_ALPHA_EXT=: 16b8598
  GL_OPERAND1_ALPHA_EXT=: 16b8599
  GL_OPERAND2_ALPHA_EXT=: 16b859a
  GL_LIGHT_MODEL_SPECULAR_VECTOR_APPLE=: 16b85b0
  GL_TRANSFORM_HINT_APPLE=: 16b85b1
  GL_FOG_SCALE_SGIX=: 16b81fc
  GL_FOG_SCALE_VALUE_SGIX=: 16b81fd
  GL_UNPACK_CONSTANT_DATA_SUNX=: 16b81d5
  GL_TEXTURE_CONSTANT_DATA_SUNX=: 16b81d6
  GL_GLOBAL_ALPHA_SUN=: 16b81d9
  GL_GLOBAL_ALPHA_FACTOR_SUN=: 16b81da
  GL_RESTART_SUN=: 16b0001
  GL_REPLACE_MIDDLE_SUN=: 16b0002
  GL_REPLACE_OLDEST_SUN=: 16b0003
  GL_TRIANGLE_LIST_SUN=: 16b81d7
  GL_REPLACEMENT_CODE_SUN=: 16b81d8
  GL_REPLACEMENT_CODE_ARRAY_SUN=: 16b85c0
  GL_REPLACEMENT_CODE_ARRAY_TYPE_SUN=: 16b85c1
  GL_REPLACEMENT_CODE_ARRAY_STRIDE_SUN=: 16b85c2
  GL_REPLACEMENT_CODE_ARRAY_POINTER_SUN=: 16b85c3
  GL_R1UI_V3F_SUN=: 16b85c4
  GL_R1UI_C4UB_V3F_SUN=: 16b85c5
  GL_R1UI_C3F_V3F_SUN=: 16b85c6
  GL_R1UI_N3F_V3F_SUN=: 16b85c7
  GL_R1UI_C4F_N3F_V3F_SUN=: 16b85c8
  GL_R1UI_T2F_V3F_SUN=: 16b85c9
  GL_R1UI_T2F_N3F_V3F_SUN=: 16b85ca
  GL_R1UI_T2F_C4F_N3F_V3F_SUN=: 16b85cb
  GL_BLEND_DST_RGB_EXT=: 16b80c8
  GL_BLEND_SRC_RGB_EXT=: 16b80c9
  GL_BLEND_DST_ALPHA_EXT=: 16b80ca
  GL_BLEND_SRC_ALPHA_EXT=: 16b80cb
  GL_RED_MIN_CLAMP_INGR=: 16b8560
  GL_GREEN_MIN_CLAMP_INGR=: 16b8561
  GL_BLUE_MIN_CLAMP_INGR=: 16b8562
  GL_ALPHA_MIN_CLAMP_INGR=: 16b8563
  GL_RED_MAX_CLAMP_INGR=: 16b8564
  GL_GREEN_MAX_CLAMP_INGR=: 16b8565
  GL_BLUE_MAX_CLAMP_INGR=: 16b8566
  GL_ALPHA_MAX_CLAMP_INGR=: 16b8567
  GL_INTERLACE_READ_INGR=: 16b8568
  GL_INCR_WRAP_EXT=: 16b8507
  GL_DECR_WRAP_EXT=: 16b8508
  GL_422_EXT=: 16b80cc
  GL_422_REV_EXT=: 16b80cd
  GL_422_AVERAGE_EXT=: 16b80ce
  GL_422_REV_AVERAGE_EXT=: 16b80cf
  GL_NORMAL_MAP_NV=: 16b8511
  GL_REFLECTION_MAP_NV=: 16b8512
  GL_NORMAL_MAP_EXT=: 16b8511
  GL_REFLECTION_MAP_EXT=: 16b8512
  GL_TEXTURE_CUBE_MAP_EXT=: 16b8513
  GL_TEXTURE_BINDING_CUBE_MAP_EXT=: 16b8514
  GL_TEXTURE_CUBE_MAP_POSITIVE_X_EXT=: 16b8515
  GL_TEXTURE_CUBE_MAP_NEGATIVE_X_EXT=: 16b8516
  GL_TEXTURE_CUBE_MAP_POSITIVE_Y_EXT=: 16b8517
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_EXT=: 16b8518
  GL_TEXTURE_CUBE_MAP_POSITIVE_Z_EXT=: 16b8519
  GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_EXT=: 16b851a
  GL_PROXY_TEXTURE_CUBE_MAP_EXT=: 16b851b
  GL_MAX_CUBE_MAP_TEXTURE_SIZE_EXT=: 16b851c
  GL_WRAP_BORDER_SUN=: 16b81d4
  GL_MAX_TEXTURE_LOD_BIAS_EXT=: 16b84fd
  GL_TEXTURE_FILTER_CONTROL_EXT=: 16b8500
  GL_TEXTURE_LOD_BIAS_EXT=: 16b8501
  GL_TEXTURE_MAX_ANISOTROPY_EXT=: 16b84fe
  GL_MAX_TEXTURE_MAX_ANISOTROPY_EXT=: 16b84ff
  GL_MODELVIEW0_STACK_DEPTH_EXT=: GL_MODELVIEW_STACK_DEPTH
  GL_MODELVIEW1_STACK_DEPTH_EXT=: 16b8502
  GL_MODELVIEW0_MATRIX_EXT=: GL_MODELVIEW_MATRIX
  GL_MODELVIEW1_MATRIX_EXT=: 16b8506
  GL_VERTEX_WEIGHTING_EXT=: 16b8509
  GL_MODELVIEW0_EXT=: GL_MODELVIEW
  GL_MODELVIEW1_EXT=: 16b850a
  GL_CURRENT_VERTEX_WEIGHT_EXT=: 16b850b
  GL_VERTEX_WEIGHT_ARRAY_EXT=: 16b850c
  GL_VERTEX_WEIGHT_ARRAY_SIZE_EXT=: 16b850d
  GL_VERTEX_WEIGHT_ARRAY_TYPE_EXT=: 16b850e
  GL_VERTEX_WEIGHT_ARRAY_STRIDE_EXT=: 16b850f
  GL_VERTEX_WEIGHT_ARRAY_POINTER_EXT=: 16b8510
  GL_MAX_SHININESS_NV=: 16b8504
  GL_MAX_SPOT_EXPONENT_NV=: 16b8505
  GL_VERTEX_ARRAY_RANGE_NV=: 16b851d
  GL_VERTEX_ARRAY_RANGE_LENGTH_NV=: 16b851e
  GL_VERTEX_ARRAY_RANGE_VALID_NV=: 16b851f
  GL_MAX_VERTEX_ARRAY_RANGE_ELEMENT_NV=: 16b8520
  GL_VERTEX_ARRAY_RANGE_POINTER_NV=: 16b8521
  GL_REGISTER_COMBINERS_NV=: 16b8522
  GL_VARIABLE_A_NV=: 16b8523
  GL_VARIABLE_B_NV=: 16b8524
  GL_VARIABLE_C_NV=: 16b8525
  GL_VARIABLE_D_NV=: 16b8526
  GL_VARIABLE_E_NV=: 16b8527
  GL_VARIABLE_F_NV=: 16b8528
  GL_VARIABLE_G_NV=: 16b8529
  GL_CONSTANT_COLOR0_NV=: 16b852a
  GL_CONSTANT_COLOR1_NV=: 16b852b
  GL_PRIMARY_COLOR_NV=: 16b852c
  GL_SECONDARY_COLOR_NV=: 16b852d
  GL_SPARE0_NV=: 16b852e
  GL_SPARE1_NV=: 16b852f
  GL_DISCARD_NV=: 16b8530
  GL_E_TIMES_F_NV=: 16b8531
  GL_SPARE0_PLUS_SECONDARY_COLOR_NV=: 16b8532
  GL_UNSIGNED_IDENTITY_NV=: 16b8536
  GL_UNSIGNED_INVERT_NV=: 16b8537
  GL_EXPAND_NORMAL_NV=: 16b8538
  GL_EXPAND_NEGATE_NV=: 16b8539
  GL_HALF_BIAS_NORMAL_NV=: 16b853a
  GL_HALF_BIAS_NEGATE_NV=: 16b853b
  GL_SIGNED_IDENTITY_NV=: 16b853c
  GL_SIGNED_NEGATE_NV=: 16b853d
  GL_SCALE_BY_TWO_NV=: 16b853e
  GL_SCALE_BY_FOUR_NV=: 16b853f
  GL_SCALE_BY_ONE_HALF_NV=: 16b8540
  GL_BIAS_BY_NEGATIVE_ONE_HALF_NV=: 16b8541
  GL_COMBINER_INPUT_NV=: 16b8542
  GL_COMBINER_MAPPING_NV=: 16b8543
  GL_COMBINER_COMPONENT_USAGE_NV=: 16b8544
  GL_COMBINER_AB_DOT_PRODUCT_NV=: 16b8545
  GL_COMBINER_CD_DOT_PRODUCT_NV=: 16b8546
  GL_COMBINER_MUX_SUM_NV=: 16b8547
  GL_COMBINER_SCALE_NV=: 16b8548
  GL_COMBINER_BIAS_NV=: 16b8549
  GL_COMBINER_AB_OUTPUT_NV=: 16b854a
  GL_COMBINER_CD_OUTPUT_NV=: 16b854b
  GL_COMBINER_SUM_OUTPUT_NV=: 16b854c
  GL_MAX_GENERAL_COMBINERS_NV=: 16b854d
  GL_NUM_GENERAL_COMBINERS_NV=: 16b854e
  GL_COLOR_SUM_CLAMP_NV=: 16b854f
  GL_COMBINER0_NV=: 16b8550
  GL_COMBINER1_NV=: 16b8551
  GL_COMBINER2_NV=: 16b8552
  GL_COMBINER3_NV=: 16b8553
  GL_COMBINER4_NV=: 16b8554
  GL_COMBINER5_NV=: 16b8555
  GL_COMBINER6_NV=: 16b8556
  GL_COMBINER7_NV=: 16b8557
  GL_FOG_DISTANCE_MODE_NV=: 16b855a
  GL_EYE_RADIAL_NV=: 16b855b
  GL_EYE_PLANE_ABSOLUTE_NV=: 16b855c
  GL_EMBOSS_LIGHT_NV=: 16b855d
  GL_EMBOSS_CONSTANT_NV=: 16b855e
  GL_EMBOSS_MAP_NV=: 16b855f
  GL_COMBINE4_NV=: 16b8503
  GL_SOURCE3_RGB_NV=: 16b8583
  GL_SOURCE3_ALPHA_NV=: 16b858b
  GL_OPERAND3_RGB_NV=: 16b8593
  GL_OPERAND3_ALPHA_NV=: 16b859b
  GL_COMPRESSED_RGB_S3TC_DXT1_EXT=: 16b83f0
  GL_COMPRESSED_RGBA_S3TC_DXT1_EXT=: 16b83f1
  GL_COMPRESSED_RGBA_S3TC_DXT3_EXT=: 16b83f2
  GL_COMPRESSED_RGBA_S3TC_DXT5_EXT=: 16b83f3
  GL_CULL_VERTEX_IBM=: 103050
  GL_VERTEX_ARRAY_LIST_IBM=: 103070
  GL_NORMAL_ARRAY_LIST_IBM=: 103071
  GL_COLOR_ARRAY_LIST_IBM=: 103072
  GL_INDEX_ARRAY_LIST_IBM=: 103073
  GL_TEXTURE_COORD_ARRAY_LIST_IBM=: 103074
  GL_EDGE_FLAG_ARRAY_LIST_IBM=: 103075
  GL_FOG_COORDINATE_ARRAY_LIST_IBM=: 103076
  GL_SECONDARY_COLOR_ARRAY_LIST_IBM=: 103077
  GL_VERTEX_ARRAY_LIST_STRIDE_IBM=: 103080
  GL_NORMAL_ARRAY_LIST_STRIDE_IBM=: 103081
  GL_COLOR_ARRAY_LIST_STRIDE_IBM=: 103082
  GL_INDEX_ARRAY_LIST_STRIDE_IBM=: 103083
  GL_TEXTURE_COORD_ARRAY_LIST_STRIDE_IBM=: 103084
  GL_EDGE_FLAG_ARRAY_LIST_STRIDE_IBM=: 103085
  GL_FOG_COORDINATE_ARRAY_LIST_STRIDE_IBM=: 103086
  GL_SECONDARY_COLOR_ARRAY_LIST_STRIDE_IBM=: 103087
  GL_PACK_SUBSAMPLE_RATE_SGIX=: 16b85a0
  GL_UNPACK_SUBSAMPLE_RATE_SGIX=: 16b85a1
  GL_PIXEL_SUBSAMPLE_4444_SGIX=: 16b85a2
  GL_PIXEL_SUBSAMPLE_2424_SGIX=: 16b85a3
  GL_PIXEL_SUBSAMPLE_4242_SGIX=: 16b85a4
  GL_YCRCB_SGIX=: 16b8318
  GL_YCRCBA_SGIX=: 16b8319
  GL_DEPTH_PASS_INSTRUMENT_SGIX=: 16b8310
  GL_DEPTH_PASS_INSTRUMENT_COUNTERS_SGIX=: 16b8311
  GL_DEPTH_PASS_INSTRUMENT_MAX_SGIX=: 16b8312
  GL_COMPRESSED_RGB_FXT1_3DFX=: 16b86b0
  GL_COMPRESSED_RGBA_FXT1_3DFX=: 16b86b1
  GL_MULTISAMPLE_3DFX=: 16b86b2
  GL_SAMPLE_BUFFERS_3DFX=: 16b86b3
  GL_SAMPLES_3DFX=: 16b86b4
  GL_MULTISAMPLE_BIT_3DFX=: 16b20000000
  GL_MULTISAMPLE_EXT=: 16b809d
  GL_SAMPLE_ALPHA_TO_MASK_EXT=: 16b809e
  GL_SAMPLE_ALPHA_TO_ONE_EXT=: 16b809f
  GL_SAMPLE_MASK_EXT=: 16b80a0
  GL_1PASS_EXT=: 16b80a1
  GL_2PASS_0_EXT=: 16b80a2
  GL_2PASS_1_EXT=: 16b80a3
  GL_4PASS_0_EXT=: 16b80a4
  GL_4PASS_1_EXT=: 16b80a5
  GL_4PASS_2_EXT=: 16b80a6
  GL_4PASS_3_EXT=: 16b80a7
  GL_SAMPLE_BUFFERS_EXT=: 16b80a8
  GL_SAMPLES_EXT=: 16b80a9
  GL_SAMPLE_MASK_VALUE_EXT=: 16b80aa
  GL_SAMPLE_MASK_INVERT_EXT=: 16b80ab
  GL_SAMPLE_PATTERN_EXT=: 16b80ac
  GL_MULTISAMPLE_BIT_EXT=: 16b20000000
  GL_VERTEX_PRECLIP_SGIX=: 16b83ee
  GL_VERTEX_PRECLIP_HINT_SGIX=: 16b83ef
  GL_CONVOLUTION_HINT_SGIX=: 16b8316
  GL_PACK_RESAMPLE_SGIX=: 16b842c
  GL_UNPACK_RESAMPLE_SGIX=: 16b842d
  GL_RESAMPLE_REPLICATE_SGIX=: 16b842e
  GL_RESAMPLE_ZERO_FILL_SGIX=: 16b842f
  GL_RESAMPLE_DECIMATE_SGIX=: 16b8430
  GL_EYE_DISTANCE_TO_POINT_SGIS=: 16b81f0
  GL_OBJECT_DISTANCE_TO_POINT_SGIS=: 16b81f1
  GL_EYE_DISTANCE_TO_LINE_SGIS=: 16b81f2
  GL_OBJECT_DISTANCE_TO_LINE_SGIS=: 16b81f3
  GL_EYE_POINT_SGIS=: 16b81f4
  GL_OBJECT_POINT_SGIS=: 16b81f5
  GL_EYE_LINE_SGIS=: 16b81f6
  GL_OBJECT_LINE_SGIS=: 16b81f7
  GL_TEXTURE_COLOR_WRITEMASK_SGIS=: 16b81ef
  GL_DOT3_RGB_EXT=: 16b8740
  GL_DOT3_RGBA_EXT=: 16b8741
  GL_MIRROR_CLAMP_ATI=: 16b8742
  GL_MIRROR_CLAMP_TO_EDGE_ATI=: 16b8743
  GL_ALL_COMPLETED_NV=: 16b84f2
  GL_FENCE_STATUS_NV=: 16b84f3
  GL_FENCE_CONDITION_NV=: 16b84f4
  GL_MIRRORED_REPEAT_IBM=: 16b8370
  GL_EVAL_2D_NV=: 16b86c0
  GL_EVAL_TRIANGULAR_2D_NV=: 16b86c1
  GL_MAP_TESSELLATION_NV=: 16b86c2
  GL_MAP_ATTRIB_U_ORDER_NV=: 16b86c3
  GL_MAP_ATTRIB_V_ORDER_NV=: 16b86c4
  GL_EVAL_FRACTIONAL_TESSELLATION_NV=: 16b86c5
  GL_EVAL_VERTEX_ATTRIB0_NV=: 16b86c6
  GL_EVAL_VERTEX_ATTRIB1_NV=: 16b86c7
  GL_EVAL_VERTEX_ATTRIB2_NV=: 16b86c8
  GL_EVAL_VERTEX_ATTRIB3_NV=: 16b86c9
  GL_EVAL_VERTEX_ATTRIB4_NV=: 16b86ca
  GL_EVAL_VERTEX_ATTRIB5_NV=: 16b86cb
  GL_EVAL_VERTEX_ATTRIB6_NV=: 16b86cc
  GL_EVAL_VERTEX_ATTRIB7_NV=: 16b86cd
  GL_EVAL_VERTEX_ATTRIB8_NV=: 16b86ce
  GL_EVAL_VERTEX_ATTRIB9_NV=: 16b86cf
  GL_EVAL_VERTEX_ATTRIB10_NV=: 16b86d0
  GL_EVAL_VERTEX_ATTRIB11_NV=: 16b86d1
  GL_EVAL_VERTEX_ATTRIB12_NV=: 16b86d2
  GL_EVAL_VERTEX_ATTRIB13_NV=: 16b86d3
  GL_EVAL_VERTEX_ATTRIB14_NV=: 16b86d4
  GL_EVAL_VERTEX_ATTRIB15_NV=: 16b86d5
  GL_MAX_MAP_TESSELLATION_NV=: 16b86d6
  GL_MAX_RATIONAL_EVAL_ORDER_NV=: 16b86d7
  GL_DEPTH_STENCIL_NV=: 16b84f9
  GL_UNSIGNED_INT_24_8_NV=: 16b84fa
  GL_PER_STAGE_CONSTANTS_NV=: 16b8535
  GL_TEXTURE_RECTANGLE_NV=: 16b84f5
  GL_TEXTURE_BINDING_RECTANGLE_NV=: 16b84f6
  GL_PROXY_TEXTURE_RECTANGLE_NV=: 16b84f7
  GL_MAX_RECTANGLE_TEXTURE_SIZE_NV=: 16b84f8
  GL_OFFSET_TEXTURE_RECTANGLE_NV=: 16b864c
  GL_OFFSET_TEXTURE_RECTANGLE_SCALE_NV=: 16b864d
  GL_DOT_PRODUCT_TEXTURE_RECTANGLE_NV=: 16b864e
  GL_RGBA_UNSIGNED_DOT_PRODUCT_MAPPING_NV=: 16b86d9
  GL_UNSIGNED_INT_S8_S8_8_8_NV=: 16b86da
  GL_UNSIGNED_INT_8_8_S8_S8_REV_NV=: 16b86db
  GL_DSDT_MAG_INTENSITY_NV=: 16b86dc
  GL_SHADER_CONSISTENT_NV=: 16b86dd
  GL_TEXTURE_SHADER_NV=: 16b86de
  GL_SHADER_OPERATION_NV=: 16b86df
  GL_CULL_MODES_NV=: 16b86e0
  GL_OFFSET_TEXTURE_MATRIX_NV=: 16b86e1
  GL_OFFSET_TEXTURE_SCALE_NV=: 16b86e2
  GL_OFFSET_TEXTURE_BIAS_NV=: 16b86e3
  GL_OFFSET_TEXTURE_2D_MATRIX_NV=: GL_OFFSET_TEXTURE_MATRIX_NV
  GL_OFFSET_TEXTURE_2D_SCALE_NV=: GL_OFFSET_TEXTURE_SCALE_NV
  GL_OFFSET_TEXTURE_2D_BIAS_NV=: GL_OFFSET_TEXTURE_BIAS_NV
  GL_PREVIOUS_TEXTURE_INPUT_NV=: 16b86e4
  GL_CONST_EYE_NV=: 16b86e5
  GL_PASS_THROUGH_NV=: 16b86e6
  GL_CULL_FRAGMENT_NV=: 16b86e7
  GL_OFFSET_TEXTURE_2D_NV=: 16b86e8
  GL_DEPENDENT_AR_TEXTURE_2D_NV=: 16b86e9
  GL_DEPENDENT_GB_TEXTURE_2D_NV=: 16b86ea
  GL_DOT_PRODUCT_NV=: 16b86ec
  GL_DOT_PRODUCT_DEPTH_REPLACE_NV=: 16b86ed
  GL_DOT_PRODUCT_TEXTURE_2D_NV=: 16b86ee
  GL_DOT_PRODUCT_TEXTURE_CUBE_MAP_NV=: 16b86f0
  GL_DOT_PRODUCT_DIFFUSE_CUBE_MAP_NV=: 16b86f1
  GL_DOT_PRODUCT_REFLECT_CUBE_MAP_NV=: 16b86f2
  GL_DOT_PRODUCT_CONST_EYE_REFLECT_CUBE_MAP_NV=: 16b86f3
  GL_HILO_NV=: 16b86f4
  GL_DSDT_NV=: 16b86f5
  GL_DSDT_MAG_NV=: 16b86f6
  GL_DSDT_MAG_VIB_NV=: 16b86f7
  GL_HILO16_NV=: 16b86f8
  GL_SIGNED_HILO_NV=: 16b86f9
  GL_SIGNED_HILO16_NV=: 16b86fa
  GL_SIGNED_RGBA_NV=: 16b86fb
  GL_SIGNED_RGBA8_NV=: 16b86fc
  GL_SIGNED_RGB_NV=: 16b86fe
  GL_SIGNED_RGB8_NV=: 16b86ff
  GL_SIGNED_LUMINANCE_NV=: 16b8701
  GL_SIGNED_LUMINANCE8_NV=: 16b8702
  GL_SIGNED_LUMINANCE_ALPHA_NV=: 16b8703
  GL_SIGNED_LUMINANCE8_ALPHA8_NV=: 16b8704
  GL_SIGNED_ALPHA_NV=: 16b8705
  GL_SIGNED_ALPHA8_NV=: 16b8706
  GL_SIGNED_INTENSITY_NV=: 16b8707
  GL_SIGNED_INTENSITY8_NV=: 16b8708
  GL_DSDT8_NV=: 16b8709
  GL_DSDT8_MAG8_NV=: 16b870a
  GL_DSDT8_MAG8_INTENSITY8_NV=: 16b870b
  GL_SIGNED_RGB_UNSIGNED_ALPHA_NV=: 16b870c
  GL_SIGNED_RGB8_UNSIGNED_ALPHA8_NV=: 16b870d
  GL_HI_SCALE_NV=: 16b870e
  GL_LO_SCALE_NV=: 16b870f
  GL_DS_SCALE_NV=: 16b8710
  GL_DT_SCALE_NV=: 16b8711
  GL_MAGNITUDE_SCALE_NV=: 16b8712
  GL_VIBRANCE_SCALE_NV=: 16b8713
  GL_HI_BIAS_NV=: 16b8714
  GL_LO_BIAS_NV=: 16b8715
  GL_DS_BIAS_NV=: 16b8716
  GL_DT_BIAS_NV=: 16b8717
  GL_MAGNITUDE_BIAS_NV=: 16b8718
  GL_VIBRANCE_BIAS_NV=: 16b8719
  GL_TEXTURE_BORDER_VALUES_NV=: 16b871a
  GL_TEXTURE_HI_SIZE_NV=: 16b871b
  GL_TEXTURE_LO_SIZE_NV=: 16b871c
  GL_TEXTURE_DS_SIZE_NV=: 16b871d
  GL_TEXTURE_DT_SIZE_NV=: 16b871e
  GL_TEXTURE_MAG_SIZE_NV=: 16b871f
  GL_DOT_PRODUCT_TEXTURE_3D_NV=: 16b86ef
  GL_VERTEX_ARRAY_RANGE_WITHOUT_FLUSH_NV=: 16b8533
  GL_VERTEX_PROGRAM_NV=: 16b8620
  GL_VERTEX_STATE_PROGRAM_NV=: 16b8621
  GL_ATTRIB_ARRAY_SIZE_NV=: 16b8623
  GL_ATTRIB_ARRAY_STRIDE_NV=: 16b8624
  GL_ATTRIB_ARRAY_TYPE_NV=: 16b8625
  GL_CURRENT_ATTRIB_NV=: 16b8626
  GL_PROGRAM_LENGTH_NV=: 16b8627
  GL_PROGRAM_STRING_NV=: 16b8628
  GL_MODELVIEW_PROJECTION_NV=: 16b8629
  GL_IDENTITY_NV=: 16b862a
  GL_INVERSE_NV=: 16b862b
  GL_TRANSPOSE_NV=: 16b862c
  GL_INVERSE_TRANSPOSE_NV=: 16b862d
  GL_MAX_TRACK_MATRIX_STACK_DEPTH_NV=: 16b862e
  GL_MAX_TRACK_MATRICES_NV=: 16b862f
  GL_MATRIX0_NV=: 16b8630
  GL_MATRIX1_NV=: 16b8631
  GL_MATRIX2_NV=: 16b8632
  GL_MATRIX3_NV=: 16b8633
  GL_MATRIX4_NV=: 16b8634
  GL_MATRIX5_NV=: 16b8635
  GL_MATRIX6_NV=: 16b8636
  GL_MATRIX7_NV=: 16b8637
  GL_CURRENT_MATRIX_STACK_DEPTH_NV=: 16b8640
  GL_CURRENT_MATRIX_NV=: 16b8641
  GL_VERTEX_PROGRAM_POINT_SIZE_NV=: 16b8642
  GL_VERTEX_PROGRAM_TWO_SIDE_NV=: 16b8643
  GL_PROGRAM_PARAMETER_NV=: 16b8644
  GL_ATTRIB_ARRAY_POINTER_NV=: 16b8645
  GL_PROGRAM_TARGET_NV=: 16b8646
  GL_PROGRAM_RESIDENT_NV=: 16b8647
  GL_TRACK_MATRIX_NV=: 16b8648
  GL_TRACK_MATRIX_TRANSFORM_NV=: 16b8649
  GL_VERTEX_PROGRAM_BINDING_NV=: 16b864a
  GL_PROGRAM_ERROR_POSITION_NV=: 16b864b
  GL_VERTEX_ATTRIB_ARRAY0_NV=: 16b8650
  GL_VERTEX_ATTRIB_ARRAY1_NV=: 16b8651
  GL_VERTEX_ATTRIB_ARRAY2_NV=: 16b8652
  GL_VERTEX_ATTRIB_ARRAY3_NV=: 16b8653
  GL_VERTEX_ATTRIB_ARRAY4_NV=: 16b8654
  GL_VERTEX_ATTRIB_ARRAY5_NV=: 16b8655
  GL_VERTEX_ATTRIB_ARRAY6_NV=: 16b8656
  GL_VERTEX_ATTRIB_ARRAY7_NV=: 16b8657
  GL_VERTEX_ATTRIB_ARRAY8_NV=: 16b8658
  GL_VERTEX_ATTRIB_ARRAY9_NV=: 16b8659
  GL_VERTEX_ATTRIB_ARRAY10_NV=: 16b865a
  GL_VERTEX_ATTRIB_ARRAY11_NV=: 16b865b
  GL_VERTEX_ATTRIB_ARRAY12_NV=: 16b865c
  GL_VERTEX_ATTRIB_ARRAY13_NV=: 16b865d
  GL_VERTEX_ATTRIB_ARRAY14_NV=: 16b865e
  GL_VERTEX_ATTRIB_ARRAY15_NV=: 16b865f
  GL_MAP1_VERTEX_ATTRIB0_4_NV=: 16b8660
  GL_MAP1_VERTEX_ATTRIB1_4_NV=: 16b8661
  GL_MAP1_VERTEX_ATTRIB2_4_NV=: 16b8662
  GL_MAP1_VERTEX_ATTRIB3_4_NV=: 16b8663
  GL_MAP1_VERTEX_ATTRIB4_4_NV=: 16b8664
  GL_MAP1_VERTEX_ATTRIB5_4_NV=: 16b8665
  GL_MAP1_VERTEX_ATTRIB6_4_NV=: 16b8666
  GL_MAP1_VERTEX_ATTRIB7_4_NV=: 16b8667
  GL_MAP1_VERTEX_ATTRIB8_4_NV=: 16b8668
  GL_MAP1_VERTEX_ATTRIB9_4_NV=: 16b8669
  GL_MAP1_VERTEX_ATTRIB10_4_NV=: 16b866a
  GL_MAP1_VERTEX_ATTRIB11_4_NV=: 16b866b
  GL_MAP1_VERTEX_ATTRIB12_4_NV=: 16b866c
  GL_MAP1_VERTEX_ATTRIB13_4_NV=: 16b866d
  GL_MAP1_VERTEX_ATTRIB14_4_NV=: 16b866e
  GL_MAP1_VERTEX_ATTRIB15_4_NV=: 16b866f
  GL_MAP2_VERTEX_ATTRIB0_4_NV=: 16b8670
  GL_MAP2_VERTEX_ATTRIB1_4_NV=: 16b8671
  GL_MAP2_VERTEX_ATTRIB2_4_NV=: 16b8672
  GL_MAP2_VERTEX_ATTRIB3_4_NV=: 16b8673
  GL_MAP2_VERTEX_ATTRIB4_4_NV=: 16b8674
  GL_MAP2_VERTEX_ATTRIB5_4_NV=: 16b8675
  GL_MAP2_VERTEX_ATTRIB6_4_NV=: 16b8676
  GL_MAP2_VERTEX_ATTRIB7_4_NV=: 16b8677
  GL_MAP2_VERTEX_ATTRIB8_4_NV=: 16b8678
  GL_MAP2_VERTEX_ATTRIB9_4_NV=: 16b8679
  GL_MAP2_VERTEX_ATTRIB10_4_NV=: 16b867a
  GL_MAP2_VERTEX_ATTRIB11_4_NV=: 16b867b
  GL_MAP2_VERTEX_ATTRIB12_4_NV=: 16b867c
  GL_MAP2_VERTEX_ATTRIB13_4_NV=: 16b867d
  GL_MAP2_VERTEX_ATTRIB14_4_NV=: 16b867e
  GL_MAP2_VERTEX_ATTRIB15_4_NV=: 16b867f
  GL_TEXTURE_MAX_CLAMP_S_SGIX=: 16b8369
  GL_TEXTURE_MAX_CLAMP_T_SGIX=: 16b836a
  GL_TEXTURE_MAX_CLAMP_R_SGIX=: 16b836b
  GL_SCALEBIAS_HINT_SGIX=: 16b8322
  GL_INTERLACE_OML=: 16b8980
  GL_INTERLACE_READ_OML=: 16b8981
  GL_FORMAT_SUBSAMPLE_24_24_OML=: 16b8982
  GL_FORMAT_SUBSAMPLE_244_244_OML=: 16b8983
  GL_PACK_RESAMPLE_OML=: 16b8984
  GL_UNPACK_RESAMPLE_OML=: 16b8985
  GL_RESAMPLE_REPLICATE_OML=: 16b8986
  GL_RESAMPLE_ZERO_FILL_OML=: 16b8987
  GL_RESAMPLE_AVERAGE_OML=: 16b8988
  GL_RESAMPLE_DECIMATE_OML=: 16b8989
  GL_DEPTH_STENCIL_TO_RGBA_NV=: 16b886e
  GL_DEPTH_STENCIL_TO_BGRA_NV=: 16b886f
  GL_BUMP_ROT_MATRIX_ATI=: 16b8775
  GL_BUMP_ROT_MATRIX_SIZE_ATI=: 16b8776
  GL_BUMP_NUM_TEX_UNITS_ATI=: 16b8777
  GL_BUMP_TEX_UNITS_ATI=: 16b8778
  GL_DUDV_ATI=: 16b8779
  GL_DU8DV8_ATI=: 16b877a
  GL_BUMP_ENVMAP_ATI=: 16b877b
  GL_BUMP_TARGET_ATI=: 16b877c
  GL_FRAGMENT_SHADER_ATI=: 16b8920
  GL_REG_0_ATI=: 16b8921
  GL_REG_1_ATI=: 16b8922
  GL_REG_2_ATI=: 16b8923
  GL_REG_3_ATI=: 16b8924
  GL_REG_4_ATI=: 16b8925
  GL_REG_5_ATI=: 16b8926
  GL_REG_6_ATI=: 16b8927
  GL_REG_7_ATI=: 16b8928
  GL_REG_8_ATI=: 16b8929
  GL_REG_9_ATI=: 16b892a
  GL_REG_10_ATI=: 16b892b
  GL_REG_11_ATI=: 16b892c
  GL_REG_12_ATI=: 16b892d
  GL_REG_13_ATI=: 16b892e
  GL_REG_14_ATI=: 16b892f
  GL_REG_15_ATI=: 16b8930
  GL_REG_16_ATI=: 16b8931
  GL_REG_17_ATI=: 16b8932
  GL_REG_18_ATI=: 16b8933
  GL_REG_19_ATI=: 16b8934
  GL_REG_20_ATI=: 16b8935
  GL_REG_21_ATI=: 16b8936
  GL_REG_22_ATI=: 16b8937
  GL_REG_23_ATI=: 16b8938
  GL_REG_24_ATI=: 16b8939
  GL_REG_25_ATI=: 16b893a
  GL_REG_26_ATI=: 16b893b
  GL_REG_27_ATI=: 16b893c
  GL_REG_28_ATI=: 16b893d
  GL_REG_29_ATI=: 16b893e
  GL_REG_30_ATI=: 16b893f
  GL_REG_31_ATI=: 16b8940
  GL_CON_0_ATI=: 16b8941
  GL_CON_1_ATI=: 16b8942
  GL_CON_2_ATI=: 16b8943
  GL_CON_3_ATI=: 16b8944
  GL_CON_4_ATI=: 16b8945
  GL_CON_5_ATI=: 16b8946
  GL_CON_6_ATI=: 16b8947
  GL_CON_7_ATI=: 16b8948
  GL_CON_8_ATI=: 16b8949
  GL_CON_9_ATI=: 16b894a
  GL_CON_10_ATI=: 16b894b
  GL_CON_11_ATI=: 16b894c
  GL_CON_12_ATI=: 16b894d
  GL_CON_13_ATI=: 16b894e
  GL_CON_14_ATI=: 16b894f
  GL_CON_15_ATI=: 16b8950
  GL_CON_16_ATI=: 16b8951
  GL_CON_17_ATI=: 16b8952
  GL_CON_18_ATI=: 16b8953
  GL_CON_19_ATI=: 16b8954
  GL_CON_20_ATI=: 16b8955
  GL_CON_21_ATI=: 16b8956
  GL_CON_22_ATI=: 16b8957
  GL_CON_23_ATI=: 16b8958
  GL_CON_24_ATI=: 16b8959
  GL_CON_25_ATI=: 16b895a
  GL_CON_26_ATI=: 16b895b
  GL_CON_27_ATI=: 16b895c
  GL_CON_28_ATI=: 16b895d
  GL_CON_29_ATI=: 16b895e
  GL_CON_30_ATI=: 16b895f
  GL_CON_31_ATI=: 16b8960
  GL_MOV_ATI=: 16b8961
  GL_ADD_ATI=: 16b8963
  GL_MUL_ATI=: 16b8964
  GL_SUB_ATI=: 16b8965
  GL_DOT3_ATI=: 16b8966
  GL_DOT4_ATI=: 16b8967
  GL_MAD_ATI=: 16b8968
  GL_LERP_ATI=: 16b8969
  GL_CND_ATI=: 16b896a
  GL_CND0_ATI=: 16b896b
  GL_DOT2_ADD_ATI=: 16b896c
  GL_SECONDARY_INTERPOLATOR_ATI=: 16b896d
  GL_NUM_FRAGMENT_REGISTERS_ATI=: 16b896e
  GL_NUM_FRAGMENT_CONSTANTS_ATI=: 16b896f
  GL_NUM_PASSES_ATI=: 16b8970
  GL_NUM_INSTRUCTIONS_PER_PASS_ATI=: 16b8971
  GL_NUM_INSTRUCTIONS_TOTAL_ATI=: 16b8972
  GL_NUM_INPUT_INTERPOLATOR_COMPONENTS_ATI=: 16b8973
  GL_NUM_LOOPBACK_COMPONENTS_ATI=: 16b8974
  GL_COLOR_ALPHA_PAIRING_ATI=: 16b8975
  GL_SWIZZLE_STR_ATI=: 16b8976
  GL_SWIZZLE_STQ_ATI=: 16b8977
  GL_SWIZZLE_STR_DR_ATI=: 16b8978
  GL_SWIZZLE_STQ_DQ_ATI=: 16b8979
  GL_SWIZZLE_STRQ_ATI=: 16b897a
  GL_SWIZZLE_STRQ_DQ_ATI=: 16b897b
  GL_RED_BIT_ATI=: 16b00000001
  GL_GREEN_BIT_ATI=: 16b00000002
  GL_BLUE_BIT_ATI=: 16b00000004
  GL_2X_BIT_ATI=: 16b00000001
  GL_4X_BIT_ATI=: 16b00000002
  GL_8X_BIT_ATI=: 16b00000004
  GL_HALF_BIT_ATI=: 16b00000008
  GL_QUARTER_BIT_ATI=: 16b00000010
  GL_EIGHTH_BIT_ATI=: 16b00000020
  GL_SATURATE_BIT_ATI=: 16b00000040
  GL_COMP_BIT_ATI=: 16b00000002
  GL_NEGATE_BIT_ATI=: 16b00000004
  GL_BIAS_BIT_ATI=: 16b00000008
  GL_PN_TRIANGLES_ATI=: 16b87f0
  GL_MAX_PN_TRIANGLES_TESSELATION_LEVEL_ATI=: 16b87f1
  GL_PN_TRIANGLES_POINT_MODE_ATI=: 16b87f2
  GL_PN_TRIANGLES_NORMAL_MODE_ATI=: 16b87f3
  GL_PN_TRIANGLES_TESSELATION_LEVEL_ATI=: 16b87f4
  GL_PN_TRIANGLES_POINT_MODE_LINEAR_ATI=: 16b87f5
  GL_PN_TRIANGLES_POINT_MODE_CUBIC_ATI=: 16b87f6
  GL_PN_TRIANGLES_NORMAL_MODE_LINEAR_ATI=: 16b87f7
  GL_PN_TRIANGLES_NORMAL_MODE_QUADRATIC_ATI=: 16b87f8
  GL_STATIC_ATI=: 16b8760
  GL_DYNAMIC_ATI=: 16b8761
  GL_PRESERVE_ATI=: 16b8762
  GL_DISCARD_ATI=: 16b8763
  GL_OBJECT_BUFFER_SIZE_ATI=: 16b8764
  GL_OBJECT_BUFFER_USAGE_ATI=: 16b8765
  GL_ARRAY_OBJECT_BUFFER_ATI=: 16b8766
  GL_ARRAY_OBJECT_OFFSET_ATI=: 16b8767
  GL_VERTEX_SHADER_EXT=: 16b8780
  GL_VERTEX_SHADER_BINDING_EXT=: 16b8781
  GL_OP_INDEX_EXT=: 16b8782
  GL_OP_NEGATE_EXT=: 16b8783
  GL_OP_DOT3_EXT=: 16b8784
  GL_OP_DOT4_EXT=: 16b8785
  GL_OP_MUL_EXT=: 16b8786
  GL_OP_ADD_EXT=: 16b8787
  GL_OP_MADD_EXT=: 16b8788
  GL_OP_FRAC_EXT=: 16b8789
  GL_OP_MAX_EXT=: 16b878a
  GL_OP_MIN_EXT=: 16b878b
  GL_OP_SET_GE_EXT=: 16b878c
  GL_OP_SET_LT_EXT=: 16b878d
  GL_OP_CLAMP_EXT=: 16b878e
  GL_OP_FLOOR_EXT=: 16b878f
  GL_OP_ROUND_EXT=: 16b8790
  GL_OP_EXP_BASE_2_EXT=: 16b8791
  GL_OP_LOG_BASE_2_EXT=: 16b8792
  GL_OP_POWER_EXT=: 16b8793
  GL_OP_RECIP_EXT=: 16b8794
  GL_OP_RECIP_SQRT_EXT=: 16b8795
  GL_OP_SUB_EXT=: 16b8796
  GL_OP_CROSS_PRODUCT_EXT=: 16b8797
  GL_OP_MULTIPLY_MATRIX_EXT=: 16b8798
  GL_OP_MOV_EXT=: 16b8799
  GL_OUTPUT_VERTEX_EXT=: 16b879a
  GL_OUTPUT_COLOR0_EXT=: 16b879b
  GL_OUTPUT_COLOR1_EXT=: 16b879c
  GL_OUTPUT_TEXTURE_COORD0_EXT=: 16b879d
  GL_OUTPUT_TEXTURE_COORD1_EXT=: 16b879e
  GL_OUTPUT_TEXTURE_COORD2_EXT=: 16b879f
  GL_OUTPUT_TEXTURE_COORD3_EXT=: 16b87a0
  GL_OUTPUT_TEXTURE_COORD4_EXT=: 16b87a1
  GL_OUTPUT_TEXTURE_COORD5_EXT=: 16b87a2
  GL_OUTPUT_TEXTURE_COORD6_EXT=: 16b87a3
  GL_OUTPUT_TEXTURE_COORD7_EXT=: 16b87a4
  GL_OUTPUT_TEXTURE_COORD8_EXT=: 16b87a5
  GL_OUTPUT_TEXTURE_COORD9_EXT=: 16b87a6
  GL_OUTPUT_TEXTURE_COORD10_EXT=: 16b87a7
  GL_OUTPUT_TEXTURE_COORD11_EXT=: 16b87a8
  GL_OUTPUT_TEXTURE_COORD12_EXT=: 16b87a9
  GL_OUTPUT_TEXTURE_COORD13_EXT=: 16b87aa
  GL_OUTPUT_TEXTURE_COORD14_EXT=: 16b87ab
  GL_OUTPUT_TEXTURE_COORD15_EXT=: 16b87ac
  GL_OUTPUT_TEXTURE_COORD16_EXT=: 16b87ad
  GL_OUTPUT_TEXTURE_COORD17_EXT=: 16b87ae
  GL_OUTPUT_TEXTURE_COORD18_EXT=: 16b87af
  GL_OUTPUT_TEXTURE_COORD19_EXT=: 16b87b0
  GL_OUTPUT_TEXTURE_COORD20_EXT=: 16b87b1
  GL_OUTPUT_TEXTURE_COORD21_EXT=: 16b87b2
  GL_OUTPUT_TEXTURE_COORD22_EXT=: 16b87b3
  GL_OUTPUT_TEXTURE_COORD23_EXT=: 16b87b4
  GL_OUTPUT_TEXTURE_COORD24_EXT=: 16b87b5
  GL_OUTPUT_TEXTURE_COORD25_EXT=: 16b87b6
  GL_OUTPUT_TEXTURE_COORD26_EXT=: 16b87b7
  GL_OUTPUT_TEXTURE_COORD27_EXT=: 16b87b8
  GL_OUTPUT_TEXTURE_COORD28_EXT=: 16b87b9
  GL_OUTPUT_TEXTURE_COORD29_EXT=: 16b87ba
  GL_OUTPUT_TEXTURE_COORD30_EXT=: 16b87bb
  GL_OUTPUT_TEXTURE_COORD31_EXT=: 16b87bc
  GL_OUTPUT_FOG_EXT=: 16b87bd
  GL_SCALAR_EXT=: 16b87be
  GL_VECTOR_EXT=: 16b87bf
  GL_MATRIX_EXT=: 16b87c0
  GL_VARIANT_EXT=: 16b87c1
  GL_INVARIANT_EXT=: 16b87c2
  GL_LOCAL_CONSTANT_EXT=: 16b87c3
  GL_LOCAL_EXT=: 16b87c4
  GL_MAX_VERTEX_SHADER_INSTRUCTIONS_EXT=: 16b87c5
  GL_MAX_VERTEX_SHADER_VARIANTS_EXT=: 16b87c6
  GL_MAX_VERTEX_SHADER_INVARIANTS_EXT=: 16b87c7
  GL_MAX_VERTEX_SHADER_LOCAL_CONSTANTS_EXT=: 16b87c8
  GL_MAX_VERTEX_SHADER_LOCALS_EXT=: 16b87c9
  GL_MAX_OPTIMIZED_VERTEX_SHADER_INSTRUCTIONS_EXT=: 16b87ca
  GL_MAX_OPTIMIZED_VERTEX_SHADER_VARIANTS_EXT=: 16b87cb
  GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCAL_CONSTANTS_EXT=: 16b87cc
  GL_MAX_OPTIMIZED_VERTEX_SHADER_INVARIANTS_EXT=: 16b87cd
  GL_MAX_OPTIMIZED_VERTEX_SHADER_LOCALS_EXT=: 16b87ce
  GL_VERTEX_SHADER_INSTRUCTIONS_EXT=: 16b87cf
  GL_VERTEX_SHADER_VARIANTS_EXT=: 16b87d0
  GL_VERTEX_SHADER_INVARIANTS_EXT=: 16b87d1
  GL_VERTEX_SHADER_LOCAL_CONSTANTS_EXT=: 16b87d2
  GL_VERTEX_SHADER_LOCALS_EXT=: 16b87d3
  GL_VERTEX_SHADER_OPTIMIZED_EXT=: 16b87d4
  GL_X_EXT=: 16b87d5
  GL_Y_EXT=: 16b87d6
  GL_Z_EXT=: 16b87d7
  GL_W_EXT=: 16b87d8
  GL_NEGATIVE_X_EXT=: 16b87d9
  GL_NEGATIVE_Y_EXT=: 16b87da
  GL_NEGATIVE_Z_EXT=: 16b87db
  GL_NEGATIVE_W_EXT=: 16b87dc
  GL_ZERO_EXT=: 16b87dd
  GL_ONE_EXT=: 16b87de
  GL_NEGATIVE_ONE_EXT=: 16b87df
  GL_NORMALIZED_RANGE_EXT=: 16b87e0
  GL_FULL_RANGE_EXT=: 16b87e1
  GL_CURRENT_VERTEX_EXT=: 16b87e2
  GL_MVP_MATRIX_EXT=: 16b87e3
  GL_VARIANT_VALUE_EXT=: 16b87e4
  GL_VARIANT_DATATYPE_EXT=: 16b87e5
  GL_VARIANT_ARRAY_STRIDE_EXT=: 16b87e6
  GL_VARIANT_ARRAY_TYPE_EXT=: 16b87e7
  GL_VARIANT_ARRAY_EXT=: 16b87e8
  GL_VARIANT_ARRAY_POINTER_EXT=: 16b87e9
  GL_INVARIANT_VALUE_EXT=: 16b87ea
  GL_INVARIANT_DATATYPE_EXT=: 16b87eb
  GL_LOCAL_CONSTANT_VALUE_EXT=: 16b87ec
  GL_LOCAL_CONSTANT_DATATYPE_EXT=: 16b87ed
  GL_MAX_VERTEX_STREAMS_ATI=: 16b876b
  GL_VERTEX_STREAM0_ATI=: 16b876c
  GL_VERTEX_STREAM1_ATI=: 16b876d
  GL_VERTEX_STREAM2_ATI=: 16b876e
  GL_VERTEX_STREAM3_ATI=: 16b876f
  GL_VERTEX_STREAM4_ATI=: 16b8770
  GL_VERTEX_STREAM5_ATI=: 16b8771
  GL_VERTEX_STREAM6_ATI=: 16b8772
  GL_VERTEX_STREAM7_ATI=: 16b8773
  GL_VERTEX_SOURCE_ATI=: 16b8774
  GL_ELEMENT_ARRAY_ATI=: 16b8768
  GL_ELEMENT_ARRAY_TYPE_ATI=: 16b8769
  GL_ELEMENT_ARRAY_POINTER_ATI=: 16b876a
  GL_QUAD_MESH_SUN=: 16b8614
  GL_TRIANGLE_MESH_SUN=: 16b8615
  GL_SLICE_ACCUM_SUN=: 16b85cc
  GL_MULTISAMPLE_FILTER_HINT_NV=: 16b8534
  GL_DEPTH_CLAMP_NV=: 16b864f
  GL_PIXEL_COUNTER_BITS_NV=: 16b8864
  GL_CURRENT_OCCLUSION_QUERY_ID_NV=: 16b8865
  GL_PIXEL_COUNT_NV=: 16b8866
  GL_PIXEL_COUNT_AVAILABLE_NV=: 16b8867
  GL_POINT_SPRITE_NV=: 16b8861
  GL_COORD_REPLACE_NV=: 16b8862
  GL_POINT_SPRITE_R_MODE_NV=: 16b8863
  GL_OFFSET_PROJECTIVE_TEXTURE_2D_NV=: 16b8850
  GL_OFFSET_PROJECTIVE_TEXTURE_2D_SCALE_NV=: 16b8851
  GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_NV=: 16b8852
  GL_OFFSET_PROJECTIVE_TEXTURE_RECTANGLE_SCALE_NV=: 16b8853
  GL_OFFSET_HILO_TEXTURE_2D_NV=: 16b8854
  GL_OFFSET_HILO_TEXTURE_RECTANGLE_NV=: 16b8855
  GL_OFFSET_HILO_PROJECTIVE_TEXTURE_2D_NV=: 16b8856
  GL_OFFSET_HILO_PROJECTIVE_TEXTURE_RECTANGLE_NV=: 16b8857
  GL_DEPENDENT_HILO_TEXTURE_2D_NV=: 16b8858
  GL_DEPENDENT_RGB_TEXTURE_3D_NV=: 16b8859
  GL_DEPENDENT_RGB_TEXTURE_CUBE_MAP_NV=: 16b885a
  GL_DOT_PRODUCT_PASS_THROUGH_NV=: 16b885b
  GL_DOT_PRODUCT_TEXTURE_1D_NV=: 16b885c
  GL_DOT_PRODUCT_AFFINE_DEPTH_REPLACE_NV=: 16b885d
  GL_HILO8_NV=: 16b885e
  GL_SIGNED_HILO8_NV=: 16b885f
  GL_FORCE_BLUE_TO_ONE_NV=: 16b8860
  GL_STENCIL_TEST_TWO_SIDE_EXT=: 16b8910
  GL_ACTIVE_STENCIL_FACE_EXT=: 16b8911
  GL_TEXT_FRAGMENT_SHADER_ATI=: 16b8200
  GL_UNPACK_CLIENT_STORAGE_APPLE=: 16b85b2
  GL_ELEMENT_ARRAY_APPLE=: 16b8a0c
  GL_ELEMENT_ARRAY_TYPE_APPLE=: 16b8a0d
  GL_ELEMENT_ARRAY_POINTER_APPLE=: 16b8a0e
  GL_DRAW_PIXELS_APPLE=: 16b8a0a
  GL_FENCE_APPLE=: 16b8a0b
  GL_VERTEX_ARRAY_BINDING_APPLE=: 16b85b5
  GL_VERTEX_ARRAY_RANGE_APPLE=: 16b851d
  GL_VERTEX_ARRAY_RANGE_LENGTH_APPLE=: 16b851e
  GL_VERTEX_ARRAY_STORAGE_HINT_APPLE=: 16b851f
  GL_VERTEX_ARRAY_RANGE_POINTER_APPLE=: 16b8521
  GL_STORAGE_CLIENT_APPLE=: 16b85b4
  GL_STORAGE_CACHED_APPLE=: 16b85be
  GL_STORAGE_SHARED_APPLE=: 16b85bf
  GL_YCBCR_422_APPLE=: 16b85b9
  GL_UNSIGNED_SHORT_8_8_APPLE=: 16b85ba
  GL_UNSIGNED_SHORT_8_8_REV_APPLE=: 16b85bb
  GL_RGB_S3TC=: 16b83a0
  GL_RGB4_S3TC=: 16b83a1
  GL_RGBA_S3TC=: 16b83a2
  GL_RGBA4_S3TC=: 16b83a3
  GL_MAX_DRAW_BUFFERS_ATI=: 16b8824
  GL_DRAW_BUFFER0_ATI=: 16b8825
  GL_DRAW_BUFFER1_ATI=: 16b8826
  GL_DRAW_BUFFER2_ATI=: 16b8827
  GL_DRAW_BUFFER3_ATI=: 16b8828
  GL_DRAW_BUFFER4_ATI=: 16b8829
  GL_DRAW_BUFFER5_ATI=: 16b882a
  GL_DRAW_BUFFER6_ATI=: 16b882b
  GL_DRAW_BUFFER7_ATI=: 16b882c
  GL_DRAW_BUFFER8_ATI=: 16b882d
  GL_DRAW_BUFFER9_ATI=: 16b882e
  GL_DRAW_BUFFER10_ATI=: 16b882f
  GL_DRAW_BUFFER11_ATI=: 16b8830
  GL_DRAW_BUFFER12_ATI=: 16b8831
  GL_DRAW_BUFFER13_ATI=: 16b8832
  GL_DRAW_BUFFER14_ATI=: 16b8833
  GL_DRAW_BUFFER15_ATI=: 16b8834
  GL_TYPE_RGBA_FLOAT_ATI=: 16b8820
  GL_COLOR_CLEAR_UNCLAMPED_VALUE_ATI=: 16b8835
  GL_MODULATE_ADD_ATI=: 16b8744
  GL_MODULATE_SIGNED_ADD_ATI=: 16b8745
  GL_MODULATE_SUBTRACT_ATI=: 16b8746
  GL_RGBA_FLOAT32_ATI=: 16b8814
  GL_RGB_FLOAT32_ATI=: 16b8815
  GL_ALPHA_FLOAT32_ATI=: 16b8816
  GL_INTENSITY_FLOAT32_ATI=: 16b8817
  GL_LUMINANCE_FLOAT32_ATI=: 16b8818
  GL_LUMINANCE_ALPHA_FLOAT32_ATI=: 16b8819
  GL_RGBA_FLOAT16_ATI=: 16b881a
  GL_RGB_FLOAT16_ATI=: 16b881b
  GL_ALPHA_FLOAT16_ATI=: 16b881c
  GL_INTENSITY_FLOAT16_ATI=: 16b881d
  GL_LUMINANCE_FLOAT16_ATI=: 16b881e
  GL_LUMINANCE_ALPHA_FLOAT16_ATI=: 16b881f
  GL_FLOAT_R_NV=: 16b8880
  GL_FLOAT_RG_NV=: 16b8881
  GL_FLOAT_RGB_NV=: 16b8882
  GL_FLOAT_RGBA_NV=: 16b8883
  GL_FLOAT_R16_NV=: 16b8884
  GL_FLOAT_R32_NV=: 16b8885
  GL_FLOAT_RG16_NV=: 16b8886
  GL_FLOAT_RG32_NV=: 16b8887
  GL_FLOAT_RGB16_NV=: 16b8888
  GL_FLOAT_RGB32_NV=: 16b8889
  GL_FLOAT_RGBA16_NV=: 16b888a
  GL_FLOAT_RGBA32_NV=: 16b888b
  GL_TEXTURE_FLOAT_COMPONENTS_NV=: 16b888c
  GL_FLOAT_CLEAR_COLOR_VALUE_NV=: 16b888d
  GL_FLOAT_RGBA_MODE_NV=: 16b888e
  GL_MAX_FRAGMENT_PROGRAM_LOCAL_PARAMETERS_NV=: 16b8868
  GL_FRAGMENT_PROGRAM_NV=: 16b8870
  GL_MAX_TEXTURE_COORDS_NV=: 16b8871
  GL_MAX_TEXTURE_IMAGE_UNITS_NV=: 16b8872
  GL_FRAGMENT_PROGRAM_BINDING_NV=: 16b8873
  GL_PROGRAM_ERROR_STRING_NV=: 16b8874
  GL_HALF_FLOAT_NV=: 16b140b
  GL_WRITE_PIXEL_DATA_RANGE_NV=: 16b8878
  GL_READ_PIXEL_DATA_RANGE_NV=: 16b8879
  GL_WRITE_PIXEL_DATA_RANGE_LENGTH_NV=: 16b887a
  GL_READ_PIXEL_DATA_RANGE_LENGTH_NV=: 16b887b
  GL_WRITE_PIXEL_DATA_RANGE_POINTER_NV=: 16b887c
  GL_READ_PIXEL_DATA_RANGE_POINTER_NV=: 16b887d
  GL_PRIMITIVE_RESTART_NV=: 16b8558
  GL_PRIMITIVE_RESTART_INDEX_NV=: 16b8559
  GL_TEXTURE_UNSIGNED_REMAP_MODE_NV=: 16b888f
  GL_STENCIL_BACK_FUNC_ATI=: 16b8800
  GL_STENCIL_BACK_FAIL_ATI=: 16b8801
  GL_STENCIL_BACK_PASS_DEPTH_FAIL_ATI=: 16b8802
  GL_STENCIL_BACK_PASS_DEPTH_PASS_ATI=: 16b8803
  GL_IMPLEMENTATION_COLOR_READ_TYPE_OES=: 16b8b9a
  GL_IMPLEMENTATION_COLOR_READ_FORMAT_OES=: 16b8b9b
  GL_DEPTH_BOUNDS_TEST_EXT=: 16b8890
  GL_DEPTH_BOUNDS_EXT=: 16b8891
  GL_MIRROR_CLAMP_EXT=: 16b8742
  GL_MIRROR_CLAMP_TO_EDGE_EXT=: 16b8743
  GL_MIRROR_CLAMP_TO_BORDER_EXT=: 16b8912
  GL_BLEND_EQUATION_RGB_EXT=: 16b8009
  GL_BLEND_EQUATION_ALPHA_EXT=: 16b883d
  GL_PACK_INVERT_MESA=: 16b8758
  GL_UNSIGNED_SHORT_8_8_MESA=: 16b85ba
  GL_UNSIGNED_SHORT_8_8_REV_MESA=: 16b85bb
  GL_YCBCR_MESA=: 16b8757
  GL_PIXEL_PACK_BUFFER_EXT=: 16b88eb
  GL_PIXEL_UNPACK_BUFFER_EXT=: 16b88ec
  GL_PIXEL_PACK_BUFFER_BINDING_EXT=: 16b88ed
  GL_PIXEL_UNPACK_BUFFER_BINDING_EXT=: 16b88ef
  GL_MAX_PROGRAM_EXEC_INSTRUCTIONS_NV=: 16b88f4
  GL_MAX_PROGRAM_CALL_DEPTH_NV=: 16b88f5
  GL_MAX_PROGRAM_IF_DEPTH_NV=: 16b88f6
  GL_MAX_PROGRAM_LOOP_DEPTH_NV=: 16b88f7
  GL_MAX_PROGRAM_LOOP_COUNT_NV=: 16b88f8
  GL_INVALID_FRAMEBUFFER_OPERATION_EXT=: 16b0506
  GL_MAX_RENDERBUFFER_SIZE_EXT=: 16b84e8
  GL_FRAMEBUFFER_BINDING_EXT=: 16b8ca6
  GL_RENDERBUFFER_BINDING_EXT=: 16b8ca7
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE_EXT=: 16b8cd0
  GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME_EXT=: 16b8cd1
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL_EXT=: 16b8cd2
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE_EXT=: 16b8cd3
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_3D_ZOFFSET_EXT=: 16b8cd4
  GL_FRAMEBUFFER_COMPLETE_EXT=: 16b8cd5
  GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT_EXT=: 16b8cd6
  GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT_EXT=: 16b8cd7
  GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS_EXT=: 16b8cd9
  GL_FRAMEBUFFER_INCOMPLETE_FORMATS_EXT=: 16b8cda
  GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER_EXT=: 16b8cdb
  GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER_EXT=: 16b8cdc
  GL_FRAMEBUFFER_UNSUPPORTED_EXT=: 16b8cdd
  GL_MAX_COLOR_ATTACHMENTS_EXT=: 16b8cdf
  GL_COLOR_ATTACHMENT0_EXT=: 16b8ce0
  GL_COLOR_ATTACHMENT1_EXT=: 16b8ce1
  GL_COLOR_ATTACHMENT2_EXT=: 16b8ce2
  GL_COLOR_ATTACHMENT3_EXT=: 16b8ce3
  GL_COLOR_ATTACHMENT4_EXT=: 16b8ce4
  GL_COLOR_ATTACHMENT5_EXT=: 16b8ce5
  GL_COLOR_ATTACHMENT6_EXT=: 16b8ce6
  GL_COLOR_ATTACHMENT7_EXT=: 16b8ce7
  GL_COLOR_ATTACHMENT8_EXT=: 16b8ce8
  GL_COLOR_ATTACHMENT9_EXT=: 16b8ce9
  GL_COLOR_ATTACHMENT10_EXT=: 16b8cea
  GL_COLOR_ATTACHMENT11_EXT=: 16b8ceb
  GL_COLOR_ATTACHMENT12_EXT=: 16b8cec
  GL_COLOR_ATTACHMENT13_EXT=: 16b8ced
  GL_COLOR_ATTACHMENT14_EXT=: 16b8cee
  GL_COLOR_ATTACHMENT15_EXT=: 16b8cef
  GL_DEPTH_ATTACHMENT_EXT=: 16b8d00
  GL_STENCIL_ATTACHMENT_EXT=: 16b8d20
  GL_FRAMEBUFFER_EXT=: 16b8d40
  GL_RENDERBUFFER_EXT=: 16b8d41
  GL_RENDERBUFFER_WIDTH_EXT=: 16b8d42
  GL_RENDERBUFFER_HEIGHT_EXT=: 16b8d43
  GL_RENDERBUFFER_INTERNAL_FORMAT_EXT=: 16b8d44
  GL_STENCIL_INDEX1_EXT=: 16b8d46
  GL_STENCIL_INDEX4_EXT=: 16b8d47
  GL_STENCIL_INDEX8_EXT=: 16b8d48
  GL_STENCIL_INDEX16_EXT=: 16b8d49
  GL_RENDERBUFFER_RED_SIZE_EXT=: 16b8d50
  GL_RENDERBUFFER_GREEN_SIZE_EXT=: 16b8d51
  GL_RENDERBUFFER_BLUE_SIZE_EXT=: 16b8d52
  GL_RENDERBUFFER_ALPHA_SIZE_EXT=: 16b8d53
  GL_RENDERBUFFER_DEPTH_SIZE_EXT=: 16b8d54
  GL_RENDERBUFFER_STENCIL_SIZE_EXT=: 16b8d55
  GL_DEPTH_STENCIL_EXT=: 16b84f9
  GL_UNSIGNED_INT_24_8_EXT=: 16b84fa
  GL_DEPTH24_STENCIL8_EXT=: 16b88f0
  GL_TEXTURE_STENCIL_SIZE_EXT=: 16b88f1
  GL_STENCIL_TAG_BITS_EXT=: 16b88f2
  GL_STENCIL_CLEAR_TAG_VALUE_EXT=: 16b88f3
  GL_SRGB_EXT=: 16b8c40
  GL_SRGB8_EXT=: 16b8c41
  GL_SRGB_ALPHA_EXT=: 16b8c42
  GL_SRGB8_ALPHA8_EXT=: 16b8c43
  GL_SLUMINANCE_ALPHA_EXT=: 16b8c44
  GL_SLUMINANCE8_ALPHA8_EXT=: 16b8c45
  GL_SLUMINANCE_EXT=: 16b8c46
  GL_SLUMINANCE8_EXT=: 16b8c47
  GL_COMPRESSED_SRGB_EXT=: 16b8c48
  GL_COMPRESSED_SRGB_ALPHA_EXT=: 16b8c49
  GL_COMPRESSED_SLUMINANCE_EXT=: 16b8c4a
  GL_COMPRESSED_SLUMINANCE_ALPHA_EXT=: 16b8c4b
  GL_COMPRESSED_SRGB_S3TC_DXT1_EXT=: 16b8c4c
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT1_EXT=: 16b8c4d
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT3_EXT=: 16b8c4e
  GL_COMPRESSED_SRGB_ALPHA_S3TC_DXT5_EXT=: 16b8c4f
  GL_READ_FRAMEBUFFER_EXT=: 16b8ca8
  GL_DRAW_FRAMEBUFFER_EXT=: 16b8ca9
  GL_DRAW_FRAMEBUFFER_BINDING_EXT=: GL_FRAMEBUFFER_BINDING_EXT
  GL_READ_FRAMEBUFFER_BINDING_EXT=: 16b8caa
  GL_RENDERBUFFER_SAMPLES_EXT=: 16b8cab
  GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE_EXT=: 16b8d56
  GL_MAX_SAMPLES_EXT=: 16b8d57
  GL_TEXTURE_1D_STACK_MESAX=: 16b8759
  GL_TEXTURE_2D_STACK_MESAX=: 16b875a
  GL_PROXY_TEXTURE_1D_STACK_MESAX=: 16b875b
  GL_PROXY_TEXTURE_2D_STACK_MESAX=: 16b875c
  GL_TEXTURE_1D_STACK_BINDING_MESAX=: 16b875d
  GL_TEXTURE_2D_STACK_BINDING_MESAX=: 16b875e
  GL_TIME_ELAPSED_EXT=: 16b88bf
  GL_BUFFER_SERIALIZED_MODIFY_APPLE=: 16b8a12
  GL_BUFFER_FLUSHING_UNMAP_APPLE=: 16b8a13
  GL_MIN_PROGRAM_TEXEL_OFFSET_NV=: 16b8904
  GL_MAX_PROGRAM_TEXEL_OFFSET_NV=: 16b8905
  GL_PROGRAM_ATTRIB_COMPONENTS_NV=: 16b8906
  GL_PROGRAM_RESULT_COMPONENTS_NV=: 16b8907
  GL_MAX_PROGRAM_ATTRIB_COMPONENTS_NV=: 16b8908
  GL_MAX_PROGRAM_RESULT_COMPONENTS_NV=: 16b8909
  GL_MAX_PROGRAM_GENERIC_ATTRIBS_NV=: 16b8da5
  GL_MAX_PROGRAM_GENERIC_RESULTS_NV=: 16b8da6
  GL_LINES_ADJACENCY_EXT=: 16b000a
  GL_LINE_STRIP_ADJACENCY_EXT=: 16b000b
  GL_TRIANGLES_ADJACENCY_EXT=: 16b000c
  GL_TRIANGLE_STRIP_ADJACENCY_EXT=: 16b000d
  GL_GEOMETRY_PROGRAM_NV=: 16b8c26
  GL_MAX_PROGRAM_OUTPUT_VERTICES_NV=: 16b8c27
  GL_MAX_PROGRAM_TOTAL_OUTPUT_COMPONENTS_NV=: 16b8c28
  GL_GEOMETRY_VERTICES_OUT_EXT=: 16b8dda
  GL_GEOMETRY_INPUT_TYPE_EXT=: 16b8ddb
  GL_GEOMETRY_OUTPUT_TYPE_EXT=: 16b8ddc
  GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS_EXT=: 16b8c29
  GL_FRAMEBUFFER_ATTACHMENT_LAYERED_EXT=: 16b8da7
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS_EXT=: 16b8da8
  GL_FRAMEBUFFER_INCOMPLETE_LAYER_COUNT_EXT=: 16b8da9
  GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER_EXT=: 16b8cd4
  GL_PROGRAM_POINT_SIZE_EXT=: 16b8642
  GL_GEOMETRY_SHADER_EXT=: 16b8dd9
  GL_MAX_GEOMETRY_VARYING_COMPONENTS_EXT=: 16b8ddd
  GL_MAX_VERTEX_VARYING_COMPONENTS_EXT=: 16b8dde
  GL_MAX_VARYING_COMPONENTS_EXT=: 16b8b4b
  GL_MAX_GEOMETRY_UNIFORM_COMPONENTS_EXT=: 16b8ddf
  GL_MAX_GEOMETRY_OUTPUT_VERTICES_EXT=: 16b8de0
  GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS_EXT=: 16b8de1
  GL_VERTEX_ATTRIB_ARRAY_INTEGER_NV=: 16b88fd
  GL_SAMPLER_1D_ARRAY_EXT=: 16b8dc0
  GL_SAMPLER_2D_ARRAY_EXT=: 16b8dc1
  GL_SAMPLER_BUFFER_EXT=: 16b8dc2
  GL_SAMPLER_1D_ARRAY_SHADOW_EXT=: 16b8dc3
  GL_SAMPLER_2D_ARRAY_SHADOW_EXT=: 16b8dc4
  GL_SAMPLER_CUBE_SHADOW_EXT=: 16b8dc5
  GL_UNSIGNED_INT_VEC2_EXT=: 16b8dc6
  GL_UNSIGNED_INT_VEC3_EXT=: 16b8dc7
  GL_UNSIGNED_INT_VEC4_EXT=: 16b8dc8
  GL_INT_SAMPLER_1D_EXT=: 16b8dc9
  GL_INT_SAMPLER_2D_EXT=: 16b8dca
  GL_INT_SAMPLER_3D_EXT=: 16b8dcb
  GL_INT_SAMPLER_CUBE_EXT=: 16b8dcc
  GL_INT_SAMPLER_2D_RECT_EXT=: 16b8dcd
  GL_INT_SAMPLER_1D_ARRAY_EXT=: 16b8dce
  GL_INT_SAMPLER_2D_ARRAY_EXT=: 16b8dcf
  GL_INT_SAMPLER_BUFFER_EXT=: 16b8dd0
  GL_UNSIGNED_INT_SAMPLER_1D_EXT=: 16b8dd1
  GL_UNSIGNED_INT_SAMPLER_2D_EXT=: 16b8dd2
  GL_UNSIGNED_INT_SAMPLER_3D_EXT=: 16b8dd3
  GL_UNSIGNED_INT_SAMPLER_CUBE_EXT=: 16b8dd4
  GL_UNSIGNED_INT_SAMPLER_2D_RECT_EXT=: 16b8dd5
  GL_UNSIGNED_INT_SAMPLER_1D_ARRAY_EXT=: 16b8dd6
  GL_UNSIGNED_INT_SAMPLER_2D_ARRAY_EXT=: 16b8dd7
  GL_UNSIGNED_INT_SAMPLER_BUFFER_EXT=: 16b8dd8
  GL_R11F_G11F_B10F_EXT=: 16b8c3a
  GL_UNSIGNED_INT_10F_11F_11F_REV_EXT=: 16b8c3b
  GL_RGBA_SIGNED_COMPONENTS_EXT=: 16b8c3c
  GL_TEXTURE_1D_ARRAY_EXT=: 16b8c18
  GL_PROXY_TEXTURE_1D_ARRAY_EXT=: 16b8c19
  GL_TEXTURE_2D_ARRAY_EXT=: 16b8c1a
  GL_PROXY_TEXTURE_2D_ARRAY_EXT=: 16b8c1b
  GL_TEXTURE_BINDING_1D_ARRAY_EXT=: 16b8c1c
  GL_TEXTURE_BINDING_2D_ARRAY_EXT=: 16b8c1d
  GL_MAX_ARRAY_TEXTURE_LAYERS_EXT=: 16b88ff
  GL_COMPARE_REF_DEPTH_TO_TEXTURE_EXT=: 16b884e
  GL_TEXTURE_BUFFER_EXT=: 16b8c2a
  GL_MAX_TEXTURE_BUFFER_SIZE_EXT=: 16b8c2b
  GL_TEXTURE_BINDING_BUFFER_EXT=: 16b8c2c
  GL_TEXTURE_BUFFER_DATA_STORE_BINDING_EXT=: 16b8c2d
  GL_TEXTURE_BUFFER_FORMAT_EXT=: 16b8c2e
  GL_COMPRESSED_LUMINANCE_LATC1_EXT=: 16b8c70
  GL_COMPRESSED_SIGNED_LUMINANCE_LATC1_EXT=: 16b8c71
  GL_COMPRESSED_LUMINANCE_ALPHA_LATC2_EXT=: 16b8c72
  GL_COMPRESSED_SIGNED_LUMINANCE_ALPHA_LATC2_EXT=: 16b8c73
  GL_COMPRESSED_RED_RGTC1_EXT=: 16b8dbb
  GL_COMPRESSED_SIGNED_RED_RGTC1_EXT=: 16b8dbc
  GL_COMPRESSED_RED_GREEN_RGTC2_EXT=: 16b8dbd
  GL_COMPRESSED_SIGNED_RED_GREEN_RGTC2_EXT=: 16b8dbe
  GL_RGB9_E5_EXT=: 16b8c3d
  GL_UNSIGNED_INT_5_9_9_9_REV_EXT=: 16b8c3e
  GL_TEXTURE_SHARED_SIZE_EXT=: 16b8c3f
  GL_DEPTH_COMPONENT32F_NV=: 16b8dab
  GL_DEPTH32F_STENCIL8_NV=: 16b8dac
  GL_FLOAT_32_UNSIGNED_INT_24_8_REV_NV=: 16b8dad
  GL_DEPTH_BUFFER_FLOAT_MODE_NV=: 16b8daf
  GL_RENDERBUFFER_COVERAGE_SAMPLES_NV=: 16b8cab
  GL_RENDERBUFFER_COLOR_SAMPLES_NV=: 16b8e10
  GL_MAX_MULTISAMPLE_COVERAGE_MODES_NV=: 16b8e11
  GL_MULTISAMPLE_COVERAGE_MODES_NV=: 16b8e12
  GL_FRAMEBUFFER_SRGB_EXT=: 16b8db9
  GL_FRAMEBUFFER_SRGB_CAPABLE_EXT=: 16b8dba
  GL_MAX_PROGRAM_PARAMETER_BUFFER_BINDINGS_NV=: 16b8da0
  GL_MAX_PROGRAM_PARAMETER_BUFFER_SIZE_NV=: 16b8da1
  GL_VERTEX_PROGRAM_PARAMETER_BUFFER_NV=: 16b8da2
  GL_GEOMETRY_PROGRAM_PARAMETER_BUFFER_NV=: 16b8da3
  GL_FRAGMENT_PROGRAM_PARAMETER_BUFFER_NV=: 16b8da4
  GL_BACK_PRIMARY_COLOR_NV=: 16b8c77
  GL_BACK_SECONDARY_COLOR_NV=: 16b8c78
  GL_TEXTURE_COORD_NV=: 16b8c79
  GL_CLIP_DISTANCE_NV=: 16b8c7a
  GL_VERTEX_ID_NV=: 16b8c7b
  GL_PRIMITIVE_ID_NV=: 16b8c7c
  GL_GENERIC_ATTRIB_NV=: 16b8c7d
  GL_TRANSFORM_FEEDBACK_ATTRIBS_NV=: 16b8c7e
  GL_TRANSFORM_FEEDBACK_BUFFER_MODE_NV=: 16b8c7f
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_NV=: 16b8c80
  GL_ACTIVE_VARYINGS_NV=: 16b8c81
  GL_ACTIVE_VARYING_MAX_LENGTH_NV=: 16b8c82
  GL_TRANSFORM_FEEDBACK_VARYINGS_NV=: 16b8c83
  GL_TRANSFORM_FEEDBACK_BUFFER_START_NV=: 16b8c84
  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_NV=: 16b8c85
  GL_TRANSFORM_FEEDBACK_RECORD_NV=: 16b8c86
  GL_PRIMITIVES_GENERATED_NV=: 16b8c87
  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_NV=: 16b8c88
  GL_RASTERIZER_DISCARD_NV=: 16b8c89
  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_ATTRIBS_NV=: 16b8c8a
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_NV=: 16b8c8b
  GL_INTERLEAVED_ATTRIBS_NV=: 16b8c8c
  GL_SEPARATE_ATTRIBS_NV=: 16b8c8d
  GL_TRANSFORM_FEEDBACK_BUFFER_NV=: 16b8c8e
  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_NV=: 16b8c8f
  GL_LAYER_NV=: 16b8daa
  GL_NEXT_BUFFER_NV=: _2
  GL_SKIP_COMPONENTS4_NV=: _3
  GL_SKIP_COMPONENTS3_NV=: _4
  GL_SKIP_COMPONENTS2_NV=: _5
  GL_SKIP_COMPONENTS1_NV=: _6
  GL_MAX_VERTEX_BINDABLE_UNIFORMS_EXT=: 16b8de2
  GL_MAX_FRAGMENT_BINDABLE_UNIFORMS_EXT=: 16b8de3
  GL_MAX_GEOMETRY_BINDABLE_UNIFORMS_EXT=: 16b8de4
  GL_MAX_BINDABLE_UNIFORM_SIZE_EXT=: 16b8ded
  GL_UNIFORM_BUFFER_EXT=: 16b8dee
  GL_UNIFORM_BUFFER_BINDING_EXT=: 16b8def
  GL_RGBA32UI_EXT=: 16b8d70
  GL_RGB32UI_EXT=: 16b8d71
  GL_ALPHA32UI_EXT=: 16b8d72
  GL_INTENSITY32UI_EXT=: 16b8d73
  GL_LUMINANCE32UI_EXT=: 16b8d74
  GL_LUMINANCE_ALPHA32UI_EXT=: 16b8d75
  GL_RGBA16UI_EXT=: 16b8d76
  GL_RGB16UI_EXT=: 16b8d77
  GL_ALPHA16UI_EXT=: 16b8d78
  GL_INTENSITY16UI_EXT=: 16b8d79
  GL_LUMINANCE16UI_EXT=: 16b8d7a
  GL_LUMINANCE_ALPHA16UI_EXT=: 16b8d7b
  GL_RGBA8UI_EXT=: 16b8d7c
  GL_RGB8UI_EXT=: 16b8d7d
  GL_ALPHA8UI_EXT=: 16b8d7e
  GL_INTENSITY8UI_EXT=: 16b8d7f
  GL_LUMINANCE8UI_EXT=: 16b8d80
  GL_LUMINANCE_ALPHA8UI_EXT=: 16b8d81
  GL_RGBA32I_EXT=: 16b8d82
  GL_RGB32I_EXT=: 16b8d83
  GL_ALPHA32I_EXT=: 16b8d84
  GL_INTENSITY32I_EXT=: 16b8d85
  GL_LUMINANCE32I_EXT=: 16b8d86
  GL_LUMINANCE_ALPHA32I_EXT=: 16b8d87
  GL_RGBA16I_EXT=: 16b8d88
  GL_RGB16I_EXT=: 16b8d89
  GL_ALPHA16I_EXT=: 16b8d8a
  GL_INTENSITY16I_EXT=: 16b8d8b
  GL_LUMINANCE16I_EXT=: 16b8d8c
  GL_LUMINANCE_ALPHA16I_EXT=: 16b8d8d
  GL_RGBA8I_EXT=: 16b8d8e
  GL_RGB8I_EXT=: 16b8d8f
  GL_ALPHA8I_EXT=: 16b8d90
  GL_INTENSITY8I_EXT=: 16b8d91
  GL_LUMINANCE8I_EXT=: 16b8d92
  GL_LUMINANCE_ALPHA8I_EXT=: 16b8d93
  GL_RED_INTEGER_EXT=: 16b8d94
  GL_GREEN_INTEGER_EXT=: 16b8d95
  GL_BLUE_INTEGER_EXT=: 16b8d96
  GL_ALPHA_INTEGER_EXT=: 16b8d97
  GL_RGB_INTEGER_EXT=: 16b8d98
  GL_RGBA_INTEGER_EXT=: 16b8d99
  GL_BGR_INTEGER_EXT=: 16b8d9a
  GL_BGRA_INTEGER_EXT=: 16b8d9b
  GL_LUMINANCE_INTEGER_EXT=: 16b8d9c
  GL_LUMINANCE_ALPHA_INTEGER_EXT=: 16b8d9d
  GL_RGBA_INTEGER_MODE_EXT=: 16b8d9e
  GL_QUERY_WAIT_NV=: 16b8e13
  GL_QUERY_NO_WAIT_NV=: 16b8e14
  GL_QUERY_BY_REGION_WAIT_NV=: 16b8e15
  GL_QUERY_BY_REGION_NO_WAIT_NV=: 16b8e16
  GL_FRAME_NV=: 16b8e26
  GL_FIELDS_NV=: 16b8e27
  GL_CURRENT_TIME_NV=: 16b8e28
  GL_NUM_FILL_STREAMS_NV=: 16b8e29
  GL_PRESENT_TIME_NV=: 16b8e2a
  GL_PRESENT_DURATION_NV=: 16b8e2b
  GL_TRANSFORM_FEEDBACK_BUFFER_EXT=: 16b8c8e
  GL_TRANSFORM_FEEDBACK_BUFFER_START_EXT=: 16b8c84
  GL_TRANSFORM_FEEDBACK_BUFFER_SIZE_EXT=: 16b8c85
  GL_TRANSFORM_FEEDBACK_BUFFER_BINDING_EXT=: 16b8c8f
  GL_INTERLEAVED_ATTRIBS_EXT=: 16b8c8c
  GL_SEPARATE_ATTRIBS_EXT=: 16b8c8d
  GL_PRIMITIVES_GENERATED_EXT=: 16b8c87
  GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN_EXT=: 16b8c88
  GL_RASTERIZER_DISCARD_EXT=: 16b8c89
  GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS_EXT=: 16b8c8a
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS_EXT=: 16b8c8b
  GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS_EXT=: 16b8c80
  GL_TRANSFORM_FEEDBACK_VARYINGS_EXT=: 16b8c83
  GL_TRANSFORM_FEEDBACK_BUFFER_MODE_EXT=: 16b8c7f
  GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH_EXT=: 16b8c76
  GL_PROGRAM_MATRIX_EXT=: 16b8e2d
  GL_TRANSPOSE_PROGRAM_MATRIX_EXT=: 16b8e2e
  GL_PROGRAM_MATRIX_STACK_DEPTH_EXT=: 16b8e2f
  GL_TEXTURE_SWIZZLE_R_EXT=: 16b8e42
  GL_TEXTURE_SWIZZLE_G_EXT=: 16b8e43
  GL_TEXTURE_SWIZZLE_B_EXT=: 16b8e44
  GL_TEXTURE_SWIZZLE_A_EXT=: 16b8e45
  GL_TEXTURE_SWIZZLE_RGBA_EXT=: 16b8e46
  GL_SAMPLE_POSITION_NV=: 16b8e50
  GL_SAMPLE_MASK_NV=: 16b8e51
  GL_SAMPLE_MASK_VALUE_NV=: 16b8e52
  GL_TEXTURE_BINDING_RENDERBUFFER_NV=: 16b8e53
  GL_TEXTURE_RENDERBUFFER_DATA_STORE_BINDING_NV=: 16b8e54
  GL_TEXTURE_RENDERBUFFER_NV=: 16b8e55
  GL_SAMPLER_RENDERBUFFER_NV=: 16b8e56
  GL_INT_SAMPLER_RENDERBUFFER_NV=: 16b8e57
  GL_UNSIGNED_INT_SAMPLER_RENDERBUFFER_NV=: 16b8e58
  GL_MAX_SAMPLE_MASK_WORDS_NV=: 16b8e59
  GL_TRANSFORM_FEEDBACK_NV=: 16b8e22
  GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED_NV=: 16b8e23
  GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE_NV=: 16b8e24
  GL_TRANSFORM_FEEDBACK_BINDING_NV=: 16b8e25
  GL_VBO_FREE_MEMORY_ATI=: 16b87fb
  GL_TEXTURE_FREE_MEMORY_ATI=: 16b87fc
  GL_RENDERBUFFER_FREE_MEMORY_ATI=: 16b87fd
  GL_COUNTER_TYPE_AMD=: 16b8bc0
  GL_COUNTER_RANGE_AMD=: 16b8bc1
  GL_UNSIGNED_INT64_AMD=: 16b8bc2
  GL_PERCENTAGE_AMD=: 16b8bc3
  GL_PERFMON_RESULT_AVAILABLE_AMD=: 16b8bc4
  GL_PERFMON_RESULT_SIZE_AMD=: 16b8bc5
  GL_PERFMON_RESULT_AMD=: 16b8bc6
  GL_SAMPLER_BUFFER_AMD=: 16b9001
  GL_INT_SAMPLER_BUFFER_AMD=: 16b9002
  GL_UNSIGNED_INT_SAMPLER_BUFFER_AMD=: 16b9003
  GL_TESSELLATION_MODE_AMD=: 16b9004
  GL_TESSELLATION_FACTOR_AMD=: 16b9005
  GL_DISCRETE_AMD=: 16b9006
  GL_CONTINUOUS_AMD=: 16b9007
  GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION_EXT=: 16b8e4c
  GL_FIRST_VERTEX_CONVENTION_EXT=: 16b8e4d
  GL_LAST_VERTEX_CONVENTION_EXT=: 16b8e4e
  GL_PROVOKING_VERTEX_EXT=: 16b8e4f
  GL_ALPHA_SNORM=: 16b9010
  GL_LUMINANCE_SNORM=: 16b9011
  GL_LUMINANCE_ALPHA_SNORM=: 16b9012
  GL_INTENSITY_SNORM=: 16b9013
  GL_ALPHA8_SNORM=: 16b9014
  GL_LUMINANCE8_SNORM=: 16b9015
  GL_LUMINANCE8_ALPHA8_SNORM=: 16b9016
  GL_INTENSITY8_SNORM=: 16b9017
  GL_ALPHA16_SNORM=: 16b9018
  GL_LUMINANCE16_SNORM=: 16b9019
  GL_LUMINANCE16_ALPHA16_SNORM=: 16b901a
  GL_INTENSITY16_SNORM=: 16b901b
  GL_TEXTURE_RANGE_LENGTH_APPLE=: 16b85b7
  GL_TEXTURE_RANGE_POINTER_APPLE=: 16b85b8
  GL_TEXTURE_STORAGE_HINT_APPLE=: 16b85bc
  GL_STORAGE_PRIVATE_APPLE=: 16b85bd
  GL_HALF_APPLE=: 16b140b
  GL_RGBA_FLOAT32_APPLE=: 16b8814
  GL_RGB_FLOAT32_APPLE=: 16b8815
  GL_ALPHA_FLOAT32_APPLE=: 16b8816
  GL_INTENSITY_FLOAT32_APPLE=: 16b8817
  GL_LUMINANCE_FLOAT32_APPLE=: 16b8818
  GL_LUMINANCE_ALPHA_FLOAT32_APPLE=: 16b8819
  GL_RGBA_FLOAT16_APPLE=: 16b881a
  GL_RGB_FLOAT16_APPLE=: 16b881b
  GL_ALPHA_FLOAT16_APPLE=: 16b881c
  GL_INTENSITY_FLOAT16_APPLE=: 16b881d
  GL_LUMINANCE_FLOAT16_APPLE=: 16b881e
  GL_LUMINANCE_ALPHA_FLOAT16_APPLE=: 16b881f
  GL_COLOR_FLOAT_APPLE=: 16b8a0f
  GL_VERTEX_ATTRIB_MAP1_APPLE=: 16b8a00
  GL_VERTEX_ATTRIB_MAP2_APPLE=: 16b8a01
  GL_VERTEX_ATTRIB_MAP1_SIZE_APPLE=: 16b8a02
  GL_VERTEX_ATTRIB_MAP1_COEFF_APPLE=: 16b8a03
  GL_VERTEX_ATTRIB_MAP1_ORDER_APPLE=: 16b8a04
  GL_VERTEX_ATTRIB_MAP1_DOMAIN_APPLE=: 16b8a05
  GL_VERTEX_ATTRIB_MAP2_SIZE_APPLE=: 16b8a06
  GL_VERTEX_ATTRIB_MAP2_COEFF_APPLE=: 16b8a07
  GL_VERTEX_ATTRIB_MAP2_ORDER_APPLE=: 16b8a08
  GL_VERTEX_ATTRIB_MAP2_DOMAIN_APPLE=: 16b8a09
  GL_AUX_DEPTH_STENCIL_APPLE=: 16b8a14
  GL_BUFFER_OBJECT_APPLE=: 16b85b3
  GL_RELEASED_APPLE=: 16b8a19
  GL_VOLATILE_APPLE=: 16b8a1a
  GL_RETAINED_APPLE=: 16b8a1b
  GL_UNDEFINED_APPLE=: 16b8a1c
  GL_PURGEABLE_APPLE=: 16b8a1d
  GL_PACK_ROW_BYTES_APPLE=: 16b8a15
  GL_UNPACK_ROW_BYTES_APPLE=: 16b8a16
  GL_RGB_422_APPLE=: 16b8a1f
  GL_VIDEO_BUFFER_NV=: 16b9020
  GL_VIDEO_BUFFER_BINDING_NV=: 16b9021
  GL_FIELD_UPPER_NV=: 16b9022
  GL_FIELD_LOWER_NV=: 16b9023
  GL_NUM_VIDEO_CAPTURE_STREAMS_NV=: 16b9024
  GL_NEXT_VIDEO_CAPTURE_BUFFER_STATUS_NV=: 16b9025
  GL_VIDEO_CAPTURE_TO_422_SUPPORTED_NV=: 16b9026
  GL_LAST_VIDEO_CAPTURE_STATUS_NV=: 16b9027
  GL_VIDEO_BUFFER_PITCH_NV=: 16b9028
  GL_VIDEO_COLOR_CONVERSION_MATRIX_NV=: 16b9029
  GL_VIDEO_COLOR_CONVERSION_MAX_NV=: 16b902a
  GL_VIDEO_COLOR_CONVERSION_MIN_NV=: 16b902b
  GL_VIDEO_COLOR_CONVERSION_OFFSET_NV=: 16b902c
  GL_VIDEO_BUFFER_INTERNAL_FORMAT_NV=: 16b902d
  GL_PARTIAL_SUCCESS_NV=: 16b902e
  GL_SUCCESS_NV=: 16b902f
  GL_FAILURE_NV=: 16b9030
  GL_YCBYCR8_422_NV=: 16b9031
  GL_YCBAYCR8A_4224_NV=: 16b9032
  GL_Z6Y10Z6CB10Z6Y10Z6CR10_422_NV=: 16b9033
  GL_Z6Y10Z6CB10Z6A10Z6Y10Z6CR10Z6A10_4224_NV=: 16b9034
  GL_Z4Y12Z4CB12Z4Y12Z4CR12_422_NV=: 16b9035
  GL_Z4Y12Z4CB12Z4A12Z4Y12Z4CR12Z4A12_4224_NV=: 16b9036
  GL_Z4Y12Z4CB12Z4CR12_444_NV=: 16b9037
  GL_VIDEO_CAPTURE_FRAME_WIDTH_NV=: 16b9038
  GL_VIDEO_CAPTURE_FRAME_HEIGHT_NV=: 16b9039
  GL_VIDEO_CAPTURE_FIELD_UPPER_HEIGHT_NV=: 16b903a
  GL_VIDEO_CAPTURE_FIELD_LOWER_HEIGHT_NV=: 16b903b
  GL_VIDEO_CAPTURE_SURFACE_ORIGIN_NV=: 16b903c
  GL_ACTIVE_PROGRAM_EXT=: 16b8b8d
  GL_BUFFER_GPU_ADDRESS_NV=: 16b8f1d
  GL_GPU_ADDRESS_NV=: 16b8f34
  GL_MAX_SHADER_BUFFER_ADDRESS_NV=: 16b8f35
  GL_VERTEX_ATTRIB_ARRAY_UNIFIED_NV=: 16b8f1e
  GL_ELEMENT_ARRAY_UNIFIED_NV=: 16b8f1f
  GL_VERTEX_ATTRIB_ARRAY_ADDRESS_NV=: 16b8f20
  GL_VERTEX_ARRAY_ADDRESS_NV=: 16b8f21
  GL_NORMAL_ARRAY_ADDRESS_NV=: 16b8f22
  GL_COLOR_ARRAY_ADDRESS_NV=: 16b8f23
  GL_INDEX_ARRAY_ADDRESS_NV=: 16b8f24
  GL_TEXTURE_COORD_ARRAY_ADDRESS_NV=: 16b8f25
  GL_EDGE_FLAG_ARRAY_ADDRESS_NV=: 16b8f26
  GL_SECONDARY_COLOR_ARRAY_ADDRESS_NV=: 16b8f27
  GL_FOG_COORD_ARRAY_ADDRESS_NV=: 16b8f28
  GL_ELEMENT_ARRAY_ADDRESS_NV=: 16b8f29
  GL_VERTEX_ATTRIB_ARRAY_LENGTH_NV=: 16b8f2a
  GL_VERTEX_ARRAY_LENGTH_NV=: 16b8f2b
  GL_NORMAL_ARRAY_LENGTH_NV=: 16b8f2c
  GL_COLOR_ARRAY_LENGTH_NV=: 16b8f2d
  GL_INDEX_ARRAY_LENGTH_NV=: 16b8f2e
  GL_TEXTURE_COORD_ARRAY_LENGTH_NV=: 16b8f2f
  GL_EDGE_FLAG_ARRAY_LENGTH_NV=: 16b8f30
  GL_SECONDARY_COLOR_ARRAY_LENGTH_NV=: 16b8f31
  GL_FOG_COORD_ARRAY_LENGTH_NV=: 16b8f32
  GL_ELEMENT_ARRAY_LENGTH_NV=: 16b8f33
  GL_DRAW_INDIRECT_UNIFIED_NV=: 16b8f40
  GL_DRAW_INDIRECT_ADDRESS_NV=: 16b8f41
  GL_DRAW_INDIRECT_LENGTH_NV=: 16b8f42
  GL_MAX_IMAGE_UNITS_EXT=: 16b8f38
  GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS_EXT=: 16b8f39
  GL_IMAGE_BINDING_NAME_EXT=: 16b8f3a
  GL_IMAGE_BINDING_LEVEL_EXT=: 16b8f3b
  GL_IMAGE_BINDING_LAYERED_EXT=: 16b8f3c
  GL_IMAGE_BINDING_LAYER_EXT=: 16b8f3d
  GL_IMAGE_BINDING_ACCESS_EXT=: 16b8f3e
  GL_IMAGE_1D_EXT=: 16b904c
  GL_IMAGE_2D_EXT=: 16b904d
  GL_IMAGE_3D_EXT=: 16b904e
  GL_IMAGE_2D_RECT_EXT=: 16b904f
  GL_IMAGE_CUBE_EXT=: 16b9050
  GL_IMAGE_BUFFER_EXT=: 16b9051
  GL_IMAGE_1D_ARRAY_EXT=: 16b9052
  GL_IMAGE_2D_ARRAY_EXT=: 16b9053
  GL_IMAGE_CUBE_MAP_ARRAY_EXT=: 16b9054
  GL_IMAGE_2D_MULTISAMPLE_EXT=: 16b9055
  GL_IMAGE_2D_MULTISAMPLE_ARRAY_EXT=: 16b9056
  GL_INT_IMAGE_1D_EXT=: 16b9057
  GL_INT_IMAGE_2D_EXT=: 16b9058
  GL_INT_IMAGE_3D_EXT=: 16b9059
  GL_INT_IMAGE_2D_RECT_EXT=: 16b905a
  GL_INT_IMAGE_CUBE_EXT=: 16b905b
  GL_INT_IMAGE_BUFFER_EXT=: 16b905c
  GL_INT_IMAGE_1D_ARRAY_EXT=: 16b905d
  GL_INT_IMAGE_2D_ARRAY_EXT=: 16b905e
  GL_INT_IMAGE_CUBE_MAP_ARRAY_EXT=: 16b905f
  GL_INT_IMAGE_2D_MULTISAMPLE_EXT=: 16b9060
  GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT=: 16b9061
  GL_UNSIGNED_INT_IMAGE_1D_EXT=: 16b9062
  GL_UNSIGNED_INT_IMAGE_2D_EXT=: 16b9063
  GL_UNSIGNED_INT_IMAGE_3D_EXT=: 16b9064
  GL_UNSIGNED_INT_IMAGE_2D_RECT_EXT=: 16b9065
  GL_UNSIGNED_INT_IMAGE_CUBE_EXT=: 16b9066
  GL_UNSIGNED_INT_IMAGE_BUFFER_EXT=: 16b9067
  GL_UNSIGNED_INT_IMAGE_1D_ARRAY_EXT=: 16b9068
  GL_UNSIGNED_INT_IMAGE_2D_ARRAY_EXT=: 16b9069
  GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY_EXT=: 16b906a
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_EXT=: 16b906b
  GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY_EXT=: 16b906c
  GL_MAX_IMAGE_SAMPLES_EXT=: 16b906d
  GL_IMAGE_BINDING_FORMAT_EXT=: 16b906e
  GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT_EXT=: 16b00000001
  GL_ELEMENT_ARRAY_BARRIER_BIT_EXT=: 16b00000002
  GL_UNIFORM_BARRIER_BIT_EXT=: 16b00000004
  GL_TEXTURE_FETCH_BARRIER_BIT_EXT=: 16b00000008
  GL_SHADER_IMAGE_ACCESS_BARRIER_BIT_EXT=: 16b00000020
  GL_COMMAND_BARRIER_BIT_EXT=: 16b00000040
  GL_PIXEL_BUFFER_BARRIER_BIT_EXT=: 16b00000080
  GL_TEXTURE_UPDATE_BARRIER_BIT_EXT=: 16b00000100
  GL_BUFFER_UPDATE_BARRIER_BIT_EXT=: 16b00000200
  GL_FRAMEBUFFER_BARRIER_BIT_EXT=: 16b00000400
  GL_TRANSFORM_FEEDBACK_BARRIER_BIT_EXT=: 16b00000800
  GL_ATOMIC_COUNTER_BARRIER_BIT_EXT=: 16b00001000
  GL_ALL_BARRIER_BITS_EXT=: _1
  GL_DOUBLE_VEC2_EXT=: 16b8ffc
  GL_DOUBLE_VEC3_EXT=: 16b8ffd
  GL_DOUBLE_VEC4_EXT=: 16b8ffe
  GL_DOUBLE_MAT2_EXT=: 16b8f46
  GL_DOUBLE_MAT3_EXT=: 16b8f47
  GL_DOUBLE_MAT4_EXT=: 16b8f48
  GL_DOUBLE_MAT2x3_EXT=: 16b8f49
  GL_DOUBLE_MAT2x4_EXT=: 16b8f4a
  GL_DOUBLE_MAT3x2_EXT=: 16b8f4b
  GL_DOUBLE_MAT3x4_EXT=: 16b8f4c
  GL_DOUBLE_MAT4x2_EXT=: 16b8f4d
  GL_DOUBLE_MAT4x3_EXT=: 16b8f4e
  GL_MAX_GEOMETRY_PROGRAM_INVOCATIONS_NV=: 16b8e5a
  GL_MIN_FRAGMENT_INTERPOLATION_OFFSET_NV=: 16b8e5b
  GL_MAX_FRAGMENT_INTERPOLATION_OFFSET_NV=: 16b8e5c
  GL_FRAGMENT_PROGRAM_INTERPOLATION_OFFSET_BITS_NV=: 16b8e5d
  GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET_NV=: 16b8e5e
  GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET_NV=: 16b8e5f
  GL_MAX_PROGRAM_SUBROUTINE_PARAMETERS_NV=: 16b8f44
  GL_MAX_PROGRAM_SUBROUTINE_NUM_NV=: 16b8f45
  GL_INT64_NV=: 16b140e
  GL_UNSIGNED_INT64_NV=: 16b140f
  GL_INT8_NV=: 16b8fe0
  GL_INT8_VEC2_NV=: 16b8fe1
  GL_INT8_VEC3_NV=: 16b8fe2
  GL_INT8_VEC4_NV=: 16b8fe3
  GL_INT16_NV=: 16b8fe4
  GL_INT16_VEC2_NV=: 16b8fe5
  GL_INT16_VEC3_NV=: 16b8fe6
  GL_INT16_VEC4_NV=: 16b8fe7
  GL_INT64_VEC2_NV=: 16b8fe9
  GL_INT64_VEC3_NV=: 16b8fea
  GL_INT64_VEC4_NV=: 16b8feb
  GL_UNSIGNED_INT8_NV=: 16b8fec
  GL_UNSIGNED_INT8_VEC2_NV=: 16b8fed
  GL_UNSIGNED_INT8_VEC3_NV=: 16b8fee
  GL_UNSIGNED_INT8_VEC4_NV=: 16b8fef
  GL_UNSIGNED_INT16_NV=: 16b8ff0
  GL_UNSIGNED_INT16_VEC2_NV=: 16b8ff1
  GL_UNSIGNED_INT16_VEC3_NV=: 16b8ff2
  GL_UNSIGNED_INT16_VEC4_NV=: 16b8ff3
  GL_UNSIGNED_INT64_VEC2_NV=: 16b8ff5
  GL_UNSIGNED_INT64_VEC3_NV=: 16b8ff6
  GL_UNSIGNED_INT64_VEC4_NV=: 16b8ff7
  GL_FLOAT16_NV=: 16b8ff8
  GL_FLOAT16_VEC2_NV=: 16b8ff9
  GL_FLOAT16_VEC3_NV=: 16b8ffa
  GL_FLOAT16_VEC4_NV=: 16b8ffb
  GL_SHADER_GLOBAL_ACCESS_BARRIER_BIT_NV=: 16b00000010
  GL_MAX_PROGRAM_PATCH_ATTRIBS_NV=: 16b86d8
  GL_TESS_CONTROL_PROGRAM_NV=: 16b891e
  GL_TESS_EVALUATION_PROGRAM_NV=: 16b891f
  GL_TESS_CONTROL_PROGRAM_PARAMETER_BUFFER_NV=: 16b8c74
  GL_TESS_EVALUATION_PROGRAM_PARAMETER_BUFFER_NV=: 16b8c75
  GL_COVERAGE_SAMPLES_NV=: 16b80a9
  GL_COLOR_SAMPLES_NV=: 16b8e20
  GL_DATA_BUFFER_AMD=: 16b9151
  GL_PERFORMANCE_MONITOR_AMD=: 16b9152
  GL_QUERY_OBJECT_AMD=: 16b9153
  GL_VERTEX_ARRAY_OBJECT_AMD=: 16b9154
  GL_SAMPLER_OBJECT_AMD=: 16b9155
  GL_MAX_DEBUG_LOGGED_MESSAGES_AMD=: 16b9144
  GL_DEBUG_LOGGED_MESSAGES_AMD=: 16b9145
  GL_DEBUG_SEVERITY_HIGH_AMD=: 16b9146
  GL_DEBUG_SEVERITY_MEDIUM_AMD=: 16b9147
  GL_DEBUG_SEVERITY_LOW_AMD=: 16b9148
  GL_DEBUG_CATEGORY_API_ERROR_AMD=: 16b9149
  GL_DEBUG_CATEGORY_WINDOW_SYSTEM_AMD=: 16b914a
  GL_DEBUG_CATEGORY_DEPRECATION_AMD=: 16b914b
  GL_DEBUG_CATEGORY_UNDEFINED_BEHAVIOR_AMD=: 16b914c
  GL_DEBUG_CATEGORY_PERFORMANCE_AMD=: 16b914d
  GL_DEBUG_CATEGORY_SHADER_COMPILER_AMD=: 16b914e
  GL_DEBUG_CATEGORY_APPLICATION_AMD=: 16b914f
  GL_DEBUG_CATEGORY_OTHER_AMD=: 16b9150
  GL_SURFACE_STATE_NV=: 16b86eb
  GL_SURFACE_REGISTERED_NV=: 16b86fd
  GL_SURFACE_MAPPED_NV=: 16b8700
  GL_WRITE_DISCARD_NV=: 16b88be
  GL_DEPTH_CLAMP_NEAR_AMD=: 16b901e
  GL_DEPTH_CLAMP_FAR_AMD=: 16b901f
  GL_TEXTURE_SRGB_DECODE_EXT=: 16b8a48
  GL_DECODE_EXT=: 16b8a49
  GL_SKIP_DECODE_EXT=: 16b8a4a
  GL_TEXTURE_COVERAGE_SAMPLES_NV=: 16b9045
  GL_TEXTURE_COLOR_SAMPLES_NV=: 16b9046
  GL_FACTOR_MIN_AMD=: 16b901c
  GL_FACTOR_MAX_AMD=: 16b901d
  GL_SUBSAMPLE_DISTANCE_AMD=: 16b883f
  GL_SYNC_X11_FENCE_EXT=: 16b90e1
  GL_SCALED_RESOLVE_FASTEST_EXT=: 16b90ba
  GL_SCALED_RESOLVE_NICEST_EXT=: 16b90bb
  GLEXT_64_TYPES_DEFINED
  GL_ARB_multitexture=: 1
  GL_ARB_transpose_matrix=: 1
  GL_ARB_multisample=: 1
  GL_ARB_texture_env_add=: 1
  GL_ARB_texture_cube_map=: 1
  GL_ARB_texture_compression=: 1
  GL_ARB_texture_border_clamp=: 1
  GL_ARB_point_parameters=: 1
  GL_ARB_vertex_blend=: 1
  GL_ARB_matrix_palette=: 1
  GL_ARB_texture_env_combine=: 1
  GL_ARB_texture_env_crossbar=: 1
  GL_ARB_texture_env_dot3=: 1
  GL_ARB_texture_mirrored_repeat=: 1
  GL_ARB_depth_texture=: 1
  GL_ARB_shadow=: 1
  GL_ARB_shadow_ambient=: 1
  GL_ARB_window_pos=: 1
  GL_ARB_vertex_program=: 1
  GL_ARB_fragment_program=: 1
  GL_ARB_vertex_buffer_object=: 1
  GL_ARB_occlusion_query=: 1
  GL_ARB_shader_objects=: 1
  GL_ARB_vertex_shader=: 1
  GL_ARB_fragment_shader=: 1
  GL_ARB_shading_language_100=: 1
  GL_ARB_texture_non_power_of_two=: 1
  GL_ARB_point_sprite=: 1
  GL_ARB_fragment_program_shadow=: 1
  GL_ARB_draw_buffers=: 1
  GL_ARB_texture_rectangle=: 1
  GL_ARB_color_buffer_float=: 1
  GL_ARB_half_float_pixel=: 1
  GL_ARB_texture_float=: 1
  GL_ARB_pixel_buffer_object=: 1
  GL_ARB_depth_buffer_float=: 1
  GL_ARB_draw_instanced=: 1
  GL_ARB_framebuffer_object=: 1
  GL_ARB_framebuffer_sRGB=: 1
  GL_ARB_geometry_shader4=: 1
  GL_ARB_half_float_vertex=: 1
  GL_ARB_instanced_arrays=: 1
  GL_ARB_map_buffer_range=: 1
  GL_ARB_texture_buffer_object=: 1
  GL_ARB_texture_compression_rgtc=: 1
  GL_ARB_texture_rg=: 1
  GL_ARB_vertex_array_object=: 1
  GL_ARB_uniform_buffer_object=: 1
  GL_ARB_compatibility=: 1
  GL_ARB_copy_buffer=: 1
  GL_ARB_shader_texture_lod=: 1
  GL_ARB_depth_clamp=: 1
  GL_ARB_draw_elements_base_vertex=: 1
  GL_ARB_fragment_coord_conventions=: 1
  GL_ARB_provoking_vertex=: 1
  GL_ARB_seamless_cube_map=: 1
  GL_ARB_sync=: 1
  GL_ARB_texture_multisample=: 1
  GL_ARB_vertex_array_bgra=: 1
  GL_ARB_draw_buffers_blend=: 1
  GL_ARB_sample_shading=: 1
  GL_ARB_texture_cube_map_array=: 1
  GL_ARB_texture_gather=: 1
  GL_ARB_texture_query_lod=: 1
  GL_ARB_shading_language_include=: 1
  GL_ARB_texture_compression_bptc=: 1
  GL_ARB_blend_func_extended=: 1
  GL_ARB_explicit_attrib_location=: 1
  GL_ARB_occlusion_query2=: 1
  GL_ARB_sampler_objects=: 1
  GL_ARB_shader_bit_encoding=: 1
  GL_ARB_texture_rgb10_a2ui=: 1
  GL_ARB_texture_swizzle=: 1
  GL_ARB_timer_query=: 1
  GL_ARB_vertex_type_2_10_10_10_rev=: 1
  GL_ARB_draw_indirect=: 1
  GL_ARB_gpu_shader5=: 1
  GL_ARB_gpu_shader_fp64=: 1
  GL_ARB_shader_subroutine=: 1
  GL_ARB_tessellation_shader=: 1
  GL_ARB_texture_buffer_object_rgb32=: 1
  GL_ARB_transform_feedback2=: 1
  GL_ARB_transform_feedback3=: 1
  GL_ARB_ES2_compatibility=: 1
  GL_ARB_get_program_binary=: 1
  GL_ARB_separate_shader_objects=: 1
  GL_ARB_vertex_attrib_64bit=: 1
  GL_ARB_viewport_array=: 1
  GL_ARB_cl_event=: 1
  GL_ARB_debug_output=: 1
  GL_ARB_robustness=: 1
  GL_ARB_shader_stencil_export=: 1
  GL_ARB_base_instance=: 1
  GL_ARB_shading_language_420pack=: 1
  GL_ARB_transform_feedback_instanced=: 1
  GL_ARB_compressed_texture_pixel_storage=: 1
  GL_ARB_conservative_depth=: 1
  GL_ARB_internalformat_query=: 1
  GL_ARB_map_buffer_alignment=: 1
  GL_ARB_shader_atomic_counters=: 1
  GL_ARB_shader_image_load_store=: 1
  GL_ARB_shading_language_packing=: 1
  GL_ARB_texture_storage=: 1
  GL_EXT_abgr=: 1
  GL_EXT_blend_color=: 1
  GL_EXT_polygon_offset=: 1
  GL_EXT_texture=: 1
  GL_EXT_texture3D=: 1
  GL_SGIS_texture_filter4=: 1
  GL_EXT_subtexture=: 1
  GL_EXT_copy_texture=: 1
  GL_EXT_histogram=: 1
  GL_EXT_convolution=: 1
  GL_SGI_color_matrix=: 1
  GL_SGI_color_table=: 1
  GL_SGIX_pixel_texture=: 1
  GL_SGIS_pixel_texture=: 1
  GL_SGIS_texture4D=: 1
  GL_SGI_texture_color_table=: 1
  GL_EXT_cmyka=: 1
  GL_EXT_texture_object=: 1
  GL_SGIS_detail_texture=: 1
  GL_SGIS_sharpen_texture=: 1
  GL_EXT_packed_pixels=: 1
  GL_SGIS_texture_lod=: 1
  GL_SGIS_multisample=: 1
  GL_EXT_rescale_normal=: 1
  GL_EXT_vertex_array=: 1
  GL_EXT_misc_attribute=: 1
  GL_SGIS_generate_mipmap=: 1
  GL_SGIX_clipmap=: 1
  GL_SGIX_shadow=: 1
  GL_SGIS_texture_edge_clamp=: 1
  GL_SGIS_texture_border_clamp=: 1
  GL_EXT_blend_minmax=: 1
  GL_EXT_blend_subtract=: 1
  GL_EXT_blend_logic_op=: 1
  GL_SGIX_interlace=: 1
  GL_SGIX_pixel_tiles=: 1
  GL_SGIX_texture_select=: 1
  GL_SGIX_sprite=: 1
  GL_SGIX_texture_multi_buffer=: 1
  GL_EXT_point_parameters=: 1
  GL_SGIS_point_parameters=: 1
  GL_SGIX_instruments=: 1
  GL_SGIX_texture_scale_bias=: 1
  GL_SGIX_framezoom=: 1
  GL_SGIX_tag_sample_buffer=: 1
  GL_SGIX_polynomial_ffd=: 1
  GL_SGIX_reference_plane=: 1
  GL_SGIX_flush_raster=: 1
  GL_SGIX_depth_texture=: 1
  GL_SGIS_fog_function=: 1
  GL_SGIX_fog_offset=: 1
  GL_HP_image_transform=: 1
  GL_HP_convolution_border_modes=: 1
  GL_SGIX_texture_add_env=: 1
  GL_EXT_color_subtable=: 1
  GL_PGI_vertex_hints=: 1
  GL_PGI_misc_hints=: 1
  GL_EXT_paletted_texture=: 1
  GL_EXT_clip_volume_hint=: 1
  GL_SGIX_list_priority=: 1
  GL_SGIX_ir_instrument1=: 1
  GL_SGIX_calligraphic_fragment=: 1
  GL_SGIX_texture_lod_bias=: 1
  GL_SGIX_shadow_ambient=: 1
  GL_EXT_index_texture=: 1
  GL_EXT_index_material=: 1
  GL_EXT_index_func=: 1
  GL_EXT_index_array_formats=: 1
  GL_EXT_compiled_vertex_array=: 1
  GL_EXT_cull_vertex=: 1
  GL_SGIX_ycrcb=: 1
  GL_SGIX_fragment_lighting=: 1
  GL_IBM_rasterpos_clip=: 1
  GL_HP_texture_lighting=: 1
  GL_EXT_draw_range_elements=: 1
  GL_WIN_phong_shading=: 1
  GL_WIN_specular_fog=: 1
  GL_EXT_light_texture=: 1
  GL_SGIX_blend_alpha_minmax=: 1
  GL_EXT_bgra=: 1
  GL_SGIX_async=: 1
  GL_SGIX_async_pixel=: 1
  GL_SGIX_async_histogram=: 1
  GL_INTEL_parallel_arrays=: 1
  GL_HP_occlusion_test=: 1
  GL_EXT_pixel_transform=: 1
  GL_EXT_pixel_transform_color_table=: 1
  GL_EXT_shared_texture_palette=: 1
  GL_EXT_separate_specular_color=: 1
  GL_EXT_secondary_color=: 1
  GL_EXT_texture_perturb_normal=: 1
  GL_EXT_multi_draw_arrays=: 1
  GL_EXT_fog_coord=: 1
  GL_REND_screen_coordinates=: 1
  GL_EXT_coordinate_frame=: 1
  GL_EXT_texture_env_combine=: 1
  GL_APPLE_specular_vector=: 1
  GL_APPLE_transform_hint=: 1
  GL_SGIX_fog_scale=: 1
  GL_SUNX_constant_data=: 1
  GL_SUN_global_alpha=: 1
  GL_SUN_triangle_list=: 1
  GL_SUN_vertex=: 1
  GL_EXT_blend_func_separate=: 1
  GL_INGR_blend_func_separate=: 1
  GL_INGR_color_clamp=: 1
  GL_INGR_interlace_read=: 1
  GL_EXT_stencil_wrap=: 1
  GL_EXT_422_pixels=: 1
  GL_NV_texgen_reflection=: 1
  GL_SUN_convolution_border_modes=: 1
  GL_EXT_texture_env_add=: 1
  GL_EXT_texture_lod_bias=: 1
  GL_EXT_texture_filter_anisotropic=: 1
  GL_EXT_vertex_weighting=: 1
  GL_NV_light_max_exponent=: 1
  GL_NV_vertex_array_range=: 1
  GL_NV_register_combiners=: 1
  GL_NV_fog_distance=: 1
  GL_NV_texgen_emboss=: 1
  GL_NV_blend_square=: 1
  GL_NV_texture_env_combine4=: 1
  GL_MESA_resize_buffers=: 1
  GL_MESA_window_pos=: 1
  GL_IBM_cull_vertex=: 1
  GL_IBM_multimode_draw_arrays=: 1
  GL_IBM_vertex_array_lists=: 1
  GL_SGIX_subsample=: 1
  GL_SGIX_ycrcba=: 1
  GL_SGIX_ycrcb_subsample=: 1
  GL_SGIX_depth_pass_instrument=: 1
  GL_3DFX_texture_compression_FXT1=: 1
  GL_3DFX_multisample=: 1
  GL_3DFX_tbuffer=: 1
  GL_EXT_multisample=: 1
  GL_SGIX_vertex_preclip=: 1
  GL_SGIX_convolution_accuracy=: 1
  GL_SGIX_resample=: 1
  GL_SGIS_point_line_texgen=: 1
  GL_SGIS_texture_color_mask=: 1
  GL_SGIX_igloo_interface=: 1
  GL_EXT_texture_env_dot3=: 1
  GL_ATI_texture_mirror_once=: 1
  GL_NV_fence=: 1
  GL_NV_evaluators=: 1
  GL_NV_packed_depth_stencil=: 1
  GL_NV_register_combiners2=: 1
  GL_NV_texture_compression_vtc=: 1
  GL_NV_texture_rectangle=: 1
  GL_NV_texture_shader=: 1
  GL_NV_texture_shader2=: 1
  GL_NV_vertex_array_range2=: 1
  GL_NV_vertex_program=: 1
  GL_SGIX_texture_coordinate_clamp=: 1
  GL_SGIX_scalebias_hint=: 1
  GL_OML_interlace=: 1
  GL_OML_subsample=: 1
  GL_OML_resample=: 1
  GL_NV_copy_depth_to_color=: 1
  GL_ATI_envmap_bumpmap=: 1
  GL_ATI_fragment_shader=: 1
  GL_ATI_pn_triangles=: 1
  GL_ATI_vertex_array_object=: 1
  GL_EXT_vertex_shader=: 1
  GL_ATI_vertex_streams=: 1
  GL_ATI_element_array=: 1
  GL_SUN_mesh_array=: 1
  GL_SUN_slice_accum=: 1
  GL_NV_multisample_filter_hint=: 1
  GL_NV_depth_clamp=: 1
  GL_NV_occlusion_query=: 1
  GL_NV_point_sprite=: 1
  GL_NV_texture_shader3=: 1
  GL_NV_vertex_program1_1=: 1
  GL_EXT_shadow_funcs=: 1
  GL_EXT_stencil_two_side=: 1
  GL_ATI_text_fragment_shader=: 1
  GL_APPLE_client_storage=: 1
  GL_APPLE_element_array=: 1
  GL_APPLE_fence=: 1
  GL_APPLE_vertex_array_object=: 1
  GL_APPLE_vertex_array_range=: 1
  GL_APPLE_ycbcr_422=: 1
  GL_S3_s3tc=: 1
  GL_ATI_draw_buffers=: 1
  GL_ATI_pixel_format_float=: 1
  GL_ATI_texture_env_combine3=: 1
  GL_ATI_texture_float=: 1
  GL_NV_float_buffer=: 1
  GL_NV_fragment_program=: 1
  GL_NV_half_float=: 1
  GL_NV_pixel_data_range=: 1
  GL_NV_primitive_restart=: 1
  GL_NV_texture_expand_normal=: 1
  GL_NV_vertex_program2=: 1
  GL_ATI_map_object_buffer=: 1
  GL_ATI_separate_stencil=: 1
  GL_ATI_vertex_attrib_array_object=: 1
  GL_OES_read_format=: 1
  GL_EXT_depth_bounds_test=: 1
  GL_EXT_texture_mirror_clamp=: 1
  GL_EXT_blend_equation_separate=: 1
  GL_MESA_pack_invert=: 1
  GL_MESA_ycbcr_texture=: 1
  GL_EXT_pixel_buffer_object=: 1
  GL_NV_fragment_program_option=: 1
  GL_NV_fragment_program2=: 1
  GL_NV_vertex_program2_option=: 1
  GL_NV_vertex_program3=: 1
  GL_EXT_framebuffer_object=: 1
  GL_GREMEDY_string_marker=: 1
  GL_EXT_packed_depth_stencil=: 1
  GL_EXT_stencil_clear_tag=: 1
  GL_EXT_texture_sRGB=: 1
  GL_EXT_framebuffer_blit=: 1
  GL_EXT_framebuffer_multisample=: 1
  GL_MESAX_texture_stack=: 1
  GL_EXT_timer_query=: 1
  GL_EXT_gpu_program_parameters=: 1
  GL_APPLE_flush_buffer_range=: 1
  GL_NV_gpu_program4=: 1
  GL_NV_geometry_program4=: 1
  GL_EXT_geometry_shader4=: 1
  GL_NV_vertex_program4=: 1
  GL_EXT_gpu_shader4=: 1
  GL_EXT_draw_instanced=: 1
  GL_EXT_packed_float=: 1
  GL_EXT_texture_array=: 1
  GL_EXT_texture_buffer_object=: 1
  GL_EXT_texture_compression_latc=: 1
  GL_EXT_texture_compression_rgtc=: 1
  GL_EXT_texture_shared_exponent=: 1
  GL_NV_depth_buffer_float=: 1
  GL_NV_fragment_program4=: 1
  GL_NV_framebuffer_multisample_coverage=: 1
  GL_EXT_framebuffer_sRGB=: 1
  GL_NV_geometry_shader4=: 1
  GL_NV_parameter_buffer_object=: 1
  GL_EXT_draw_buffers2=: 1
  GL_NV_transform_feedback=: 1
  GL_EXT_bindable_uniform=: 1
  GL_EXT_texture_integer=: 1
  GL_GREMEDY_frame_terminator=: 1
  GL_NV_conditional_render=: 1
  GL_NV_present_video=: 1
  GL_EXT_transform_feedback=: 1
  GL_EXT_direct_state_access=: 1
  GL_EXT_vertex_array_bgra=: 1
  GL_EXT_texture_swizzle=: 1
  GL_NV_explicit_multisample=: 1
  GL_NV_transform_feedback2=: 1
  GL_ATI_meminfo=: 1
  GL_AMD_performance_monitor=: 1
  GL_AMD_texture_texture4=: 1
  GL_AMD_vertex_shader_tesselator=: 1
  GL_EXT_provoking_vertex=: 1
  GL_EXT_texture_snorm=: 1
  GL_AMD_draw_buffers_blend=: 1
  GL_APPLE_texture_range=: 1
  GL_APPLE_float_pixels=: 1
  GL_APPLE_vertex_program_evaluators=: 1
  GL_APPLE_aux_depth_stencil=: 1
  GL_APPLE_object_purgeable=: 1
  GL_APPLE_row_bytes=: 1
  GL_APPLE_rgb_422=: 1
  GL_NV_video_capture=: 1
  GL_NV_copy_image=: 1
  GL_EXT_separate_shader_objects=: 1
  GL_NV_parameter_buffer_object2=: 1
  GL_NV_shader_buffer_load=: 1
  GL_NV_vertex_buffer_unified_memory=: 1
  GL_NV_texture_barrier=: 1
  GL_AMD_shader_stencil_export=: 1
  GL_AMD_seamless_cubemap_per_texture=: 1
  GL_AMD_conservative_depth=: 1
  GL_EXT_shader_image_load_store=: 1
  GL_EXT_vertex_attrib_64bit=: 1
  GL_NV_gpu_program5=: 1
  GL_NV_gpu_shader5=: 1
  GL_NV_shader_buffer_store=: 1
  GL_NV_tessellation_program5=: 1
  GL_NV_vertex_attrib_integer_64bit=: 1
  GL_NV_multisample_coverage=: 1
  GL_AMD_name_gen_delete=: 1
  GL_AMD_debug_output=: 1
  GL_NV_vdpau_interop=: 1
  GL_AMD_transform_feedback3_lines_triangles=: 1
  GL_AMD_depth_clamp_separate=: 1
  GL_EXT_texture_sRGB_decode=: 1
  GL_NV_texture_multisample=: 1
  GL_AMD_blend_minmax_factor=: 1
  GL_AMD_sample_positions=: 1
  GL_EXT_x11_sync_object=: 1
  GL_AMD_multi_draw_indirect=: 1
  GL_EXT_framebuffer_multisample_blit_scaled=: 1
end.
''
)

gl_I=: =@i.@(4"_)

gl_GetFloatv=: 3 : 0
1&fc ,y
)

gl_mp=: +/ . *
gl_Rotate=: (gl_I'')&$: : (4 : 0)
mat=. x
'a x y z'=. y
s=. 1 o. a * 1p1 % 180
c=. 2 o. a * 1p1 % 180

xx=. x * x
xy=. x * y
xz=. x * z
yy=. y * y
yz=. y * z
zz=. z * z
m=. (xx * (1 - c)) + c
m=. m, (xy * (1 - c)) - z * s
m=. m, (xz * (1 - c)) + y * s
m=. m, 0

m=. m, (xy * (1 - c)) + z * s
m=. m, (yy * (1 - c)) + c
m=. m, (yz * (1 - c)) - x * s
m=. m, 0

m=. m, (xz * (1 - c)) - y * s
m=. m, (yz * (1 - c)) + x * s
m=. m, (zz * (1 - c)) + c
m=. m, 0

m=. m, 0 0 0 1

mat (+/ . *) _4]\m
)

gl_Translate=: (gl_I'')&$: : (4 : 0)
mat=. x
'x y z'=. y

m=. 1 0 0 0
m=. m, 0 1 0 0
m=. m, 0 0 1 0
m=. m, x,y,z,1

mat (+/ . *) _4]\m
)

gl_Scale=: (gl_I'')&$: : (4 : 0)
mat=. x
'x y z'=. y

m=. x,0 0 0
m=. m,  0,y,0 0
m=. m,  0 0,z,0
m=. m,  0 0 0 1

mat (+/ . *) _4]\m
)
gl_Perspective=: (gl_I'')&$: : (4 : 0)
mat=. x
'fovy aspect znear zfar'=. y
if. (0=znear-zfar) +. (0=180|fovy) +. (0=aspect) do. mat return. end.

xymax=. znear * 3&o. fovy * 1p1%360
ymin=. -xymax
xmin=. -xymax

width=. xymax - xmin
height=. xymax - ymin

depth=. zfar - znear
q=. -(zfar + znear) % depth
qn=. _2 * (zfar * znear) % depth

w=. 2 * znear % width
w=. w % aspect
h=. 2 * znear % height

m=. w, 0 0 0
m=. m, 0, h, 0 0
m=. m, 0 0, q, _1
m=. m, 0 0, qn, 0

mat (+/ . *) _4[\m
)
gl_Perspective0=: (gl_I'')&$: : (4 : 0)
mat=. x
'fovy aspect znear zfar'=. y
size=. znear * 3&o. fovy * 1p1%360
gl_Frustum (-size*aspect), (size*aspect), (-size), (size), znear, zfar
)

gl_Frustum=: (gl_I'')&$: : (4 : 0)
mat=. x
'left right bottom top near far'=. y
if. (0=right-left) +. (0=top-bottom) +. (0=far-near) do. mat return. end.

m=. (2 * near % (right - left)), 0 0 0

m=. m, 0 ,(2 * near % (top - bottom)), 0 0

m=. m, (right + left) % (right - left)
m=. m, (top + bottom) % (top - bottom)
m=. m, -(far + near) % (far - near)
m=. m, _1

m=. m, 0 0, (_2 * far * near % (far - near)), 0

mat (+/ . *) _4[\m
)

gl_Ortho=: 3 : 0
mat=. x
'left right bottom top near far'=. y
if. (0=right-left) +. (0=top-bottom) +. (0=far-near) do. mat return. end.

r_l=. right - left
t_b=. top - bottom
f_n=. far - near
tx=. - (right + left) % (right - left)
ty=. - (top + bottom) % (top - bottom)
tz=. - (far + near) % (far - near)

m=. (2 % r_l), 0 0, tx

m=. m, 0, (2 % t_b), 0, ty

m=. m, 0 0, (2 % f_n), tz

m=. m, 0 0 0 1

mat (+/ . *) _4[\m
)
gl_makeshader=: 4 : 0
shader=. glCreateShader x
if. '#version'-.@-:8{.y do.
  hdr=. ''
  if. GL_ES_VERSION_2_0 do.
    if. ADD_GLSL_ES_VERSION do. hdr=. LF,~ '#version ',":ADD_GLSL_ES_VERSION end.
  else.
    if. ADD_GLSL_VERSION do. hdr=. LF,~ '#version ',":ADD_GLSL_VERSION end.
  end.
  if. GL_DX_ANGLE+.GL_ES_VERSION_2_0>EMU_GLES do.
    if. x = GL_FRAGMENT_SHADER do.
      hdr=. hdr, '#ifdef GL_FRAGMENT_PRECISION_HIGH', LF, 'precision highp float;', LF, '#else', LF, 'precision mediump float;', LF, '#endif', LF
    end.
  else.
    hdr=. hdr, '#define lowp', LF, '#define mediump', LF, '#define highp', LF
  end.
  y=. hdr,y
end.
glShaderSource shader; 1; (,symdat <'y'); <<0
glCompileShader shader
glGetShaderiv shader; GL_COMPILE_STATUS; st=. ,_1
if. ({.st) = GL_FALSE do.
  err=. gl_infolog shader
  (err,LF,y);shader
else.
  '';shader
end.
)

gl_makeprogram=: 3 : 0
'vsrc fsrc'=. y
if. 0= (*#vsrc)+.(*#fsrc) do. 'no shader source';0 return. end.
try.
  program=. glCreateProgram''
catch.
  0;~ 'glCreateProgram error',LF,(5!:6<'glCreateProgram'),LF,'cder : ',":cder'' return.
end.
if. #vsrc do.
  'err shader'=. GL_VERTEX_SHADER gl_makeshader vsrc
  if. #err do. err;0 [ glDeleteProgram program return. end.
  glAttachShader program ; shader
end.
if. #fsrc do.
  'err shader'=. GL_FRAGMENT_SHADER gl_makeshader fsrc
  if. #err do. err;0 [ glDeleteProgram program return. end.
  glAttachShader program ; shader
end.
glLinkProgram program
glGetProgramiv program; GL_LINK_STATUS; st=. ,_1
if. ({.st) = GL_FALSE do.
  glDeleteProgram program
  err=. gl_infolog program
  err;program
else.
  '';program
end.
)
gl_infolog=: 3 : 0
ln=. ,_1
if. glIsShader y do.
  glGetShaderiv y; GL_INFO_LOG_LENGTH; ln
elseif. glIsProgram y do.
  glGetProgramiv y; GL_INFO_LOG_LENGTH; ln
elseif. do.
  'Not a shader or a program' return.
end.

strInfoLog=. ({.ln)#' '
if. glIsShader y do.
  glGetShaderInfoLog y; ({.ln); (<0); strInfoLog
elseif. glIsProgram y do.
  glGetProgramInfoLog y; ({.ln); (<0); strInfoLog
end.
err=. strInfoLog
)
glu_LookAt=: 3 : 0
'eye center up'=. _3]\,>y
F=. center - eye
f=. (% +/&.:*:)F
UPP=. (% +/&.:*:)up
s=. f ((1&|.@:[ * _1&|.@:]) - _1&|.@:[ * 1&|.@:]) UPP
u=. s ((1&|.@:[ * _1&|.@:]) - _1&|.@:[ * 1&|.@:]) f
M=. _4]\ s, 0, u, 0, (-f), 0 0 0 0 1
M gl_Translate -eye
)
