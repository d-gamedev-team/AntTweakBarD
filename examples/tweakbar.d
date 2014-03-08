module tweakbar;

/**
    This just displays the tweak bar, it doesn't hook any variables
    or render anything.

    Note:

    - When using GLFW_OPENGL_CORE_PROFILE make sure to use TW_OPENGL_CORE in the TwInit call,
    otherwise you won't have have anything displayed on the screen.
*/

import std.conv;
import std.stdio;
import std.exception;

import deimos.glfw.glfw3;

import glad.gl.all;
import glad.gl.gl;
import glad.gl.loader;

import glwtf.input;
import glwtf.window;

import AntTweakBar;

void on_glfw_error(int code, string msg)
{
    stderr.writefln("Error (%s): %s", code, msg);
}

int width = 640;
int height = 480;

int main()
{
    TwBar *bar;         // Pointer to a tweak bar

    double time = 0, dt;// Current time and enlapsed time
    double turn = 0;    // Model turn counter
    double speed = 0.3; // Model rotation speed
    int wire = 0;       // Draw model in wireframe?
    float bgColor[3] = [0.1f, 0.2f, 0.4f];         // Background color
    ubyte cubeColor[4] = [255, 0, 0, 128]; // Model color (32bits RGBA)

    // Intialize GLFW
    if( !glfwInit() )
    {
        // An error occured
        //~ fprintf(stderr, "GLFW initialization failed\n");
        return 1;
    }

    Window window = createWindow("Tutorial 01", WindowMode.windowed, width, height);

    register_glfw_error_callback(&on_glfw_error);

    // antialiasing
    window.samples = 4;

    window.make_context_current();

    // Load all OpenGL function pointers via glad.
    enforce(gladLoadGL());

    // Initialize AntTweakBar
    TwInit(TW_OPENGL_CORE, null);

	TwWindowSize(width, height);

    // Create a tweak bar
    bar = TwNewBar("TweakBar");
    TwDefine(" GLOBAL help='This example shows how to integrate AntTweakBar with GLFW and OpenGL.' "); // Message added to the help bar.

    // Add 'speed' to 'bar': it is a modifable (RW) variable of type TW_TYPE_DOUBLE. Its key shortcuts are [s] and [S].
    TwAddVarRW(bar, "speed", TW_TYPE_DOUBLE, &speed,
               " label='Rot speed' min=0 max=2 step=0.01 keyIncr=s keyDecr=S help='Rotation speed (turns/second)' ");

    // Add 'wire' to 'bar': it is a modifable variable of type TW_TYPE_BOOL32 (32 bits boolean). Its key shortcut is [w].
    TwAddVarRW(bar, "wire", TW_TYPE_BOOL32, &wire,
               " label='Wireframe mode' key=w help='Toggle wireframe display mode.' ");

    // Add 'time' to 'bar': it is a read-only (RO) variable of type TW_TYPE_DOUBLE, with 1 precision digit
    TwAddVarRO(bar, "time", TW_TYPE_DOUBLE, &time, " label='Time' precision=1 help='Time (in seconds).' ");

    // Add 'bgColor' to 'bar': it is a modifable variable of type TW_TYPE_COLOR3F (3 floats color)
    TwAddVarRW(bar, "bgColor", TW_TYPE_COLOR3F, &bgColor, " label='Background color' ");

    // Add 'cubeColor' to 'bar': it is a modifable variable of type TW_TYPE_COLOR32 (32 bits color) with alpha
    TwAddVarRW(bar, "cubeColor", TW_TYPE_COLOR32, &cubeColor,
               " label='Cube color' alpha help='Color and transparency of the cube.' ");

    while (!glfwWindowShouldClose(window.window))
    {
        // Clear frame buffer using bgColor
        glClearColor(bgColor[0], bgColor[1], bgColor[2], 1);
        glClear( GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT );

        // Draw tweak bars
        TwDraw();

        /* Swap front and back buffers */
        window.swap_buffers();

        /* Poll for and process events */
        glfwPollEvents();

        if (window.is_key_down(GLFW_KEY_ESCAPE))
            glfwSetWindowShouldClose(window.window, true);
    }

    // Terminate AntTweakBar and GLFW
    TwTerminate();
    glfwTerminate();

    return 0;
}


enum WindowMode
{
    fullscreen,
    windowed,
}

/* Wrapper around the glwtf API. */
Window createWindow(string windowName, WindowMode windowMode, int width, int height)
{
    auto window = new Window();
    auto monitor = windowMode == WindowMode.fullscreen ? glfwGetPrimaryMonitor() : null;
    auto cv = window.create_highest_available_context(width, height, windowName, monitor, null, GLFW_OPENGL_CORE_PROFILE);
    return window;
}
