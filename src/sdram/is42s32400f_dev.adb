with IS42S32400F_Interface;

with STM32F746; use STM32F746;
with STM32F746.RCC; use STM32F746.RCC;
with STM32F746.FSMC; use STM32F746.FSMC;

package body IS42S32400F_Dev is

   SDRAM_Base   : constant System.Address := System'To_Address (16#C000_0000#);
   SDRAM_Length : constant MT.UInt32      := 16#0080_0000#;

   Initialized_Flag : Boolean := False;

   --  FMC SVD primitives

   procedure FMC_RCC_Enable is
   begin
      RCC_Periph.AHB3ENR.FMCEN := 1;
   end FMC_RCC_Enable;

   procedure FMC_RCC_Reset is
   begin
      RCC_Periph.AHB3RSTR.FMCRST := 1;
      RCC_Periph.AHB3RSTR.FMCRST := 0;
   end FMC_RCC_Reset;

   procedure FMC_SDRAM_Config
     (CAS_Latency       : Positive;
      Column_Bits       : Positive;
      Row_Bits          : Positive;
      Data_Width        : Positive;
      Internal_Banks    : Positive;
      Clock_Period      : Positive;
      Load_To_Active    : Positive;
      Exit_Self_Refresh : Positive;
      Self_Refresh_Time : Positive;
      Row_Cycle_Delay   : Positive;
      Write_Recovery    : Positive;
      RP_Delay          : Positive;
      RCD_Delay         : Positive)
   is
   begin
      FMC_Periph.SDCR1 :=
        (NC     => STM32F746.UInt2 (Column_Bits    - 8),
         NR     => STM32F746.UInt2 (Row_Bits       - 11),
         MWID   => STM32F746.UInt2 (Data_Width / 8 - 1),
         NB     => (if Internal_Banks = 4 then 1 else 0),
         CAS    => STM32F746.UInt2 (CAS_Latency),
         WP     => 0,
         SDCLK  => STM32F746.UInt2 (Clock_Period),
         RBURST => 0,
         RPIPE  => 0,
         others => <>);

      FMC_Periph.SDTR1 :=
        (TMRD  => STM32F746.UInt4 (Load_To_Active    - 1),
         TXSR  => STM32F746.UInt4 (Exit_Self_Refresh - 1),
         TRAS  => STM32F746.UInt4 (Self_Refresh_Time - 1),
         TRC   => STM32F746.UInt4 (Row_Cycle_Delay   - 1),
         TWR   => STM32F746.UInt4 (Write_Recovery    - 1),
         TRP   => STM32F746.UInt4 (RP_Delay          - 1),
         TRCD  => STM32F746.UInt4 (RCD_Delay         - 1),
         others => <>);
   end FMC_SDRAM_Config;

   procedure FMC_Send_Cmd
     (Mode                : Natural;
      Auto_Refresh_Number : Natural := 1;
      Mode_Register       : Natural := 0)
   is
   begin
      FMC_Periph.SDCMR :=
        (MODE  => STM32F746.UInt3 (Mode),
         CTB1  => 1,
         CTB2  => 0,
         NRFS  => STM32F746.UInt4 (Auto_Refresh_Number - 1),
         MRD   => STM32F746.UInt13 (Mode_Register),
         others => <>);
   end FMC_Send_Cmd;

   function FMC_Busy return Boolean is (FMC_Periph.SDSR.BUSY = 1);

   procedure FMC_Set_Refresh_Count (Count : Natural) is
   begin
      FMC_Periph.SDRTR.COUNT := STM32F746.UInt13 (Count);
   end FMC_Set_Refresh_Count;

   function Driver_Is_Initialized return Boolean is (Initialized_Flag);

   --  Instantiate chip driver with FMC SVD primitives
   package Chip is new IS42S32400F_Interface
     (Driver_FMC_RCC_Enable    => FMC_RCC_Enable,
      Driver_FMC_RCC_Reset     => FMC_RCC_Reset,
      Driver_FMC_Config        => FMC_SDRAM_Config,
      Driver_Send_Cmd          => FMC_Send_Cmd,
      Driver_Busy              => FMC_Busy,
      Driver_Is_Initialized    => Driver_Is_Initialized,
      Driver_Set_Refresh_Count => FMC_Set_Refresh_Count,
      Base                     => SDRAM_Base,
      Length                   => SDRAM_Length);

   procedure Configure     is begin Chip.Configure;                      end Configure;
   procedure Init_Sequence is begin Chip.Init_Sequence;
                                    Initialized_Flag := True;            end Init_Sequence;
   function  Busy           return Boolean is (Chip.Busy);
   function  Is_Initialized return Boolean is (Initialized_Flag);
   function  Base_Address   return System.Address is (Chip.Base_Address);
   function  Buffer_Size    return MT.UInt32      is (Chip.Buffer_Size);

   function Reserve
     (Amount : MT.UInt32;
      Align  : MT.UInt32 := Standard'Maximum_Alignment)
      return System.Address
   is (Chip.Reserve (Amount, Align));

end IS42S32400F_Dev;