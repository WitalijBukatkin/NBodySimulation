project('nbodysimulation', 'vala', 'c')

dependencies = [
    dependency('gtk+-3.0'),
    dependency('sdl'),
    
    meson.get_compiler('c').find_library('m'),
    meson.get_compiler('c').find_library('SDL_gfx'),
    meson.get_compiler('vala').find_library('sdl-gfx'),
]

sources = files('src/Main.vala', 'src/NBodySimulation.vala', 'src/SDLWindow.vala')

executable('nbodysimulation', sources, dependencies: dependencies)
