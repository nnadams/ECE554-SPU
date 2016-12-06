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
static const char *ng0 = "//userspace.cae.wisc.edu/people/j/jjbrand/554/project/ECE554-SPU/hw/CPU/verilog/mem.v";
static int ng1[] = {0, 0};
static unsigned int ng2[] = {0U, 0U};
static int ng3[] = {1, 0};
static unsigned int ng4[] = {1U, 0U};



static void Cont_21_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    t1 = (t0 + 4608U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(21, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = (t0 + 6856);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t3, 8);
    xsi_driver_vfirst_trans(t2, 0, 31);
    t8 = (t0 + 6664);
    *((int *)t8) = 1;

LAB1:    return;
}

static void Cont_22_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    t1 = (t0 + 4856U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(22, ng0);
    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = (t0 + 6920);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t3, 8);
    xsi_driver_vfirst_trans(t2, 0, 31);
    t8 = (t0 + 6680);
    *((int *)t8) = 1;

LAB1:    return;
}

static void Cont_23_2(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;

LAB0:    t1 = (t0 + 5104U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(23, ng0);
    t2 = (t0 + 1688U);
    t3 = *((char **)t2);
    t2 = (t0 + 6984);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memset(t7, 0, 8);
    t8 = 15U;
    t9 = t8;
    t10 = (t3 + 4);
    t11 = *((unsigned int *)t3);
    t8 = (t8 & t11);
    t12 = *((unsigned int *)t10);
    t9 = (t9 & t12);
    t13 = (t7 + 4);
    t14 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t14 | t8);
    t15 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t15 | t9);
    xsi_driver_vfirst_trans(t2, 0, 3);
    t16 = (t0 + 6696);
    *((int *)t16) = 1;

LAB1:    return;
}

static void Cont_24_3(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;

LAB0:    t1 = (t0 + 5352U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(24, ng0);
    t2 = (t0 + 1848U);
    t3 = *((char **)t2);
    t2 = (t0 + 7048);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memset(t7, 0, 8);
    t8 = 15U;
    t9 = t8;
    t10 = (t3 + 4);
    t11 = *((unsigned int *)t3);
    t8 = (t8 & t11);
    t12 = *((unsigned int *)t10);
    t9 = (t9 & t12);
    t13 = (t7 + 4);
    t14 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t14 | t8);
    t15 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t15 | t9);
    xsi_driver_vfirst_trans(t2, 0, 3);
    t16 = (t0 + 6712);
    *((int *)t16) = 1;

LAB1:    return;
}

static void Cont_25_4(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    t1 = (t0 + 5600U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(25, ng0);
    t2 = (t0 + 2008U);
    t3 = *((char **)t2);
    t2 = (t0 + 7112);
    t4 = (t2 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memcpy(t7, t3, 8);
    xsi_driver_vfirst_trans(t2, 0, 31);
    t8 = (t0 + 6728);
    *((int *)t8) = 1;

LAB1:    return;
}

static void Cont_26_5(char *t0)
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

LAB0:    t1 = (t0 + 5848U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(26, ng0);
    t2 = (t0 + 3688);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 7176);
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
    t18 = (t0 + 6744);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Always_29_6(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;

LAB0:    t1 = (t0 + 6096U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(29, ng0);
    t2 = (t0 + 6760);
    *((int *)t2) = 1;
    t3 = (t0 + 6128);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(29, ng0);

LAB5:    xsi_set_current_line(30, ng0);
    t4 = (t0 + 1208U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(31, ng0);
    t2 = (t0 + 3528);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 3368);
    xsi_vlogvar_wait_assign_value(t5, t4, 0, 0, 1, 0LL);

LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(30, ng0);
    t11 = ((char*)((ng1)));
    t12 = (t0 + 3368);
    xsi_vlogvar_wait_assign_value(t12, t11, 0, 0, 1, 0LL);
    goto LAB8;

}

static void Always_34_7(char *t0)
{
    char t9[8];
    char t20[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    int t6;
    char *t7;
    char *t8;
    char *t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    char *t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    char *t34;
    char *t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    int t44;
    int t45;
    unsigned int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    char *t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    char *t58;
    char *t59;

LAB0:    t1 = (t0 + 6344U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 6776);
    *((int *)t2) = 1;
    t3 = (t0 + 6376);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(34, ng0);

LAB5:    xsi_set_current_line(35, ng0);
    t4 = ((char*)((ng1)));
    t5 = (t0 + 3688);
    xsi_vlogvar_assign_value(t5, t4, 0, 0, 1);
    xsi_set_current_line(36, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3528);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(37, ng0);
    t2 = (t0 + 3368);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);

LAB6:    t5 = ((char*)((ng2)));
    t6 = xsi_vlog_unsigned_case_compare(t4, 1, t5, 1);
    if (t6 == 1)
        goto LAB7;

LAB8:    t2 = ((char*)((ng4)));
    t6 = xsi_vlog_unsigned_case_compare(t4, 1, t2, 1);
    if (t6 == 1)
        goto LAB9;

LAB10:
LAB11:    goto LAB2;

LAB7:    xsi_set_current_line(38, ng0);

LAB12:    xsi_set_current_line(39, ng0);
    t7 = (t0 + 2168U);
    t8 = *((char **)t7);
    t7 = (t0 + 2648U);
    t10 = *((char **)t7);
    memset(t9, 0, 8);
    t7 = (t9 + 4);
    t11 = (t10 + 4);
    t12 = *((unsigned int *)t10);
    t13 = (~(t12));
    *((unsigned int *)t9) = t13;
    *((unsigned int *)t7) = 0;
    if (*((unsigned int *)t11) != 0)
        goto LAB14;

LAB13:    t18 = *((unsigned int *)t9);
    *((unsigned int *)t9) = (t18 & 15U);
    t19 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t19 & 15U);
    t21 = *((unsigned int *)t8);
    t22 = *((unsigned int *)t9);
    t23 = (t21 & t22);
    *((unsigned int *)t20) = t23;
    t24 = (t8 + 4);
    t25 = (t9 + 4);
    t26 = (t20 + 4);
    t27 = *((unsigned int *)t24);
    t28 = *((unsigned int *)t25);
    t29 = (t27 | t28);
    *((unsigned int *)t26) = t29;
    t30 = *((unsigned int *)t26);
    t31 = (t30 != 0);
    if (t31 == 1)
        goto LAB15;

LAB16:
LAB17:    t52 = (t20 + 4);
    t53 = *((unsigned int *)t52);
    t54 = (~(t53));
    t55 = *((unsigned int *)t20);
    t56 = (t55 & t54);
    t57 = (t56 != 0);
    if (t57 > 0)
        goto LAB18;

LAB19:
LAB20:    goto LAB11;

LAB9:    xsi_set_current_line(45, ng0);

LAB22:    xsi_set_current_line(46, ng0);
    t3 = ((char*)((ng1)));
    t5 = (t0 + 3528);
    xsi_vlogvar_assign_value(t5, t3, 0, 0, 1);
    goto LAB11;

LAB14:    t14 = *((unsigned int *)t9);
    t15 = *((unsigned int *)t11);
    *((unsigned int *)t9) = (t14 | t15);
    t16 = *((unsigned int *)t7);
    t17 = *((unsigned int *)t11);
    *((unsigned int *)t7) = (t16 | t17);
    goto LAB13;

LAB15:    t32 = *((unsigned int *)t20);
    t33 = *((unsigned int *)t26);
    *((unsigned int *)t20) = (t32 | t33);
    t34 = (t8 + 4);
    t35 = (t9 + 4);
    t36 = *((unsigned int *)t8);
    t37 = (~(t36));
    t38 = *((unsigned int *)t34);
    t39 = (~(t38));
    t40 = *((unsigned int *)t9);
    t41 = (~(t40));
    t42 = *((unsigned int *)t35);
    t43 = (~(t42));
    t44 = (t37 & t39);
    t45 = (t41 & t43);
    t46 = (~(t44));
    t47 = (~(t45));
    t48 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t48 & t46);
    t49 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t49 & t47);
    t50 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t50 & t46);
    t51 = *((unsigned int *)t20);
    *((unsigned int *)t20) = (t51 & t47);
    goto LAB17;

LAB18:    xsi_set_current_line(39, ng0);

LAB21:    xsi_set_current_line(40, ng0);
    t58 = ((char*)((ng3)));
    t59 = (t0 + 3688);
    xsi_vlogvar_assign_value(t59, t58, 0, 0, 1);
    xsi_set_current_line(41, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3528);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    goto LAB20;

}


extern void work_m_00000000002229743518_2381739659_init()
{
	static char *pe[] = {(void *)Cont_21_0,(void *)Cont_22_1,(void *)Cont_23_2,(void *)Cont_24_3,(void *)Cont_25_4,(void *)Cont_26_5,(void *)Always_29_6,(void *)Always_34_7};
	xsi_register_didat("work_m_00000000002229743518_2381739659", "isim/cpu_mmu_integration_isim_beh.exe.sim/work/m_00000000002229743518_2381739659.didat");
	xsi_register_executes(pe);
}
