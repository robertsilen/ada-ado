-----------------------------------------------------------------------
--  ado-sql -- Basic SQL Generation
--  Copyright (C) 2010, 2011, 2012, 2015, 2019, 2022 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Ada.Text_IO;
with Util.Strings.Builders;

--  Utilities for creating SQL queries and statements.
package body ADO.SQL is

   --  --------------------
   --  Buffer
   --  --------------------

   --  --------------------
   --  Clear the SQL buffer.
   --  --------------------
   overriding
   procedure Clear (Target : in out Buffer) is
   begin
      Target.Buf := To_Unbounded_String ("");
   end Clear;

   --  --------------------
   --  Append an SQL extract into the buffer.
   --  --------------------
   procedure Append (Target : in out Buffer;
                     SQL    : in String) is
   begin
      Append (Target.Buf, SQL);
   end Append;

   --  --------------------
   --  Append a name in the buffer and escape that
   --  name if this is a reserved keyword.
   --  --------------------
   procedure Append_Name (Target : in out Buffer;
                          Name   : in String) is
      use type ADO.Dialects.Dialect_Access;
      Dialect : constant ADO.Dialects.Dialect_Access := Target.Get_Dialect;
   begin
      if Dialect /= null and then Dialect.Is_Reserved (Name) then
         declare
            Quote : constant Character := Dialect.Get_Identifier_Quote;
         begin
            Append (Target.Buf, Quote);
            Append (Target.Buf, Name);
            Append (Target.Buf, Quote);
         end;
      else
         Append (Target.Buf, Name);
      end if;
   end Append_Name;

   --  --------------------
   --  Append a string value in the buffer and
   --  escape any special character if necessary.
   --  --------------------
   procedure Append_Value (Target : in out Buffer;
                           Value  : in String) is
   begin
      Append (Target.Buf, Value);
   end Append_Value;

   --  --------------------
   --  Append a string value in the buffer and
   --  escape any special character if necessary.
   --  --------------------
   procedure Append_Value (Target : in out Buffer;
                           Value  : in Unbounded_String) is
   begin
      Append (Target.Buf, Value);
   end Append_Value;

   --  --------------------
   --  Append the integer value in the buffer.
   --  --------------------
   procedure Append_Value (Target : in out Buffer;
                           Value  : in Long_Integer) is
      S : constant String := Long_Integer'Image (Value);
   begin
      Append (Target.Buf, S (S'First + 1 .. S'Last));
   end Append_Value;

   --  --------------------
   --  Append the integer value in the buffer.
   --  --------------------
   procedure Append_Value (Target : in out Buffer;
                           Value  : in Integer) is
      S : constant String := Integer'Image (Value);
   begin
      Append (Target.Buf, S (S'First + 1 .. S'Last));
   end Append_Value;

   --  --------------------
   --  Append the identifier value in the buffer.
   --  --------------------
   procedure Append_Value (Target : in out Buffer;
                           Value  : in Identifier) is
      S : constant String := Identifier'Image (Value);
   begin
      Append (Target.Buf, S (S'First + 1 .. S'Last));
   end Append_Value;

   --  --------------------
   --  Get the SQL string that was accumulated in the buffer.
   --  --------------------
   function To_String (From : in Buffer) return String is
   begin
      return To_String (From.Buf);
   end To_String;

   --  --------------------
   --  Clear the query object.
   --  --------------------
   overriding
   procedure Clear (Target : in out Query) is
   begin
      ADO.Parameters.List (Target).Clear;
      Target.Join.Clear;
      Target.Filter.Clear;
      Target.SQL.Clear;
   end Clear;

   --  --------------------
   --  Set the SQL dialect description object.
   --  --------------------
   overriding
   procedure Set_Dialect (Target : in out Query;
                          D      : in ADO.Dialects.Dialect_Access) is
   begin
      ADO.Parameters.Abstract_List (Target).Set_Dialect (D);
      Set_Dialect (Target.SQL, D);
      Set_Dialect (Target.Filter, D);
      Set_Dialect (Target.Join, D);
   end Set_Dialect;

   procedure Set_Filter (Target : in out Query;
                         Filter : in String) is
   begin
      Target.Filter.Buf := To_Unbounded_String (Filter);
   end Set_Filter;

   function Get_Filter (Source : in Query) return String is
   begin
      if Source.Filter.Buf = Null_Unbounded_String then
         return "";
      else
         return To_String (Source.Filter.Buf);
      end if;
   end Get_Filter;

   function Has_Filter (Source : in Query) return Boolean is
   begin
      return Source.Filter.Buf /= Null_Unbounded_String
        and then Length (Source.Filter.Buf) > 0;
   end Has_Filter;

   --  --------------------
   --  Set the join condition.
   --  --------------------
   procedure Set_Join (Target : in out Query;
                       Join   : in String) is
   begin
      Target.Join.Buf := To_Unbounded_String (Join);
   end Set_Join;

   --  --------------------
   --  Returns true if there is a join condition
   --  --------------------
   function Has_Join (Source : in Query) return Boolean is
   begin
      return Source.Join.Buf /= Null_Unbounded_String
        and then Length (Source.Join.Buf) > 0;
   end Has_Join;

   --  --------------------
   --  Get the join condition
   --  --------------------
   function Get_Join (Source : in Query) return String is
   begin
      if Source.Join.Buf = Null_Unbounded_String then
         return "";
      else
         return To_String (Source.Join.Buf);
      end if;
   end Get_Join;

   --  --------------------
   --  Set the parameters from another parameter list.
   --  If the parameter list is a query object, also copy the filter part.
   --  --------------------
   overriding
   procedure Set_Parameters (Params : in out Query;
                             From   : in ADO.Parameters.Abstract_List'Class) is
   begin
      ADO.Parameters.List (Params).Set_Parameters (From);
      if From in Query'Class then
         declare
            L : constant Query'Class := Query'Class (From);
         begin
            Params.Filter := L.Filter;
            Params.Join   := L.Join;
         end;
      end if;
   end Set_Parameters;

   --  --------------------
   --  Expand the parameters into the query and return the expanded SQL query.
   --  --------------------
   function Expand (Source : in Query) return String is
   begin
      return ADO.Parameters.Abstract_List (Source).Expand (To_String (Source.SQL.Buf));
   end Expand;

   procedure Add_Field (Update : in out Update_Query'Class;
                        Name   : in String) is
   begin
      Update.Pos := Update.Pos + 1;
      if Update.Pos > 1 then
         Append (Target => Update.Set_Fields, SQL => ",");
         Append (Target => Update.Fields, SQL => ",");
      end if;
      Append_Name (Target => Update.Set_Fields, Name => Name);
      if Update.Is_Update_Stmt then
         Append (Target => Update.Set_Fields, SQL => " = ?");
      end if;
      Append (Target => Update.Fields, SQL => "?");
   end Add_Field;

   --  ------------------------------
   --  Set the SQL dialect description object.
   --  ------------------------------
   overriding
   procedure Set_Dialect (Target : in out Update_Query;
                          D      : in ADO.Dialects.Dialect_Access) is
   begin
      Target.Set_Fields.Set_Dialect (D);
      Target.Fields.Set_Dialect (D);
      Query (Target).Set_Dialect (D);
   end Set_Dialect;

   --  ------------------------------
   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   --  ------------------------------
   procedure Save_Field (Update : in out Update_Query;
                         Name   : in String;
                         Value  : in Boolean) is
   begin
      Update.Add_Field (Name => Name);
      Update_Query'Class (Update).Bind_Param (Position => Update.Pos, Value => Value);
   end Save_Field;

   --  --------------------
   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   --  --------------------
   procedure Save_Field (Update : in out Update_Query;
                         Name   : in String;
                         Value  : in Integer) is
   begin
      Update.Add_Field (Name => Name);
      Update_Query'Class (Update).Bind_Param (Position => Update.Pos, Value => Value);
   end Save_Field;

   --  --------------------
   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   --  --------------------
   procedure Save_Field (Update : in out Update_Query;
                         Name   : in String;
                         Value  : in Long_Long_Integer) is
   begin
      Update.Add_Field (Name => Name);
      Update_Query'Class (Update).Bind_Param (Position => Update.Pos, Value => Value);
   end Save_Field;

   --  --------------------
   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   --  --------------------
   procedure Save_Field (Update : in out Update_Query;
                         Name   : in String;
                         Value  : in Long_Float) is
   begin
      Update.Add_Field (Name => Name);
      Update_Query'Class (Update).Bind_Param (Position => Update.Pos, Value => Value);
   end Save_Field;

   --  --------------------
   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   --  --------------------
   procedure Save_Field (Update : in out Update_Query;
                         Name   : in String;
                         Value  : in Identifier) is
   begin
      Update.Add_Field (Name => Name);
      Update_Query'Class (Update).Add_Param (Value => Value);
   end Save_Field;

   --  --------------------
   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   --  --------------------
   procedure Save_Field (Update : in out Update_Query;
                         Name   : in String;
                         Value  : in Entity_Type) is
   begin
      Update.Add_Field (Name => Name);
      Update_Query'Class (Update).Add_Param (Value => Integer (Value));
   end Save_Field;

   --  --------------------
   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   --  --------------------
   procedure Save_Field (Update : in out Update_Query;
                         Name   : in String;
                         Value  : in Ada.Calendar.Time) is
   begin
      Update.Add_Field (Name => Name);
      Update_Query'Class (Update).Add_Param (Value => Value);
   end Save_Field;

   --  --------------------
   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   --  --------------------
   procedure Save_Field (Update : in out Update_Query;
                         Name   : in String;
                         Value  : in String) is
   begin
      Update.Add_Field (Name => Name);
      Update_Query'Class (Update).Bind_Param (Position => Update.Pos, Value => Value);
   end Save_Field;

   --  --------------------
   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   --  --------------------
   procedure Save_Field (Update : in out Update_Query;
                         Name   : in String;
                         Value  : in Unbounded_String) is
   begin
      Update.Add_Field (Name => Name);
      Update_Query'Class (Update).Bind_Param (Position => Update.Pos, Value => Value);
   end Save_Field;

   --  ------------------------------
   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to the <b>Value</b>.
   --  ------------------------------
   procedure Save_Field (Update : in out Update_Query;
                         Name   : in String;
                         Value  : in ADO.Blob_Ref) is
   begin
      Update.Add_Field (Name => Name);
      Update_Query'Class (Update).Bind_Param (Position => Update.Pos, Value => Value);
   end Save_Field;

   --  ------------------------------
   --  Prepare the update/insert query to save the table field
   --  identified by <b>Name</b> and set it to NULL.
   --  ------------------------------
   procedure Save_Null_Field (Update : in out Update_Query;
                              Name   : in String) is
   begin
      Update.Add_Field (Name => Name);
      Update_Query'Class (Update).Bind_Null_Param (Position => Update.Pos);
   end Save_Null_Field;

   --  --------------------
   --  Check if the update/insert query has some fields to update.
   --  --------------------
   function Has_Save_Fields (Update : in Update_Query) return Boolean is
   begin
      return Update.Pos > 0;
   end Has_Save_Fields;

   procedure Set_Insert_Mode (Update : in out Update_Query) is
   begin
      Update.Is_Update_Stmt := False;
   end Set_Insert_Mode;

   procedure Append_Fields (Update : in out Update_Query;
                            Mode   : in Boolean := False) is
   begin
      if Mode then
         Append (Target => Update.SQL, SQL => To_String (Update.Fields.Buf));
      else
         Append (Target => Update.SQL, SQL => To_String (Update.Set_Fields.Buf));
      end if;
   end Append_Fields;

   --  --------------------
   --  Read the file for SQL statements separated by ';' and execute the
   --  `Process` procedure with each SQL statement that is read.
   --  --------------------
   procedure Read_File (Path    : in String;
                        Process : not null access procedure (SQL : in String)) is
      File : Ada.Text_IO.File_Type;
      SQL  : Util.Strings.Builders.Builder (1024);
   begin
      Ada.Text_IO.Open (File => File,
                        Mode => Ada.Text_IO.In_File,
                        Name => Path);
      begin
         while not Ada.Text_IO.End_Of_File (File) loop
            declare
               Line : constant String := Ada.Text_IO.Get_Line (File);
            begin
               if Util.Strings.Builders.Length (SQL) > 0 then
                  Util.Strings.Builders.Append (SQL, ' ');
               end if;
               for C of Line loop
                  if C = ';' then
                     if Util.Strings.Builders.Length (SQL) > 0 then
                        Process (Util.Strings.Builders.To_Array (SQL));
                     end if;
                     Util.Strings.Builders.Clear (SQL);
                  else
                     Util.Strings.Builders.Append (SQL, C);
                  end if;
               end loop;
            end;
         end loop;
         if Util.Strings.Builders.Length (SQL) > 0 then
            Process (Util.Strings.Builders.To_Array (SQL));
         end if;

      exception
         when others =>
            Ada.Text_IO.Close (File);
            raise;
      end;
      Ada.Text_IO.Close (File);
   end Read_File;

end ADO.SQL;
