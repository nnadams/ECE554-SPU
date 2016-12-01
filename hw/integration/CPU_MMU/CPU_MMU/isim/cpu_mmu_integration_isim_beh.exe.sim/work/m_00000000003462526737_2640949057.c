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
static const char *ng0 = "//userspace.cae.wisc.edu/people/j/jjbrand/554/project/ECE554-SPU/hw/CPU/verilog/imm_decode.v";
static unsigned int ng1[] = {8U, 0U};
static int ng2[] = {16, 0};
static unsigned int ng3[] = {9U, 0U};
static int ng4[] = {15, 0};
static unsigned int ng5[] = {10U, 0U};
static unsigned int ng6[] = {0U, 0U};
static unsigned int ng7[] = {11U, 0U};
static unsigned int ng8[] = {20U, 0U};
static unsigned int ng9[] = {21U, 0U};
static unsigned int ng10[] = {22U, 0U};
static unsigned int ng11[] = {23U, 0U};
static unsigned int ng12[] = {16U, 0U};
static unsigned int ng13[] = {17U, 0U};
static unsigned int ng14[] = {48U, 0U};
static unsigned int ng15[] = {56U, 0U};
static unsigned int ng16[] = {19U, 0U};
static unsigned int ng17[] = {12U, 0U};
static unsigned int ng18[] = {13U, 0U};
static unsigned int ng19[] = {14U, 0U};
static unsigned int ng20[] = {15U, 0U};
static unsigned int ng21[] = {24U, 0U};
static unsigned int ng22[] = {18U, 0U};
static unsigned int ng23[] = {4U, 0U};
static int ng24[] = {6, 0};
static unsigned int ng25[] = {5U, 0U};
static unsigned int ng26[] = {6U, 0U};
static unsigned int ng27[] = {7U, 0U};
static unsigned int ng28[] = {4294967295U, 4294967295U};



static void Cont_8_0(char *t0)
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
    char *t10;

LAB0:    t1 = (t0 + 2528U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(8, ng0);
    t2 = (t0 + 1608);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 3192);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t4, 8);
    xsi_driver_vfirst_trans(t5, 0, 31);
    t10 = (t0 + 3096);
    *((int *)t10) = 1;

LAB1:    return;
}

static void Always_10_1(char *t0)
{
    char t4[8];
    char t5[8];
    char t17[8];
    char t18[8];
    char t28[8];
    char t32[8];
    char *t1;
    char *t2;
    char *t3;
    char *t6;
    char *t7;
    char *t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    int t16;
    char *t19;
    char *t20;
    char *t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    char *t29;
    char *t30;
    char *t31;
    char *t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t40;

LAB0:    t1 = (t0 + 2776U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(10, ng0);
    t2 = (t0 + 3112);
    *((int *)t2) = 1;
    t3 = (t0 + 2808);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(10, ng0);

LAB5:    xsi_set_current_line(11, ng0);
    t6 = (t0 + 1048U);
    t7 = *((char **)t6);
    memset(t5, 0, 8);
    t6 = (t5 + 4);
    t8 = (t7 + 4);
    t9 = *((unsigned int *)t7);
    t10 = (t9 >> 26);
    *((unsigned int *)t5) = t10;
    t11 = *((unsigned int *)t8);
    t12 = (t11 >> 26);
    *((unsigned int *)t6) = t12;
    t13 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t13 & 63U);
    t14 = *((unsigned int *)t6);
    *((unsigned int *)t6) = (t14 & 63U);
    xsi_vlogtype_concat(t4, 6, 6, 1U, t5, 6);

LAB6:    t15 = ((char*)((ng1)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t15, 6);
    if (t16 == 1)
        goto LAB7;

LAB8:    t2 = ((char*)((ng3)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB9;

LAB10:    t2 = ((char*)((ng5)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB11;

LAB12:    t2 = ((char*)((ng7)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB13;

LAB14:    t2 = ((char*)((ng8)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB15;

LAB16:    t2 = ((char*)((ng9)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB17;

LAB18:    t2 = ((char*)((ng10)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB19;

LAB20:    t2 = ((char*)((ng11)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB21;

LAB22:    t2 = ((char*)((ng12)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB23;

LAB24:    t2 = ((char*)((ng13)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB25;

LAB26:    t2 = ((char*)((ng14)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB27;

LAB28:    t2 = ((char*)((ng15)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB29;

LAB30:    t2 = ((char*)((ng16)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB31;

LAB32:    t2 = ((char*)((ng17)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB33;

LAB34:    t2 = ((char*)((ng18)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB35;

LAB36:    t2 = ((char*)((ng19)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB37;

LAB38:    t2 = ((char*)((ng20)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB39;

LAB40:    t2 = ((char*)((ng21)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB41;

LAB42:    t2 = ((char*)((ng22)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB43;

LAB44:    t2 = ((char*)((ng23)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB45;

LAB46:    t2 = ((char*)((ng25)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB47;

LAB48:    t2 = ((char*)((ng26)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB49;

LAB50:    t2 = ((char*)((ng27)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB51;

LAB52:
LAB54:
LAB53:    xsi_set_current_line(154, ng0);

LAB79:    xsi_set_current_line(155, ng0);
    t2 = ((char*)((ng28)));
    t3 = (t0 + 1608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB55:    goto LAB2;

LAB7:    xsi_set_current_line(14, ng0);

LAB56:    xsi_set_current_line(15, ng0);
    t19 = (t0 + 1048U);
    t20 = *((char **)t19);
    memset(t18, 0, 8);
    t19 = (t18 + 4);
    t21 = (t20 + 4);
    t22 = *((unsigned int *)t20);
    t23 = (t22 >> 0);
    *((unsigned int *)t18) = t23;
    t24 = *((unsigned int *)t21);
    t25 = (t24 >> 0);
    *((unsigned int *)t19) = t25;
    t26 = *((unsigned int *)t18);
    *((unsigned int *)t18) = (t26 & 65535U);
    t27 = *((unsigned int *)t19);
    *((unsigned int *)t19) = (t27 & 65535U);
    t29 = ((char*)((ng2)));
    t30 = (t0 + 1048U);
    t31 = *((char **)t30);
    memset(t32, 0, 8);
    t30 = (t32 + 4);
    t33 = (t31 + 4);
    t34 = *((unsigned int *)t31);
    t35 = (t34 >> 15);
    t36 = (t35 & 1);
    *((unsigned int *)t32) = t36;
    t37 = *((unsigned int *)t33);
    t38 = (t37 >> 15);
    t39 = (t38 & 1);
    *((unsigned int *)t30) = t39;
    xsi_vlog_mul_concat(t28, 16, 1, t29, 1U, t32, 1);
    xsi_vlogtype_concat(t17, 32, 32, 2U, t28, 16, t18, 16);
    t40 = (t0 + 1608);
    xsi_vlogvar_assign_value(t40, t17, 0, 0, 32);
    goto LAB55;

LAB9:    xsi_set_current_line(20, ng0);

LAB57:    xsi_set_current_line(21, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB11:    xsi_set_current_line(26, ng0);

LAB58:    xsi_set_current_line(27, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng6)));
    xsi_vlogtype_concat(t5, 32, 31, 2U, t8, 15, t17, 16);
    t15 = (t0 + 1608);
    xsi_vlogvar_assign_value(t15, t5, 0, 0, 32);
    goto LAB55;

LAB13:    xsi_set_current_line(32, ng0);

LAB59:    xsi_set_current_line(33, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng6)));
    xsi_vlogtype_concat(t5, 32, 31, 2U, t8, 15, t17, 16);
    t15 = (t0 + 1608);
    xsi_vlogvar_assign_value(t15, t5, 0, 0, 32);
    goto LAB55;

LAB15:    xsi_set_current_line(38, ng0);

LAB60:    xsi_set_current_line(39, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB17:    xsi_set_current_line(44, ng0);

LAB61:    xsi_set_current_line(45, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB19:    xsi_set_current_line(50, ng0);

LAB62:    xsi_set_current_line(51, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB21:    xsi_set_current_line(56, ng0);

LAB63:    xsi_set_current_line(57, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB23:    xsi_set_current_line(62, ng0);

LAB64:    xsi_set_current_line(63, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB25:    xsi_set_current_line(68, ng0);

LAB65:    xsi_set_current_line(69, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB27:    xsi_set_current_line(74, ng0);

LAB66:    xsi_set_current_line(75, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB29:    xsi_set_current_line(80, ng0);

LAB67:    xsi_set_current_line(81, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB31:    xsi_set_current_line(86, ng0);

LAB68:    xsi_set_current_line(87, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB33:    xsi_set_current_line(92, ng0);

LAB69:    xsi_set_current_line(93, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB35:    xsi_set_current_line(98, ng0);

LAB70:    xsi_set_current_line(99, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB37:    xsi_set_current_line(104, ng0);

LAB71:    xsi_set_current_line(105, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB39:    xsi_set_current_line(110, ng0);

LAB72:    xsi_set_current_line(111, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB41:    xsi_set_current_line(116, ng0);

LAB73:    xsi_set_current_line(117, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB43:    xsi_set_current_line(122, ng0);

LAB74:    xsi_set_current_line(123, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng6)));
    xsi_vlogtype_concat(t5, 32, 31, 2U, t8, 15, t17, 16);
    t15 = (t0 + 1608);
    xsi_vlogvar_assign_value(t15, t5, 0, 0, 32);
    goto LAB55;

LAB45:    xsi_set_current_line(128, ng0);

LAB75:    xsi_set_current_line(129, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 67108863U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 67108863U);
    t8 = ((char*)((ng24)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 25);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 25);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 6, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 32, 2U, t18, 6, t17, 26);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB47:    xsi_set_current_line(134, ng0);

LAB76:    xsi_set_current_line(135, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB49:    xsi_set_current_line(140, ng0);

LAB77:    xsi_set_current_line(141, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 2047U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 2047U);
    t8 = ((char*)((ng24)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 25);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 25);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 6, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 17, 2U, t18, 6, t17, 11);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

LAB51:    xsi_set_current_line(146, ng0);

LAB78:    xsi_set_current_line(147, ng0);
    t3 = (t0 + 1048U);
    t6 = *((char **)t3);
    memset(t17, 0, 8);
    t3 = (t17 + 4);
    t7 = (t6 + 4);
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t17) = t10;
    t11 = *((unsigned int *)t7);
    t12 = (t11 >> 0);
    *((unsigned int *)t3) = t12;
    t13 = *((unsigned int *)t17);
    *((unsigned int *)t17) = (t13 & 65535U);
    t14 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t14 & 65535U);
    t8 = ((char*)((ng4)));
    t15 = (t0 + 1048U);
    t19 = *((char **)t15);
    memset(t28, 0, 8);
    t15 = (t28 + 4);
    t20 = (t19 + 4);
    t22 = *((unsigned int *)t19);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t28) = t24;
    t25 = *((unsigned int *)t20);
    t26 = (t25 >> 15);
    t27 = (t26 & 1);
    *((unsigned int *)t15) = t27;
    xsi_vlog_mul_concat(t18, 15, 1, t8, 1U, t28, 1);
    xsi_vlogtype_concat(t5, 32, 31, 2U, t18, 15, t17, 16);
    t21 = (t0 + 1608);
    xsi_vlogvar_assign_value(t21, t5, 0, 0, 32);
    goto LAB55;

}


extern void work_m_00000000003462526737_2640949057_init()
{
	static char *pe[] = {(void *)Cont_8_0,(void *)Always_10_1};
	xsi_register_didat("work_m_00000000003462526737_2640949057", "isim/cpu_mmu_integration_isim_beh.exe.sim/work/m_00000000003462526737_2640949057.didat");
	xsi_register_executes(pe);
}
