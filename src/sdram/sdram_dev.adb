with IS42S32400F_Dev;

package body SDRAM_Dev is

   ---------------
   -- Configure --
   ---------------

   procedure Configure is
   begin
      IS42S32400F_Dev.Configure;
   end Configure;

   -------------------
   -- Init_Sequence --
   -------------------

   procedure Init_Sequence is
   begin
      IS42S32400F_Dev.Init_Sequence;
   end Init_Sequence;

   ----------
   -- Busy --
   ----------

   function Busy return Boolean is (IS42S32400F_Dev.Busy);

   --------------------
   -- Is_Initialized --
   --------------------

   function Is_Initialized return Boolean is (IS42S32400F_Dev.Is_Initialized);

   -------------
   -- Reserve --
   -------------

   function Reserve
     (Amount : UInt32;
      Align  : UInt32 := Standard'Maximum_Alignment)
      return System.Address
   is (IS42S32400F_Dev.Reserve (Amount, Align));

   ----------
   -- Fill --
   ----------

   procedure Fill
     (Addr  : System.Address;
      Size  : UInt32;
      Value : UInt8 := 0)
   is
      type Byte_Array is array (UInt32 range <>) of UInt8 with Pack;
      Buf : Byte_Array (1 .. Size) with Address => Addr, Volatile;
   begin
      for B of Buf loop
         B := Value;
      end loop;
   end Fill;

   ------------------
   -- Base_Address --
   ------------------

   function Base_Address return System.Address is
     (IS42S32400F_Dev.Base_Address);

   -----------------
   -- Buffer_Size --
   -----------------

   function Buffer_Size return UInt32 is
     (IS42S32400F_Dev.Buffer_Size);

end SDRAM_Dev;
