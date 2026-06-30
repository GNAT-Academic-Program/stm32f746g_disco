with Gpio_Types;
with Usart_Types;
with I2C_Types;
with FB_Types;
with Board_GPIO;
with MT;

with Last_Chance_Handler;
pragma Unreferenced (Last_Chance_Handler);

with IS42S32400F_Dev;
with STM32F746_DMA2D;
with FT5336_Interface;

with Console_GPIO;
with I2C_3_GPIO;
with SDRAM_1_GPIO;
with LTDC_GPIO;
with Debug;

package body Board is

   use type MT.Bit;

   --  -------------------------------------------------------------------
   --  GPIO initialization
   --  -------------------------------------------------------------------

   procedure Init_Led_Gpio is
      Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode       => Gpio_Types.Output,
         Pull       => Gpio_Types.None,
         Drive      => Gpio_Types.Push_Pull,
         Speed      => Gpio_Types.Low_Speed,
         Init_State => Gpio_Types.Low);
   begin
      Gpio.Configure (Board_GPIO.Led, Cfg);
   end Init_Led_Gpio;

   procedure Init_Button_Gpio is
      Cfg : constant Gpio_Types.Gpio_Config :=
        (Mode => Gpio_Types.Input,
         Pull => Gpio_Types.Pull_Down);
   begin
      Gpio.Configure (Board_GPIO.Button, Cfg);
   end Init_Button_Gpio;

   --  -------------------------------------------------------------------
   --  Public entry points
   --  -------------------------------------------------------------------

   procedure Initialize is
   begin
      --  GPIO: LED and button
      Init_Led_Gpio;
      Init_Button_Gpio;

      --  Console
      Console_GPIO.Configure;
      Console.Open
        ((Baud      => Usart_Types.B115200,
          Data_Bits => Usart_Types.Data_8,
          Parity    => Usart_Types.None,
          Stop_Bits => Usart_Types.Stop_1,
          Flow      => Usart_Types.None));

      --  I2C3 for FT5336 touch controller
      I2C_3_GPIO.Configure;
      Debug.Put_Line ("I2C3 GPIO configured");
      I2C_3.Open ((Speed => I2C_Types.Standard_Mode,
                   Role  => I2C_Types.Master_Only));
      Debug.Put_Line ("I2C3 opened");

      --  SDRAM: GPIO first, then chip init
      SDRAM_1_GPIO.Configure;
      Debug.Put_Line ("SDRAM GPIO configured");
      IS42S32400F_Dev.Configure;
      Debug.Put_Line ("SDRAM controller configured");
      IS42S32400F_Dev.Init_Sequence;
      Debug.Put_Line ("SDRAM init sequence done");

      --  DMA2D: Initialize BEFORE LTDC to avoid clock conflicts
      STM32F746_DMA2D.Initialize;
      Debug.Put_Line ("DMA2D initialized");

      --  LTDC: GPIO first, then controller init via FB
      LTDC_GPIO.Configure;
      Debug.Put_Line ("LTDC GPIO configured");
      --  The working reference 2048 path initializes the framebuffer in
      --  polling mode. Do the same here so LTDC reload interrupt plumbing is
      --  not involved during board bring-up.
      FB_1.Initialize (Mode => FB_Types.Polling);
      Debug.Put_Line ("FB initialized");

      --  Touch: Wait 200ms after power-up, then initialize on I2C3
      delay 0.2;
      Touch_1.Initialize (Enable_Interrupts => False);
      Debug.Put_Line ("Touch initialized");
      Instances.FT5336_1.Driver_Set_Bounds
        (Width  => LCD_Width,
         Height => LCD_Height,
         Swap   => (Invert_X => False, Invert_Y => False, Swap_XY => False));
      Debug.Put_Line ("Touch bounds set");

      --  RNG
      RNG_1.Initialize;
      Debug.Put_Line ("RNG initialized");
   end Initialize;

   function Button_Pressed return Boolean is
   begin
      return Gpio.Read (Board_GPIO.Button) = 1;
   end Button_Pressed;

end Board;
