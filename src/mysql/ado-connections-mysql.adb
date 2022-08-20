-----------------------------------------------------------------------
--  ado-connections-mysql -- MySQL Database connections
--  Copyright (C) 2009, 2010, 2011, 2012, 2013, 2015, 2017, 2018, 2019, 2022 Stephane Carrez
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

with Ada.Task_Identification;
with Ada.Directories;

with Interfaces.C.Strings;
with Util.Log;
with Util.Log.Loggers;
with Util.Properties;
with Util.Processes.Tools;
with ADO.Sessions.Sources;
with ADO.Sessions.Factory;
with ADO.Statements.Mysql;
with ADO.Statements.Create;
with ADO.Schemas.Mysql;
with ADO.Parameters;
with ADO.Queries;
with ADO.C;
with Mysql.Lib; use Mysql.Lib;
package body ADO.Connections.Mysql is

   use ADO.Statements.Mysql;
   use Util.Log;
   use Interfaces.C;

   pragma Linker_Options (MYSQL_LIB_NAME);

   Log : constant Loggers.Logger := Loggers.Create ("ADO.Databases.Mysql");

   Driver_Name : aliased constant String := "mysql";
   Driver      : aliased Mysql_Driver;

   --  ------------------------------
   --  Get the database driver which manages this connection.
   --  ------------------------------
   overriding
   function Get_Driver (Database : in Database_Connection)
                        return ADO.Connections.Driver_Access is
      pragma Unreferenced (Database);
   begin
      return Driver'Access;
   end Get_Driver;

   overriding
   function Create_Statement (Database : in Database_Connection;
                              Table    : in ADO.Schemas.Class_Mapping_Access)
                              return Query_Statement_Access is
   begin
      return Create_Statement (Database => Database.Server, Table => Table);
   end Create_Statement;

   overriding
   function Create_Statement (Database : in Database_Connection;
                              Query    : in String)
                              return Query_Statement_Access is
   begin
      return Create_Statement (Database => Database.Server, Query => Query);
   end Create_Statement;

   --  ------------------------------
   --  Create a delete statement.
   --  ------------------------------
   overriding
   function Create_Statement (Database : in Database_Connection;
                              Table    : in ADO.Schemas.Class_Mapping_Access)
                              return Delete_Statement_Access is
   begin
      return Create_Statement (Database => Database.Server, Table => Table);
   end Create_Statement;

   --  ------------------------------
   --  Create an insert statement.
   --  ------------------------------
   overriding
   function Create_Statement (Database : in Database_Connection;
                              Table    : in ADO.Schemas.Class_Mapping_Access)
                              return Insert_Statement_Access is
   begin
      return Create_Statement (Database => Database.Server, Table => Table);
   end Create_Statement;

   --  ------------------------------
   --  Create an update statement.
   --  ------------------------------
   overriding
   function Create_Statement (Database : in Database_Connection;
                              Table    : in ADO.Schemas.Class_Mapping_Access)
                              return Update_Statement_Access is
   begin
      return Create_Statement (Database => Database.Server, Table => Table);
   end Create_Statement;

   --  ------------------------------
   --  Start a transaction.
   --  ------------------------------
   overriding
   procedure Begin_Transaction (Database : in out Database_Connection) is
   begin
      if Database.Autocommit then
         Database.Execute ("set autocommit=0");
         Database.Autocommit := False;
      end if;
      Database.Execute ("start transaction;");
   end Begin_Transaction;

   --  ------------------------------
   --  Commit the current transaction.
   --  ------------------------------
   overriding
   procedure Commit (Database : in out Database_Connection) is
      Result : char;
   begin
      if Database.Server = null then
         Log.Warn ("Commit while the connection is closed");
         raise ADO.Sessions.Session_Error with "Database connection is closed";
      end if;
      Result := mysql_commit (Database.Server);
      if Result /= nul then
         raise Database_Error with "Cannot commit transaction";
      end if;
   end Commit;

   --  ------------------------------
   --  Rollback the current transaction.
   --  ------------------------------
   overriding
   procedure Rollback (Database : in out Database_Connection) is
      Result : char;
   begin
      if Database.Server = null then
         Log.Warn ("Rollback while the connection is closed");
         raise ADO.Sessions.Session_Error with "Database connection is closed";
      end if;
      Result := mysql_rollback (Database.Server);
      if Result /= nul then
         raise Database_Error with "Cannot rollback transaction";
      end if;
   end Rollback;

   --  ------------------------------
   --  Load the database schema definition for the current database.
   --  ------------------------------
   overriding
   procedure Load_Schema (Database : in Database_Connection;
                          Schema   : out ADO.Schemas.Schema_Definition) is
   begin
      ADO.Schemas.Mysql.Load_Schema (Database, Schema);
   end Load_Schema;

   --  ------------------------------
   --  Check if the table with the given name exists in the database.
   --  ------------------------------
   overriding
   function Has_Table (Database : in Database_Connection;
                       Name     : in String) return Boolean is
      Stmt  : ADO.Statements.Query_Statement
        := Create.Create_Statement
          (Database.Create_Statement
             ("SELECT COUNT(*) FROM information_schema.TABLES "
                & "WHERE TABLE_SCHEMA LIKE :database AND "
                & "TABLE_TYPE LIKE 'BASE TABLE' AND "
                & "TABLE_NAME = :name"));
   begin
      Stmt.Bind_Param ("database", Database.Name);
      Stmt.Bind_Param ("name", Name);
      Stmt.Execute;

      return Stmt.Get_Result_Integer > 0;
   end Has_Table;

   --  ------------------------------
   --  Execute a simple SQL statement
   --  ------------------------------
   procedure Execute (Database : in out Database_Connection;
                      SQL      : in Query_String) is
      SQL_Stat  : constant ADO.C.String_Ptr := ADO.C.To_String_Ptr (SQL);
      Result    : int;
   begin
      Log.Debug ("Execute SQL: {0}", SQL);
      if Database.Server = null then
         Log.Warn ("Database connection is not open");
         raise ADO.Sessions.Session_Error with "Database connection is closed";
      end if;

      Result := Mysql_Query (Database.Server, ADO.C.To_C (SQL_Stat));
      if Result /= 0 then
         declare
            Error : constant Strings.chars_ptr := Mysql_Error (Database.Server);
            Msg   : constant String := Strings.Value (Error);
         begin
            Log.Error ("Error: {0}", Msg);
            raise ADO.Statements.SQL_Error with "SQL error: " & Msg;
         end;
      end if;
   end Execute;

   --  ------------------------------
   --  Closes the database connection
   --  ------------------------------
   overriding
   procedure Close (Database : in out Database_Connection) is
   begin
      if Database.Server /= null then
         Log.Info ("Closing connection {0}/{1}", Database.Name, Database.Ident);

         mysql_close (Database.Server);
         Database.Server := null;
      end if;
   end Close;

   --  ------------------------------
   --  Releases the mysql connection if it is open
   --  ------------------------------
   overriding
   procedure Finalize (Database : in out Database_Connection) is
   begin
      Log.Debug ("Release connection {0}/{1}", Database.Name, Database.Ident);
      Database.Close;
   end Finalize;

   --  ------------------------------
   --  Initialize the database connection manager.
   --
   --  mysql://localhost:3306/db
   --
   --  ------------------------------
   procedure Create_Connection (D      : in out Mysql_Driver;
                                Config : in Configuration'Class;
                                Result : in out Ref.Ref'Class) is

      Host     : constant ADO.C.String_Ptr := ADO.C.To_String_Ptr (Config.Get_Server);
      Name     : constant ADO.C.String_Ptr := ADO.C.To_String_Ptr (Config.Get_Database);
      Login    : constant ADO.C.String_Ptr := ADO.C.To_String_Ptr (Config.Get_Property ("user"));
      Password : constant ADO.C.String_Ptr := C.To_String_Ptr (Config.Get_Property ("password"));
      Socket   : ADO.C.String_Ptr;
      Port     : unsigned := unsigned (Config.Get_Port);
      Flags    : constant unsigned_long := 0;
      Connection : Mysql_Access;

      Socket_Path : constant String := Config.Get_Property ("socket");
      Server      : Mysql_Access;
   begin
      if Socket_Path /= "" then
         ADO.C.Set_String (Socket, Socket_Path);
      end if;
      if Port = 0 then
         Port := 3306;
      end if;

      Log.Info ("Task {0} connecting to {1}:{2}",
                Ada.Task_Identification.Image (Ada.Task_Identification.Current_Task),
                Config.Get_Server, Config.Get_Database);
      if Config.Get_Property ("password") = "" then
         Log.Debug ("MySQL connection with user={0}", Config.Get_Property ("user"));
      else
         Log.Debug ("MySQL connection with user={0} password=XXXXXXXX",
                    Config.Get_Property ("user"));
      end if;
      Connection := mysql_init (null);

      Server := mysql_real_connect (Connection, ADO.C.To_C (Host),
                                    ADO.C.To_C (Login), ADO.C.To_C (Password),
                                    ADO.C.To_C (Name), Port, ADO.C.To_C (Socket), Flags);

      if Server = null then
         declare
            Message : constant String := Strings.Value (Mysql_Error (Connection));
         begin
            Log.Error ("Cannot connect to '{0}': {1}", Config.Get_Log_URI, Message);
            mysql_close (Connection);
            raise ADO.Configs.Connection_Error with "Cannot connect to mysql server: " & Message;
         end;
      end if;

      D.Id := D.Id + 1;
      declare
         Ident    : constant String := Util.Strings.Image (D.Id);
         Database : constant Database_Connection_Access := new Database_Connection;

         procedure Configure (Name : in String;
                              Item : in Util.Properties.Value);
         function Is_Number (Value : in String) return Boolean is
            (for all C of Value => C >= '0' and C <= '9');

         procedure Configure (Name : in String;
                              Item : in Util.Properties.Value) is
            Value : constant String := Util.Properties.To_String (Item);
         begin
            if Name = "encoding" then
               Database.Execute ("SET NAMES " & Value);
               Database.Execute ("SET CHARACTER SET " & Value);
               Database.Execute ("SET CHARACTER_SET_SERVER = '" & Value & "'");
               Database.Execute ("SET CHARACTER_SET_DATABASE = '" & Value & "'");

            elsif Util.Strings.Index (Name, '.') = 0
              and Name /= "user" and Name /= "password" and Name /= "socket"
            then
               if Is_Number (Value) then
                  Database.Execute ("SET " & Name & "=" & Value);
               else
                  Database.Execute ("SET " & Name & "='" & Value & "'");
               end if;
            end if;
         end Configure;

      begin
         Database.Ident (1 .. Ident'Length) := Ident;
         Database.Server := Server;
         Database.Name   := To_Unbounded_String (Config.Get_Database);

         --  Configure the connection by setting up the MySQL 'SET X=Y' SQL commands.
         --  Typical configuration includes:
         --    encoding=utf8
         --    collation_connection=utf8_general_ci
         Config.Iterate (Process => Configure'Access);

         Result := Ref.Create (Database.all'Access);
      end;
   end Create_Connection;

   --  ------------------------------
   --  Create the database and initialize it with the schema SQL file.
   --  The `Admin` parameter describes the database connection with administrator access.
   --  The `Config` parameter describes the target database connection.
   --  ------------------------------
   overriding
   procedure Create_Database (D           : in out Mysql_Driver;
                              Admin       : in Configs.Configuration'Class;
                              Config      : in Configs.Configuration'Class;
                              Schema_Path : in String;
                              Messages    : out Util.Strings.Vectors.Vector) is
      pragma Unreferenced (D);

      --  Create the MySQL tables in the database.  The tables are created by launching
      --  the external command 'mysql' and using the create-xxx-mysql.sql generated scripts.
      procedure Create_Mysql_Tables (Path   : in String;
                                     Config : in Configs.Configuration'Class);

      --  Create the database identified by the given name.
      procedure Create_Database (DB   : in ADO.Sessions.Master_Session;
                                 Name : in String);

      --  Create the user and grant him access to the database.
      procedure Create_User_Grant (DB       : in ADO.Sessions.Master_Session;
                                   Name     : in String;
                                   User     : in String;
                                   Password : in String);

      --  ------------------------------
      --  Check if the database with the given name exists.
      --  ------------------------------
      function Has_Database (DB   : in ADO.Sessions.Session'Class;
                             Name : in String) return Boolean is
         Stmt  : ADO.Statements.Query_Statement;
      begin
         Stmt := DB.Create_Statement ("SHOW DATABASES");
         Stmt.Execute;
         while Stmt.Has_Elements loop
            declare
               D : constant String := Stmt.Get_String (0);
            begin
               if Name = D then
                  return True;
               end if;
            end;
            Stmt.Next;
         end loop;
         return False;
      end Has_Database;

      --  ------------------------------
      --  Check if the database with the given name has some tables.
      --  ------------------------------
      function Has_Tables (DB   : in ADO.Sessions.Session'Class;
                           Name : in String) return Boolean is
         Stmt  : ADO.Statements.Query_Statement;
      begin
         Stmt := DB.Create_Statement ("SHOW TABLES FROM `:name`");
         Stmt.Bind_Param ("name", ADO.Parameters.Token (Name));
         Stmt.Execute;
         return Stmt.Has_Elements;
      end Has_Tables;

      --  ------------------------------
      --  Create the database identified by the given name.
      --  ------------------------------
      procedure Create_Database (DB   : in ADO.Sessions.Master_Session;
                                 Name : in String) is
         Stmt  : ADO.Statements.Query_Statement;
      begin
         Log.Info ("Creating database '{0}'", Name);

         Stmt := DB.Create_Statement ("CREATE DATABASE `:name`");
         Stmt.Bind_Param ("name", ADO.Parameters.Token (Name));
         Stmt.Execute;
      end Create_Database;

      --  ------------------------------
      --  Create the user and grant him access to the database.
      --  ------------------------------
      procedure Create_User_Grant (DB       : in ADO.Sessions.Master_Session;
                                   Name     : in String;
                                   User     : in String;
                                   Password : in String) is
         Query : ADO.Queries.Context;
         Stmt  : ADO.Statements.Query_Statement;
      begin
         Log.Info ("Granting access for user '{0}' to database '{1}'", User, Name);

         if Password'Length > 0 then
            Query.Set_SQL ("GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, "
                           & "CREATE TEMPORARY TABLES, EXECUTE, SHOW VIEW ON "
                           & "`:name`.* to `:user`@'localhost' IDENTIFIED BY :password");
         else
            Query.Set_SQL ("GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, "
                           & "CREATE TEMPORARY TABLES, EXECUTE, SHOW VIEW ON "
                           & "`:name`.* to `:user`@'localhost'");
         end if;

         Stmt := DB.Create_Statement (Query);
         Stmt.Bind_Param ("name", ADO.Parameters.Token (Name));
         Stmt.Bind_Param ("user", ADO.Parameters.Token (User));
         if Password'Length > 0 then
            Stmt.Bind_Param ("password", Password);
         end if;
         Stmt.Execute;

         Stmt := DB.Create_Statement ("FLUSH PRIVILEGES");
         Stmt.Execute;
      end Create_User_Grant;

      --  ------------------------------
      --  Create the MySQL tables in the database.  The tables are created by launching
      --  the external command 'mysql' and using the create-xxx-mysql.sql generated scripts.
      --  ------------------------------
      procedure Create_Mysql_Tables (Path   : in String;
                                     Config : in Configs.Configuration'Class) is
         Database : constant String := Config.Get_Database;
         Username : constant String := Config.Get_Property ("user");
         Password : constant String := Config.Get_Property ("password");
         Status   : Integer;
      begin
         Log.Info ("Creating database tables using schema '{0}'", Path);

         if not Ada.Directories.Exists (Path) then
            Log.Error ("SQL file '{0}' does not exist.", Path);
            Log.Error ("Please, run the following command: dynamo generate db");
            return;
         end if;

         if Password'Length > 0 then
            Util.Processes.Tools.Execute ("mysql --user='" & Username & "' --password='"
                                          & Password & "' "
                                          & Database, Path, Messages, Status);
         else
            Util.Processes.Tools.Execute ("mysql --user='" & Username & "' "
                                          & Database, Path, Messages, Status);
         end if;
      end Create_Mysql_Tables;

      Factory : ADO.Sessions.Factory.Session_Factory;
   begin
      Log.Info ("Connecting to {0} for database setup", Admin.Get_Log_URI);

      --  Initialize the session factory to connect to the
      --  database defined by root connection (which should allow the database creation).
      Factory.Create (ADO.Sessions.Sources.Data_Source (Admin));

      declare
         DB   : constant ADO.Sessions.Master_Session := Factory.Get_Master_Session;
      begin
         --  Create the database only if it does not already exists.
         if not Has_Database (DB, Config.Get_Database) then
            Create_Database (DB, Config.Get_Database);
         end if;

         --  If some tables exist, don't try to create tables again.
         --  We could improve by reading the current database schema, comparing with our
         --  schema and create what is missing (new tables, new columns).
         if Has_Tables (DB, Config.Get_Database) then
            Log.Error ("The database {0} exists", Config.Get_Database);
         else
            if "" /= Config.Get_Property ("user") then
               --  Create the user grant.  On MySQL, it is safe to do this several times.
               Create_User_Grant (DB, Config.Get_Database,
                                  Config.Get_Property ("user"),
                                  Config.Get_Property ("password"));
            end if;

            --  And now create the tables by using the SQL script.
            Create_Mysql_Tables (Schema_Path, Config);
         end if;
      end;
   end Create_Database;

   --  ------------------------------
   --  Initialize the Mysql driver.
   --  ------------------------------
   procedure Initialize is
      use type Util.Strings.Name_Access;
   begin
      Log.Debug ("Initializing mysql driver");

      if Driver.Name = null then
         Driver.Name := Driver_Name'Access;
         Register (Driver'Access);
      end if;
   end Initialize;

   --  ------------------------------
   --  Deletes the Mysql driver.
   --  ------------------------------
   overriding
   procedure Finalize (D : in out Mysql_Driver) is
      pragma Unreferenced (D);
   begin
      Log.Debug ("Deleting the mysql driver");

      mysql_server_end;
   end Finalize;

end ADO.Connections.Mysql;
