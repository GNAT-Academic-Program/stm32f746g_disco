with Gpio;
with Gpio_Types;
with Board_GPIO;

package body Console_GPIO is

   procedure Configure is
      Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode       => Gpio_Types.Alternate,
         Pull       => Gpio_Types.Pull_Up,
         Drive      => Gpio_Types.Push_Pull,
         Speed      => Gpio_Types.Very_High_Speed,
         Init_State => Gpio_Types.High,
         AF         => 7);
   begin
      Gpio.Configure (Board_GPIO.Console_TX, Cfg);
      Gpio.Configure (Board_GPIO.Console_RX, Cfg);
   end Configure;

end Console_GPIO;
