# stm32f746g_disco

Board Support Package for the STM32F746G-DISCO development board.

## Overview

`stm32f746g_disco` provides board-level abstractions and pin definitions for the STM32F746G Discovery board. It instantiates the STM32F746 HAL with board-specific configurations and provides convenient access to onboard peripherals.

## Features

- Board-specific pin definitions
- Onboard LED support
- Debug output via USART
- Pre-configured peripheral instances
- Last chance handler for runtime errors
- LCD display support (480x272 pixels)
- Touch screen interface
- Audio codec
- SDRAM (8 MB)
- QSPI Flash (16 MB)

## Board Specifications

- **MCU:** STM32F746NGH6
- **Core:** ARM Cortex-M7 @ 216 MHz
- **Flash:** 1 MB
- **RAM:** 340 KB (320 KB + 16 KB + 4 KB)
- **Display:** 4.3" 480x272 LCD with capacitive touch

## Usage

### In Application Code

```ada
with Board;
with Gpio;

procedure Main is
begin
   Board.Initialize;
   
   loop
      Gpio.Toggle (Board.Led);
      delay 0.5;
   end loop;
end Main;
```

### Debug Output

```ada
with Debug;

Debug.Put_Line ("System initialized");
```

## Integration

Add to your `alire.toml`:

```toml
[[depends-on]]
stm32f746g_disco = "^0.1.0"
```

## Dependencies

- `stm32f746` - STM32F746 HAL
- `gpio_generic` - Generic GPIO interface
- `debug_generic` - Generic debug output

## License

MIT OR Apache-2.0 WITH LLVM-exception
