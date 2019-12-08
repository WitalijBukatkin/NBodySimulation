all:
	valac --pkg sdl --pkg sdl-gfx --pkg glib-2.0 -X -lSDL_gfx -X -lm -o nbodysimulation NBodySimulation.vala
clean:
	rm -r nbodysimulation
