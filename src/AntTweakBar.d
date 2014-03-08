module AntTweakBar;

import core.stdc.config;

extern (System):

alias CTwBar TwBar;
alias ETwType TwType;
alias void function(const(void)*, void*) TwSetVarCallback;
alias void function(void*, void*) TwGetVarCallback;
alias void function(void*) TwButtonCallback;
alias CTwEnumVal TwEnumVal;
alias CTwStructMember TwStructMember;
alias void function(char*, c_ulong, const(void)*, void*) TwSummaryCallback;
alias void function(char**, const(char)*) TwCopyCDStringToClient;
alias ETwParamValueType TwParamValueType;
alias ETwGraphAPI TwGraphAPI;
alias ETwKeyModifier TwKeyModifier;
alias EKeySpecial TwKeySpecial;
alias ETwMouseAction TwMouseAction;
alias ETwMouseButtonID TwMouseButtonID;
alias void function(const(char)*) TwErrorHandler;
alias void function(int, int, int, int) GLUTmousebuttonfun;
alias void function(int, int) GLUTmousemotionfun;
alias void function(ubyte, int, int) GLUTkeyboardfun;
alias void function(int, int, int) GLUTspecialfun;

alias ETwType = int;
enum : ETwType
{
    TW_TYPE_UNDEF    = 0,
    TW_TYPE_BOOL8    = 2,
    TW_TYPE_BOOL16   = 3,
    TW_TYPE_BOOL32   = 4,
    TW_TYPE_CHAR     = 5,
    TW_TYPE_INT8     = 6,
    TW_TYPE_UINT8    = 7,
    TW_TYPE_INT16    = 8,
    TW_TYPE_UINT16   = 9,
    TW_TYPE_INT32    = 10,
    TW_TYPE_UINT32   = 11,
    TW_TYPE_FLOAT    = 12,
    TW_TYPE_DOUBLE   = 13,
    TW_TYPE_COLOR32  = 14,
    TW_TYPE_COLOR3F  = 15,
    TW_TYPE_COLOR4F  = 16,
    TW_TYPE_CDSTRING = 17,
    TW_TYPE_QUAT4F   = 19,
    TW_TYPE_QUAT4D   = 20,
    TW_TYPE_DIR3F    = 21,
    TW_TYPE_DIR3D    = 22
}

alias ETwParamValueType = int;
enum : ETwParamValueType
{
    TW_PARAM_INT32   = 0,
    TW_PARAM_FLOAT   = 1,
    TW_PARAM_DOUBLE  = 2,
    TW_PARAM_CSTRING = 3
}


alias ETwGraphAPI = int;
enum : ETwGraphAPI
{
    TW_OPENGL      = 1,
    TW_DIRECT3D9   = 2,
    TW_DIRECT3D10  = 3,
    TW_DIRECT3D11  = 4,
    TW_OPENGL_CORE = 5  // NOTE: Use this one when using a CORE OpenGL profile, TW_OPENGL will not work!
}

alias ETwKeyModifier = int;
enum : ETwKeyModifier
{
    TW_KMOD_NONE  = 0,
    TW_KMOD_SHIFT = 3,
    TW_KMOD_CTRL  = 192,
    TW_KMOD_ALT   = 256,
    TW_KMOD_META  = 3072
}

alias EKeySpecial = int;
enum : EKeySpecial
{
    TW_KEY_BACKSPACE = 8,
    TW_KEY_TAB       = 9,
    TW_KEY_CLEAR     = 12,
    TW_KEY_RETURN    = 13,
    TW_KEY_PAUSE     = 19,
    TW_KEY_ESCAPE    = 27,
    TW_KEY_SPACE     = 32,
    TW_KEY_DELETE    = 127,
    TW_KEY_UP        = 273,
    TW_KEY_DOWN      = 274,
    TW_KEY_RIGHT     = 275,
    TW_KEY_LEFT      = 276,
    TW_KEY_INSERT    = 277,
    TW_KEY_HOME      = 278,
    TW_KEY_END       = 279,
    TW_KEY_PAGE_UP   = 280,
    TW_KEY_PAGE_DOWN = 281,
    TW_KEY_F1        = 282,
    TW_KEY_F2        = 283,
    TW_KEY_F3        = 284,
    TW_KEY_F4        = 285,
    TW_KEY_F5        = 286,
    TW_KEY_F6        = 287,
    TW_KEY_F7        = 288,
    TW_KEY_F8        = 289,
    TW_KEY_F9        = 290,
    TW_KEY_F10       = 291,
    TW_KEY_F11       = 292,
    TW_KEY_F12       = 293,
    TW_KEY_F13       = 294,
    TW_KEY_F14       = 295,
    TW_KEY_F15       = 296,
    TW_KEY_LAST      = 297
}

alias ETwMouseAction = int;
enum : ETwMouseAction
{
    TW_MOUSE_RELEASED = 0,
    TW_MOUSE_PRESSED  = 1
}

alias ETwMouseButtonID = int;
enum : ETwMouseButtonID
{
    TW_MOUSE_LEFT   = 1,
    TW_MOUSE_MIDDLE = 2,
    TW_MOUSE_RIGHT  = 3
}


struct CTwEnumVal
{
    int Value;
    const(char)*Label;
}


struct CTwStructMember
{
    const(char)*Name;
    TwType Type;
    size_t Offset;
    const(char)*DefString;
}


struct CTwBar;

TwBar* TwNewBar(const(char)* barName);
int TwDeleteBar(TwBar* bar);
int TwDeleteAllBars();
int TwSetTopBar(const(TwBar)* bar);
TwBar* TwGetTopBar();
int TwSetBottomBar(const(TwBar)* bar);
TwBar* TwGetBottomBar();
const(char)* TwGetBarName(const(TwBar)* bar);
int TwGetBarCount();
TwBar* TwGetBarByIndex(int barIndex);
TwBar* TwGetBarByName(const(char)* barName);
int TwRefreshBar(TwBar* bar);
int TwAddVarRW(TwBar* bar, const(char)* name, TwType type, void* var, const(char)* def);
int TwAddVarRO(TwBar* bar, const(char)* name, TwType type, const(void)* var, const(char)* def);
int TwAddVarCB(TwBar* bar, const(char)* name, TwType type, TwSetVarCallback setCallback, TwGetVarCallback getCallback, void* clientData, const(char)* def);
int TwAddButton(TwBar* bar, const(char)* name, TwButtonCallback callback, void* clientData, const(char)* def);
int TwAddSeparator(TwBar* bar, const(char)* name, const(char)* def);
int TwRemoveVar(TwBar* bar, const(char)* name);
int TwRemoveAllVars(TwBar* bar);
int TwDefine(const(char)* def);
TwType TwDefineEnum(const(char)* name, const(TwEnumVal)* enumValues, uint nbValues);
TwType TwDefineEnumFromString(const(char)* name, const(char)* enumString);
TwType TwDefineStruct(const(char)* name, const(TwStructMember)* structMembers, uint nbMembers, size_t structSize, TwSummaryCallback summaryCallback, void* summaryClientData);
void TwCopyCDStringToClientFunc(TwCopyCDStringToClient copyCDStringFunc);
void TwCopyCDStringToLibrary(char** destinationLibraryStringPtr, const(char)* sourceClientString);
int TwGetParam(TwBar* bar, const(char)* varName, const(char)* paramName, TwParamValueType paramValueType, uint outValueMaxCount, void* outValues);
int TwSetParam(TwBar* bar, const(char)* varName, const(char)* paramName, TwParamValueType paramValueType, uint inValueCount, const(void)* inValues);
int TwInit(TwGraphAPI graphAPI, void* device);
int TwTerminate();
int TwDraw();
int TwWindowSize(int width, int height);
int TwSetCurrentWindow(int windowID);
int TwGetCurrentWindow();
int TwWindowExists(int windowID);
int TwKeyPressed(int key, int modifiers);
int TwKeyTest(int key, int modifiers);
int TwMouseButton(TwMouseAction action, TwMouseButtonID button);
int TwMouseMotion(int mouseX, int mouseY);
int TwMouseWheel(int pos);
const(char)* TwGetLastError();
void TwHandleErrors(TwErrorHandler errorHandler);
int TwEventWin(void* wnd, uint msg, uint wParam, int lParam);
int TwEventSDL(const(void)* sdlEvent, ubyte sdlMajorVersion, ubyte sdlMinorVersion);
int TwEventMouseButtonGLFW(int glfwButton, int glfwAction);
int TwEventKeyGLFW(int glfwKey, int glfwAction);
int TwEventCharGLFW(int glfwChar, int glfwAction);

alias TwEventMousePosGLFW   = TwMouseMotion;
alias TwEventMouseWheelGLFW = TwMouseWheel;

extern(C) :

int TwEventMouseButtonGLUT(int glutButton, int glutState, int mouseX, int mouseY);
int TwEventMouseMotionGLUT(int mouseX, int mouseY);
int TwEventKeyboardGLUT(ubyte glutKey, int mouseX, int mouseY);
int TwEventSpecialGLUT(int glutKey, int mouseX, int mouseY);
int TwGLUTModifiersFunc(int function() glutGetModifiersFunc);
int TwEventSFML(const(void)* sfmlEvent, ubyte sfmlMajorVersion, ubyte sfmlMinorVersion);
