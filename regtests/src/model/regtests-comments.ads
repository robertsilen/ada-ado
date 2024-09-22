-----------------------------------------------------------------------
--  Regtests.Comments -- Regtests.Comments
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
with Ada.Calendar;
with Ada.Containers.Vectors;
with Ada.Strings.Unbounded;
with Util.Beans.Objects;
with Util.Beans.Basic.Lists;
with Regtests.Simple.Model;
pragma Warnings (On);
package Regtests.Comments is

   pragma Style_Checks ("-mrIu");

   type Comment_Ref is new ADO.Objects.Object_Ref with null record;

   --  --------------------
   --  The Comment table records a user comment associated with a database entity.
   --  The comment can be associated with any other database record.
   --  --------------------
   --  Create an object key for Comment.
   function Comment_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key;
   --  Create an object key for Comment from a string.
   --  Raises Constraint_Error if the string cannot be converted into the object key.
   function Comment_Key (Id : in String) return ADO.Objects.Object_Key;

   Null_Comment : constant Comment_Ref;
   function "=" (Left, Right : Comment_Ref'Class) return Boolean;

   --  Set the comment identifier
   procedure Set_Id (Object : in out Comment_Ref;
                     Value  : in ADO.Identifier);

   --  Get the comment identifier
   function Get_Id (Object : in Comment_Ref)
                 return ADO.Identifier;
   --  Get the comment version.
   function Get_Version (Object : in Comment_Ref)
                 return Integer;

   --  Set the comment publication date.
   procedure Set_Date (Object : in out Comment_Ref;
                       Value  : in Ada.Calendar.Time);

   --  Get the comment publication date.
   function Get_Date (Object : in Comment_Ref)
                 return Ada.Calendar.Time;

   --  Set the comment message.
   procedure Set_Message (Object : in out Comment_Ref;
                          Value  : in Ada.Strings.Unbounded.Unbounded_String);
   procedure Set_Message (Object : in out Comment_Ref;
                          Value : in String);

   --  Get the comment message.
   function Get_Message (Object : in Comment_Ref)
                 return Ada.Strings.Unbounded.Unbounded_String;
   function Get_Message (Object : in Comment_Ref)
                 return String;

   --  Set the entity identifier to which this comment is associated.
   procedure Set_Entity_Id (Object : in out Comment_Ref;
                            Value  : in Integer);

   --  Get the entity identifier to which this comment is associated.
   function Get_Entity_Id (Object : in Comment_Ref)
                 return Integer;

   --  Set the user who posted this comment
   procedure Set_User (Object : in out Comment_Ref;
                       Value  : in Regtests.Simple.Model.User_Ref'Class);

   --  Get the user who posted this comment
   function Get_User (Object : in Comment_Ref)
                 return Regtests.Simple.Model.User_Ref'Class;

   --  Set the entity type that correspond to the entity associated with this comment.
   procedure Set_Entity_Type (Object : in out Comment_Ref;
                              Value  : in ADO.Entity_Type);

   --  Get the entity type that correspond to the entity associated with this comment.
   function Get_Entity_Type (Object : in Comment_Ref)
                 return ADO.Entity_Type;

   --  Load the entity identified by 'Id'.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Load (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier);

   --  Load the entity identified by 'Id'.
   --  Returns True in <b>Found</b> if the object was found and False if it does not exist.
   procedure Load (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean);

   --  Reload from the database the same object if it was modified.
   --  Returns True in `Updated` if the object was reloaded.
   --  Raises the NOT_FOUND exception if it does not exist.
   procedure Reload (Object  : in out Comment_Ref;
                     Session : in out ADO.Sessions.Session'Class;
                     Updated : out Boolean);

   --  Find and load the entity.
   overriding
   procedure Find (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   --  Save the entity.  If the entity does not have an identifier, an identifier is allocated
   --  and it is inserted in the table.  Otherwise, only data fields which have been changed
   --  are updated.
   overriding
   procedure Save (Object  : in out Comment_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class);

   --  Delete the entity.
   overriding
   procedure Delete (Object  : in out Comment_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   function Get_Value (From : in Comment_Ref;
                       Name : in String) return Util.Beans.Objects.Object;

   --  Table definition
   COMMENT_TABLE : constant ADO.Schemas.Class_Mapping_Access;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out Comment_Ref);

   --  Copy of the object.
   procedure Copy (Object : in Comment_Ref;
                   Into   : in out Comment_Ref);

   package Comment_Vectors is
      new Ada.Containers.Vectors (Index_Type   => Positive,
                                  Element_Type => Comment_Ref,
                                  "="          => "=");
   subtype Comment_Vector is Comment_Vectors.Vector;

   procedure List (Object  : in out Comment_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class);



private
   COMMENT_NAME : aliased constant String := "TEST_COMMENTS";
   COL_0_1_NAME : aliased constant String := "id";
   COL_1_1_NAME : aliased constant String := "version";
   COL_2_1_NAME : aliased constant String := "date";
   COL_3_1_NAME : aliased constant String := "message";
   COL_4_1_NAME : aliased constant String := "entity_id";
   COL_5_1_NAME : aliased constant String := "user_fk";
   COL_6_1_NAME : aliased constant String := "entity__type_fk";

   COMMENT_DEF : aliased constant ADO.Schemas.Class_Mapping :=
     (Count   => 7,
      Table   => COMMENT_NAME'Access,
      Members => (
         1 => COL_0_1_NAME'Access,
         2 => COL_1_1_NAME'Access,
         3 => COL_2_1_NAME'Access,
         4 => COL_3_1_NAME'Access,
         5 => COL_4_1_NAME'Access,
         6 => COL_5_1_NAME'Access,
         7 => COL_6_1_NAME'Access)
     );
   COMMENT_TABLE : constant ADO.Schemas.Class_Mapping_Access
      := COMMENT_DEF'Access;


   Null_Comment : constant Comment_Ref
      := Comment_Ref'(ADO.Objects.Object_Ref with null record);

   type Comment_Impl is
      new ADO.Objects.Object_Record (Key_Type => ADO.Objects.KEY_INTEGER,
                                     Of_Class => COMMENT_DEF'Access)
   with record
       Version : Integer;
       Date : Ada.Calendar.Time;
       Message : Ada.Strings.Unbounded.Unbounded_String;
       Entity_Id : Integer;
       User : Regtests.Simple.Model.User_Ref;
       Entity_Type : ADO.Entity_Type;
   end record;

   type Comment_Access is access all Comment_Impl;

   overriding
   procedure Destroy (Object : access Comment_Impl);

   overriding
   procedure Find (Object  : in out Comment_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean);

   overriding
   procedure Load (Object  : in out Comment_Impl;
                   Session : in out ADO.Sessions.Session'Class);
   procedure Load (Object  : in out Comment_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class);

   overriding
   procedure Save (Object  : in out Comment_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Create (Object  : in out Comment_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   overriding
   procedure Delete (Object  : in out Comment_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class);

   procedure Set_Field (Object : in out Comment_Ref'Class;
                        Impl   : out Comment_Access);
end Regtests.Comments;
