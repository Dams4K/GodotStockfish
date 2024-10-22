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

void GodotStockfish::_bind_methods() {
    ClassDB::bind_method(D_METHOD("print_eval"), &GodotStockfish::print_eval);
    ClassDB::bind_method(D_METHOD("set_position", "fen", "moves"), &GodotStockfish::set_position);
}

std::string GodotStockfish::String_to_string(String str) {
    return str.utf8().get_data();
}

String GodotStockfish::string_to_String(std::string str) {
    return String(str.c_str());
}

GodotStockfish::GodotStockfish() {}

GodotStockfish::~GodotStockfish() {
    engine.stop();
}

void GodotStockfish::set_position(String fen, TypedArray<String> moves) {
    std::vector<std::string> v_moves;

    for (int i = 0; i < moves.size(); i++) {
        v_moves.push_back(String_to_string(moves[i]));
    }

    engine.set_position(String_to_string(fen), v_moves);
}

void GodotStockfish::print_eval() {
    UtilityFunctions::print(String(engine.trace_eval().c_str()));
}

String GodotStockfish::init_engine() {

    engine.trace_eval();

    // return String(Stockfish::engine_info().c_str());
    // engine.set_position("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", {"e2e4"});


    // TypedArray<String> moves;
    // moves.push_back("e2e4");
    // set_position("rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1", moves);

    return String(engine.trace_eval().c_str());
}

