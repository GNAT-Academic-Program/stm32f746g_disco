with Gpio;
with Gpio_Types;
with Board_GPIO;

package body SDRAM_1_GPIO is

   procedure Configure is
      Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode       => Gpio_Types.Alternate,
         Pull       => Gpio_Types.Pull_Up,
         Drive      => Gpio_Types.Push_Pull,
         Speed      => Gpio_Types.Very_High_Speed,
         Init_State => Gpio_Types.High,
         AF         => 12);  --  AF12 for FMC
   begin
      --  Configure address pins
      Gpio.Configure (Board_GPIO.FMC_A0, Cfg);
      Gpio.Configure (Board_GPIO.FMC_A1, Cfg);
      Gpio.Configure (Board_GPIO.FMC_A2, Cfg);
      Gpio.Configure (Board_GPIO.FMC_A3, Cfg);
      Gpio.Configure (Board_GPIO.FMC_A4, Cfg);
      Gpio.Configure (Board_GPIO.FMC_A5, Cfg);
      Gpio.Configure (Board_GPIO.FMC_A6, Cfg);
      Gpio.Configure (Board_GPIO.FMC_A7, Cfg);
      Gpio.Configure (Board_GPIO.FMC_A8, Cfg);
      Gpio.Configure (Board_GPIO.FMC_A9, Cfg);
      Gpio.Configure (Board_GPIO.FMC_A10, Cfg);
      Gpio.Configure (Board_GPIO.FMC_A11, Cfg);

      --  Configure data pins
      Gpio.Configure (Board_GPIO.FMC_D0, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D1, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D2, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D3, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D4, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D5, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D6, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D7, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D8, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D9, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D10, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D11, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D12, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D13, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D14, Cfg);
      Gpio.Configure (Board_GPIO.FMC_D15, Cfg);

      --  Configure control pins
      Gpio.Configure (Board_GPIO.FMC_SDNWE, Cfg);
      Gpio.Configure (Board_GPIO.FMC_SDNRAS, Cfg);
      Gpio.Configure (Board_GPIO.FMC_SDNCAS, Cfg);
      Gpio.Configure (Board_GPIO.FMC_SDCLK, Cfg);
      Gpio.Configure (Board_GPIO.FMC_BA0, Cfg);
      Gpio.Configure (Board_GPIO.FMC_BA1, Cfg);
      Gpio.Configure (Board_GPIO.FMC_SDNE0, Cfg);
      Gpio.Configure (Board_GPIO.FMC_SDCKE0, Cfg);
      Gpio.Configure (Board_GPIO.FMC_NBL0, Cfg);
      Gpio.Configure (Board_GPIO.FMC_NBL1, Cfg);
   end Configure;

end SDRAM_1_GPIO;
