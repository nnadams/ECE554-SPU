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
    xilinxcorelib_ver_m_00000000001358910285_0771494958_init();
    xilinxcorelib_ver_m_00000000001358910285_2022601941_init();
    xilinxcorelib_ver_m_00000000001687936702_1564388946_init();
    xilinxcorelib_ver_m_00000000001080096809_3998729279_init();
    xilinxcorelib_ver_m_00000000003435484244_3540738721_init();
    work_m_00000000000921089688_1720460815_init();
    work_m_00000000000184843227_0800204438_init();
    xilinxcorelib_ver_m_00000000001358910285_2967176973_init();
    xilinxcorelib_ver_m_00000000001687936702_4016793922_init();
    xilinxcorelib_ver_m_00000000001080096809_2613905373_init();
    xilinxcorelib_ver_m_00000000003435484244_2991265102_init();
    work_m_00000000003289761879_3200543613_init();
    work_m_00000000000518045785_2362697507_init();
    work_m_00000000002645719316_1985558087_init();
    work_m_00000000004134447467_2073120511_init();


    xsi_register_tops("work_m_00000000002645719316_1985558087");
    xsi_register_tops("work_m_00000000004134447467_2073120511");


    return xsi_run_simulation(argc, argv);

}
