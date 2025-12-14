if (!("Entities" in this)) return;

IncludeScript("ppmod");

class TextQueue
{
	font_size = null;
	pos_x = null;
	pos_y = null;
	display_time = null;
	default_color = null;

	text_queue = null;
	color_queue = null;

	constructor (x = 0.025, y = 0.05, size = 0, time = 4, default_color = "250 232 182") {
		this.font_size = size;
		this.pos_x = x;
		this.pos_y = y;
		this.display_time = time;
		this.text_queue = [];
		this.color_queue = [];
		this.default_color = default_color;
	}

	function AddToQueue(text, color = null) {
		this.text_queue.append(text);
		if (color) {
			this.color_queue.append(color);
		} else {
			this.color_queue.append(this.default_color)
		}
	}

	function DisplayQueueMessage() {
		if (this.text_queue.len() == 0) {
			return
		}
		local text = this.text_queue[0];
		this.text_queue.remove(0);
		local color = this.color_queue[0];
		this.color_queue.remove(0);

		local dt = ppmod.text(text, this.pos_x, this.pos_y);
		dt.SetColor(color);
		dt.SetSize(this.font_size);
		dt.SetFade(0.1, 0.1);
		dt.Display(this.display_time);
	}
}