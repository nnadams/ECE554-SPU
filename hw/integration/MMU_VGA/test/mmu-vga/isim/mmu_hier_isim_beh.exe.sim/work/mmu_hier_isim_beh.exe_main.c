/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;



int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    xilinxcorelib_ver_m_00000000001358910285_3273544749_init();
    xilinxcorelib_ver_m_00000000001358910285_2834128467_init();
    xilinxcorelib_ver_m_00000000001687936702_1345273840_init();
    xilinxcorelib_ver_m_00000000001080096809_1651506803_init();
    xilinxcorelib_ver_m_00000000003435484244_0436676651_init();
    work_m_00000000000921089688_1155251120_init();
    xilinxcorelib_ver_m_00000000001358910285_2568633598_init();
    xilinxcorelib_ver_m_00000000001687936702_2843080771_init();
    xilinxcorelib_ver_m_00000000000277421008_3859216361_init();
    xilinxcorelib_ver_m_00000000003435484244_0596917787_init();
    work_m_00000000002601660452_3200543613_init();
    work_m_00000000001585773925_2362697507_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000001585773925_2362697507");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
