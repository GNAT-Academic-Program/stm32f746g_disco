with Gpio_Types;
with Usart_Types;
with STM32F746_GPIO;
with MT; use MT;

with Debug;

with STM32F746.GPIO;

with Last_Chance_Handler;
pragma Unreferenced (Last_Chance_Handler);

package body Board is

   use type Gpio_Types.Logic_Level;

   --  -------------------------------------------------------------------
   --  GPIO initialization (per-bus; private to this body)
   --  -------------------------------------------------------------------

   procedure Init_Led_Gpio is
      Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode       => Gpio_Types.Output,
         Pull       => Gpio_Types.None,
         Drive      => Gpio_Types.Push_Pull,
         Speed      => Gpio_Types.Low_Speed,
         Init_State => Gpio_Types.Low);
   begin
      Gpio.Configure (Led, Cfg);
   end Init_Led_Gpio;

   procedure Init_Button_Gpio is
      --  B1 (blue) on PI11, active-high. Pull-down keeps it defined.
      Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode => Gpio_Types.Input,
         Pull => Gpio_Types.Pull_Down);
   begin
      Gpio.Configure (Button, Cfg);
   end Init_Button_Gpio;

   procedure Init_Console_Gpio is
      --  USART1 TX on PA9 (AF7), RX on PB7 (AF7). Pull-up biases idle-high.
      Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode       => Gpio_Types.Alternate,
         Pull       => Gpio_Types.Pull_Up,
         Drive      => Gpio_Types.Push_Pull,
         Speed      => Gpio_Types.Very_High_Speed,
         Init_State => Gpio_Types.High,
         AF         => 7);

      PA9 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.A, 9);
      PB7 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.B, 7);
   begin
      Gpio.Configure (PA9, Cfg);
      Gpio.Configure (PB7, Cfg);
   end Init_Console_Gpio;

   procedure Init_I2C_1_Gpio is
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

      --  I2C1: SCL=PB8, SDA=PB9 (AF4) — Arduino D15/D14 + CN2.
      PB8 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.B, 8);
      PB9 : constant Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.B, 9);
   begin
      --  Float-with-pullup probe: real bus pullups should hold both high.
      Gpio.Configure (PB8, Input_Cfg);
      Gpio.Configure (PB9, Input_Cfg);
      Debug.Put_Line ("Pre-AF: SCL=" & Gpio.Read (PB8)'Image
                     & " SDA=" & Gpio.Read (PB9)'Image);

      Gpio.Configure (PB8, Af_Cfg);  --  I2C1_SCL, AF4
      Gpio.Configure (PB9, Af_Cfg);  --  I2C1_SDA, AF4
   end Init_I2C_1_Gpio;

   --  -------------------------------------------------------------------
   --  Public entry points
   --  -------------------------------------------------------------------

   procedure Initialize is
   begin
      Init_Led_Gpio;
      Init_Button_Gpio;
      Init_Console_Gpio;

      Console.Open
        (Console_Dev,
         (Baud      => Usart_Types.B115200,
          Data_Bits => Usart_Types.Data_8,
          Parity    => Usart_Types.None,
          Stop_Bits => Usart_Types.Stop_1,
          Flow      => Usart_Types.None));

      Init_I2C_1_Gpio;
   end Initialize;

   function Button_Pressed return Boolean is
   begin
      return Gpio.Read (Button) = 1;
   end Button_Pressed;

end Board;