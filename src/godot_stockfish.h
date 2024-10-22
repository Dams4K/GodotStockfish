#ifndef STOCKFISH_H
#define STOCKFISH_H

#include <godot_cpp/classes/node.hpp>

#include "engine.h"
#include "misc.h"
#include "search.h"

namespace godot {

class GodotStockfish : public Node {
    GDCLASS(GodotStockfish, Node)

protected:
    static void _bind_methods();

public:
    GodotStockfish();
    ~GodotStockfish();

    String init_engine();
};

}

#endif