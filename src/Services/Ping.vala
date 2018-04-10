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
 
public class GamePing.Services.Ping {

	string ping_out;

	public Ping () {

	}

	public string get_ping (string ip) {

		
	
		Thread<void*> thread = new Thread<void*>.try("Conntections Thread.", () => {
			
			try {		
				
				string command = "sh -c \"ping -c 1 %s | cut -d '/' -s -f5\"".printf(ip);

				Process.spawn_command_line_sync (command, out ping_out);	
					
				//return ping_out;

			} catch (IOChannelError e) {
				stdout.printf ("IOChannelError: %s\n", e.message);
			} catch (ConvertError e) {
				stdout.printf ("ConvertError: %s\n", e.message);
			}

			return null;
		});

		return ping_out;  
	}
}