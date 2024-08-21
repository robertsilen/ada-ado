-----------------------------------------------------------------------
--  ado-postgresql -- PostgreSQL Database Drivers
--  Copyright (C) 2019 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--
--  Licensed under the Apache License, Version 2.0 (the "License");
--  you may not use this file except in compliance with the License.
--  You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
--  Unless required by applicable law or agreed to in writing, software
--  distributed under the License is distributed on an "AS IS" BASIS,
--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--  See the License for the specific language governing permissions and
--  limitations under the License.
-----------------------------------------------------------------------

with ADO.Configs;
with ADO.Connections.Postgresql;

package body ADO.Postgresql is
   --  ------------------------------
   --  Initialize the Postgresql driver.
   --  ------------------------------
   procedure Initialize is
   begin
      ADO.Connections.Postgresql.Initialize;
   end Initialize;

   --  ------------------------------
   --  Initialize the drivers and the library by reading the property file
   --  and configure the runtime with it.
   --  ------------------------------
   procedure Initialize (Config : in String) is
   begin
      ADO.Configs.Initialize (Config);
      ADO.Connections.Postgresql.Initialize;
   end Initialize;

   --  ------------------------------
   --  Initialize the drivers and the library and configure the runtime with the given properties.
   --  ------------------------------
   procedure Initialize (Config : in Util.Properties.Manager'Class) is
   begin
      ADO.Configs.Initialize (Config);
      ADO.Connections.Postgresql.Initialize;
   end Initialize;

end ADO.Postgresql;
