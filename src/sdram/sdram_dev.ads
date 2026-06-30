with MT;     use MT;
with System;

--  SDRAM_Dev is the board-level SDRAM adapter for STM32F746G-DISCO.
--  Delegates chip operations to IS42S32400F_Dev.
--  GPIO configuration lives in SDRAM_1_GPIO.

package SDRAM_Dev is

   procedure Configure;
   --  Configure FMC peripheral (delegates to IS42S32400F_Dev).

   procedure Init_Sequence;
   --  Initialize SDRAM chip.

   function Busy return Boolean;
   function Is_Initialized return Boolean;

   function Reserve
     (Amount : UInt32;
      Align  : UInt32 := Standard'Maximum_Alignment)
      return System.Address;

   procedure Fill
     (Addr  : System.Address;
      Size  : UInt32;
      Value : UInt8 := 0);
   --  Fill Size bytes at Addr with Value.
   --  Used to clear freshly allocated SDRAM buffers before hardware reads them.

   function Base_Address return System.Address;
   function Buffer_Size  return UInt32;

end SDRAM_Dev;