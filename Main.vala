using Gtk;

public class Main : Gtk.Window{
	private Entry widthEntry = new Entry();
	private Entry heightEntry = new Entry();
	private Entry dotsCountEntry = new Entry();
	private Entry dotsSizeEntry = new Entry();
	private ColorButton colorButton = new ColorButton();
	private CheckButton circle_generation_button = new CheckButton.with_label("Circle generation");

	public Main(){
		this.title = "NbodySimulation Setup";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.set_default_size(300, 190);
		this.resizable = false;
		this.border_width = 10;
		this.destroy.connect(Gtk.main_quit);
		
		widthEntry.set_text("1280");
		widthEntry.set_placeholder_text("width");

		heightEntry.set_text("800");
		heightEntry.set_placeholder_text("height");

		dotsCountEntry.set_text("700");
		dotsCountEntry.set_placeholder_text("count");

		dotsSizeEntry.set_text("1.5");
		dotsSizeEntry.set_placeholder_text("size");

		Gdk.RGBA rgba = Gdk.RGBA();
		rgba.red = 0.203922;
		rgba.green = 0.396078;
		rgba.blue = 0.643137;
		rgba.alpha = 1.0;
		colorButton.set_rgba(rgba);

		Button showButton = new Button.with_label("Show");
		showButton.clicked.connect(show_button_clicked);

		Grid grid = new Grid();
		grid.set_row_spacing(20);
		grid.set_column_spacing(10);
		this.add(grid);
		
		grid.attach(new Label("Resolution"), 0, 0, 1, 1);
		grid.attach(widthEntry, 1, 0, 1, 1);
		grid.attach(new Label("X"), 2, 0, 1, 1);
		grid.attach(heightEntry, 3, 0, 1, 1);

		grid.attach(new Label("Dots count"), 0, 1, 1, 1);
		grid.attach(dotsCountEntry, 1, 1, 1, 1);

		grid.attach(new Label("Dot size"), 0, 2, 1, 1);
		grid.attach(dotsSizeEntry, 1, 2, 1, 1);

		grid.attach(new Label("Color"), 0, 3, 1, 1);
		grid.attach(colorButton, 1, 3, 1, 1);

		grid.attach(circle_generation_button, 3, 2, 1, 1);

		grid.attach(showButton, 3, 3, 1, 1);
	}

	private void show_button_clicked(){
		int width = int.parse(widthEntry.get_text());
		int height = int.parse(heightEntry.get_text());
		int dotsCount = int.parse(dotsCountEntry.get_text());
		double dotsSize = double.parse(dotsSizeEntry.get_text());

		width=width==0?1280:width;
		height=height==0?800:height;
		dotsCount=dotsCount==0?700:dotsCount;
		dotsSize=dotsSize==0?1.5:dotsSize;

		Gdk.RGBA rgba = colorButton.get_rgba();
		
		new SDLWindow(width, height, dotsCount, dotsSize, circle_generation_button.get_active(),
			(uchar)(rgba.red*255), (uchar)(rgba.green*255), (uchar)(rgba.blue*255), (uchar)(rgba.alpha*255)).run();
	}

	public static void main(string[] args){
		Gtk.init(ref args);

		var window = new Main();
		window.show_all();

		Gtk.main();
	}
}
