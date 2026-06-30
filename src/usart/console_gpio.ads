--  Console_GPIO — USART1 GPIO configuration for STM32F746G-DISCO.
--  TX=PA9 (AF7), RX=PB7 (AF7) — wired to ST-LINK VCP/USB.

package Console_GPIO is

   procedure Configure;
   --  Configure PA9 and PB7 for USART1 alternate function.

end Console_GPIO;
