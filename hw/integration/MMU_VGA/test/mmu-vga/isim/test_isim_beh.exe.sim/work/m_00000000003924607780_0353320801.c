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

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//userspace.cae.wisc.edu/people/b/barry-lenoch/Documents/School/Classes/5th_year/Fall_2016/ece554/project/ECE554-SPU/hw/intrf/vga/src/simple_rom.v";
static int ng1[] = {778921325, 0, 1650815603, 0, 7239021, 0};



static void Initial_30_0(char *t0)
{
    char *t1;
    char *t2;

LAB0:    xsi_set_current_line(30, ng0);
    t1 = ((char*)((ng1)));
    t2 = (t0 + 2176);
    xsi_vlogfile_readmemh(t1, 88, t2, 0, 0, 0, 0);

LAB1:    return;
}

static void Always_31_1(char *t0)
{
    char t7[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;

LAB0:    t1 = (t0 + 3344U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(31, ng0);
    t2 = (t0 + 3664);
    *((int *)t2) = 1;
    t3 = (t0 + 3376);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(31, ng0);
    t4 = (t0 + 2176);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    t8 = (t0 + 2176);
    t9 = (t8 + 72U);
    t10 = *((char **)t9);
    t11 = (t0 + 2176);
    t12 = (t11 + 64U);
    t13 = *((char **)t12);
    t14 = (t0 + 1616U);
    t15 = *((char **)t14);
    xsi_vlog_generic_get_array_select_value(t7, 24, t6, t10, t13, 2, 1, t15, 12, 2);
    t14 = (t0 + 2016);
    xsi_vlogvar_wait_assign_value(t14, t7, 0, 0, 24, 0LL);
    goto LAB2;

}


extern void work_m_00000000003924607780_0353320801_init()
{
	static char *pe[] = {(void *)Initial_30_0,(void *)Always_31_1};
	xsi_register_didat("work_m_00000000003924607780_0353320801", "isim/test_isim_beh.exe.sim/work/m_00000000003924607780_0353320801.didat");
	xsi_register_executes(pe);
}
