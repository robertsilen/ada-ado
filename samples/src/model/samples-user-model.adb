-----------------------------------------------------------------------
--  Samples.User.Model -- Samples.User.Model
-----------------------------------------------------------------------
--  File generated by Dynamo DO NOT MODIFY
--  Template used: templates/model/package-body.xhtml
--  Ada Generator: https://github.com/stcarrez/dynamo Version 1.4.0
-----------------------------------------------------------------------
--  Copyright (C) 2022 Stephane Carrez
--  Written by Stephane Carrez (Stephane.Carrez@gmail.com)
--  SPDX-License-Identifier: Apache-2.0
-----------------------------------------------------------------------
pragma Warnings (Off);
with Ada.Unchecked_Deallocation;
pragma Warnings (On);
package body Samples.User.Model is

   pragma Style_Checks ("-mrIu");
   pragma Warnings (Off, "formal parameter * is not referenced");
   pragma Warnings (Off, "use clause for type *");
   pragma Warnings (Off, "use clause for private type *");

   use type ADO.Objects.Object_Record_Access;
   use type ADO.Objects.Object_Ref;

   function User_Key (Id : in ADO.Identifier) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => USER_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end User_Key;

   function User_Key (Id : in String) return ADO.Objects.Object_Key is
      Result : ADO.Objects.Object_Key (Of_Type  => ADO.Objects.KEY_INTEGER,
                                       Of_Class => USER_DEF'Access);
   begin
      ADO.Objects.Set_Value (Result, Id);
      return Result;
   end User_Key;

   function "=" (Left, Right : User_Ref'Class) return Boolean is
   begin
      return ADO.Objects.Object_Ref'Class (Left) = ADO.Objects.Object_Ref'Class (Right);
   end "=";

   procedure Set_Field (Object : in out User_Ref'Class;
                        Impl   : out User_Access) is
      Result : ADO.Objects.Object_Record_Access;
   begin
      Object.Prepare_Modify (Result);
      Impl := User_Impl (Result.all)'Access;
   end Set_Field;

   --  Internal method to allocate the Object_Record instance
   overriding
   procedure Allocate (Object : in out User_Ref) is
      Impl : User_Access;
   begin
      Impl := new User_Impl;
      Impl.Version := 0;
      Impl.Status := 0;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Allocate;

   -- ----------------------------------------
   --  Data object: User
   -- ----------------------------------------

   procedure Set_Id (Object : in out User_Ref;
                     Value  : in ADO.Identifier) is
      Impl : User_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Key_Value (Impl.all, 1, Value);
   end Set_Id;

   function Get_Id (Object : in User_Ref)
                  return ADO.Identifier is
      Impl : constant User_Access
         := User_Impl (Object.Get_Object.all)'Access;
   begin
      return Impl.Get_Key_Value;
   end Get_Id;


   function Get_Version (Object : in User_Ref)
                  return Integer is
      Impl : constant User_Access
         := User_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Version;
   end Get_Version;


   procedure Set_Name (Object : in out User_Ref;
                        Value : in String) is
      Impl : User_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_String (Impl.all, 3, Impl.Name, Value);
   end Set_Name;

   procedure Set_Name (Object : in out User_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String) is
      Impl : User_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Unbounded_String (Impl.all, 3, Impl.Name, Value);
   end Set_Name;

   function Get_Name (Object : in User_Ref)
                 return String is
   begin
      return Ada.Strings.Unbounded.To_String (Object.Get_Name);
   end Get_Name;
   function Get_Name (Object : in User_Ref)
                  return Ada.Strings.Unbounded.Unbounded_String is
      Impl : constant User_Access
         := User_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Name;
   end Get_Name;


   procedure Set_Email (Object : in out User_Ref;
                         Value : in String) is
      Impl : User_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_String (Impl.all, 4, Impl.Email, Value);
   end Set_Email;

   procedure Set_Email (Object : in out User_Ref;
                        Value  : in Ada.Strings.Unbounded.Unbounded_String) is
      Impl : User_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Unbounded_String (Impl.all, 4, Impl.Email, Value);
   end Set_Email;

   function Get_Email (Object : in User_Ref)
                 return String is
   begin
      return Ada.Strings.Unbounded.To_String (Object.Get_Email);
   end Get_Email;
   function Get_Email (Object : in User_Ref)
                  return Ada.Strings.Unbounded.Unbounded_String is
      Impl : constant User_Access
         := User_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Email;
   end Get_Email;


   procedure Set_Date (Object : in out User_Ref;
                        Value : in String) is
      Impl : User_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_String (Impl.all, 5, Impl.Date, Value);
   end Set_Date;

   procedure Set_Date (Object : in out User_Ref;
                       Value  : in Ada.Strings.Unbounded.Unbounded_String) is
      Impl : User_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Unbounded_String (Impl.all, 5, Impl.Date, Value);
   end Set_Date;

   function Get_Date (Object : in User_Ref)
                 return String is
   begin
      return Ada.Strings.Unbounded.To_String (Object.Get_Date);
   end Get_Date;
   function Get_Date (Object : in User_Ref)
                  return Ada.Strings.Unbounded.Unbounded_String is
      Impl : constant User_Access
         := User_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Date;
   end Get_Date;


   procedure Set_Description (Object : in out User_Ref;
                               Value : in String) is
      Impl : User_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_String (Impl.all, 6, Impl.Description, Value);
   end Set_Description;

   procedure Set_Description (Object : in out User_Ref;
                              Value  : in Ada.Strings.Unbounded.Unbounded_String) is
      Impl : User_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Unbounded_String (Impl.all, 6, Impl.Description, Value);
   end Set_Description;

   function Get_Description (Object : in User_Ref)
                 return String is
   begin
      return Ada.Strings.Unbounded.To_String (Object.Get_Description);
   end Get_Description;
   function Get_Description (Object : in User_Ref)
                  return Ada.Strings.Unbounded.Unbounded_String is
      Impl : constant User_Access
         := User_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Description;
   end Get_Description;


   procedure Set_Status (Object : in out User_Ref;
                         Value  : in Integer) is
      Impl : User_Access;
   begin
      Set_Field (Object, Impl);
      ADO.Objects.Set_Field_Integer (Impl.all, 7, Impl.Status, Value);
   end Set_Status;

   function Get_Status (Object : in User_Ref)
                  return Integer is
      Impl : constant User_Access
         := User_Impl (Object.Get_Load_Object.all)'Access;
   begin
      return Impl.Status;
   end Get_Status;

   --  Copy of the object.
   procedure Copy (Object : in User_Ref;
                   Into   : in out User_Ref) is
      Result : User_Ref;
   begin
      if not Object.Is_Null then
         declare
            Impl : constant User_Access
              := User_Impl (Object.Get_Load_Object.all)'Access;
            Copy : constant User_Access
              := new User_Impl;
         begin
            ADO.Objects.Set_Object (Result, Copy.all'Access);
            Copy.Copy (Impl.all);
            Copy.Version := Impl.Version;
            Copy.Name := Impl.Name;
            Copy.Email := Impl.Email;
            Copy.Date := Impl.Date;
            Copy.Description := Impl.Description;
            Copy.Status := Impl.Status;
         end;
      end if;
      Into := Result;
   end Copy;

   overriding
   procedure Find (Object  : in out User_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Impl  : constant User_Access := new User_Impl;
   begin
      Impl.Find (Session, Query, Found);
      if Found then
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      else
         ADO.Objects.Set_Object (Object, null);
         Destroy (Impl);
      end if;
   end Find;

   procedure Load (Object  : in out User_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier) is
      Impl  : constant User_Access := new User_Impl;
      Found : Boolean;
      Query : ADO.SQL.Query;
   begin
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Set_Filter ("id = ?");
      Impl.Find (Session, Query, Found);
      if not Found then
         Destroy (Impl);
         raise ADO.Objects.NOT_FOUND;
      end if;
      ADO.Objects.Set_Object (Object, Impl.all'Access);
   end Load;

   procedure Load (Object  : in out User_Ref;
                   Session : in out ADO.Sessions.Session'Class;
                   Id      : in ADO.Identifier;
                   Found   : out Boolean) is
      Impl  : constant User_Access := new User_Impl;
      Query : ADO.SQL.Query;
   begin
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Set_Filter ("id = ?");
      Impl.Find (Session, Query, Found);
      if not Found then
         Destroy (Impl);
      else
         ADO.Objects.Set_Object (Object, Impl.all'Access);
      end if;
   end Load;

   procedure Reload (Object  : in out User_Ref;
                     Session : in out ADO.Sessions.Session'Class;
                     Updated : out Boolean) is
      Result : ADO.Objects.Object_Record_Access;
      Impl   : User_Access;
      Query  : ADO.SQL.Query;
      Id     : ADO.Identifier;
   begin
      if Object.Is_Null then
         raise ADO.Objects.NULL_ERROR;
      end if;
      Object.Prepare_Modify (Result);
      Impl := User_Impl (Result.all)'Access;
      Id := ADO.Objects.Get_Key_Value (Impl.all);
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Bind_Param (Position => 2, Value => Impl.Version);
      Query.Set_Filter ("id = ? AND version != ?");
      declare
         Stmt : ADO.Statements.Query_Statement
             := Session.Create_Statement (Query, USER_DEF'Access);
      begin
         Stmt.Execute;
         if Stmt.Has_Elements then
            Updated := True;
            Impl.Load (Stmt, Session);
         else
            Updated := False;
         end if;
      end;
   end Reload;

   overriding
   procedure Save (Object  : in out User_Ref;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl = null then
         Impl := new User_Impl;
         ADO.Objects.Set_Object (Object, Impl);
      end if;
      if not ADO.Objects.Is_Created (Impl.all) then
         Impl.Create (Session);
      else
         Impl.Save (Session);
      end if;
   end Save;

   overriding
   procedure Delete (Object  : in out User_Ref;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Impl : constant ADO.Objects.Object_Record_Access := Object.Get_Object;
   begin
      if Impl /= null then
         Impl.Delete (Session);
      end if;
   end Delete;

   --  --------------------
   --  Free the object
   --  --------------------
   overriding
   procedure Destroy (Object : access User_Impl) is
      type User_Impl_Ptr is access all User_Impl;
      procedure Unchecked_Free is new Ada.Unchecked_Deallocation
              (User_Impl, User_Impl_Ptr);
      pragma Warnings (Off, "*redundant conversion*");
      Ptr : User_Impl_Ptr := User_Impl (Object.all)'Access;
      pragma Warnings (On, "*redundant conversion*");
   begin
      Unchecked_Free (Ptr);
   end Destroy;

   overriding
   procedure Find (Object  : in out User_Impl;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class;
                   Found   : out Boolean) is
      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Query, USER_DEF'Access);
   begin
      Stmt.Execute;
      if Stmt.Has_Elements then
         Object.Load (Stmt, Session);
         Stmt.Next;
         Found := not Stmt.Has_Elements;
      else
         Found := False;
      end if;
   end Find;

   overriding
   procedure Load (Object  : in out User_Impl;
                   Session : in out ADO.Sessions.Session'Class) is
      Found : Boolean;
      Query : ADO.SQL.Query;
      Id    : constant ADO.Identifier := Object.Get_Key_Value;
   begin
      Query.Bind_Param (Position => 1, Value => Id);
      Query.Set_Filter ("id = ?");
      Object.Find (Session, Query, Found);
      if not Found then
         raise ADO.Objects.NOT_FOUND;
      end if;
   end Load;

   overriding
   procedure Save (Object  : in out User_Impl;
                   Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Update_Statement
         := Session.Create_Statement (USER_DEF'Access);
   begin
      if Object.Is_Modified (1) then
         Stmt.Save_Field (Name  => COL_0_1_NAME, --  id
                          Value => Object.Get_Key);
         Object.Clear_Modified (1);
      end if;
      if Object.Is_Modified (3) then
         Stmt.Save_Field (Name  => COL_2_1_NAME, --  name
                          Value => Object.Name);
         Object.Clear_Modified (3);
      end if;
      if Object.Is_Modified (4) then
         Stmt.Save_Field (Name  => COL_3_1_NAME, --  email
                          Value => Object.Email);
         Object.Clear_Modified (4);
      end if;
      if Object.Is_Modified (5) then
         Stmt.Save_Field (Name  => COL_4_1_NAME, --  date
                          Value => Object.Date);
         Object.Clear_Modified (5);
      end if;
      if Object.Is_Modified (6) then
         Stmt.Save_Field (Name  => COL_5_1_NAME, --  description
                          Value => Object.Description);
         Object.Clear_Modified (6);
      end if;
      if Object.Is_Modified (7) then
         Stmt.Save_Field (Name  => COL_6_1_NAME, --  status
                          Value => Object.Status);
         Object.Clear_Modified (7);
      end if;
      if Stmt.Has_Save_Fields then
         Object.Version := Object.Version + 1;
         Stmt.Save_Field (Name  => "version",
                          Value => Object.Version);
         Stmt.Set_Filter (Filter => "id = ? and version = ?");
         Stmt.Add_Param (Value => Object.Get_Key);
         Stmt.Add_Param (Value => Object.Version - 1);
         declare
            Result : Integer;
         begin
            Stmt.Execute (Result);
            if Result /= 1 then
               if Result /= 0 then
                  raise ADO.Objects.UPDATE_ERROR;
               else
                  raise ADO.Objects.LAZY_LOCK;
               end if;
            end if;
         end;
      end if;
   end Save;

   overriding
   procedure Create (Object  : in out User_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Query : ADO.Statements.Insert_Statement
                  := Session.Create_Statement (USER_DEF'Access);
      Result : Integer;
   begin
      Object.Version := 1;
      Session.Allocate (Id => Object);
      Query.Save_Field (Name  => COL_0_1_NAME, --  id
                        Value => Object.Get_Key);
      Query.Save_Field (Name  => COL_1_1_NAME, --  object_version
                        Value => Object.Version);
      Query.Save_Field (Name  => COL_2_1_NAME, --  name
                        Value => Object.Name);
      Query.Save_Field (Name  => COL_3_1_NAME, --  email
                        Value => Object.Email);
      Query.Save_Field (Name  => COL_4_1_NAME, --  date
                        Value => Object.Date);
      Query.Save_Field (Name  => COL_5_1_NAME, --  description
                        Value => Object.Description);
      Query.Save_Field (Name  => COL_6_1_NAME, --  status
                        Value => Object.Status);
      Query.Execute (Result);
      if Result /= 1 then
         raise ADO.Objects.INSERT_ERROR;
      end if;
      ADO.Objects.Set_Created (Object);
   end Create;

   overriding
   procedure Delete (Object  : in out User_Impl;
                     Session : in out ADO.Sessions.Master_Session'Class) is
      Stmt : ADO.Statements.Delete_Statement
         := Session.Create_Statement (USER_DEF'Access);
   begin
      Stmt.Set_Filter (Filter => "id = ?");
      Stmt.Add_Param (Value => Object.Get_Key);
      Stmt.Execute;
   end Delete;

   --  ------------------------------
   --  Get the bean attribute identified by the name.
   --  ------------------------------
   overriding
   function Get_Value (From : in User_Ref;
                       Name : in String) return Util.Beans.Objects.Object is
      Obj  : ADO.Objects.Object_Record_Access;
      Impl : access User_Impl;
   begin
      if From.Is_Null then
         return Util.Beans.Objects.Null_Object;
      end if;
      Obj := From.Get_Load_Object;
      Impl := User_Impl (Obj.all)'Access;
      if Name = "id" then
         return ADO.Objects.To_Object (Impl.Get_Key);
      elsif Name = "name" then
         return Util.Beans.Objects.To_Object (Impl.Name);
      elsif Name = "email" then
         return Util.Beans.Objects.To_Object (Impl.Email);
      elsif Name = "date" then
         return Util.Beans.Objects.To_Object (Impl.Date);
      elsif Name = "description" then
         return Util.Beans.Objects.To_Object (Impl.Description);
      elsif Name = "status" then
         return Util.Beans.Objects.To_Object (Long_Long_Integer (Impl.Status));
      end if;
      return Util.Beans.Objects.Null_Object;
   end Get_Value;


   procedure List (Object  : in out User_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Query   : in ADO.SQL.Query'Class) is
      Stmt : ADO.Statements.Query_Statement
        := Session.Create_Statement (Query, USER_DEF'Access);
   begin
      Stmt.Execute;
      User_Vectors.Clear (Object);
      while Stmt.Has_Elements loop
         declare
            Item : User_Ref;
            Impl : constant User_Access := new User_Impl;
         begin
            Impl.Load (Stmt, Session);
            ADO.Objects.Set_Object (Item, Impl.all'Access);
            Object.Append (Item);
         end;
         Stmt.Next;
      end loop;
   end List;

   --  ------------------------------
   --  Load the object from current iterator position
   --  ------------------------------
   procedure Load (Object  : in out User_Impl;
                   Stmt    : in out ADO.Statements.Query_Statement'Class;
                   Session : in out ADO.Sessions.Session'Class) is
      pragma Unreferenced (Session);
   begin
      Object.Set_Key_Value (Stmt.Get_Identifier (0));
      Object.Name := Stmt.Get_Unbounded_String (2);
      Object.Email := Stmt.Get_Unbounded_String (3);
      Object.Date := Stmt.Get_Unbounded_String (4);
      Object.Description := Stmt.Get_Unbounded_String (5);
      Object.Status := Stmt.Get_Integer (6);
      Object.Version := Stmt.Get_Integer (1);
      ADO.Objects.Set_Created (Object);
   end Load;
   --  --------------------
   --  
   --  --------------------
   procedure List (Object  : in out User_Info_Vector;
                   Session : in out ADO.Sessions.Session'Class;
                   Context : in out ADO.Queries.Context'Class) is
      procedure Read (Into : in out User_Info);

      Stmt : ADO.Statements.Query_Statement
          := Session.Create_Statement (Context);
      Pos  : Positive := 1;
      procedure Read (Into : in out User_Info) is
      begin
         Into.Id := Stmt.Get_Identifier (0);
         Into.Name := Stmt.Get_Unbounded_String (1);
         Into.Email := Stmt.Get_Unbounded_String (2);
      end Read;
   begin
      Stmt.Execute;
      User_Info_Vectors.Clear (Object);
      while Stmt.Has_Elements loop
         Object.Insert_Space (Before => Pos);
         Object.Update_Element (Index => Pos, Process => Read'Access);
         Pos := Pos + 1;
         Stmt.Next;
      end loop;
   end List;



end Samples.User.Model;
