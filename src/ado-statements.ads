-----------------------------------------------------------------------
--  ado-statements -- Database statements
--  Copyright (C) 2009 - 2021 Stephane Carrez
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

with Ada.Strings.Unbounded;
with Ada.Finalization;
with Ada.Calendar;

with ADO.Schemas;
with ADO.Parameters;
with ADO.SQL;
with ADO.Objects;
private with Ada.Unchecked_Conversion;
private with System;
private with Interfaces.C;
private with Interfaces.C.Strings;

--  = Database Statements =
--  The `ADO.Statements` package provides high level operations to construct database
--  statements and execute them.  They allow to represent SQL statements (prepared or not)
--  and provide support to execute them and retreive their result.  The SQL statements are
--  represented by several Ada types depending on their behavior:
--
--  * The `Statement` type represents the base type for all the SQL statements.
--  * The `Query_Statement` type is intended to be used for database query statements
--    and provides additional operations to retrieve results.
--  * The `Update_Statement` type targets the database update statements and it
--    provides specific operations to update fields.  The `Insert_Statement`
--    extends the `Update_Statement` type and is intended for database insertion.
--  * The `Delete_Statement` type is intended to be used to remove elements
--    from the database.
--
--  The database statements are created by using the database session and by providing
--  the SQL or the named query to be used.
--
--  @include ado-parameters.ads
--
--  == Query Statements ==
--  The database query statement is represented by the `Query_Statement` type.
--  The `Create_Statement` operation is provided on the `Session` type
--  and it gets the SQL to execute as parameter.  For example:
--
--    Stmt : ADO.Statements.Query_Statement := Session.Create_Statement
--              ("SELECT * FROM user WHERE name = :name");
--
--  After the creation of the query statement, the parameters for the SQL query are provided
--  by using either the `Bind_Param` or `Add_Param` procedures as follows:
--
--    Stmt.Bind_Param ("name", name);
--
--  Once all the parameters are defined, the query statement is executed by calling the
--  `Execute` procedure:
--
--    Stmt.Execute;
--
--  Several operations are provided to retrieve the result.  First, the `Has_Elements`
--  function will indicate whether some database rows are available in the result.  It is then
--  possible to retrieve each row and proceed to the next one by calling the `Next`
--  procedure.  The number of rows is also returned by the `Get_Row_Count` function.
--  A simple loop to iterate over the query result looks like:
--
--    while Stmt.Has_Elements loop
--       Id := Stmt.Get_Identifier (1);
--       ...
--       Stmt.Next;
--    end loop;
--
--  @include ado-queries.ads
package ADO.Statements is

   use Ada.Strings.Unbounded;

   Invalid_Statement : exception;

   --  Exception raised when an SQL statement failed.
   SQL_Error         : exception;

   --  Exception raised when a column number is invalid.
   Invalid_Column    : exception;

   --  Exception raised when a value cannot be converted to the target type.
   Invalid_Type      : exception;

   --  ---------
   --  SQL statement
   --  ---------
   --  The SQL statement
   --
   type Statement is abstract new ADO.Parameters.Abstract_List with private;
   type Statement_Access is access all Statement'Class;

   function Get_Query (Query : Statement) return ADO.SQL.Query_Access;

   procedure Add_Parameter (Query : in out Statement;
                            Param : in ADO.Parameters.Parameter);

   procedure Set_Parameters (Query : in out Statement;
                             From  : in ADO.Parameters.Abstract_List'Class);

   --  Return the number of parameters in the list.
   function Length (Query : in Statement) return Natural;

   --  Return the parameter at the given position
   function Element (Query    : in Statement;
                     Position : in Natural) return ADO.Parameters.Parameter;

   --  Execute the <b>Process</b> procedure with the given parameter as argument.
   procedure Query_Element (Query    : in Statement;
                            Position : in Natural;
                            Process  : not null access
                              procedure (Element : in ADO.Parameters.Parameter));

   --  Clear the list of parameters.
   procedure Clear (Query : in out Statement);

   subtype Query_String is String;

   procedure Add_Param (Params : in out Statement;
                        Value : in ADO.Objects.Object_Key);

   --  Add the parameter by using the primary key of the object.
   --  Use null if the object is a null reference.
   procedure Add_Param (Params : in out Statement;
                        Value  : in ADO.Objects.Object_Ref'Class);

   --  Operations to build the SQL query
   procedure Append (Query : in out Statement; SQL : in String);
   procedure Append (Query : in out Statement; SQL : in Unbounded_String);
   procedure Append (Query : in out Statement; Value : in Integer);
   procedure Append (Query : in out Statement; Value : in Long_Integer);

   --  Append the value to the SQL query string.
   procedure Append_Escape (Query : in out Statement; Value : in String);

   --  Append the value to the SQL query string.
   procedure Append_Escape (Query : in out Statement;
                            Value : in Unbounded_String);

   procedure Set_Filter (Query : in out Statement;
                         Filter : in String);

   --  Execute the query
   procedure Execute (Query : in out Statement) is abstract;

   --  ------------------------------
   --  An SQL query statement
   --
   --  The Query_Statement provides operations to retrieve the
   --  results after execution of the query.
   --  ------------------------------
   type Query_Statement is new Statement with private;
   type Query_Statement_Access is access all Query_Statement'Class;

   --  Execute the query
   overriding
   procedure Execute (Query : in out Query_Statement);

   --  Get the number of rows returned by the query
   function Get_Row_Count (Query : in Query_Statement) return Natural;

   --  Returns True if there is more data (row) to fetch
   function Has_Elements (Query : in Query_Statement) return Boolean;

   --  Fetch the next row
   procedure Next (Query : in out Query_Statement);

   --  Returns true if the column <b>Column</b> is null.
   function Is_Null (Query  : in Query_Statement;
                     Column : in Natural) return Boolean;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Int64</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Int64 (Query  : Query_Statement;
                       Column : Natural) return Int64;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Identifier</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Identifier (Query  : Query_Statement;
                            Column : Natural) return Identifier;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Integer</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Integer (Query  : Query_Statement;
                         Column : Natural) return Integer;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Integer</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Natural (Query  : in Query_Statement;
                         Column : in Natural) return Natural;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Nullable_Integer</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Nullable_Integer (Query  : Query_Statement;
                                  Column : Natural) return Nullable_Integer;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Float</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Float (Query  : Query_Statement;
                       Column : Natural) return Float;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Long_Float</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Long_Float (Query  : Query_Statement;
                            Column : Natural) return Long_Float;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Boolean</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Boolean (Query  : Query_Statement;
                         Column : Natural) return Boolean;

   --  Get the column value at position <b>Column</b> and
   --  return it as a <b>Nullable_Boolean</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Nullable_Boolean (Query  : Query_Statement;
                                  Column : Natural) return Nullable_Boolean;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Unbounded_String</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Unbounded_String (Query  : Query_Statement;
                                  Column : Natural) return Unbounded_String;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Nullable_String</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Nullable_String (Query  : Query_Statement;
                                 Column : Natural) return Nullable_String;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Unbounded_String</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_String (Query : Query_Statement;
                        Column : Natural) return String;

   --  Get the column value at position <b>Column</b> and
   --  return it as a <b>Blob</b> reference.
   function Get_Blob (Query  : in Query_Statement;
                      Column : in Natural) return ADO.Blob_Ref;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Time</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Time (Query  : Query_Statement;
                      Column : Natural) return Ada.Calendar.Time;

   --  Get the column value at position <b>Column</b> and
   --  return it as a <b>Nullable_Time</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Nullable_Time (Query  : Query_Statement;
                               Column : Natural) return Nullable_Time;

   --  Get the column value at position <b>Column</b> and
   --  return it as an <b>Nullable_Entity_Type</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Nullable_Entity_Type (Query  : Query_Statement;
                                      Column : Natural) return Nullable_Entity_Type;

   --  Get the column type
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Column_Type (Query  : Query_Statement;
                             Column : Natural)
                             return ADO.Schemas.Column_Type;

   --  Get the column name.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Column_Name (Query  : in Query_Statement;
                             Column : in Natural)
                             return String;

   --  Get the number of columns in the result.
   function Get_Column_Count (Query  : in Query_Statement)
                             return Natural;

   --  Get the query result as an integer
   function Get_Result_Integer (Query : in Query_Statement) return Integer;

   --  Get the query result as an blob.
   function Get_Result_Blob (Query : in Query_Statement) return ADO.Blob_Ref;

   --  ------------------------------
   --  Delete statement
   --  ------------------------------
   type Delete_Statement is new Statement with private;
   type Delete_Statement_Access is access all Delete_Statement'Class;

   --  Execute the delete query.
   overriding
   procedure Execute (Query  : in out Delete_Statement);

   --  Execute the delete query.
   --  Returns the number of rows deleted.
   procedure Execute (Query  : in out Delete_Statement;
                      Result : out Natural);

   --  ------------------------------
   --  Update statement
   --  ------------------------------
   type Update_Statement is new Statement with private;
   type Update_Statement_Access is access all Update_Statement'Class;

   --  Get the update query object associated with this update statement.
   function Get_Update_Query (Update : in Update_Statement)
                              return ADO.SQL.Update_Query_Access;

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Boolean);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Nullable_Boolean);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Integer);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Nullable_Integer);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Long_Long_Integer);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Float);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Long_Float);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Identifier);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Entity_Type);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Nullable_Entity_Type);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Ada.Calendar.Time);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Nullable_Time);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in String);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Unbounded_String);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in Nullable_String);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in ADO.Objects.Object_Key);

   --  Prepare the update/insert query to save the table field.
   --  identified by <b>Name</b> and set it to the identifier key held by <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in ADO.Objects.Object_Ref'Class);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   procedure Save_Field (Update : in out Update_Statement;
                         Name   : in String;
                         Value  : in ADO.Blob_Ref);

   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to NULL.
   procedure Save_Null_Field (Update : in out Update_Statement;
                              Name   : in String);

   --  Check if the update/insert query has some fields to update.
   function Has_Save_Fields (Update : in Update_Statement) return Boolean;

   --  Execute the query
   overriding
   procedure Execute (Query : in out Update_Statement);

   --  Execute the query
   procedure Execute (Query : in out Update_Statement;
                      Result : out Integer);

   --  ------------------------------
   --  Insert statement
   --  ------------------------------
   type Insert_Statement is new Update_Statement with private;
   type Insert_Statement_Access is access all Insert_Statement'Class;

   --  Execute the query
   overriding
   procedure Execute (Query : in out Insert_Statement);

private

   type Statement is abstract new ADO.Parameters.Abstract_List with record
      Query  : ADO.SQL.Query_Access;
   end record;

   type Driver_Statement is new Ada.Finalization.Limited_Controlled with null record;

   procedure Execute (Query  : in out Statement;
                      SQL    : in Unbounded_String;
                      Params : in ADO.Parameters.Abstract_List'Class);

   type Query_Statement is new Statement with record
      Proxy       : Query_Statement_Access := null;
      Ref_Counter : Natural := 0;
   end record;

   overriding
   procedure Adjust (Stmt : in out Query_Statement);

   overriding
   procedure Finalize (Stmt : in out Query_Statement);

   --  String pointer to interface with a C library
   type chars_ptr is access all Character;
   pragma Convention (C, chars_ptr);

   type Size_T is mod 2 ** Standard'Address_Size;

   use Interfaces.C;

   function To_Chars_Ptr is
     new Ada.Unchecked_Conversion (System.Address, chars_ptr);

   function To_Chars_Ptr is
     new Ada.Unchecked_Conversion (Interfaces.C.Strings.chars_ptr, chars_ptr);

   function To_Address is
     new Ada.Unchecked_Conversion (chars_ptr, System.Address);

   function "+" (Left : chars_ptr; Right : Size_T) return chars_ptr;
   pragma Inline ("+");

   --  Get an unsigned 64-bit number from a C string terminated by \0
   function Get_Uint64 (Str : chars_ptr) return unsigned_long;

   --  Get a signed 64-bit number from a C string terminated by \0
   function Get_Int64 (Str : chars_ptr) return Int64;

   --  Get a double number from a C string terminated by \0
   function Get_Long_Float (Str : chars_ptr) return Long_Float;

   --  Get a time from the C string passed in <b>Value</b>.
   --  Raises <b>Invalid_Type</b> if the value cannot be converted.
   --  Raises <b>Invalid_Column</b> if the column does not exist.
   function Get_Time (Value  : in chars_ptr) return Ada.Calendar.Time;

   --  Create a blob initialized with the given data buffer pointed to by <b>Data</b>
   --  and which contains <b>Size</b> bytes.
   function Get_Blob (Data : in chars_ptr;
                      Size : in Natural) return Blob_Ref;

   type Delete_Statement is new Statement with record
      Proxy : Delete_Statement_Access := null;
      Ref_Counter : Natural := 0;
   end record;

   overriding
   procedure Adjust (Stmt : in out Delete_Statement);

   overriding
   procedure Finalize (Stmt : in out Delete_Statement);

   type Update_Statement is new Statement with record
      Proxy  : Update_Statement_Access := null;
      Update : ADO.SQL.Update_Query_Access;
      Ref_Counter : Natural := 0;
   end record;

   overriding
   procedure Adjust (Stmt : in out Update_Statement);

   overriding
   procedure Finalize (Stmt : in out Update_Statement);

   type Insert_Statement is new Update_Statement with record
      Pos2 : Natural := 0;
   end record;

end ADO.Statements;
