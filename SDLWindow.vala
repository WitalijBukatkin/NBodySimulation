using SDL;
using SDLGraphics;

public class SDLWindow {
	private NBodySimulation nBodySimulation;

	private unowned SDL.Screen screen;

	private const int SCREEN_BPP = 32;
    private const int DELAY = 1;
	
	public SDLWindow(int screenWidth, int screenHeight, int dotsCount, double dotSize, bool circleGeneration, uchar r, uchar g, uchar b, uchar a){
		SDL.init (InitFlag.VIDEO);

		screen = Screen.set_video_mode(screenWidth, screenHeight, SCREEN_BPP, 0);
        
        if (screen == null) {
            stderr.printf ("Could not set video mode.\n");
        }

        SDL.WindowManager.set_caption("NBodySimulation", "");

		nBodySimulation = new NBodySimulation(screen, dotsCount, dotSize, circleGeneration, r, g, b, a);
	}

	public void run(){
		while (isContinued()) {
        	nBodySimulation.draw ();
        	SDL.Timer.delay (DELAY);
    	}
		SDL.quit ();
	}

	private bool isContinued () {
        Event event;
        while (Event.poll (out event) == 1) {
            if (event.type == EventType.QUIT){
                return false;
	    	}
        }
		return true;
    }
}
