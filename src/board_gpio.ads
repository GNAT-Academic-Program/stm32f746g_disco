--  Board_GPIO — complete GPIO pin map for STM32F746G-DISCO.
--  Every pin used on this board is declared here.
--  One file, full picture — no scavenging through peripheral files.

with Gpio;
with STM32F746_GPIO;

package Board_GPIO is

   --  LD1 — green user LED, active-high
   Led : constant Gpio.Pin :=
     STM32F746_GPIO.Make_Pin (STM32F746_GPIO.I, 1);   --  PI1

   --  B1 — blue user button, active-high
   Button : constant Gpio.Pin :=
     STM32F746_GPIO.Make_Pin (STM32F746_GPIO.I, 11);  --  PI11

   --  USART1 — ST-LINK VCP (USB console), AF7
   Console_TX : constant Gpio.Pin :=
     STM32F746_GPIO.Make_Pin (STM32F746_GPIO.A, 9);   --  PA9
   Console_RX : constant Gpio.Pin :=
     STM32F746_GPIO.Make_Pin (STM32F746_GPIO.B, 7);   --  PB7

   --  I2C1 — Arduino CN2 header D15/D14, AF4, open-drain
   I2C1_SCL : constant Gpio.Pin :=
     STM32F746_GPIO.Make_Pin (STM32F746_GPIO.B, 8);   --  PB8
   I2C1_SDA : constant Gpio.Pin :=
     STM32F746_GPIO.Make_Pin (STM32F746_GPIO.B, 9);   --  PB9

   --  I2C3 — FT5336 touch controller, AF4, open-drain
   I2C3_SCL : constant Gpio.Pin :=
     STM32F746_GPIO.Make_Pin (STM32F746_GPIO.H, 7);   --  PH7
   I2C3_SDA : constant Gpio.Pin :=
     STM32F746_GPIO.Make_Pin (STM32F746_GPIO.H, 8);   --  PH8

   --  FMC — IS42S32400F SDRAM, AF12
   --  Address lines A0..A11
   FMC_A0  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.F, 0);
   FMC_A1  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.F, 1);
   FMC_A2  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.F, 2);
   FMC_A3  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.F, 3);
   FMC_A4  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.F, 4);
   FMC_A5  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.F, 5);
   FMC_A6  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.F, 12);
   FMC_A7  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.F, 13);
   FMC_A8  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.F, 14);
   FMC_A9  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.F, 15);
   FMC_A10 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.G, 0);
   FMC_A11 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.G, 1);

   --  Data lines D0..D15
   FMC_D0  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.D, 14);
   FMC_D1  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.D, 15);
   FMC_D2  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.D, 0);
   FMC_D3  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.D, 1);
   FMC_D4  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.E, 7);
   FMC_D5  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.E, 8);
   FMC_D6  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.E, 9);
   FMC_D7  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.E, 10);
   FMC_D8  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.E, 11);
   FMC_D9  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.E, 12);
   FMC_D10 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.E, 13);
   FMC_D11 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.E, 14);
   FMC_D12 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.E, 15);
   FMC_D13 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.D, 8);
   FMC_D14 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.D, 9);
   FMC_D15 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.D, 10);

   --  Control lines
   FMC_SDNWE  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.H, 5);
   FMC_SDNRAS : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.F, 11);
   FMC_SDNCAS : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.G, 15);
   FMC_SDCLK  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.G, 8);
   FMC_BA0    : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.G, 4);
   FMC_BA1    : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.G, 5);
   FMC_SDNE0  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.H, 3);
   FMC_SDCKE0 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.C, 3);
   FMC_NBL0   : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.E, 0);
   FMC_NBL1   : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.E, 1);

   --  LTDC — RK043FN48H display panel
   --  Control pins (AF14)
   LCD_VSYNC  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.I, 9);
   LCD_HSYNC  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.I, 10);
   LCD_NC     : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.I, 8);
   LCD_CLK    : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.I, 14);
   LCD_DE     : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.K, 7);

   --  Red (AF14)
   LCD_R2  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.I, 15);
   LCD_R3  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 0);
   LCD_R4  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 1);
   LCD_R5  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 2);
   LCD_R6  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 3);
   LCD_R7  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 4);
   LCD_R8  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 5);
   LCD_R9  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 6);

   --  Green (AF14)
   LCD_G2  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 7);
   LCD_G3  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 8);
   LCD_G4  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 9);
   LCD_G5  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 10);
   LCD_G6  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 11);
   LCD_G7  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.K, 0);
   LCD_G8  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.K, 1);
   LCD_G9  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.K, 2);

   --  Blue (AF14 except B4)
   LCD_B1  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.E, 4);
   LCD_B4  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.G, 12); -- AF9
   LCD_B5  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 13);
   LCD_B6  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 14);
   LCD_B7  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.J, 15);
   LCD_B8  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.K, 4);
   LCD_B9  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.K, 5);
   LCD_B10 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.K, 6);

   --  Enable and backlight (output, active-high)
   LCD_ENABLE  : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.I, 12);
   LCD_BL_CTRL : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.K, 3);

end Board_GPIO;