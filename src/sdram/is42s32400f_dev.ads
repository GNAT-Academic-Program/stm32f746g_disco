with MT;     use MT;
with System;

--  IS42S32400F_Dev instantiates IS42S32400F_Interface with FMC SVD primitives.
--  Chip-level dev file — mirrors W25Q128_Dev pattern.
--  GPIO wiring is board-specific and lives in SDRAM_Dev (stm32f746g_disco).

package IS42S32400F_Dev is

   procedure Configure;
   procedure Init_Sequence;
   function  Busy           return Boolean;
   function  Is_Initialized return Boolean;

   function Reserve
     (Amount : UInt32;
      Align  : UInt32 := Standard'Maximum_Alignment)
      return System.Address;

   function Base_Address return System.Address;
   function Buffer_Size  return UInt32;

end IS42S32400F_Dev;