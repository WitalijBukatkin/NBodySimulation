using SDL;

public class SDLWindow {
	private NBodySimulation nBodySimulation;

	private const int SCREEN_BPP = 32;
    private const int DELAY = 1;
	
	public SDLWindow(int screen_width, int screen_height, int dots_count, double dotSize, bool circle_generation, uchar r, uchar g, uchar b, uchar a){
		SDL.init (InitFlag.VIDEO);

		unowned Screen screen = Screen.set_video_mode(screen_width, screen_height, SCREEN_BPP, SurfaceFlag.FULLSCREEN);
        
        if (screen == null) {
            stderr.printf ("Could not set video mode.\n");
        }

        WindowManager.set_caption("NBodySimulation", "");

		nBodySimulation = new NBodySimulation(screen, dots_count, dotSize, circle_generation, r, g, b, a);
	}

	public void run(){
		while (is_continued()) {
        	nBodySimulation.draw ();
        	SDL.Timer.delay (DELAY);
    	}
		SDL.quit ();
	}

	private bool is_continued() {
        Event event;
        while (Event.poll (out event) == 1) {
            if (event.type == EventType.KEYDOWN){
                return false;
	    	}
        }
		return true;
    }
}
