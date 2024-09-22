-----------------------------------------------------------------------
--  ado-datasets -- Datasets
--  Copyright (C) 2013, 2014, 2018 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
with Util.Beans.Objects.Time;

with ADO.Schemas;
with ADO.Statements;

package body ADO.Datasets is

   --  ------------------------------
   --  Execute the SQL query on the database session and populate the dataset.
   --  The column names are used to setup the dataset row bean definition.
   --  ------------------------------
   procedure List (Into    : in out Dataset;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.Queries.Context'Class) is
      procedure Fill (Data : in out Util.Beans.Objects.Datasets.Object_Array);

      Stmt : ADO.Statements.Query_Statement := Session.Create_Statement (Query);

      procedure Fill (Data : in out Util.Beans.Objects.Datasets.Object_Array) is
         use ADO.Schemas;
      begin
         for I in Data'Range loop
            if Stmt.Is_Null (I - 1) then
               Data (I) := Util.Beans.Objects.Null_Object;
            else
               case Stmt.Get_Column_Type (I - 1) is
                  --  Boolean column
               when T_BOOLEAN =>
                  Data (I) := Util.Beans.Objects.To_Object (Stmt.Get_Boolean (I - 1));

               when T_TINYINT | T_SMALLINT | T_INTEGER | T_LONG_INTEGER | T_YEAR =>
                  Data (I) := Util.Beans.Objects.To_Object (Stmt.Get_Integer (I - 1));

               when T_FLOAT | T_DOUBLE | T_DECIMAL =>
                  Data (I) := Util.Beans.Objects.Null_Object;

               when T_ENUM =>
                  Data (I) := Util.Beans.Objects.To_Object (Stmt.Get_String (I - 1));

               when T_TIME | T_DATE | T_DATE_TIME | T_TIMESTAMP =>
                  Data (I) := Util.Beans.Objects.Time.To_Object (Stmt.Get_Time (I - 1));

               when T_CHAR | T_VARCHAR =>
                  Data (I) := Util.Beans.Objects.To_Object (Stmt.Get_String (I - 1));

               when T_BLOB =>
                  Data (I) := Util.Beans.Objects.Null_Object;

               when T_SET | T_UNKNOWN | T_NULL =>
                  Data (I) := Util.Beans.Objects.Null_Object;

               end case;
            end if;
         end loop;
      end Fill;

   begin
      Stmt.Execute;
      Into.Clear;
      if Stmt.Has_Elements then
         for I in 1 .. Stmt.Get_Column_Count loop
            Into.Add_Column (Stmt.Get_Column_Name (I - 1));
         end loop;
         while Stmt.Has_Elements loop
            Into.Append (Fill'Access);
            Stmt.Next;
         end loop;
      end if;
   end List;

   --  ------------------------------
   --  Get the number of items in a list by executing an SQL query.
   --  ------------------------------
   function Get_Count (Session : in ADO.Sessions.Session'Class;
                       Query   : in ADO.Queries.Context'Class) return Natural is
      Stmt : ADO.Statements.Query_Statement := Session.Create_Statement (Query);
   begin
      Stmt.Execute;
      return Stmt.Get_Result_Integer;
   end Get_Count;

end ADO.Datasets;
