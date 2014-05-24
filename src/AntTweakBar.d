module AntTweakBar;

import core.stdc.config;

extern (System):

/** The type of the callback function that will be called by AntTweakBar to change a variable’s value. */
alias void function(const(void)*, void*) TwSetVarCallback;

/** The type of the callback function that will be called by AntTweakBar to get a variable’s value. */
alias void function(void*, void*) TwGetVarCallback;

/** The type of the callback function that will be called by AntTweakBar when a button is clicked. */
alias void function(void*) TwButtonCallback;

/** The type of the callback function that will be called to display a summary of the structure content. */
alias void function(char*, c_ulong, const(void)*, void*) TwSummaryCallback;

/** The type of the callback function that will be called to copy a C-dynamic string to the client application.. */
alias void function(char**, const(char)*) TwCopyCDStringToClient;

/** The type of the callback function that will be called by AntTweakBar when an error occurs.*/
alias void function(const(char)*) TwErrorHandler;

///
alias TwType = int;

/**
    Constants used to declare the type of variables added to a tweak bar.
    Used by functions TwAddVarRW, TwAddVarRO and TwAddVarCB.
*/
enum : TwType
{
    TW_TYPE_UNDEF    = 0,  ///
    TW_TYPE_BOOL8    = 2,  ///
    TW_TYPE_BOOL16   = 3,  ///
    TW_TYPE_BOOL32   = 4,  ///
    TW_TYPE_CHAR     = 5,  ///
    TW_TYPE_INT8     = 6,  ///
    TW_TYPE_UINT8    = 7,  ///
    TW_TYPE_INT16    = 8,  ///
    TW_TYPE_UINT16   = 9,  ///
    TW_TYPE_INT32    = 10, ///
    TW_TYPE_UINT32   = 11, ///
    TW_TYPE_FLOAT    = 12, ///
    TW_TYPE_DOUBLE   = 13, ///
    TW_TYPE_COLOR32  = 14, ///
    TW_TYPE_COLOR3F  = 15, ///
    TW_TYPE_COLOR4F  = 16, ///
    TW_TYPE_CDSTRING = 17, ///
    TW_TYPE_QUAT4F   = 19, ///
    TW_TYPE_QUAT4D   = 20, ///
    TW_TYPE_DIR3F    = 21, ///
    TW_TYPE_DIR3D    = 22  ///
}

///
alias TwParamValueType = int;

/**
    Constants used by TwSetParam and TwGetParam to specify the
    type of parameter(s) value(s).
*/
enum : TwParamValueType
{
    TW_PARAM_INT32   = 0, ///
    TW_PARAM_FLOAT   = 1, ///
    TW_PARAM_DOUBLE  = 2, ///
    TW_PARAM_CSTRING = 3  ///
}

///
alias TwGraphAPI = int;

/** These constants are used by TwInit to specify which graphic API is used. */
enum : TwGraphAPI
{
    TW_OPENGL      = 1, /// Note: Using this with the Core OpenGL profile will not work, use TW_OPENGL_CORE instead.
    TW_DIRECT3D9   = 2, ///
    TW_DIRECT3D10  = 3, ///
    TW_DIRECT3D11  = 4, ///
    TW_OPENGL_CORE = 5  /// For use with a Core OpenGL profile only.
}

///
alias TwKeyModifier = int;

/** Constants used by TwKeyPressed to denote modifier key codes. */
enum : TwKeyModifier
{
    TW_KMOD_NONE  = 0,   ///
    TW_KMOD_SHIFT = 3,   ///
    TW_KMOD_CTRL  = 192, ///
    TW_KMOD_ALT   = 256, ///
    TW_KMOD_META  = 3072 ///
}

///
alias TwKeySpecial = int;

/** Constants used by TwKeyPressed to denote special key codes.  */
enum : TwKeySpecial
{
    TW_KEY_BACKSPACE = 8,   ///
    TW_KEY_TAB       = 9,   ///
    TW_KEY_CLEAR     = 12,  ///
    TW_KEY_RETURN    = 13,  ///
    TW_KEY_PAUSE     = 19,  ///
    TW_KEY_ESCAPE    = 27,  ///
    TW_KEY_SPACE     = 32,  ///
    TW_KEY_DELETE    = 127, ///
    TW_KEY_UP        = 273, ///
    TW_KEY_DOWN      = 274, ///
    TW_KEY_RIGHT     = 275, ///
    TW_KEY_LEFT      = 276, ///
    TW_KEY_INSERT    = 277, ///
    TW_KEY_HOME      = 278, ///
    TW_KEY_END       = 279, ///
    TW_KEY_PAGE_UP   = 280, ///
    TW_KEY_PAGE_DOWN = 281, ///
    TW_KEY_F1        = 282, ///
    TW_KEY_F2        = 283, ///
    TW_KEY_F3        = 284, ///
    TW_KEY_F4        = 285, ///
    TW_KEY_F5        = 286, ///
    TW_KEY_F6        = 287, ///
    TW_KEY_F7        = 288, ///
    TW_KEY_F8        = 289, ///
    TW_KEY_F9        = 290, ///
    TW_KEY_F10       = 291, ///
    TW_KEY_F11       = 292, ///
    TW_KEY_F12       = 293, ///
    TW_KEY_F13       = 294, ///
    TW_KEY_F14       = 295, ///
    TW_KEY_F15       = 296, ///
    TW_KEY_LAST      = 297  ///
}

///
alias TwMouseAction = int;

/** Constants used by TwMouseButton to denote a mouse button action. */
enum : TwMouseAction
{
    TW_MOUSE_RELEASED = 0, ///
    TW_MOUSE_PRESSED  = 1  ///
}

///
alias TwMouseButtonID = int;

/** Constants used by TwMouseButton to identify a mouse button. */
enum : TwMouseButtonID
{
    TW_MOUSE_LEFT   = 1, ///
    TW_MOUSE_MIDDLE = 2, ///
    TW_MOUSE_RIGHT  = 3  ///
}

/**
    This structure stores an enum value and its associated label
    (a pointer to a zero-terminated string). It is used by
    TwDefineEnum to define values of variables of type enum.
*/
struct TwEnumVal
{
    ///
    int Value;

    ///
    const(char)*Label;
}

/**
    TwStructMember stores the description of a structure member.
    It is used by TwDefineStruct to create a type that represents
    a structure.
*/
struct TwStructMember
{
    /// name of the member
    const(char)* Name;

    /// type of the member
    TwType Type;

    /// offset of the member from the beginning of its parent
    /// structure (in bytes). It can be obtained by using .offsetof.
    size_t Offset;

    /// a definition string that will be used to modify the
    /// behavior of this member. The same syntax is used as
    /// the definition string of TwAddVar* functions.
    const(char)* DefString;
}

/** An opaque type representing a Tweak Bar. */
struct TwBar;

/**
This function initializes the AntTweakBar library. It must be called once at the beginning of the program, just after graphic mode is initialized.

Note:
When program finishes, TwTerminate must be called, just before graphic mode is terminated.
    See how to integrate AntTweakBar into your application.

Params:
  graphAPI = This parameter specifies which graphic API is used: OpenGL, OpenGL core profile (3.2 and higher), Direct3D 9, Direct3D 10 or Direct3D 11.

It is one of the TwGraphAPI enum element. If graphAPI is Direct3D, the D3D device pointer must be supplied.

  device = Pointer to the Direct3D device, or NULL for OpenGL.

If graphAPI is OpenGL, this parameter must be NULL, otherwise it is the IDirect3DDevice9, ID3D10Device or ID3D11Device pointer returned by the appropriate D3D CreateDevice function when D3D has been initialized.

Returns:
0 if an error has occurred (call TwGetLastError to retrieve the error).
1 if succeeded.
*/
int TwInit(TwGraphAPI graphAPI, void* device);

/**
Uninitialize the AntTweakBar API. Must be called at the end of the program, before terminating the graphics API.

Returns:
0 if failed (AntTweakBar has not been initialized properly before).
1 if succeeded.
*/
int TwTerminate();

/**
Returns:
Returns the last error that has occured during a previous AntTweakBar function call.
*/
const(char)* TwGetLastError();

/**
By default, if an error occurs AntTweakBar prints a message to the standard error console output stream (stderr, cerr), and optionally to the output debug panel if your app is run from Visual Studio.

TwHanldeErrors allows you to change this behavior by defining your own error handler. This handle function will be called each time an error occurs (e.g. while parsing an improper def parameter).

Params:
  errorHandler = The function that will be called by AntTweakBar when an error occurs.
*/
void TwHandleErrors(TwErrorHandler errorHandler);

/**
Creates a new tweak bar.

Note:
The AntTweakBar library must have been initialized (by calling TwInit) before creating a tweak bar.

Params:
  name = The _name of the new tweak bar.

Returns:
An opaque tweak bar identifier.
*/
TwBar* TwNewBar(const(char)* name);

/**
This function deletes a tweak bar previously created by TwNewBar.

Params:
  bar = An opaque handle to a previously created Tweak Bar.

Returns:
0 if deletion failed. Call TwGetLastError to retrieve the error.
1 if succeeded.
*/
int TwDeleteBar(TwBar* bar);

/**
Delete all bars previously created by TwNewBar.

Returns:
0 if failed. Call TwGetLastError to retrieve the error.
1 if succeeded.
*/
int TwDeleteAllBars();

/**
Returns the current foreground bar (the bar displayed on top of the others).

Returns:
The pointer to the top bar, or null if no bar is displayed.
*/
TwBar* TwGetTopBar();

/**
Set the specified tweak bar as the foreground bar. It will be displayed on top of the other bars.

Params:
  bar = The tweak bar which will become the foreground bar.

Returns:
0 if failed (bar not found; call TwGetLastError to retrieve the error).
1 if succeeded
*/
int TwSetTopBar(const(TwBar)* bar);

/**
Returns the current background bar (the bar displayed behind all others).

Returns:
The pointer to the bottom bar, or null if no bar is displayed.
*/
TwBar* TwGetBottomBar();

/**
Set the specified bar as the background bar. It will be displayed behind all of the other bars.

Params:
  bar = The tweak bar which will become the background bar.

Returns:
0 if failed (bar not found; call TwGetLastError to retrieve the error).
1 if succeeded
*/
int TwSetBottomBar(const(TwBar)* bar);

/**
Returns the name of a given tweak bar.

Params:
  bar = The tweak bar to get the name of.

Returns:
null if an error occurs (use TwGetLastError to retrieve the error).
Otherwise, a pointer to a zero-terminated C-string containing the name of the bar.
*/
const(char)* TwGetBarName(const(TwBar)* bar);

/**
Returns:
The number of created bars.
*/
int TwGetBarCount();

/**
Returns the bar of index barIndex.

Params:
  barIndex = Index of the requested bar. barIndex must be between 0 and TwGetBarCount().

Returns:
Bar identifier (a pointer to an internal TwBar structure).
or null if the index is out of range.
*/
TwBar* TwGetBarByIndex(int barIndex);

/**
Returns the bar named barName.

Params:
  barName = Name of the requested bar (a zero-terminated c string).

Returns:
Bar identifier (a pointer to an internal TwBar structure).
or null if the bar is not found.
*/
TwBar* TwGetBarByName(const(char)* barName);

/**
Forces bar content to be updated. By default bar content is periodically refreshed when TwDraw is called (the update frequency is defined by the bar parameter refresh). This function may be called to force a bar to be immediately refreshed at next TwDraw call.

Params:
  bar = Bar identifier.

Returns:
1 if the succeeded.
0 if an error occurred (call TwGetLastError to retrieve the error).
*/
int TwRefreshBar(TwBar* bar);

/**
This function adds a new variable to a tweak bar by specifying the variable’s pointer. The variable is declared Read-Write (RW), so it could be modified interactively by the user.

Params:
  bar = The tweak bar to which adding a new variable.

  name = The name of the variable. It will be displayed in the tweak bar if no label is specified for this variable. It will also be used to refer to this variable in other functions, so choose a unique, simple and short name and avoid special characters like spaces or punctuation marks.

  type = Type of the variable. It must be one of the TwType constants or a user defined type created with TwDefineStruct or TwDefineEnum*.

  var = Pointer to the variable linked to this entry.

  def = An optional definition string used to modify the behavior of this new entry. This string must follow the variable parameters syntax, or set to NULL to get the default behavior. It could be set or modified later by calling the TwDefine or TwSetParam functions.

Returns:
1 if the variable was successfully added to the tweak bar.
0 if an error occurred (call TwGetLastError to retrieve the error).
*/
int TwAddVarRW(TwBar* bar, const(char)* name, TwType type, void* var, const(char)* def);

/**
This function adds a new variable to a tweak bar by specifying the variable’s pointer. The variable is declared Read-Only (RO), so it could not be modified interactively by the user.

Params:
  bar = The tweak bar to which adding a new variable.

  name = The name of the variable. It will be displayed in the tweak bar if no label is specified for this variable. It will also be used to refer to this variable in other functions, so choose a unique, simple and short name and avoid special characters like spaces or punctuation marks.

  type = Type of the variable. It must be one of the TwType constants or a user defined type created with TwDefineStruct or TwDefineEnum*.

  var = Pointer to the variable linked to this entry.

  def = An optional definition string used to modify the behavior of this new entry. This string must follow the variable parameters syntax, or set to NULL to get the default behavior. It could be set or modified later by calling the TwDefine or TwSetParam functions.

Returns:
1 if the variable was successfully added to the tweak bar.
0 if an error occurred (call TwGetLastError to retrieve the error).
*/
int TwAddVarRO(TwBar* bar, const(char)* name, TwType type, const(void)* var, const(char)* def);

/**
This function removes a variable, button or separator from a tweak bar.

Params:
  bar = The tweak bar from which to remove a variable.

  name = The name of the variable. It is the same name as the one provided to the TwAdd* functions when the variable was added.

Returns:
1 if the variable was successfully removed.
0 if an error occurred (call TwGetLastError to retrieve the error).
*/
int TwRemoveVar(TwBar* bar, const(char)* name);

/**
This function removes all the variables, buttons and separators previously added to a tweak bar.

Params:
  bar = The tweak bar from which to remove all variables.

Returns:
1 if variables were successfully removed.
0 if an error occurred (call TwGetLastError to retrieve the error).
*/
int TwRemoveAllVars(TwBar* bar);

/**
This function adds a new variable to a tweak _bar by providing CallBack (CB) functions to access it. If the setCallback parameter is set to null, the variable is declared Read-Only, so it could not be modified interactively by the user. Otherwise, it is a Read-Write variable, and could be modified interactively by the user.

Params:
  bar  = The tweak _bar to which to add a new variable.
  name = The _name of the variable. It will be displayed in the tweak _bar if no label is specified for this variable. It will also be used to refer to this variable in other functions, so choose a unique, simple and short _name and avoid special characters like spaces or punctuation marks.

  type = Type of the variable. It must be one of the TwType constants or a user defined type created with TwDefineStruct or TwDefineEnum*.

  setCallback = The callback function that will be called by AntTweakBar to change the variable’s value.

  getCallback = The callback function that will be called by AntTweakBar to get the variable’s value.

  clientData = For your convenience, this is a supplementary pointer that will be passed to the callback functions when they are called. For instance, if you set it to an object pointer, you can use it to access to the object’s members inside the callback functions.

  def = An optional definition string used to modify the behavior of this new entry. This string must follow the variable parameters syntax, or set to null to get the default behavior. It could be set or modified later by calling the TwDefine or TwSetParam functions.

Returns:
1 if the variable was successfully added to the tweak bar.
0 if an error occurred (call TwGetLastError to retrieve the error).
*/
int TwAddVarCB(TwBar* bar, const(char)* name, TwType type, TwSetVarCallback setCallback, TwGetVarCallback getCallback, void* clientData, const(char)* def);

/**
This function adds a button entry to a tweak _bar. When the button is clicked by a user, the callback function provided to TwAddButton is called.

Params:
  bar  = The tweak _bar to which to add a button.
  name = The _name of the button. It will be displayed in the tweak bar if no label is specified for this button. It will also be used to refer to this button in other functions, so choose a unique, simple and short _name and avoid special characters like spaces or punctuation marks.

  callback = The _callback function that will be called by AntTweakBar when the button is clicked.

  clientData = For your convenience, this is a supplementary pointer that will be passed to the callback function when it is called. For instance, if you set it to an object pointer, you can use it to access to the object’s members inside the callback function.

  def = An optional definition string used to modify the behavior of this new entry. This string must follow the variable parameters syntax, or set to null to get the default behavior. It could be set or modified later by calling the TwDefine or TwSetParam functions.

Returns:
1 if the button was successfully added to the tweak bar.
0 if an error occurred (call TwGetLastError to retrieve the error).
*/
int TwAddButton(TwBar* bar, const(char)* name, TwButtonCallback callback, void* clientData, const(char)* def);

/**
This function adds a horizontal separator line to a tweak bar. It may be useful if one wants to separate several sets of variables inside a same group.

Note that you can also add a line of text in a tweak bar using a special button, see TwAddButton.

Params:
  bar  = The tweak _bar to which to add the separator.
  name = The name of the separator. It is optional and can be set to null. But if you need to refer to this separator later in other commands make sure you _name it (like for other var names, choose a unique, simple and short name and avoid special characters like spaces or punctuation marks).

  def = An optional definition string used to modify the behavior of this new entry. This string must follow the variable parameters syntax, or set to null to get the default behavior. It could be set or modified later by calling the TwDefine or TwSetParam functions.

Returns:
1 if the separator was successfully added to the tweak bar.
0 if an error occurred (call TwGetLastError to retrieve the error).
*/
int TwAddSeparator(TwBar* bar, const(char)* name, const(char)* def);

/**
This function defines optional parameters for tweak bars and variables. For instance, it allows you to change the color of a tweak bar, to set a min and a max value for a variable, to add an help message that inform users of the meaning of a variable, and so on...

Params:
  def  = A string containing one or more parameter assignments (separated by newlines).

To define bar parameters, the syntax is:

-----
barName  barParam1=xx barParam2=xx ...
-----

where barName is the name of the tweak bar (the same as the one provided to TwNewBar), and barParam n follows the bar parameters syntax.

To define variable parameters, the syntax is:

-----
barName/varName  varParam1=xx varParam2=xx ...
-----

where barName is the name of the tweak bar (the same as the one provided to TwNewBar), varName is the name of the variable (the same as the one provided to TwAddVar*), and varParam n follows the variable parameters syntax.

If barName or varName contains special characters like spaces or quotation marks, you can surround it by quotes (‘), back-quotes (`) or double-quotes (“).

Returns:
0 if an error has occurred (call TwGetLastError to retrieve the error).
1 otherwise.

Notes:
Using a text file to define parameters:

One or more parameters can be defined by each TwDefine call. If you want to assign more than one parameter through one TwDefine call, separate them by new lines (\n). This allows, for instance, the read of parameters definition from a file into a string buffer, and then send this string to TwDefine. Doing so, you can modify the behavior of your tweak bars and variables without re-compiling your application.
*/
int TwDefine(const(char)* def);

/**
This function creates a new TwType corresponding to a C/C++ enum. Thus it could be used with TwAddVar* functions to control variables of type enum.

Params:
  name = Specify a name for the enum type (must be unique).

  enumValues = An array of structures of type TwEnumVal containing integer values and their associated labels (pointers to zero terminated strings) corresponding to the values.

  nbValues = Number of elements of the enumValues array.

Returns:
0 if an error has occurred (call TwGetLastError to retrieve the error).
1 otherwise.
*/
TwType TwDefineEnum(const(char)* name, const(TwEnumVal)* enumValues, uint nbValues);

/**
This function is an alternative to TwDefineEnum. It creates a new TwType corresponding to a C/C++ enum. Thus the type could be used with TwAddVar* functions to control variables of type enum.

Here the enum values are defined by a string containing a comma-separated list of labels. The first label is associated to 0, the second to 1, etc.

Params:
  name = Specify a name for the enum type (must be unique).

  enumString = Comma-separated list of labels.

Returns:
0 if an error has occurred (call TwGetLastError to retrieve the error).
1 otherwise.
*/
TwType TwDefineEnumFromString(const(char)* name, const(char)* enumString);

/**
This function creates a new TwType corresponding to a C/C++ structure. Thus it could be used with TwAddVar* functions to control variable of type struct.

Params:
  name = Specify a name for the struct type (must be unique).

  structMembers = An array of elements of type TwStructMember containing the descriptions of the structure members.

  nbMembers = Number of elements of the structMembers array.

  structSize = Size of the C/C++ structure (in bytes).

  summaryCallback = An optional callback function that will be called to display a summary of the  structure content. If summaryCallback is NULL, a default summary will be displayed. The callback function should be declared like this:

-----
void TW_CALL SummaryCallback(char *summaryString, size_t summaryMaxLength, const void *value, void *summaryClientData);
{
    const(MyStruct)* s = cast*(const(MyStruct)*)value;
    s.PrintToString(summaryString, summaryMaxLength);  // for instance.

    // summaryString is a pre-allocated C string (zero-ended) to be filled.
    // Its maximum length is summaryMaxLength.
}
-----

  summaryClientData = For your convenience, this is a supplementary pointer that will be passed to the summaryCallback function when it is called.

Returns:
0 if an error has occurred (call TwGetLastError to retrieve the error).
1 otherwise.
*/
TwType TwDefineStruct(const(char)* name, const(TwStructMember)* structMembers, uint nbMembers, size_t structSize, TwSummaryCallback summaryCallback, void* summaryClientData);

/**
This function is related to variables of type TW_TYPE_CDSTRING (C-Dynamic String). TwCopyCDStringToClientFunc must be used to provide a function that will be called by the AntTweakBar library to copy a C-dynamic string to the client application (ie. your program).

This function is required because memory allocated by a dynamic library (like AntTweakBar) cannot be resized or freed by its client application (your program) and vice versa. Thus the provided function is called by AntTweakBar to avoid bad memory handling between the two modules. If it is not provided, all variables of type TW_TYPE_CDSTRING will remain read-only.

In the other way, if your application needs to copy a C-dynamic string to AntTweakBar (for instance if you use callbacks to handle the variable via TwAddVarCB), call TwCopyCDStringToLibrary to copy it. See TwCopyCDStringToLibrary for an example.

Params:
  copyCDStringToClient = The function that will be called by AntTweakBar to copy a C-dynamic string to the client application.

*/
void TwCopyCDStringToClientFunc(TwCopyCDStringToClient copyCDStringToClient);

/**
This function is related to variables of type TW_TYPE_CDSTRING (ie. C-Dynamic null-terminated Strings). It is the counterpart of the function provided to TwCopyCDStringToClientFunc.

It copies the C string src handled by the client application (your program) to the C string dest handled by the AntTweakBar library.

It must be used if you are adding variables of type TW_TYPE_CDSTRING to a tweak bar using TwAddVarCB in order to manage the variable through callback functions. See the example below.

This function is required because memory allocated by the application (your program) cannot be resized or deleted by a dynamic library (like AntTweakBar) and vice versa. Thus it should be called for copying a string in order to avoid bad memory handling between the two modules.

Params:
  destPtr = Pointer to the destination C string handled by the AntTweakBar library.

  src = The source C string handled by your application.
*/
void TwCopyCDStringToLibrary(char** destPtr, const(char)* src);

/**
This function returns the current value of a bar or variable parameter. Parameters define the behavior of bars and vars and may have been set or modified by functions TwDefine, TwAddVar* or TwSetParam.

Params:
  bar = Bar identifier. If the requested parameter is global (not linked to a particular bar), NULL may be used as identifier.

  varName = varName is the name of the parameter’s variable (ie., the unique name used to create the variable).

If the parameter is directly related to a bar (and not specific to a var), varName should be NULL.

  paramName = Name of the parameter. This is one of the key words listed in the bar parameters page if the parameter is directly related to a bar, or listed in the var parameters page if the parameter is related to a variable.

  paramValueType = Type of the data to be stored in outValues. Should be one of the constants defined by TwParamValueType: TW_PARAM_INT32, TW_PARAM_FLOAT, TW_PARAM_DOUBLE or TW_PARAM_CSTRING.

  outValueMaxCount = Each parameter may have one or more values (eg., a position parameter has two values x and y). outValueMaxCount is the maximum number of output values that the function can write in the outValues buffer.

If the parameter value is of type string, outValueMaxCount is the maximum number of characters allocated for the outValues buffer. In this case and if the parameter have more than one value, they are all written in the outValues string and separated by spaces.

  outValues = Pointer to the buffer that will be filled with the requested parameter values. The buffer must be large enough to contain at least outValueMaxCount values of type specified by paramValueType.
*/
int TwGetParam(TwBar* bar, const(char)* varName, const(char)* paramName, TwParamValueType paramValueType, uint outValueMaxCount, void* outValues);

/**
This function modifies the value(s) of a bar or variable parameter. Parameters define the behavior of bars and vars and may be set by functions TwDefine or TwAddVar* using a definition string. TwSetParam is an alternative to these functions avoiding the conversion of the new parameter value into a definition string.

Params:
  bar = Bar identifier. If the parameter to modify is global, NULL may be used as identifier.

  varName = If the parameter is directly related to a bar, varName should be NULL.

Otherwise, varName is the name of the parameter’s variable (ie., the unique name used to create the variable).

  paramName = Name of the parameter. This is one of the key words listed in the bar parameters page if the parameter is directly related to a bar, or listed in the var parameters page if the parameter is related to a variable.

  paramValueType = Type of the data pointed by inValues. Should be one of the constants defined by TwParamValueType: TW_PARAM_INT32, TW_PARAM_FLOAT, TW_PARAM_DOUBLE or TW_PARAM_CSTRING.

  inValueCount = Depending on the parameter, one or more values may be required to modify it. For instance, a state parameter requires one value while a rgb-color parameter requires 3 values.

If the parameter value is a string, inValueCount must be 1 (not the length of the string), and the string must be an array of chars terminated by a zero (ie., a C-style string).

  inValues = Pointer to the new parameter value(s). If there is more than one value, the values must be stored consecutively as an array starting at the address pointed by inValues.
*/
int TwSetParam(TwBar* bar, const(char)* varName, const(char)* paramName, TwParamValueType paramValueType, uint inValueCount, const(void)* inValues);

/**
Draws all the created tweak bars.

This function must be called once per frame, after all the other drawing calls and just before the application presents (swaps) the frame buffer. It will draw the bars on top of the other drawings. It tries to backup all the graphics states that it modifies, and restore them after.

This function is optimized. It aims at having as less impact as possible on the application frame rate (if the app does other things than to only display tweak bars, of course).

Returns:
0 if failed (call TwGetLastError to retrieve the error).
1 if succeeded.
*/
int TwDraw();

/**
Call this function to inform AntTweakBar of the size of the application graphics window, or to restore AntTweakBar graphics resources (after a fullscreen switch for instance).

This function is time consuming because it restores graphics resources (such as textures needed by AntTweakBar to display text efficiently), so it must be called only when necessary: when the size of the application graphics window has changed, or when the graphics context has been restored (if graphics mode has changed for instance).

Note that if you are using SDL, GLUT, GLFW or Windows (DirectX), the library provides some helper functions to handle events like window resizing. See the section how to integrate for more details.

The size must be the actual client size of the graphics window, excluding system menu and other decorations. For instance on windows GetClientRect can be used:

-----
RECT r;
GetClientRect(hWnd, &r);
TwWindowSize(r.right - r.left, r.bottom - r.top);
-----

If you need to release the graphics resources allocated by AntTweakBar, call TwWindowSize(0,0); For instance this might be useful when Direct3D requires resources to be released before resizing its render target.

Params:
  width = Width of the graphics window.

  height = Height of the graphics window.

Returns:
0 if failed (call TwGetLastError to retrieve the error).
1 if succeeded.
*/
int TwWindowSize(int width, int height);

/**
Returns:
The current window context identifier previously set by TwSetCurrentWindow.
*/
int TwGetCurrentWindow();

/**
This function is intended to be used by applications with multiple graphical windows. It tells AntTweakBar to switch its current context to the context associated to the identifier windowID. All AntTweakBar functions (except TwTerminate) called after the switch would be executed in this context. If the context does not exist (ie., if this is the first time that TwSetCurrentWindow is called for this windowID), it is created.

Function TwInit must be called once before any call to TwSetCurrentWindow, it should not be called for each new window context. TwTerminate is also context insensitive and must be called once at the end of the program, it will destroy all the created contexts.

Window contexts are separated. A tweak bar created in one context cannot be modified or displayed within an other context. Thus two tweak bars with the same name can live in different contexts. Same for enum and structure definitions.

To display the tweak bars TwDraw must be called for each window context.

Event handling must also be set for each window context.

Params:
  windowID = Window context identifier. This identifier could be any integer.

The window context identifier 0 always exist, this is the default context created when AntTweakBar is initialized through TwInit.

Returns:
0 if failed (call TwGetLastError to retrieve the error).
1 if succeeded.
*/
int TwSetCurrentWindow(int windowID);

/**
Check if a window context associated to the identifier windowID exists. A window context exists if it has previously been created by TwSetCurrentWindow.

Params:
  windowID = Window context identifier.

The window context identifier 0 always exist, this is the default context created when AntTweakBar is initialized through TwInit.

Returns:
0 if the window context does not exist
1 if the window context exists
*/
int TwWindowExists(int windowID);

/**
Call this function to inform AntTweakBar when a keyboard event occurs.

AntTweakBar interprets this event and acts consequently if it corresponds to a registered key shortcut. So TwKeyPressed has to be called each time your app receives a keyboard event that is not handled directly by your app.

For your convenience, the received key shortcut is displayed at the bottom of the Help bar.

If you are using SDL, GLUT, GLFW or Windows (DirectX), the library provides some helper functions to handle events. See the section how to integrate for more details.

Params:
  key = The ASCII code of the pressed key, or one of the TwKeySpecial codes.

  modifiers = One or a OR-ed combination of the TwKeyModifier constants.

Returns:
1 if the key event has been handled by AntTweakBar,
0 otherwise.
*/
int TwKeyPressed(int key, int modifiers);

/**
This function checks if a key event would be processed by TwKeyPressed but without processing it. TwKeyTest could be helpful to prevent bad handling report, for instance when processing WM_KEYUP and WM_KEYDOWN in windows event loop (see file src/TwEventWin.c).

Params:
  key = The ASCII code of the key, or one of the TwKeySpecial codes.

  modifiers = One or a OR-ed combination of the TwKeyModifier constants.

Returns:
1 if the key event has been handled by AntTweakBar,
0 otherwise.
*/
int TwKeyTest(int key, int modifiers);

/**
Call this function to inform AntTweakBar that a mouse button is pressed.

AntTweakBar interprets this event and acts consequently. So TwMouseButton has to be called each time your app receives a mouse button event that is not handled directly by your app.

If you are using SDL, GLUT, GLFW or Windows (DirectX), the library provides some helper functions to handle events. See the section how to integrate for more details.

Params:
  action = Tells if the button is pressed or released. It is one of the TwMouseAction constants.

  button = Tells which button is pressed. It is one of the TwMouseButtonID constants.

Returns:
1 if the mouse event has been handled by AntTweakBar,
0 otherwise.
*/
int TwMouseButton(TwMouseAction action, TwMouseButtonID button);

/**
Call this function to inform AntTweakBar that the mouse has moved.

AntTweakBar interprets this event and acts consequently. So TwMouseMotion has to be called each time your app receives a mouse motion event that is not handled directly by your app.

If you are using SDL, GLUT, GLFW or Windows (DirectX), the library provides some helper functions to handle events. See the section how to integrate for more details.

Params:
  mouseX = The new X position of the mouse, relative to the left border of the graphics window.

  mouseY = The new Y position of the mouse, relative to the top border of the graphics window.

Returns:
1 if the mouse event has been handled by AntTweakBar,
0 otherwise.
*/
int TwMouseMotion(int mouseX, int mouseY);

/**
Call this function to inform AntTweakBar that the mouse wheel has been used.

AntTweakBar interprets this event and acts consequently. So TwMouseWheel has to be called each time your app receives a mouse wheel event that is not handled directly by your app.

If you are using SDL, GLUT, GLFW or Windows (DirectX), the library provides some helper functions to handle events. See the section how to integrate for more details.

Params:
  pos = The new position of the wheel.

Returns:
1 if the mouse wheel event has been handled by AntTweakBar,
0 otherwise.
*/
int TwMouseWheel(int pos);

/**
    Function which can be used as a WNDPROC event handler (callback) for WinAPI.
*/
int TwEventWin(void* wnd, uint msg, uint wParam, int lParam);

/**
    Function which can be used as an event handler (callback) for SDL.
*/
int TwEventSDL(const(void)* sdlEvent, ubyte sdlMajorVersion, ubyte sdlMinorVersion);

/**
    Functions which can be used as event handlers (callbacks) for GLFW.
*/
int TwEventMouseButtonGLFW(int glfwButton, int glfwAction);

/// ditto
int TwEventKeyGLFW(int glfwKey, int glfwAction);

/// ditto
int TwEventCharGLFW(int glfwChar, int glfwAction);

/// ditto
alias TwEventMousePosGLFW = TwMouseMotion;

/// ditto
alias TwEventMouseWheelGLFW = TwMouseWheel;

extern (C):

/** The types of callback functions used by GLUT. */
alias void function(int, int, int, int) GLUTmousebuttonfun;

/// ditto
alias void function(int, int) GLUTmousemotionfun;

/// ditto
alias void function(ubyte, int, int) GLUTkeyboardfun;

/// ditto
alias void function(int, int, int) GLUTspecialfun;

/**
    Functions which can be used as event handlers (callbacks) for GLUT.
*/
int TwEventMouseButtonGLUT(int glutButton, int glutState, int mouseX, int mouseY);

/// ditto
int TwEventMouseMotionGLUT(int mouseX, int mouseY);

/// ditto
int TwEventKeyboardGLUT(ubyte glutKey, int mouseX, int mouseY);

/// ditto
int TwEventSpecialGLUT(int glutKey, int mouseX, int mouseY);

/// ditto
int TwGLUTModifiersFunc(int function() glutGetModifiersFunc);

/// ditto
int TwEventSFML(const(void)* sfmlEvent, ubyte sfmlMajorVersion, ubyte sfmlMinorVersion);

/**
    Functions which can be used as event handlers (callbacks) for GLFW2.

    Note: The following expect GLFW2 bindings, not GLFW3.
    In particular GLFW2 keys do not match GLFW3 keys,
    you'll have to translate them if you want to use these functions.
*/
int TwEventMouseButtonGLFWcdecl(int glfwButton, int glfwAction);

/// ditto
int TwEventKeyGLFWcdecl(int glfwKey, int glfwAction);

/// ditto
int TwEventCharGLFWcdecl(int glfwChar, int glfwAction);

/// ditto
int TwEventMousePosGLFWcdecl(int mouseX, int mouseY);

/// ditto
int TwEventMouseWheelGLFWcdecl(int wheelPos);
