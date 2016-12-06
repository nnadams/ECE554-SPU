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
static const char *ng0 = "//userspace.cae.wisc.edu/people/j/jjbrand/554/project/ECE554-SPU/hw/CPU/verilog/ofl_detect.v";
static unsigned int ng1[] = {15U, 7U};
static unsigned int ng2[] = {1U, 0U};
static unsigned int ng3[] = {25U, 8U};
static unsigned int ng4[] = {30U, 8U};
static unsigned int ng5[] = {0U, 0U};



static void Always_12_0(char *t0)
{
    char t4[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    int t11;
    char *t12;
    char *t13;

LAB0:    t1 = (t0 + 3168U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(12, ng0);
    t2 = (t0 + 3736);
    *((int *)t2) = 1;
    t3 = (t0 + 3200);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(13, ng0);

LAB5:    xsi_set_current_line(14, ng0);
    t5 = (t0 + 1688U);
    t6 = *((char **)t5);
    t5 = (t0 + 1528U);
    t7 = *((char **)t5);
    t5 = (t0 + 1368U);
    t8 = *((char **)t5);
    t5 = (t0 + 1208U);
    t9 = *((char **)t5);
    t5 = (t0 + 1048U);
    t10 = *((char **)t5);
    xsi_vlogtype_concat(t4, 5, 5, 5U, t10, 1, t9, 1, t8, 1, t7, 1, t6, 1);

LAB6:    t5 = ((char*)((ng1)));
    t11 = xsi_vlog_unsigned_case_xcompare(t4, 5, t5, 5);
    if (t11 == 1)
        goto LAB7;

LAB8:    t2 = ((char*)((ng3)));
    t11 = xsi_vlog_unsigned_case_xcompare(t4, 5, t2, 5);
    if (t11 == 1)
        goto LAB9;

LAB10:    t2 = ((char*)((ng4)));
    t11 = xsi_vlog_unsigned_case_xcompare(t4, 5, t2, 5);
    if (t11 == 1)
        goto LAB11;

LAB12:
LAB14:
LAB13:    xsi_set_current_line(24, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 2248);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);

LAB15:    goto LAB2;

LAB7:    xsi_set_current_line(17, ng0);
    t12 = ((char*)((ng2)));
    t13 = (t0 + 2248);
    xsi_vlogvar_assign_value(t13, t12, 0, 0, 1);
    goto LAB15;

LAB9:    xsi_set_current_line(20, ng0);
    t3 = ((char*)((ng2)));
    t5 = (t0 + 2248);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 1);
    goto LAB15;

LAB11:    xsi_set_current_line(22, ng0);
    t3 = ((char*)((ng2)));
    t5 = (t0 + 2248);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 1);
    goto LAB15;

}

static void Cont_28_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    char *t18;

LAB0:    t1 = (t0 + 3416U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(28, ng0);
    t2 = (t0 + 2248);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 3832);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memset(t9, 0, 8);
    t10 = 1U;
    t11 = t10;
    t12 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t10 = (t10 & t13);
    t14 = *((unsigned int *)t12);
    t11 = (t11 & t14);
    t15 = (t9 + 4);
    t16 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t16 | t10);
    t17 = *((unsigned int *)t15);
    *((unsigned int *)t15) = (t17 | t11);
    xsi_driver_vfirst_trans(t5, 0, 0);
    t18 = (t0 + 3752);
    *((int *)t18) = 1;

LAB1:    return;
}


extern void work_m_00000000001024524588_0991960448_init()
{
	static char *pe[] = {(void *)Always_12_0,(void *)Cont_28_1};
	xsi_register_didat("work_m_00000000001024524588_0991960448", "isim/cpu_mmu_integration_isim_beh.exe.sim/work/m_00000000001024524588_0991960448.didat");
	xsi_register_executes(pe);
}
