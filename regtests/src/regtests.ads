-----------------------------------------------------------------------
--  regtests -- Support for unit tests
--  Copyright (C) 2009, 2010, 2017, 2018 Stephane Carrez
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

with ADO.Audits;
with ADO.Sessions;
with ADO.Sessions.Sources;
package Regtests is

   --  Get the database manager to be used for the unit tests
   function Get_Controller return ADO.Sessions.Sources.Data_Source'Class;

   --  Get the readonly connection database to be used for the unit tests
   function Get_Database return ADO.Sessions.Session;

   --  Get the writeable connection database to be used for the unit tests
   function Get_Master_Database return ADO.Sessions.Master_Session;

   --  Set the audit manager on the factory.
   procedure Set_Audit_Manager (Manager : in ADO.Audits.Audit_Manager_Access);

   --  Initialize the test database
   procedure Initialize (Name : in String);

end Regtests;
