with Gpio;
with Gpio_Types;
with Board_GPIO;

package body I2C_3_GPIO is

   procedure Configure is
      Af_Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode       => Gpio_Types.Alternate,
         Pull       => Gpio_Types.Pull_Up,
         Drive      => Gpio_Types.Open_Drain,
         Speed      => Gpio_Types.Low_Speed,
         Init_State => Gpio_Types.High,
         AF         => 4);
   begin
      Gpio.Configure (Board_GPIO.I2C3_SCL, Af_Cfg);
      Gpio.Configure (Board_GPIO.I2C3_SDA, Af_Cfg);
   end Configure;

end I2C_3_GPIO;
