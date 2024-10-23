#include "register_types.h"

#include "godot_stockfish.h"

#include <gdextension_interface.h>
#include <godot_cpp/core/defs.hpp>
#include <godot_cpp/godot.hpp>

#include <godot_cpp/classes/engine.hpp>

using namespace godot;

void initialize_stockfish_module(ModuleInitializationLevel p_level) {
	if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
		return;
	}


    Stockfish::Bitboards::init();
    Stockfish::Position::init();

	// GDREGISTER_ABSTRACT_CLASS(GodotStockfish);
	GDREGISTER_CLASS(GodotStockfish);

	Engine::get_singleton()->register_singleton("GodotStockfish", memnew(GodotStockfish));
}

void uninitialize_stockfish_module(ModuleInitializationLevel p_level) {
	if (p_level != MODULE_INITIALIZATION_LEVEL_SCENE) {
		return;
	}
	Engine::get_singleton()->unregister_singleton("GodotStockfish");
}

extern "C" {
// Initialization.
GDExtensionBool GDE_EXPORT stockfish_library_init(GDExtensionInterfaceGetProcAddress p_get_proc_address, const GDExtensionClassLibraryPtr p_library, GDExtensionInitialization *r_initialization) {
	godot::GDExtensionBinding::InitObject init_obj(p_get_proc_address, p_library, r_initialization);

	init_obj.register_initializer(initialize_stockfish_module);
	init_obj.register_terminator(uninitialize_stockfish_module);
	init_obj.set_minimum_library_initialization_level(MODULE_INITIALIZATION_LEVEL_SCENE);

	return init_obj.init();
}
}
