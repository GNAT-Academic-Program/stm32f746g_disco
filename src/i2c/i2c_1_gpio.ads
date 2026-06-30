--  I2C_1_GPIO — I2C1 GPIO configuration for STM32F746G-DISCO.
--  SCL=PB8 (AF4), SDA=PB9 (AF4) — Arduino CN2 header D15/D14.

package I2C_1_GPIO is

   procedure Configure;
   --  Configure PB8 and PB9 for I2C1 alternate function (open-drain).

end I2C_1_GPIO;
