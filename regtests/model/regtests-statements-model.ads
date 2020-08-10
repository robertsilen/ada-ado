-----------------------------------------------------------------------
--  Regtests.Statements.Model -- Regtests.Statements.Model
-----------------------------------------------------------------------
--  File generated by ada-gen DO NOT MODIFY
--  Template used: templates/model/package-spec.xhtml
--  Ada Generator: https://ada-gen.googlecode.com/svn/trunk Revision 1095
-----------------------------------------------------------------------
--  Copyright (C) 2020 Stephane Carrez
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
pragma Warnings (Off);
with ADO.Sessions;
with ADO.Objects;
with ADO.Statements;
with ADO.SQL;
with ADO.Schemas;
with Ada.Calendar;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Util.Beans.Objects;
with Util.Beans.Basic.Lists;
pragma Warnings (On);
package Regtests.Statements.Model is

   pragma Style_Checks ("-mr");

   type Nullable_Table_Ref is new ADO.Objects.Object_Ref with null record;

   type Table_Ref is new ADO.Objects.Object_Ref with null record;

   --  --------------------
   --  Record representing a user
   --  --------------------
   --  Create an object key for Nullable_Table.
   function Nullable_Table_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Nullable_Table from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Nullable_Table_Key (Id : in String) return ADO.Objects.Object_Key;

   Null_Nullable_Table : constant Nullable_Table_Ref;
   function "=" (Left, Right : Nullable_Table_Ref'Class) return Boolean;

   --  Set the user id
   procedure Set_Id (Object : in out Nullable_Table_Ref;
                     Value  : in ADO.Identifier);

   --  Get the user id
   function Get_Id (Object : in Nullable_Table_Ref)
                 return ADO.Identifier;
   --  Get the comment version.
   function Get_Version (Object : in Nullable_Table_Ref)
                 return Integer;

   --  Set an identifier value
   procedure Set_Id_Value (Object : in out Nullable_Table_Ref;
                           Value  : in ADO.Identifier);

   --  Get an identifier value
   function Get_Id_Value (Object : in Nullable_Table_Ref)
                 return ADO.Identifier;

   --  Set an integer value
   procedure Set_Int_Value (Object : in out Nullable_Table_Ref;
                            Value  : in ADO.Nullable_Integer);

   --  Get an integer value
   function Get_Int_Value (Object : in Nullable_Table_Ref)
                 return ADO.Nullable_Integer;

   --  Set a boolean value
   procedure Set_Bool_Value (Object : in out Nullable_Table_Ref;
                             Value  : in ADO.Nullable_Boolean);

   --  Get a boolean value
   function Get_Bool_Value (Object : in Nullable_Table_Ref)
                 return ADO.Nullable_Boolean;

   --  Set a string value
   procedure Set_String_Value (Object : in out Nullable_Table_Ref;
                               Value  : in ADO.Nullable_String);
   procedure Set_String_Value (Object : in out Nullable_Table_Ref;
                               Value : in String);

   --  Get a string value
   function Get_String_Value (Object : in Nullable_Table_Ref)
                 return ADO.Nullable_String;
   function Get_String_Value (Object : in Nullable_Table_Ref)
                 return String;

   --  Set a time value
   procedure Set_Time_Value (Object : in out Nullable_Table_Ref;
                             Value  : in ADO.Nullable_Time);

   --  Get a time value
   function Get_Time_Value (Object : in Nullable_Table_Ref)
                 return ADO.Nullable_Time;

   --  Set an entity value
   procedure Set_Entity_Value (Object : in out Nullable_Table_Ref;
                               Value  : in ADO.Nullable_Entity_Type);

   --  Get an entity value
   function Get_Entity_Value (Object : in Nullable_Table_Ref)
                 return ADO.Nullable_Entity_Type;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Nullable_Table_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Nullable_Table_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Nullable_Table_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Nullable_Table_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Nullable_Table_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (From : in Nullable_Table_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   NULLABLE_TABLE_TABLE : constant ADO.Schemas.Class_Mapping_Access;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Nullable_Table_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Nullable_Table_Ref;
                   Into   : in out Nullable_Table_Ref);

   package Nullable_Table_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Positive,
                                  Element_Type => Nullable_Table_Ref,
                                  "="          => "=");
   subtype Nullable_Table_Vector is Nullable_Table_Vectors.Vector;

   procedure List (Object  : in out Nullable_Table_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);
   --  --------------------
   --  Record representing a user
   --  --------------------
   --  Create an object key for Table.
   function Table_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Table from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Table_Key (Id : in String) return ADO.Objects.Object_Key;

   Null_Table : constant Table_Ref;
   function "=" (Left, Right : Table_Ref'Class) return Boolean;

   --  Set the user id
   procedure Set_Id (Object : in out Table_Ref;
                     Value  : in ADO.Identifier);

   --  Get the user id
   function Get_Id (Object : in Table_Ref)
                 return ADO.Identifier;
   --  Get the comment version.
   function Get_Version (Object : in Table_Ref)
                 return Integer;

   --  Set an identifier value
   procedure Set_Id_Value (Object : in out Table_Ref;
                           Value  : in ADO.Identifier);

   --  Get an identifier value
   function Get_Id_Value (Object : in Table_Ref)
                 return ADO.Identifier;

   --  Set an integer value
   procedure Set_Int_Value (Object : in out Table_Ref;
                            Value  : in Integer);

   --  Get an integer value
   function Get_Int_Value (Object : in Table_Ref)
                 return Integer;

   --  Set a boolean value
   procedure Set_Bool_Value (Object : in out Table_Ref;
                             Value  : in Boolean);

   --  Get a boolean value
   function Get_Bool_Value (Object : in Table_Ref)
                 return Boolean;

   --  Set a string value
   procedure Set_String_Value (Object : in out Table_Ref;
                               Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_String_Value (Object : in out Table_Ref;
                               Value : in String);

   --  Get a string value
   function Get_String_Value (Object : in Table_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_String_Value (Object : in Table_Ref)
                 return String;

   --  Set a time value
   procedure Set_Time_Value (Object : in out Table_Ref;
                             Value  : in Ada.Calendar.Time);

   --  Get a time value
   function Get_Time_Value (Object : in Table_Ref)
                 return Ada.Calendar.Time;

   --  Set an entity value
   procedure Set_Entity_Value (Object : in out Table_Ref;
                               Value  : in ADO.Entity_Type);

   --  Get an entity value
   function Get_Entity_Value (Object : in Table_Ref)
                 return ADO.Entity_Type;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Table_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Table_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Table_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Table_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Table_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (From : in Table_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   TABLE_TABLE : constant ADO.Schemas.Class_Mapping_Access;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Table_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Table_Ref;
                   Into   : in out Table_Ref);

   package Table_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Positive,
                                  Element_Type => Table_Ref,
                                  "="          => "=");
   subtype Table_Vector is Table_Vectors.Vector;

   procedure List (Object  : in out Table_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);



private
   NULLABLE_TABLE_NAME : aliased constant String := "test_nullable_table";
   COL_0_1_NAME : aliased constant String := "id";
   COL_1_1_NAME : aliased constant String := "version";
   COL_2_1_NAME : aliased constant String := "id_value";
   COL_3_1_NAME : aliased constant String := "int_value";
   COL_4_1_NAME : aliased constant String := "bool_value";
   COL_5_1_NAME : aliased constant String := "string_value";
   COL_6_1_NAME : aliased constant String := "time_value";
   COL_7_1_NAME : aliased constant String := "entity_value";

   NULLABLE_TABLE_DEF : aliased constant ADO.Schemas.Class_Mapping :=
     (Count   => 8,
      Table   => NULLABLE_TABLE_NAME'Access,
      Members => (
         1 => COL_0_1_NAME'Access,
         2 => COL_1_1_NAME'Access,
         3 => COL_2_1_NAME'Access,
         4 => COL_3_1_NAME'Access,
         5 => COL_4_1_NAME'Access,
         6 => COL_5_1_NAME'Access,
         7 => COL_6_1_NAME'Access,
         8 => COL_7_1_NAME'Access)
     );
   NULLABLE_TABLE_TABLE : constant ADO.Schemas.Class_Mapping_Access
      := NULLABLE_TABLE_DEF'Access;


   Null_Nullable_Table : constant Nullable_Table_Ref
      := Nullable_Table_Ref'(ADO.Objects.Object_Ref with null record);

   type Nullable_Table_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => NULLABLE_TABLE_DEF'Access)
   with record
       Version : Integer;
       Id_Value : ADO.Identifier;
       Int_Value : ADO.Nullable_Integer;
       Bool_Value : ADO.Nullable_Boolean;
       String_Value : ADO.Nullable_String;
       Time_Value : ADO.Nullable_Time;
       Entity_Value : ADO.Nullable_Entity_Type;
   end record;

   type Nullable_Table_Access is access all Nullable_Table_Impl;

   overriding
   procedure Destroy (Object : access Nullable_Table_Impl);

   overriding
   procedure Find (Object  : in out Nullable_Table_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   overriding
   procedure Load (Object  : in out Nullable_Table_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Nullable_Table_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);

   overriding
   procedure Save (Object  : in out Nullable_Table_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);

   procedure Create (Object  : in out Nullable_Table_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Delete (Object  : in out Nullable_Table_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   procedure Set_Field (Object : in out Nullable_Table_Ref'Class;
                        Impl   : out Nullable_Table_Access);
   TABLE_NAME : aliased constant String := "test_table";
   COL_0_2_NAME : aliased constant String := "id";
   COL_1_2_NAME : aliased constant String := "version";
   COL_2_2_NAME : aliased constant String := "id_value";
   COL_3_2_NAME : aliased constant String := "int_value";
   COL_4_2_NAME : aliased constant String := "bool_value";
   COL_5_2_NAME : aliased constant String := "string_value";
   COL_6_2_NAME : aliased constant String := "time_value";
   COL_7_2_NAME : aliased constant String := "entity_value";

   TABLE_DEF : aliased constant ADO.Schemas.Class_Mapping :=
     (Count   => 8,
      Table   => TABLE_NAME'Access,
      Members => (
         1 => COL_0_2_NAME'Access,
         2 => COL_1_2_NAME'Access,
         3 => COL_2_2_NAME'Access,
         4 => COL_3_2_NAME'Access,
         5 => COL_4_2_NAME'Access,
         6 => COL_5_2_NAME'Access,
         7 => COL_6_2_NAME'Access,
         8 => COL_7_2_NAME'Access)
     );
   TABLE_TABLE : constant ADO.Schemas.Class_Mapping_Access
      := TABLE_DEF'Access;


   Null_Table : constant Table_Ref
      := Table_Ref'(ADO.Objects.Object_Ref with null record);

   type Table_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => TABLE_DEF'Access)
   with record
       Version : Integer;
       Id_Value : ADO.Identifier;
       Int_Value : Integer;
       Bool_Value : Boolean;
       String_Value : Ada.Strings.Unbounded.Unbounded_String;
       Time_Value : Ada.Calendar.Time;
       Entity_Value : ADO.Entity_Type;
   end record;

   type Table_Access is access all Table_Impl;

   overriding
   procedure Destroy (Object : access Table_Impl);

   overriding
   procedure Find (Object  : in out Table_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   overriding
   procedure Load (Object  : in out Table_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Table_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);

   overriding
   procedure Save (Object  : in out Table_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);

   procedure Create (Object  : in out Table_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Delete (Object  : in out Table_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   procedure Set_Field (Object : in out Table_Ref'Class;
                        Impl   : out Table_Access);
end Regtests.Statements.Model;
