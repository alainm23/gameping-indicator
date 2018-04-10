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

public class GamePing.Indicator : Wingpanel.Indicator {
  
    private Wingpanel.Widgets.OverlayIcon? display_widget = null;
    

    private GamePing.Widgets.PopoverWidget? popover_widget = null;


    public Indicator () {
        
        Object (code_name : "com.github.alainm23.gameping-indicator",
                display_name : _("GamePing"), 
                description: _("GamePing Indicator")); 

        visible = true;

        weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
        default_theme.add_resource_path ("/com/github/alainm23/gameping-indicator");
    
    }

    public override Gtk.Widget get_display_widget () {
        
        if (display_widget == null) {

            display_widget = new Wingpanel.Widgets.OverlayIcon ("applications-games-symbolic");
        }

        return display_widget;
    }

    public override Gtk.Widget? get_widget () {

        if (popover_widget == null) {

            popover_widget = new GamePing.Widgets.PopoverWidget ();
        }

        return popover_widget;
    }

    public override void opened () {
    
    }

    public override void closed () {

    }
}

public Wingpanel.Indicator? get_indicator (Module module, Wingpanel.IndicatorManager.ServerType server_type) {

    debug ("Activating Sample Indicator");

    if (server_type != Wingpanel.IndicatorManager.ServerType.SESSION) {
        return null;
    }

    var indicator = new GamePing.Indicator ();

    return indicator;
}
