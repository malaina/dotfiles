--- ion3.el --- Tight integration of emacs with the ion3 window manager

-- Copyright (C) 2005 by Stefan Reichör

-- Filename: ion3-emacs.lua
-- Author: Stefan Reichör, <stefan@xsteve.at>

-- ion3.el is free software; you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation; either version 2, or (at your option)
-- any later version.

-- ion3.el is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.

-- You should have received a copy of the GNU General Public License
-- along with GNU Emacs; see the file COPYING.  If not, write to
-- the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
-- Boston, MA 02111-1307, USA.

--; Commentary

-- ion3-emacs.lua provides the needed code on the ion3 side
-- to make ion3.el work

-- For installation instructions and usage hints see ion3.el

-- Comments / suggestions welcome!

if package.loaded["emacs"] then return end

emacs={}

function emacs.list_clients()
   local l = ioncore.clientwin_list()
   s = ""
   for a,b in l do
      -- print(a,b:name())
      s = s .. b:name() .. "\n"
   end
   return s
end

package.loaded["emacs"]=true

-- Local Variables:
-- mode: ion3
-- End:

-- arch-tag: 66f2416b-e1ae-4749-8db2-1671e2bf7c81
