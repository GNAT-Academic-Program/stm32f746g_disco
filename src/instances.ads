with STM32F746_USART;
with STM32F746_I2C;
with STM32F746.USART;
with STM32F746.I2C;
with Clock_Tree;

package Instances is

   --  Console: USART1, wired to the ST-LINK VCP (USB) on the F746G-DISCO.
   package Console is new STM32F746_USART
     (Periph     => STM32F746.USART.USART1_Periph'Access,
      Get_Clock  => Clock_Tree.Get_USART1_Clock,
      RCC_Enable => Clock_Tree.Enable_USART1,
      RCC_Reset  => Clock_Tree.Reset_USART1);

   --  I2C1: Arduino header D15/D14 + CN2 extension (SCL=PB8, SDA=PB9, AF4).
   package I2C_1 is new STM32F746_I2C
     (Base       => STM32F746.I2C.I2C1_Periph'Address,
      Get_Clock  => Clock_Tree.Get_I2C1_Clock,
      RCC_Enable => Clock_Tree.Enable_I2C1,
      RCC_Reset  => Clock_Tree.Reset_I2C1);

   --  NOTE: No SPI on this board crate. The only Arduino-header SPI is SPI2,
   --  whose SCK is PI1 -- shared with the user LED LD1. Keeping the LED means
   --  SPI2_SCK is unavailable, and no other SPI is broken out conflict-free.
   --  The STM32F746_SPI generic is ready (post-SVD-patch it accepts any SPI),
   --  so SPI can be added later if the LED is relocated.

end Instances;