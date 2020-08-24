-- CLP - Urdaniz F Ezequiel --                                                                                                                                                                     
-- Detector/contador de periodo de señales cuadradas --                                                                                                                                                                          
                                                                                                                                                                                                   
------ entity core_detector FSM --------------------                                                                                                                                                         
library IEEE;                                                                                                                                                                                      
use IEEE.std_logic_1164.all; 
use IEEE.numeric_std.all;  
                                                                                                                                                                                                
entity core_detector is                                                                                                                                                                                 
    port(       
       ---------- i/o -------
        sig_secuencia_i : in std_logic;            -- signal in.                                                                                                                               
        clk_i           : in std_logic;            -- clock.                                                                                                                                           
        sig_detec_o     : out std_logic;           -- detec signal out.                                                                                                                              
        fail_o          : out std_logic;           -- fail.    
       ---------- new registros -------
		detc_o          : out std_logic_vector(31 downto 0);
		err_o           : out std_logic_vector(31 downto 0)
        );                                                                                                                                                                                         
end core_detector;                                      
                                                                                                                                                                                                       
architecture core_detector_arq of core_detector is   

-------- Definicion de estados de la FSM ------------                                                                                                                                                       
type tipo_estado is (I,A,B,C,D,E);                                  
                                                                    -- I = Inicial/Reset
 signal estado_actual: tipo_estado;                                 -- A = Primer periodo
 signal estado_siguiente:tipo_estado:= I;                           -- B = Segundo periodo
                                                                    -- C = Comparacion.
                                                                    -- D = Deteccion.
                                                                    -- E = Error. 
                                                                                                                                                                                         
signal contador_sig_1  : std_logic_vector (3 downto 0):="0000"; -- Declaro acumulador de cuentas para periodo 4bits 
signal contador_sig_2  : std_logic_vector (3 downto 0):="0000"; -- Declaro acumulador de cuentas para periodo 4bits                                                                                                                                                                                                                                                                                                                                            
begin                                                     
------------------- Registros ------------------------------
    registros: process (clk_i,sig_secuencia_i)
        variable time_espera    : integer range 0 to 14:= 14;
        begin
            if (rising_edge(clk_i)) then  
                 if (sig_secuencia_i = '1') then

                    time_espera:= 14; 
                    C0: case estado_actual is
                           when I => estado_actual <= A;
                           when A => estado_actual <= B;
                           when B => estado_actual <= C;
                           when C => estado_actual <= D;
                           when D => estado_actual <= I;
                           when others => estado_actual <= I;      
                    end case C0;
                else
                    time_espera:= time_espera-1;
                    estado_actual <= estado_siguiente;
                    if(time_espera = 0) then
                       time_espera:= 14;
                       estado_actual <= E;                    -- Error      
                     end if;
                end if;
            end if;   
     end process registros;
    
 ------------------- Transiciones  ------------------------------                                                                                                                                          
    transiciones: process (estado_actual,sig_secuencia_i,contador_sig_1,contador_sig_2) --sig_secuencia_i)  
        variable  cuenta: integer range 0 to 14:=0;                                     -- Variable cuenta                                                                                                                                                               
        begin
                     
       -------- new  registors detec ---------
       if (estado_actual = D) then
           detc_o <= std_logic_vector(to_unsigned(1,32));  
       else
           detc_o <= std_logic_vector(to_unsigned(0,32));
       end if;
               
       -------- new  registors err_o  ---------
       if (estado_actual = E) then
           err_o  <= std_logic_vector(to_unsigned(1,32));  
       else
           err_o  <= std_logic_vector(to_unsigned(0,32));
       end if;
              
        C1: case estado_actual is
 
                when I =>     contador_sig_2 <= (others => '0');
                              contador_sig_1 <= (others => '0');
                              estado_siguiente <= I;
        
                when A =>    cuenta:= to_integer(unsigned(contador_sig_1))+1;
                             contador_sig_1 <=	std_logic_vector(to_unsigned(cuenta,4));
                             estado_siguiente <= A;                               -- Continuamos en estado A.
                                                          
                when B =>    cuenta:= to_integer(unsigned(contador_sig_2))+1;                            
                             contador_sig_2 <=std_logic_vector(to_unsigned(cuenta,4));  
                             estado_siguiente <= B;                                -- Continuamos en estado B. 
                                                          
                when C =>    if(contador_sig_1 = contador_sig_2) then                              
                                estado_siguiente <= C;                              -- Siguiente estado D.              
                             else                                                               
                                estado_siguiente <= E;                              -- Estado de Error                                       
                             end if;                                                         
                                                    
                when D =>    cuenta:= to_integer(unsigned(contador_sig_1));
                             if(cuenta = 0) then 
                                 estado_siguiente <= I;  
                             else
                                 cuenta:= cuenta-1;
                                 contador_sig_1 <= std_logic_vector(to_unsigned(cuenta,4));
                                 estado_siguiente <= D;                                  -- Continuamos en estado D. 
                             end if;
                when E =>    estado_siguiente <= I;                           
            end case C1;
        end process;                                                         
        sig_detec_o <= '1' when estado_actual = D else '0';
        fail_o <= '1' when estado_actual = E else '0';     

            
end core_detector_arq;
                
                
                