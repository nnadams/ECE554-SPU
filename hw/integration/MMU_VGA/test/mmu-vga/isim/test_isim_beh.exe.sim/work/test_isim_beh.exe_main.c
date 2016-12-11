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
    unisims_ver_m_00000000003266096158_2593380106_init();
    unisims_ver_m_00000000001946988858_2297623829_init();
    unisims_ver_m_00000000002399568039_1151823720_init();
    unisims_ver_m_00000000000740258969_2946946538_init();
    unisims_ver_m_00000000000740258969_1014629388_init();
    unisims_ver_m_00000000003750641003_2025573070_init();
    unisims_ver_m_00000000000539671959_4261724932_init();
    work_m_00000000002860736927_0829115510_init();
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
    work_m_00000000000293000950_0693391621_init();
    work_m_00000000000393102860_0934680677_init();
    work_m_00000000003924607780_0353320801_init();
    work_m_00000000003924607780_3597063709_init();
    work_m_00000000001268103840_3417729922_init();
    work_m_00000000002214799054_2202926164_init();
    work_m_00000000001601479686_4276792939_init();
    work_m_00000000001520674064_0800204438_init();
    work_m_00000000001554940677_1985558087_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000001554940677_1985558087");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
