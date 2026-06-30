--  SDRAM_1_GPIO — FMC GPIO configuration for STM32F746G-DISCO.
--  38 FMC pins for IS42S32400F SDRAM, all AF12.

package SDRAM_1_GPIO is

   procedure Configure;
   --  Configure all FMC pins (address, data, control) for SDRAM.

end SDRAM_1_GPIO;
