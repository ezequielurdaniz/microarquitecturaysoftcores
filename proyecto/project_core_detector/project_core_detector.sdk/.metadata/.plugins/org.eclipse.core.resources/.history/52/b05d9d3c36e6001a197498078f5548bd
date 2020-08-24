

#include "xparameters.h"
#include "xil_io.h"
#include "core_detector_ip.h"
int main (void) {

	//--- Variables --
	int detec = 99;
	int fail = 99;
	
	//-- Inicializacion de programa ---

	xil_printf("-- Detector de tren de pulsos con IP detector propio --\r\n");
	
	while (1){

	 		//-- Read reg0 -- detec
			detec = DETECTOR_IP_mReadReg(XPAR_DETECTOR_IP_S_AXI_BASEADDR, DETECTOR_IP_S_AXI_SLV_REG0_OFFSET);

			//-- Read reg1 -- fail
	    	fail = DETECTOR_IP_mReadReg(XPAR_DETECTOR_IP_S_AXI_BASEADDR, DETECTOR_IP_S_AXI_SLV_REG1_OFFSET);

   	    	xil_printf("detector tren de pulso: %d\r\n", detec);
	    	xil_printf("falla en deteccion: %d\r\n", fail);

	  	sleep(1);
	}
 
}

  
