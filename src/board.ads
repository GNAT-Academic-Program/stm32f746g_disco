with Instances;
with Board_GPIO;

with Gpio;
with STM32F746_DMA2D;
with STM32F746_LTDC;

package Board is

   --  -------------------------------------------------------------------
   --  Buses (vendor-neutral facades over MCU-level instances)
   --  -------------------------------------------------------------------

   --  Console: USART1 TX=PA9 (AF7), RX=PB7 (AF7) — wired to ST-LINK VCP/USB
   package Console renames Instances.Console;

   --  I2C1: SCL = PB8 (AF4) = Arduino D15 on CN2 connector
   --        SDA = PB9 (AF4) = Arduino D14 on CN2 connector
   package I2C_1 renames Instances.I2C_1;

   --  I2C3: SCL = PH7 (AF4), SDA = PH8 (AF4) — FT5336 touch controller
   package I2C_3 renames Instances.I2C_3;

   --  -------------------------------------------------------------------
   --  SDRAM (IS42S32400F, FMC bank 1, base 0xC000_0000, 8 MB)
   --  Initialized automatically by Board.Initialize.
   --  -------------------------------------------------------------------

   package SDRAM_1 renames Instances.SDRAM_1;

   --  -------------------------------------------------------------------
   --  Display, framebuffer, touch, and RNG
   --  Initialized automatically by Board.Initialize.
   --  App owns layer configuration and gesture thresholds.
   --  -------------------------------------------------------------------

   package RNG_1   renames Instances.RNG_1;
   package DC_1    renames Instances.DC_1;
   package FB_1    renames Instances.FB_1;
   package Touch_1 renames Instances.Touch_1;
   package DMA2D   renames STM32F746_DMA2D;

   --  Display dimensions — board fact, not app fact
   LCD_Width  : constant Positive := STM32F746_LTDC.LCD_Width;
   LCD_Height : constant Positive := STM32F746_LTDC.LCD_Height;

   --  -------------------------------------------------------------------
   --  GPIO pins (board-specific, STM32F746G-DISCO)
   --  -------------------------------------------------------------------

   Led    : Gpio.Pin renames Board_GPIO.Led;
   Button : Gpio.Pin renames Board_GPIO.Button;

   procedure Initialize;
   --  Brings up all peripherals in order.
   --  After this returns, SDRAM, DMA2D, display, touch and RNG are ready.
   --  App is responsible for: FB layer init, gesture thresholds, polling loop.

   function Button_Pressed return Boolean;

end Board;
