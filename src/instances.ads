with STM32F746_USART;
with STM32F746_I2C;
with STM32F746_RNG;
with STM32F746_LTDC;
with STM32F746.USART;
with STM32F746.I2C;
with Clock_Tree;
with Usart_Interface;
with I2C_Interface;
with SDRAM_Interface;
with SDRAM_Dev;
with DC_Interface;
with FB_Interface;
with Touch_Interface;
with RNG_Interface;
with FT5336_Interface;
with IS42S32400F_Dev;

package Instances is

   --  Console: USART1, wired to the ST-LINK VCP (USB) on the F746G-DISCO.
   package USART_1 is new STM32F746_USART
     (Periph     => STM32F746.USART.USART1_Periph'Access,
      Get_Clock  => Clock_Tree.Get_USART1_Clock,
      RCC_Enable => Clock_Tree.Enable_USART1,
      RCC_Reset  => Clock_Tree.Reset_USART1);

   package Console is new Usart_Interface
     (Driver_Init    => USART_1.Init,
      Driver_Enable  => USART_1.Enable,
      Driver_Disable => USART_1.Disable,
      Driver_Reset   => USART_1.Reset,
      Driver_Tx_Push => USART_1.Tx_Push,
      Driver_Rx_Pop  => USART_1.Rx_Pop);

   --  I2C1: Arduino header D15/D14 + CN2 extension (SCL=PB8, SDA=PB9, AF4).
   package I2C_1_HW is new STM32F746_I2C
     (Base       => STM32F746.I2C.I2C1_Periph'Address,
      Get_Clock  => Clock_Tree.Get_I2C1_Clock,
      RCC_Enable => Clock_Tree.Enable_I2C1,
      RCC_Reset  => Clock_Tree.Reset_I2C1);

   package I2C_1 is new I2C_Interface
     (Driver_Init        => I2C_1_HW.Init,
      Driver_Enable      => I2C_1_HW.Enable,
      Driver_Disable     => I2C_1_HW.Disable,
      Driver_Reset       => I2C_1_HW.Reset,
      Driver_Recover     => I2C_1_HW.Recover,
      Driver_Probe       => I2C_1_HW.Probe,
      Driver_Begin_Write => I2C_1_HW.Begin_Write,
      Driver_Begin_Read  => I2C_1_HW.Begin_Read,
      Driver_Send        => I2C_1_HW.Send,
      Driver_Recv        => I2C_1_HW.Recv);

   --  I2C3: FT5336 touch controller (SCL=PH7, SDA=PH8, AF4).
   package I2C_3_HW is new STM32F746_I2C
     (Base       => STM32F746.I2C.I2C3_Periph'Address,
      Get_Clock  => Clock_Tree.Get_I2C3_Clock,
      RCC_Enable => Clock_Tree.Enable_I2C3,
      RCC_Reset  => Clock_Tree.Reset_I2C3);

   package I2C_3 is new I2C_Interface
     (Driver_Init        => I2C_3_HW.Init,
      Driver_Enable      => I2C_3_HW.Enable,
      Driver_Disable     => I2C_3_HW.Disable,
      Driver_Reset       => I2C_3_HW.Reset,
      Driver_Recover     => I2C_3_HW.Recover,
      Driver_Probe       => I2C_3_HW.Probe,
      Driver_Begin_Write => I2C_3_HW.Begin_Write,
      Driver_Begin_Read  => I2C_3_HW.Begin_Read,
      Driver_Send        => I2C_3_HW.Send,
      Driver_Recv        => I2C_3_HW.Recv);

   --  SDRAM: IS42S32400F on FMC bank 1 (base 0xC000_0000, 8 MB).
   --  GPIO wiring lives in SDRAM_1_GPIO; FMC SVD primitives in IS42S32400F_Dev.
   package SDRAM_1 is new SDRAM_Interface
     (Driver_Configure      => IS42S32400F_Dev.Configure,
      Driver_Init_Sequence  => IS42S32400F_Dev.Init_Sequence,
      Driver_Busy           => IS42S32400F_Dev.Busy,
      Driver_Is_Initialized => IS42S32400F_Dev.Is_Initialized,
      Base                  => IS42S32400F_Dev.Base_Address,
      Length                => IS42S32400F_Dev.Buffer_Size);

   --  RNG_1: Hardware random number generator
   package RNG_1 is new RNG_Interface
     (Driver_RCC_Enable => STM32F746_RNG.RCC_Enable,
      Driver_RCC_Reset  => STM32F746_RNG.RCC_Reset,
      Driver_Enable     => STM32F746_RNG.Enable,
      Driver_Disable    => STM32F746_RNG.Disable,
      Driver_Data_Ready => STM32F746_RNG.Driver_Data_Ready,
      Driver_Read       => STM32F746_RNG.Driver_Read);

   --  DC_1: LTDC display controller (RK043FN48H panel, 480x272)
   package DC_1 is new DC_Interface
     (Driver_Initialize       => STM32F746_LTDC.Driver_Initialize,
      Driver_Is_Initialized   => STM32F746_LTDC.Driver_Is_Initialized,
      Driver_Start            => STM32F746_LTDC.Driver_Start,
      Driver_Stop             => STM32F746_LTDC.Driver_Stop,
      Driver_Set_Background   => STM32F746_LTDC.Driver_Set_Background,
      Driver_Reload           => STM32F746_LTDC.Driver_Reload,
      Driver_Reload_Async     => STM32F746_LTDC.Driver_Reload_Async,
      Driver_Wait_For_Reload  => STM32F746_LTDC.Driver_Wait_For_Reload,
      Driver_Layer_Init       => STM32F746_LTDC.Driver_Layer_Init,
      Driver_Set_Frame_Buffer => STM32F746_LTDC.Driver_Set_Frame_Buffer,
      Driver_Get_Frame_Buffer => STM32F746_LTDC.Driver_Get_Frame_Buffer,
      Driver_Set_Layer_State  => STM32F746_LTDC.Driver_Set_Layer_State);

   --  FB_1: Double-buffered framebuffer over DC_1 + SDRAM_1
   package FB_1 is new FB_Interface
     (LCD_Width           => STM32F746_LTDC.LCD_Width,
      LCD_Height          => STM32F746_LTDC.LCD_Height,
      Swapped             => False,
      DC_Initialize       => DC_1.Initialize,
      DC_Is_Initialized   => DC_1.Initialized,
      DC_Set_Background   => DC_1.Set_Background,
      DC_Reload           => DC_1.Reload,
      DC_Reload_Async     => DC_1.Reload_Async,
      DC_Wait_For_Reload  => DC_1.Wait_For_Reload,
      DC_Set_Frame_Buffer => DC_1.Set_Frame_Buffer,
      DC_Layer_Init       => DC_1.Layer_Init,
      DC_Get_Frame_Buffer => DC_1.Get_Frame_Buffer,
      Driver_Reserve      => SDRAM_1.Reserve,
      Driver_Fill         => SDRAM_Dev.Fill);

   --  FT5336_1: Touch controller on I2C3 at address 0x38 (7-bit)
   package FT5336_1 is new FT5336_Interface
     (Driver_Write_Read => I2C_3.Write_Read,
      Driver_Write      => I2C_3.Write,
      --  FT5336 7-bit address is 0x38. Our I2C driver shifts it to 0x70 on wire.
      I2C_Address       => 16#38#);

   --  Touch_1: Generic touch interface over FT5336_1
   package Touch_1 is new Touch_Interface
     (Driver_Set_Use_Interrupts  => FT5336_1.Driver_Set_Use_Interrupts,
      Driver_Active_Touch_Points => FT5336_1.Driver_Active_Touch_Points,
      Driver_Get_Touch_Point     => FT5336_1.Driver_Get_Touch_Point);

   --  NOTE: No SPI on this board crate. The only Arduino-header SPI is SPI2,
   --  whose SCK is PI1 -- shared with the user LED LD1. Keeping the LED means
   --  SPI2_SCK is unavailable, and no other SPI is broken out conflict-free.

end Instances;
