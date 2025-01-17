-----------------------------------------------------------------------
--  Samples.User.Model -- Samples.User.Model
-----------------------------------------------------------------------
--  File generated by Dynamo DO NOT MODIFY
--  Template used: templates/model/package-spec.xhtml
--  Ada Generator: https://github.com/stcarrez/dynamo Version 1.4.0
-----------------------------------------------------------------------
--  Copyright (C) 2022 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
pragma Warnings (Off);
with ADO.Sessions;
with ADO.Objects;
with ADO.Statements;
with ADO.SQL;
with ADO.Schemas;
with ADO.Queries;
with ADO.Queries.Loaders;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Util.Beans.Objects;
with Util.Beans.Basic.Lists;
pragma Warnings (On);
package Samples.User.Model is

   pragma Style_Checks ("-mrIu");

   type User_Ref is new ADO.Objects.Object_Ref with null record;

   --  --------------------
   --  Record representing a user
   --  --------------------
   --  Create an object key for User.
   function User_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for User from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function User_Key (Id : in String) return ADO.Objects.Object_Key;

   Null_User : constant User_Ref;
   function "=" (Left, Right : User_Ref'Class) return Boolean;

   --  Set the user identifier
   procedure Set_Id (Object : in out User_Ref;
                     Value  : in ADO.Identifier);

   --  Get the user identifier
   function Get_Id (Object : in User_Ref)
                 return ADO.Identifier;
   --
   function Get_Version (Object : in User_Ref)
                 return Integer;

   --  Set the user name
   procedure Set_Name (Object : in out User_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Name (Object : in out User_Ref;
                       Value : in String);

   --  Get the user name
   function Get_Name (Object : in User_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Name (Object : in User_Ref)
                 return String;

   --  Set the user email
   procedure Set_Email (Object : in out User_Ref;
                        Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Email (Object : in out User_Ref;
                        Value : in String);

   --  Get the user email
   function Get_Email (Object : in User_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Email (Object : in User_Ref)
                 return String;

   --  Set the user registration date
   procedure Set_Date (Object : in out User_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Date (Object : in out User_Ref;
                       Value : in String);

   --  Get the user registration date
   function Get_Date (Object : in User_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Date (Object : in User_Ref)
                 return String;

   --  Set the user description
   procedure Set_Description (Object : in out User_Ref;
                              Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Description (Object : in out User_Ref;
                              Value : in String);

   --  Get the user description
   function Get_Description (Object : in User_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Description (Object : in User_Ref)
                 return String;

   --  Set the user status
   procedure Set_Status (Object : in out User_Ref;
                         Value  : in Integer);

   --  Get the user status
   function Get_Status (Object : in User_Ref)
                 return Integer;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out User_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out User_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Reload from the database the same object if it was modified.
   --  Returns True in `Updated` if the object was reloaded.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Reload (Object  : in out User_Ref;
                     Session : in out ADO.Sessions.Session'Class;
                     Updated : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out User_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out User_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out User_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (From : in User_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   USER_TABLE : constant ADO.Schemas.Class_Mapping_Access;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out User_Ref);

   --  Copy of the object.
   procedure Copy (Object : in User_Ref;
                   Into   : in out User_Ref);

   package User_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Positive,
                                  Element_Type => User_Ref,
                                  "="          => "=");
   subtype User_Vector is User_Vectors.Vector;

   procedure List (Object  : in out User_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);

   type User_Info is record

      --  the user identifier.
      Id : ADO.Identifier;

      --  the user name.
      Name : Ada.Strings.Unbounded.Unbounded_String;

      --  the user email address.
      Email : Ada.Strings.Unbounded.Unbounded_String;
   end record;

   package User_Info_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Positive,
                                  Element_Type => User_Info,
                                  "="          => "=");

   subtype User_Info_Vector is User_Info_Vectors.Vector;

   --  Run the query controlled by <b>Context</b> and append the list in <b>Object</b>.
   procedure List (Object  : in out User_Info_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class);

   Query_User_List : constant ADO.Queries.Query_Definition_Access;

   Query_User_List_Filter : constant ADO.Queries.Query_Definition_Access;



private
   USER_NAME : aliased constant String := "user";
   COL_0_1_NAME : aliased constant String := "id";
   COL_1_1_NAME : aliased constant String := "object_version";
   COL_2_1_NAME : aliased constant String := "name";
   COL_3_1_NAME : aliased constant String := "email";
   COL_4_1_NAME : aliased constant String := "date";
   COL_5_1_NAME : aliased constant String := "description";
   COL_6_1_NAME : aliased constant String := "status";

   USER_DEF : aliased constant ADO.Schemas.Class_Mapping :=
     (Count   => 7,
      Table   => USER_NAME'Access,
      Members => (
         1 => COL_0_1_NAME'Access,
         2 => COL_1_1_NAME'Access,
         3 => COL_2_1_NAME'Access,
         4 => COL_3_1_NAME'Access,
         5 => COL_4_1_NAME'Access,
         6 => COL_5_1_NAME'Access,
         7 => COL_6_1_NAME'Access)
     );
   USER_TABLE : constant ADO.Schemas.Class_Mapping_Access
      := USER_DEF'Access;


   Null_User : constant User_Ref
      := User_Ref'(ADO.Objects.Object_Ref with null record);

   type User_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => USER_DEF'Access)
   with record
       Version : Integer;
       Name : Ada.Strings.Unbounded.Unbounded_String;
       Email : Ada.Strings.Unbounded.Unbounded_String;
       Date : Ada.Strings.Unbounded.Unbounded_String;
       Description : Ada.Strings.Unbounded.Unbounded_String;
       Status : Integer;
   end record;

   type User_Access is access all User_Impl;

   overriding
   procedure Destroy (Object : access User_Impl);

   overriding
   procedure Find (Object  : in out User_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   overriding
   procedure Load (Object  : in out User_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out User_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);

   overriding
   procedure Save (Object  : in out User_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Create (Object  : in out User_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Delete (Object  : in out User_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   procedure Set_Field (Object : in out User_Ref'Class;
                        Impl   : out User_Access);

   package File_1 is
      new ADO.Queries.Loaders.File (Path => "user-list.xml",
                                    Sha1 => "72010791BC6D2696682FF9B2D887D67CFCDFC99D");

   package Def_Userinfo_User_List is
      new ADO.Queries.Loaders.Query (Name => "user-list",
                                     File => File_1.File'Access);
   Query_User_List : constant ADO.Queries.Query_Definition_Access
   := Def_Userinfo_User_List.Query'Access;

   package Def_Userinfo_User_List_Filter is
      new ADO.Queries.Loaders.Query (Name => "user-list-filter",
                                     File => File_1.File'Access);
   Query_User_List_Filter : constant ADO.Queries.Query_Definition_Access
   := Def_Userinfo_User_List_Filter.Query'Access;
end Samples.User.Model;
