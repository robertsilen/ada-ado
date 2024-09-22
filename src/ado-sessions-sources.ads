-----------------------------------------------------------------------
--  ado-sessions-sources -- Database Sources
--  Copyright (C) 2017, 2019 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------

--  == Connection string ==
--  The database connection string is an URI that specifies the database driver to use as well
--  as the information for the database driver to connect to the database.
--  The driver connection is a string of the form:
--
--    driver://[host][:port]/[database][?property1][=value1]...
--
--  The database connection string is passed to the session factory that maintains connections
--  to the database (see ADO.Sessions.Factory).
--
package ADO.Sessions.Sources is

   --  ------------------------------
   --  The database connection source
   --  ------------------------------
   --  The <b>DataSource</b> is the factory for getting a connection to the database.
   --  It contains the configuration properties to define which database driver must
   --  be used and which connection parameters the driver has to use to establish
   --  the connection.
   type Data_Source is new ADO.Connections.Configuration with private;
   type Data_Source_Access is access all Data_Source'Class;

   --  ------------------------------
   --  Replicated Data Source
   --  ------------------------------
   --  The replicated data source supports a Master/Slave database configuration.
   --  When using this data source, the master is used to execute
   --  update, insert, delete and also query statements.  The slave is used
   --  to execute query statements.  The master and slave are represented by
   --  two separate data sources.  This allows to have a master on one server,
   --  use a specific user/password and get a slave on another server with other
   --  credentials.
   type Replicated_DataSource is new Data_Source with private;
   type Replicated_DataSource_Access is access all Replicated_DataSource'Class;

   --  Set the master data source
   procedure Set_Master (Controller : in out Replicated_DataSource;
                         Master     : in Data_Source_Access);

   --  Get the master data source
   function Get_Master (Controller : in Replicated_DataSource)
                       return Data_Source_Access;

   --  Set the slave data source
   procedure Set_Slave (Controller : in out Replicated_DataSource;
                        Slave      : in Data_Source_Access);

   --  Get the slace data source
   function Get_Slave (Controller : in Replicated_DataSource)
                      return Data_Source_Access;

   --  Get a slave database connection
--   function Get_Slave_Connection (Controller : in Replicated_DataSource)
--                                 return Connection'Class;

private

   type Data_Source is new ADO.Connections.Configuration with null record;

   type Replicated_DataSource is new Data_Source with record
      Master : Data_Source_Access := null;
      Slave  : Data_Source_Access := null;
   end record;

end ADO.Sessions.Sources;
