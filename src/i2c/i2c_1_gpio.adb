with Gpio;
with Gpio_Types;
with Board_GPIO;
with Debug;

package body I2C_1_GPIO is

   procedure Configure is
      Input_Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode => Gpio_Types.Input,
         Pull => Gpio_Types.Pull_Up);

      Af_Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode       => Gpio_Types.Alternate,
         Pull       => Gpio_Types.Pull_Up,
         Drive      => Gpio_Types.Open_Drain,
         Speed      => Gpio_Types.Low_Speed,
         Init_State => Gpio_Types.High,
         AF         => 4);
   begin
      Gpio.Configure (Board_GPIO.I2C1_SCL, Input_Cfg);
      Gpio.Configure (Board_GPIO.I2C1_SDA, Input_Cfg);
      Debug.Put_Line ("Pre-AF: SCL=" & Gpio.Read (Board_GPIO.I2C1_SCL)'Image
                     & " SDA=" & Gpio.Read (Board_GPIO.I2C1_SDA)'Image);
      Gpio.Configure (Board_GPIO.I2C1_SCL, Af_Cfg);
      Gpio.Configure (Board_GPIO.I2C1_SDA, Af_Cfg);
   end Configure;

end I2C_1_GPIO;
