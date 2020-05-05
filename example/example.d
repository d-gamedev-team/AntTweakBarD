module example;

/**
    Simple example of using the tweak bar.

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

int width  = 640;
int height = 480;

void main()
{
    enforce(glfwInit());
    scope (exit)
        glfwTerminate();

    TwBar* bar;                              // Pointer to a tweak bar

    double time        = 0, dt;              // Current time and enlapsed time
    double turn        = 0;                  // Model turn counter
    double speed       = 0.3;                // Model rotation speed
    int wire           = 0;                  // Draw model in wireframe?
    float[3] bgColor   = [0.1f, 0.2f, 0.4f]; // Background color
    ubyte[4] cubeColor = [255, 0, 0, 128];   // Model color (32bits RGBA)

    Window window = createWindow("Tutorial 01", WindowMode.windowed, width, height);
    scope (exit) destroy(window);

    register_glfw_error_callback(&on_glfw_error);

    // antialiasing
    window.samples = 4;

    window.make_context_current();

    // Load all OpenGL function pointers via glad.
    enforce(gladLoadGL());

    // Initialize AntTweakBar
    TwInit(TW_OPENGL_CORE, null);
    scope (exit)
        TwTerminate();

    TwWindowSize(640, 480);

    // Create a tweak bar
    bar = TwNewBar("TweakBar");
    TwDefine(" GLOBAL help='This example shows how to integrate AntTweakBar with GLFW and OpenGL.' "); // Message added to the help bar.

    // Add 'speed' to 'bar': it is a modifable (RW) variable of type TW_TYPE_DOUBLE. Its key shortcuts are [s] and [S].
    TwAddVarRW(bar, "speed", TW_TYPE_DOUBLE, &speed,
               " label='Rot speed' min=0 max=2 step=0.01 keyIncr=s keyDecr=S help='Rotation speed (turns/second)' ");

    // Add 'wire' to 'bar': it is a modifable variable of type TW_TYPE_BOOL32 (32 bits boolean). Its key shortcut is [w].
    TwAddVarRW(bar, "wire", TW_TYPE_BOOL32, &wire,
               " label='Wireframe mode' key=CTRL+w help='Toggle wireframe display mode.' ");

    // Add 'time' to 'bar': it is a read-only (RO) variable of type TW_TYPE_DOUBLE, with 1 precision digit
    TwAddVarRO(bar, "time", TW_TYPE_DOUBLE, &time, " label='Time' precision=1 help='Time (in seconds).' ");

    // Add 'bgColor' to 'bar': it is a modifable variable of type TW_TYPE_COLOR3F (3 floats color)
    TwAddVarRW(bar, "bgColor", TW_TYPE_COLOR3F, &bgColor, " label='Background color' ");

    // Add 'cubeColor' to 'bar': it is a modifable variable of type TW_TYPE_COLOR32 (32 bits color) with alpha
    TwAddVarRW(bar, "cubeColor", TW_TYPE_COLOR32, &cubeColor,
               " label='Cube color' alpha help='Color and transparency of the cube.' ");

    // resize window and make sure we update the viewport transform on a resize
    onWindowResize(window.window, width, height);

    /** Hook all input events. */
    glfwSetWindowSizeCallback(window.window, &onWindowResize);
    glfwSetMouseButtonCallback(window.window, &onMouseButton);
    glfwSetCursorPosCallback(window.window, &onCursorPos);
    glfwSetScrollCallback(window.window, &onScroll);
    glfwSetKeyCallback(window.window, &onKey);
    glfwSetCharCallback(window.window, &onChar);

    while (!glfwWindowShouldClose(window.window))
    {
        // Clear frame buffer using bgColor
        glClearColor(bgColor[0], bgColor[1], bgColor[2], 1);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        /**
            Note: Here you would inject your update + rendering routine,
            you could e.g. update the rotation of a cube based on the
            time variable which AntTweakBar modifies.
        */

        // Draw tweak bars
        TwDraw();

        /* Swap front and back buffers */
        window.swap_buffers();

        /* Poll for and process events */
        glfwPollEvents();

        if (window.is_key_down(GLFW_KEY_ESCAPE))
            glfwSetWindowShouldClose(window.window, true);
    }
}

extern(C) void onWindowResize(GLFWwindow* window, int width, int height)
{
    int x = 0;
    int y = 0;
    glViewport(x, y, width, height);

    // ~ glMatrixMode(GL_PROJECTION);
    // ~ glLoadIdentity();
    // ~ gluPerspective(40, (double)width/height, 1, 10);
    // ~ gluLookAt(-1,0,3, 0,0,0, 0,1,0);

    TwWindowSize(width, height);
}

extern(C) void onMouseButton(GLFWwindow* window, int button, int action, int mods)
{
    if (TwEventMouseButtonGLFW3(window, button, action, mods))
        return;

    // handle it ourselves
}

extern(C) void onCursorPos(GLFWwindow* window, double xpos, double ypos)
{
    if (TwEventMousePosGLFW3(window, xpos, ypos))
        return;

    // handle it ourselves
}

extern(C) void onScroll(GLFWwindow* window, double xoffset, double yoffset)
{
    if (TwEventMouseWheelGLFW3(window, xoffset, yoffset))
        return;

    // handle it ourselves
}

extern(C) void onKey(GLFWwindow* window, int key, int scancode, int action, int mods)
{
    if (TwEventKeyGLFW3(window, key, scancode, action, mods))
        return;

    // handle it ourselves
    if (action == GLFW_PRESS && key == GLFW_KEY_ESCAPE)
        glfwSetWindowShouldClose(window, true);
}

extern(C) void onChar(GLFWwindow* window, uint codepoint)
{
    if (TwEventCharGLFW3(window, codepoint))
        return;

    // handle it ourselves
}

enum WindowMode
{
    fullscreen,
    windowed,
}

/** Convert GLFW2 keys to GLFW3. This is only a partial implementation. */
int keyGLFW2ToGLFW3(int key)
{
    static import glfw2 = deimos.glfw.glfw2;

    switch (key)
    {
        case GLFW_KEY_LEFT_CONTROL:
            return glfw2.GLFW_KEY_LCTRL;

        default:
    }

    return key;
}

int TwEventMouseButtonGLFW3(GLFWwindow* window, int button, int action, int mods)
{
    return TwEventMouseButtonGLFW(button, action);
}

int TwEventMousePosGLFW3(GLFWwindow* window, double xpos, double ypos)
{
    return TwMouseMotion(cast(int)xpos, cast(int)ypos);
}

int TwEventMouseWheelGLFW3(GLFWwindow* window, double xoffset, double yoffset)
{
    return TwEventMouseWheelGLFW(cast(int)yoffset);
}

int TwEventKeyGLFW3(GLFWwindow* window, int key, int scancode, int action, int mods)
{
    return TwEventKeyGLFW(key.keyGLFW2ToGLFW3(), action);
}

int TwEventCharGLFW3(GLFWwindow* window, int codepoint)
{
    return TwEventCharGLFW(codepoint, GLFW_PRESS);
}

/* Wrapper around the glwtf API. */
Window createWindow(string windowName, WindowMode windowMode, int width, int height)
{
    auto window  = new Window();
    auto monitor = windowMode == WindowMode.fullscreen ? glfwGetPrimaryMonitor() : null;
    auto cv      = window.create_highest_available_context(width, height, windowName, monitor, null, GLFW_OPENGL_CORE_PROFILE);
    return window;
}
