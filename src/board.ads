with Instances;

with Gpio;
with STM32F746_GPIO;

with Usart_Interface;
with I2C_Interface;

package Board is

   --  -------------------------------------------------------------------
   --  Buses (vendor-neutral facades over MCU-level instances)
   --
   --  Naming reflects the silicon wiring on the STM32F746G-DISCO.
   --  -------------------------------------------------------------------

   --  Console: USART1 TX=PA9 (AF7), RX=PB7 (AF7) — wired to ST-LINK VCP/USB
   package Console is new Usart_Interface
     (Device_T       => Instances.Console.Device,
      Driver_Init    => Instances.Console.Init,
      Driver_Enable  => Instances.Console.Enable,
      Driver_Disable => Instances.Console.Disable,
      Driver_Reset   => Instances.Console.Reset,
      Driver_Tx_Push => Instances.Console.Tx_Push,
      Driver_Rx_Pop  => Instances.Console.Rx_Pop);

   --  SCL = PB8 (AF4) = Arduino D15 on CN2 connector
   --  SDA = PB9 (AF4) = Arduino D14 on CN2 connector
   package I2C_1 is new I2C_Interface
     (Device_T           => Instances.I2C_1.Device,
      Driver_Init        => Instances.I2C_1.Init,
      Driver_Enable      => Instances.I2C_1.Enable,
      Driver_Disable     => Instances.I2C_1.Disable,
      Driver_Reset       => Instances.I2C_1.Reset,
      Driver_Recover     => Instances.I2C_1.Recover,
      Driver_Probe       => Instances.I2C_1.Probe,
      Driver_Begin_Write => Instances.I2C_1.Begin_Write,
      Driver_Begin_Read  => Instances.I2C_1.Begin_Read,
      Driver_Send        => Instances.I2C_1.Send,
      Driver_Recv        => Instances.I2C_1.Recv);

   --  -------------------------------------------------------------------
   --  Singletons (mutable; one per bus). Created from the MCU-level
   --  instances (Instances.*.Make_Device), not from the facades — the
   --  facades don't expose Make_Device.
   --  -------------------------------------------------------------------

   Console_Dev : aliased Board.Console.Device := Instances.Console.Make_Device;
   I2C_1_Dev   : aliased Board.I2C_1.Device   := Instances.I2C_1.Make_Device;

   --  -------------------------------------------------------------------
   --  GPIO pins (board-specific, STM32F746G-DISCO)
   --  -------------------------------------------------------------------

   --  LD1 (user LED) = PI1; B1 (user/blue button) = PI11.
   Led    : Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.I, 1);
   Button : Gpio.Pin := STM32F746_GPIO.Make_Pin (STM32F746_GPIO.I, 11);

   procedure Initialize;

   --  True when the user button B1 is pressed (active-high on this board).
   function Button_Pressed return Boolean;

end Board;