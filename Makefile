all:
	valac --pkg gtk+-3.0 --pkg sdl --pkg sdl-gfx --pkg glib-2.0 -X -lSDL_gfx -X -lm -o nbodysimulation src/NBodySimulation.vala src/SDLWindow.vala src/Main.vala
clean:
	rm -r nbodysimulation
