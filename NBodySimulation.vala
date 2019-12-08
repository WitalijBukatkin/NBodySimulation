using SDL;
using SDLGraphics;

public class SDLSample : Object {

    private const int SCREEN_WIDTH = 1280;
    private const int SCREEN_HEIGHT = 800;
    private const int SCREEN_BPP = 32;
    private const int DELAY = 1;

    private unowned SDL.Screen screen;
    private GLib.Rand rand;
    
    private const int pts = 700;
    private double[] px = new double[pts];
    private double[] py = new double[pts];
    private double[] m = new double[pts];

    private double[] vx = new double[pts];
    private double[] vy = new double[pts];

    private double[] sx = new double[pts];
    private double[] sy = new double[pts];
    
    private double dscl = 1;
    private double eps = 10;
    private double dt = 0.000001;
    
    private uint32 color;

    public SDLSample () {
        this.rand = new GLib.Rand();
        this.color = rand.next_int();
    }

    public void run () {
        this.screen = Screen.set_video_mode(SCREEN_WIDTH, SCREEN_HEIGHT, SCREEN_BPP, 0);
        
        if (this.screen == null) {
            stderr.printf ("Could not set video mode.\n");
        }

        SDL.WindowManager.set_caption("NBodySimulation", "");
        
        for(int i=0; i < pts; i++) {
	    /* for random generation
	    px[i] = 1 - rand.next_double() *2;
            py[i] = 1 - rand.next_double() *2;*/
	    
	    double a = Math.PI * 2 / pts * i;
            px[i] = Math.cos(a);
            py[i] = Math.sin(a);
                
            m[i] = rand.int_range(1, 100);

            vx[i] = 0;
            vy[i] = 0;
        }

        while (process_events()) {
	    computation();
            draw ();
            SDL.Timer.delay (DELAY);
        }
    }
    
    private void computation(){
        for(int i=0; i < pts; i++) {
	    double ax = 0;
            double ay = 0;

            for (int j = 0; j < pts; j++) {
		if (i == j){
		    continue;
		}
		
                double dx = px[j] - px[i];
                double dy = py[j] - py[i];
                double dsq = dx * dx + dy * dy;
                double d = Math.sqrt(dsq);
                double f = (m[i] * m[j] * dscl) / (dsq + eps);

                double fx = dx / d * f;
                double fy = dy / d * f;

                ax += fx;
                ay += fy;
            }
            sx[i] = ax;
            sy[i] = ay;
        }
        for (int i = 0; i < pts; i++) {
	    vx[i] += sx[i] / m[i] + dt;
            vy[i] += sy[i] / m[i] + dt;

            px[i] += vx[i] * dt;
            py[i] += vy[i] * dt;
        }
    }
    
    private void draw () {
        screen.fill(null, 0);
        
        double cx = screen.w * 0.5;
        double cy = screen.h * 0.5;

        double scl = Math.fmin(cx, cy) * 0.85;
        double r = 1.5; //radius

        for (int i=0; i < pts; i++) {
	    double x = cx - px[i] * scl;
            double y = cy - py[i] * scl;
            
            Ellipse.fill_rgba(this.screen, (int16)(x - r), (int16)(y - r), (int16)(2 * r), (int16)(2 * r), 50, 50, 100, 100);
        }
		
        this.screen.flip ();
    }
    
    private bool process_events () {
        Event event;
        while (Event.poll (out event) == 1) {
            if (event.type == EventType.QUIT){
                return false;
	    }
        }
        return true;
    }

    public static void main (string[] args) {
        SDL.init (InitFlag.VIDEO);

        var sample = new SDLSample ();
        sample.run ();

        SDL.quit ();
    }
}
