#ifndef STOCKFISH_H
#define STOCKFISH_H

#include <godot_cpp/classes/node.hpp>

#include "engine.h"
#include "misc.h"
#include "search.h"

namespace godot {

class GodotStockfish : public Node {
    GDCLASS(GodotStockfish, Node)

private:
    Stockfish::Engine engine;

    // Just a tool
    std::string String_to_string(String str);
    String string_to_String(std::string str);

protected:
    static void _bind_methods();

public:
    GodotStockfish();
    ~GodotStockfish();


    void set_position(String fen, TypedArray<String> moves);
    String init_engine();
};

}

#endif