#include <furi.h>
#include <gui/gui.h>
#include <assets_icons.h>

static void hello_app_draw_callback(Canvas* canvas, void* ctx) {
    UNUSED(ctx);

    canvas_clear(canvas);
    canvas_set_font(canvas, FontPrimary);
    canvas_draw_icon(canvas, 0, 8, &I_WarningDolphin_45x42);
    canvas_set_font(canvas, FontSecondary);
    canvas_draw_str(canvas, 51, 32, "Hello Application");
    canvas_set_font(canvas, FontSecondary);
    canvas_draw_str(canvas, 17, 60, "github.com/filipsedivy");
    canvas_draw_frame(canvas, 0, 50, 128, 14);
}

static void hello_app_input_callback(InputEvent* input_event, void* ctx) {
    furi_assert(ctx);
    FuriMessageQueue* event_queue = ctx;

    furi_message_queue_put(event_queue, input_event, FuriWaitForever);
}

int32_t flipper_hello_app(void* p) {
    UNUSED(p);

    InputEvent event;
    FuriMessageQueue* event_queue = furi_message_queue_alloc(8, sizeof(InputEvent));

    // Configure view port
    ViewPort* view_port = view_port_alloc();
    view_port_draw_callback_set(view_port, hello_app_draw_callback, NULL);
    view_port_input_callback_set(view_port, hello_app_input_callback, event_queue);

    // Register view port in GUI
    Gui* gui = furi_record_open(RECORD_GUI);
    gui_add_view_port(gui, view_port, GuiLayerFullscreen);

    while(1) {
        furi_check(furi_message_queue_get(event_queue, &event, FuriWaitForever) == FuriStatusOk);

        if(event.key == InputKeyBack) {
            break;
        }
    }

    furi_message_queue_free(event_queue);

    gui_remove_view_port(gui, view_port);
    view_port_free(view_port);
    furi_record_close(RECORD_GUI);

    return 0;
}