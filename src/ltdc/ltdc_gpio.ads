--  LTDC_GPIO — LTDC GPIO configuration for STM32F746G-DISCO.
--  Configures all LCD RGB, control, enable and backlight pins.

package LTDC_GPIO is

   procedure Configure;
   --  Configure all LCD RGB, control, enable and backlight pins.
   --  Sets LCD_ENABLE and LCD_BL_CTRL High after pin config.
   --  Call before FB_1.Initialize.

end LTDC_GPIO;
