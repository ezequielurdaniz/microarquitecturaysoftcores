#ifndef DETECTOR_IP_H
#define DETECTOR_IP_H


/****************** Include Files ********************/
#include "xil_types.h"
#include "xstatus.h"

#define DETECTOR_IP_S_AXI_SLV_REG0_OFFSET 0
#define DETECTOR_IP_S_AXI_SLV_REG1_OFFSET 4
#define DETECTOR_IP_S_AXI_SLV_REG2_OFFSET 8
#define DETECTOR_IP_S_AXI_SLV_REG3_OFFSET 12


#define DETECTOR_IP_mWriteReg(BaseAddress, RegOffset, Data) \
  	Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))

#define DETECTOR_IP_mReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))

XStatus DETECTOR_IP_Reg_SelfTest(void * baseaddr_p);

#endif // DETECTOR_IP_H


