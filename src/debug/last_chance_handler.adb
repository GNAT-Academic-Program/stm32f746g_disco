with Board;
with Gpio;
with Usart_Types;
with System; use System;
with System.Storage_Elements; use System.Storage_Elements;

package body Last_Chance_Handler is

   procedure Last_Chance_Handler (Msg : System.Address; Line : Integer) is

      procedure Console_Write (S : String) is
         Buf     : Storage_Array (1 .. Storage_Offset (S'Length));
         J       : Storage_Offset := Buf'First;
         Written : Storage_Offset;
      begin
         for C of S loop
            Buf (J) := Storage_Element (Character'Pos (C));
            J := J + 1;
         end loop;
         Board.Console.Write (Board.Console_Dev, Buf, Written);
      end Console_Write;

      function Msg_String return String is
         Max : constant := 128;
         S   : String (1 .. Max);
         Len : Natural := 0;
         P   : Address := Msg;
      begin
         loop
            exit when Len = Max;
            declare
               E : Storage_Element;
               for E'Address use P;
               pragma Import (Ada, E);
            begin
               exit when E = 0;
               Len := Len + 1;
               S (Len) := Character'Val (Natural (E));
               P := P + 1;
            end;
         end loop;
         return S (1 .. Len);
      end Msg_String;

   begin
      Board.Initialize;
      Board.Console.Open
        (Board.Console_Dev,
         (Baud      => Usart_Types.B115200,
          Data_Bits => Usart_Types.Data_8,
          Parity    => Usart_Types.None,
          Stop_Bits => Usart_Types.Stop_1,
          Flow      => Usart_Types.None));

      Console_Write ("CRASH at line ");
      Console_Write (Integer'Image (Line));
      Console_Write (": ");
      Console_Write (Msg_String);
      Console_Write ("" & ASCII.CR & ASCII.LF);

      loop
         Gpio.Toggle (Board.Led);
         delay 0.05;
      end loop;
   end Last_Chance_Handler;

end Last_Chance_Handler;