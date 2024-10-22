#include "godot_stockfish.h"
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/variant/utility_functions.hpp>


#include "misc.h"
#include "uci.h"
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
    ClassDB::bind_method(D_METHOD("set_position", "fen", "moves"), &GodotStockfish::set_position);
    ClassDB::bind_method(D_METHOD("go", "depth"), &GodotStockfish::go);

    ClassDB::bind_method(D_METHOD("print_eval"), &GodotStockfish::print_eval);
}

std::string GodotStockfish::String_to_string(String str) {
    return str.utf8().get_data();
}

String GodotStockfish::string_to_String(std::string str) {
    return String(str.c_str());
}





void GodotStockfish::on_bestmove(std::string_view bestmove, std::string_view ponder) {
    std::cout << "bestmove " << bestmove;
    if (!ponder.empty())
        std::cout << " ponder " << ponder;
    std::cout << std::endl;

}


void GodotStockfish::on_update_no_moves(const Stockfish::Engine::InfoShort& info) {
    // Stockfish::sync_cout << "info depth " << info.depth << " score " << format_score(info.score) << Stockfish::sync_endl;
}

void GodotStockfish::on_update_full(const Stockfish::Engine::InfoFull& info, bool showWDL) {
    // std::stringstream ss;

    // ss << "info";
    // ss << " depth " << info.depth                 //
    //    << " seldepth " << info.selDepth           //
    //    << " multipv " << info.multiPV             //
    //    << " score " << format_score(info.score);  //

    // if (showWDL)
    //     ss << " wdl " << info.wdl;

    // if (!info.bound.empty())
    //     ss << " " << info.bound;

    // ss << " nodes " << info.nodes        //
    //    << " nps " << info.nps            //
    //    << " hashfull " << info.hashfull  //
    //    << " tbhits " << info.tbHits      //
    //    << " time " << info.timeMs        //
    //    << " pv " << info.pv;             //

    // sync_cout << ss.str() << sync_endl;
}

void GodotStockfish::on_iter(const Stockfish::Engine::InfoIter& info) {
    // std::stringstream ss;

    // ss << "info";
    // ss << " depth " << info.depth                     //
    //    << " currmove " << info.currmove               //
    //    << " currmovenumber " << info.currmovenumber;  //

    // sync_cout << ss.str() << sync_endl;
}



GodotStockfish::GodotStockfish() {
    engine.get_options().add_info_listener([](const std::optional<std::string>& str) {
        if (str.has_value()) {
            UtilityFunctions::print("Value");
        }
            // UtilityFunctions::print(string_to_String((std::string) str));
    });

    engine.set_on_iter([](const auto& i) { on_iter(i); });
    engine.set_on_update_no_moves([](const auto& i) { on_update_no_moves(i); });
    engine.set_on_update_full(
      [this](const auto& i) { on_update_full(i, engine.get_options()["UCI_ShowWDL"]); });
    engine.set_on_bestmove([](const auto& bm, const auto& p) { on_bestmove(bm, p); });
}

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


void GodotStockfish::go(int depth) {
    Stockfish::Search::LimitsType limits;
    limits.startTime = Stockfish::now();
    limits.depth = depth;

    // std::istringstream is("depth 20");

    // Stockfish::UCIEngine uci(0, NULL);
    // Stockfish::Search::LimitsType limits = uci.parse_limits(is);

    engine.go(limits);
}



String GodotStockfish::print_eval() {
    String str = String(engine.trace_eval().c_str());
    UtilityFunctions::print(str);
    return str;
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

