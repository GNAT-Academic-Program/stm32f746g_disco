with Gpio;
with Gpio_Types;
with Board_GPIO;

package body LTDC_GPIO is

   procedure Configure is
      AF14_Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode       => Gpio_Types.Alternate,
         Pull       => Gpio_Types.None,
         Drive      => Gpio_Types.Push_Pull,
         Speed      => Gpio_Types.Very_High_Speed,
         Init_State => Gpio_Types.Low,
         AF         => 14);

      AF9_Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode       => Gpio_Types.Alternate,
         Pull       => Gpio_Types.None,
         Drive      => Gpio_Types.Push_Pull,
         Speed      => Gpio_Types.Very_High_Speed,
         Init_State => Gpio_Types.Low,
         AF         => 9);

      Out_Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode       => Gpio_Types.Output,
         Pull       => Gpio_Types.Pull_Down,
         Drive      => Gpio_Types.Push_Pull,
         Speed      => Gpio_Types.Low_Speed,
         Init_State => Gpio_Types.Low);
   begin
      --  Control pins AF14
      Gpio.Configure (Board_GPIO.LCD_VSYNC, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_HSYNC, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_NC,    AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_CLK,   AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_DE,    AF14_Cfg);

      --  Red AF14
      Gpio.Configure (Board_GPIO.LCD_R2, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_R3, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_R4, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_R5, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_R6, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_R7, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_R8, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_R9, AF14_Cfg);

      --  Green AF14
      Gpio.Configure (Board_GPIO.LCD_G2, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_G3, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_G4, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_G5, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_G6, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_G7, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_G8, AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_G9, AF14_Cfg);

      --  Blue AF14 (except B4)
      Gpio.Configure (Board_GPIO.LCD_B1,  AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_B4,  AF9_Cfg);  --  PG12, AF9
      Gpio.Configure (Board_GPIO.LCD_B5,  AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_B6,  AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_B7,  AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_B8,  AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_B9,  AF14_Cfg);
      Gpio.Configure (Board_GPIO.LCD_B10, AF14_Cfg);

      --  Enable and backlight — output
      Gpio.Configure (Board_GPIO.LCD_ENABLE,  Out_Cfg);
      Gpio.Configure (Board_GPIO.LCD_BL_CTRL, Out_Cfg);

      --  Assert enable and backlight
      Gpio.Set (Board_GPIO.LCD_ENABLE);
      Gpio.Set (Board_GPIO.LCD_BL_CTRL);
   end Configure;

end LTDC_GPIO;
