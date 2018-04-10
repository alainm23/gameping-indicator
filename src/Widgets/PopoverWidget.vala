/*
 * Copyright (C) 2018 Alain M. <alain23@protonmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * Authored by Alain M. <alain23@protonmail.com>
 *
 */

public class GamePing.Widgets.PopoverWidget : Gtk.Grid {

	public unowned GamePing.Indicator indicator { get; construct set; }

	private Wingpanel.Widgets.Switch active_switch;

	private GamePing.Services.Ping ping;
	private GamePing.Services.Ping ping_ue;
	private GamePing.Services.Ping ping_uw;
	private GamePing.Services.Ping ping_sa;

	private Gtk.Label peru_ping;
	private Gtk.Label ue_ping;
	private Gtk.Label uw_ping;
	private Gtk.Label sa_ping;

	private Gtk.Grid main_grid;
	private Gtk.Revealer main_revealer;

	private bool active = true;

	public PopoverWidget () {

		orientation = Gtk.Orientation.VERTICAL;
			
		ping = new GamePing.Services.Ping ();
		ping_ue = new GamePing.Services.Ping ();
		ping_uw = new GamePing.Services.Ping ();
		ping_sa = new GamePing.Services.Ping ();

		build_ui ();

		go_ip ();
	} 

	private void build_ui () {

		active_switch = new Wingpanel.Widgets.Switch (_("Active"), true);

		var dota2_icon = new Gtk.Image.from_icon_name ("gameping-dota2", Gtk.IconSize.SMALL_TOOLBAR);
		var dota2_label = new Gtk.Label ("Dota 2");
		dota2_label.get_style_context ().add_class ("h3");

		var title_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
		title_box.margin = 12;

		title_box.pack_start (dota2_icon, false, false, 6);
		title_box.pack_start (dota2_label, false, false, 6);

		// Ping Peru
		var peru_label = new Gtk.Label ("Peru");
		peru_label.get_style_context ().add_class ("h3");
		peru_label.halign = Gtk.Align.START;

		peru_ping = new Gtk.Label ("");
		peru_ping.get_style_context ().add_class ("h3");
		peru_ping.halign = Gtk.Align.END;

		var peru_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
		peru_box.margin_start = 32;
		peru_box.margin_right = 12;
		peru_box.homogeneous = true;

		peru_box.pack_start (peru_label);
		peru_box.pack_end (peru_ping);

		// UE

		var ue_label = new Gtk.Label ("US East");
		ue_label.get_style_context ().add_class ("h3");
		ue_label.halign = Gtk.Align.START;

		ue_ping = new Gtk.Label ("");
		ue_ping.get_style_context ().add_class ("h3");
		ue_ping.halign = Gtk.Align.END;

		var ue_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
		ue_box.margin_top = 6;
		ue_box.margin_start = 24;
		ue_box.margin_right = 12;
		ue_box.homogeneous = true;

		ue_box.pack_start (ue_label);
		ue_box.pack_end (ue_ping);

		// UW

		var uw_label = new Gtk.Label ("US West");
		uw_label.get_style_context ().add_class ("h3");
		uw_label.halign = Gtk.Align.START;

		uw_ping = new Gtk.Label ("");
		uw_ping.get_style_context ().add_class ("h3");
		uw_ping.halign = Gtk.Align.END;

		var uw_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
		uw_box.margin_top = 6;
		uw_box.margin_start = 24;
		uw_box.margin_right = 12;
		uw_box.homogeneous = true;

		uw_box.pack_start (uw_label);
		uw_box.pack_end (uw_ping);

		// SA

		var sa_label = new Gtk.Label ("South America");
		sa_label.get_style_context ().add_class ("h3");
		sa_label.halign = Gtk.Align.START;

		sa_ping = new Gtk.Label ("");
		sa_ping.get_style_context ().add_class ("h3");
		sa_ping.halign = Gtk.Align.END;

		var sa_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 0);
		sa_box.margin_top = 6;
		sa_box.margin_start = 24;
		sa_box.margin_right = 12;
		sa_box.homogeneous = true;
		sa_box.margin_bottom = 12;

		sa_box.pack_start (sa_label);
		sa_box.pack_end (sa_ping);

		active_switch.switched.connect ( () => {
			
			if (main_revealer.reveal_child) {

				main_revealer.reveal_child = false;
				active = false;
			}
			 else {
			
				main_revealer.reveal_child = true;
				active = true;

				go_ip ();
			}

		});

		main_grid = new Gtk.Grid ();
		main_grid.orientation = Gtk.Orientation.VERTICAL;

		main_revealer = new Gtk.Revealer ();
		main_revealer.reveal_child = true;
		main_revealer.add (main_grid);


		//main_grid.add (active_switch);
		main_grid.add (new Wingpanel.Widgets.Separator ());
		main_grid.add (title_box);
		main_grid.add (peru_box);
		main_grid.add (ue_box);
		main_grid.add (uw_box);
		main_grid.add (sa_box);

		add (active_switch);
		add (main_revealer);

		show_all ();
	}

	private void go_ip () {

		Timeout.add_seconds (3, () => {

			string peru = ping.get_ping ("191.98.144.1"); 
			peru_ping.label = peru.replace ("\n", "") + " ms";

			string ue = ping_ue.get_ping ("iad.valve.net");
			ue_ping.label = ue.replace ("\n", "") + " ms";
				
			string uw = ping_uw.get_ping ("eat.valve.net");
			uw_ping.label = uw.replace ("\n", "") + " ms";

			string sa = ping_sa.get_ping ("gru.valve.net");
			sa_ping.label = sa.replace ("\n", "") + " ms";
				
			return active;

		});			
	}
}