using Gtk;

public class Main : Gtk.Window{
	private Entry width_entry = new Entry();
	private Entry height_entry = new Entry();
	private Entry dots_count_entry = new Entry();
	private Entry dots_size_entry = new Entry();
	private ColorButton color_button = new ColorButton();
	private CheckButton circle_generation_button = new CheckButton.with_label("Circle generation");

	public Main(){
		this.title = "NbodySimulation Setup";
		this.window_position = Gtk.WindowPosition.CENTER;
		this.set_default_size(300, 190);
		this.resizable = false;
		this.border_width = 10;
		this.destroy.connect(Gtk.main_quit);
		
		width_entry.set_text("1280");
		width_entry.set_placeholder_text("width");

		height_entry.set_text("800");
		height_entry.set_placeholder_text("height");

		dots_count_entry.set_text("700");
		dots_count_entry.set_placeholder_text("count");

		dots_size_entry.set_text("1.5");
		dots_size_entry.set_placeholder_text("size");

		Gdk.RGBA rgba = Gdk.RGBA();
		rgba.red = 0.203922;
		rgba.green = 0.396078;
		rgba.blue = 0.643137;
		rgba.alpha = 1.0;
		color_button.set_rgba(rgba);

		Button show_button = new Button.with_label("Show");
		show_button.clicked.connect(show_button_clicked);

		Grid grid = new Grid();
		grid.set_row_spacing(20);
		grid.set_column_spacing(10);
		this.add(grid);
		
		grid.attach(new Label("Resolution"), 0, 0, 1, 1);
		grid.attach(width_entry, 1, 0, 1, 1);
		grid.attach(new Label("X"), 2, 0, 1, 1);
		grid.attach(height_entry, 3, 0, 1, 1);

		grid.attach(new Label("Dots count"), 0, 1, 1, 1);
		grid.attach(dots_count_entry, 1, 1, 1, 1);

		grid.attach(new Label("Dot size"), 0, 2, 1, 1);
		grid.attach(dots_size_entry, 1, 2, 1, 1);

		grid.attach(new Label("Color"), 0, 3, 1, 1);
		grid.attach(color_button, 1, 3, 1, 1);

		grid.attach(circle_generation_button, 3, 2, 1, 1);

		grid.attach(show_button, 3, 3, 1, 1);
	}

	private void show_button_clicked(){
		int width = int.parse(width_entry.get_text());
		int height = int.parse(height_entry.get_text());
		int dotsCount = int.parse(dots_count_entry.get_text());
		double dotsSize = double.parse(dots_size_entry.get_text());

		width=width==0?1280:width;
		height=height==0?800:height;
		dotsCount=dotsCount==0?700:dotsCount;
		dotsSize=dotsSize==0?1.5:dotsSize;

		Gdk.RGBA rgba = color_button.get_rgba();
		
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
