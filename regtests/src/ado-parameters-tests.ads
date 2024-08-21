-----------------------------------------------------------------------
--  ado-parameters-tests -- Test query parameters and SQL expansion
--  Copyright (C) 2011, 2012, 2017 Stephane Carrez
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

with Util.Tests;
package ADO.Parameters.Tests is

   procedure Add_Tests (Suite : in Util.Tests.Access_Test_Suite);

   type Test is new Util.Tests.Test with null record;

   --  Test expand SQL with parameters.
   procedure Test_Expand_Sql (T : in out Test);

   --  Test expand with invalid parameters.
   procedure Test_Expand_Error (T : in out Test);

   --  Test expand performance.
   procedure Test_Expand_Perf (T : in out Test);

   --  Test expand with cache expander.
   procedure Test_Expand_With_Expander (T : in out Test);

end ADO.Parameters.Tests;
