if (!("Entities" in this)) return;

IncludeScript("ppmod");

class TextQueue
{
	font_size = null;
	pos_x = null;
	pos_y = null;
	display_time = null;

	text_queue = null;

	constructor (x = 0.05, y = 0.05, size = 2, time = 4) {
		this.font_size = size;
		this.pos_x = x;
		this.pos_y = y;
		this.display_time = time;
		this.text_queue = [];
	}

	function AddToQueue(text) {
		this.text_queue.append(text);
	}

	function DisplayQueueMessage() {
		if (this.text_queue.len() == 0) {
			return
		}
		local text = this.text_queue[0];
		this.text_queue.remove(0);

		local dt = ppmod.text(text, this.pos_x, this.pos_y);
		dt.SetColor("250 232 182");
		dt.SetFade(0.1, 0.5, true);
		dt.Display(this.display_time);
	}
}