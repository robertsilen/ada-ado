-----------------------------------------------------------------------
--  ado-schemas-postgresql -- Postgresql Database Schemas
--  Copyright (C) 2018 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with ADO.Connections;
package ADO.Schemas.Postgresql is

   --  Load the database schema
   procedure Load_Schema (C        : in ADO.Connections.Database_Connection'Class;
                          Schema   : out Schema_Definition;
                          Database : in String);

end ADO.Schemas.Postgresql;
