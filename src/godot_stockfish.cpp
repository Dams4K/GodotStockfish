#include "godot_stockfish.h"
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/variant/utility_functions.hpp>

#include "benchmark.h"
#include "engine.h"
#include "movegen.h"
#include "position.h"
#include "score.h"
#include "search.h"
#include "types.h"
#include "ucioption.h"

using namespace godot;

GodotStockfish::GodotStockfish() {
}

GodotStockfish::~GodotStockfish() {

}

String GodotStockfish::init_engine() {
    Stockfish::Bitboards::init();
    Stockfish::Position::init();

    Stockfish::Engine engine;

    engine.trace_eval();

    // return String(Stockfish::engine_info().c_str());
    engine.set_position("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", {"e2e4"});

    return String(engine.trace_eval().c_str());
}


void GodotStockfish::_bind_methods() {
    ClassDB::bind_method(D_METHOD("init_engine"), &GodotStockfish::init_engine);
}
