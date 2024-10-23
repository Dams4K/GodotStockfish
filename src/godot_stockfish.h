#ifndef STOCKFISH_H
#define STOCKFISH_H

#include <godot_cpp/classes/object.hpp>

#include "engine.h"
#include "misc.h"
#include "search.h"

namespace godot {

class GodotStockfish : public Object {
    GDCLASS(GodotStockfish, Object)

    static GodotStockfish *singleton;

private:
    Stockfish::Engine engine;

    // Just a tool
    static std::string String_to_string(String str);
    static String string_to_String(std::string str);

    static void on_update_no_moves(const Stockfish::Engine::InfoShort& info);
    static void on_update_full(const Stockfish::Engine::InfoFull& info, bool showWDL);
    static void on_iter(const Stockfish::Engine::InfoIter& info);
    void on_bestmove(std::string_view bestmove, std::string_view ponder);

protected:
    static void _bind_methods();

public:
    GodotStockfish();
    ~GodotStockfish();

    static GodotStockfish *get_singleton();

    void go(int depth);
    void set_position(String fen, TypedArray<String> moves);
    
    String print_eval();
    String init_engine();
};

}

#endif