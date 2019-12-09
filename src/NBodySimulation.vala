using SDL;
using SDLGraphics;

public class NBodySimulation{
	private unowned SDL.Screen screen;

    private GLib.Rand rand;
    
    private int pts;
    private double[] px;
    private double[] py;
    private double[] m;

    private double[] vx;
    private double[] vy;

    private double[] sx;
    private double[] sy;
    
    private double dscl = 1;
    private double eps = 10;
    private double dt = 0.000001;

	private double dot_size;

	private uchar r;
	private uchar g;
	private uchar b;
	private uchar a;

    public NBodySimulation (SDL.Screen screen, int dots_count, double dot_size, bool circleGeneration, uchar r, uchar g, uchar b, uchar a) {
		this.screen = screen;
		this.pts = dots_count;
		this.dot_size = dot_size;

		this.r = r;
		this.g = g;
		this.b = b;
		this.a = a;

		px = new double[pts];
		py = new double[pts];
		m = new double[pts];

		vx = new double[pts];
		vy = new double[pts];
		
		sx = new double[pts];
		sy = new double[pts];

        this.rand = new GLib.Rand();

		for(int i=0; i < pts; i++) {
			if(circleGeneration){
				double a1 = Math.PI * 2 / pts * i;
            	px[i] = Math.cos(a1);
            	py[i] = Math.sin(a1);
			}
			else{
				px[i] = 1 - rand.next_double() *2;
            	py[i] = 1 - rand.next_double() *2;
			}
   
            m[i] = rand.int_range(1, 100);

            vx[i] = 0;
            vy[i] = 0;
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
    
    public void draw () {
		computation();

        screen.fill(null, 0);
        
        double cx = screen.w * 0.5;
        double cy = screen.h * 0.5;

        double scl = Math.fmin(cx, cy) * 0.85;
        double rad = dot_size;

        for (int i=0; i < pts; i++) {
	    	double x = cx - px[i] * scl;
            double y = cy - py[i] * scl;
            
            Ellipse.fill_rgba(this.screen, (int16)(x - rad), (int16)(y - rad), (int16)(2 * rad), (int16)(2 * rad), r, g, b, a);
        }
		
        this.screen.flip ();
    }
}
