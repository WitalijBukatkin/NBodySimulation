using Gtk;

public class Main : Window{
	private Entry dots_count_entry;
	private Entry dots_size_entry;

	private ColorButton color_button;
	private CheckButton circle_generation_button;
	
	private int width;
	private int height;

	public Main(){
		this.title = "NbodySimulation Setup";
		this.window_position = WindowPosition.CENTER;
		this.set_default_size(300, 190);
		this.resizable = false;
		this.border_width = 10;
		this.destroy.connect(main_quit);
		this.add(get_grid());

		Gdk.Rectangle workarea = Gdk.Display.get_default().get_primary_monitor().get_workarea();
		this.width = workarea.width;
		this.height = workarea.height;
	}

	private Entry get_dots_count_entry(){
		this.dots_count_entry = new Entry();
		dots_count_entry.set_text("700");
		dots_count_entry.set_placeholder_text("count");
		return dots_count_entry;
	}

	private Entry get_dots_size_entry(){
		this.dots_size_entry = new Entry();
		dots_size_entry.set_text("1.5");
		dots_size_entry.set_placeholder_text("size");
		return dots_size_entry;
	}

	private ColorButton get_color_button(){
		Gdk.RGBA rgba = Gdk.RGBA();
		rgba.red = 0.203922;
		rgba.green = 0.396078;
		rgba.blue = 0.643137;
		rgba.alpha = 1.0;
		this.color_button = new ColorButton();
		color_button.set_rgba(rgba);
		return color_button;
	}

	private CheckButton get_circle_generation_button(){
		this.circle_generation_button = new CheckButton.with_label("Circle generation");
		return circle_generation_button;
	}

	private Button get_show_button(){
		Button show_button = new Button.with_label("Show");
		show_button.clicked.connect(show_button_clicked);
		return show_button;
	}

	private Grid get_grid(){
		Grid grid = new Grid();
		grid.set_row_spacing(20);
		grid.set_column_spacing(10);

		grid.attach(new Label("Dots count"), 0, 1, 1, 1);
		grid.attach(get_dots_count_entry(), 1, 1, 1, 1);

		grid.attach(new Label("Dot size"), 0, 2, 1, 1);
		grid.attach(get_dots_size_entry(), 1, 2, 1, 1);

		grid.attach(new Label("Color"), 0, 3, 1, 1);
		grid.attach(get_color_button(), 1, 3, 1, 1);

		grid.attach(get_circle_generation_button(), 3, 2, 1, 1);

		grid.attach(get_show_button(), 3, 3, 1, 1);
		return grid;
	}

	private void show_button_clicked(){
		int dotsCount = int.parse(dots_count_entry.get_text());
		double dotsSize = double.parse(dots_size_entry.get_text());

		dotsCount = dotsCount == 0 ? 700 : dotsCount;
		dotsSize = dotsSize == 0 ? 1.5 : dotsSize;

		Gdk.RGBA rgba = color_button.get_rgba();
		
		new SDLWindow(width, height, dotsCount, dotsSize,
				circle_generation_button.get_active(),
				(uchar)(rgba.red * 255),
				(uchar)(rgba.green * 255),
				(uchar)(rgba.blue * 255),
				(uchar)(rgba.alpha * 255))
			.run();
	}

	public static void main(string[] args){
		Gtk.init(ref args);

		new Main().show_all();

		Gtk.main();
	}
}
