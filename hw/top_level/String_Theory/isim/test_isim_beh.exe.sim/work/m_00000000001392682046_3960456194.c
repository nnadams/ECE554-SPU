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
static const char *ng0 = "//userspace.cae.wisc.edu/people/j/jjbrand/554/project/ECE554-SPU/hw/CPU/verilog/branch_control.v";
static int ng1[] = {16, 0};
static int ng2[] = {6, 0};
static unsigned int ng3[] = {0U, 0U};
static unsigned int ng4[] = {1U, 0U};
static unsigned int ng5[] = {12U, 0U};
static unsigned int ng6[] = {13U, 0U};
static unsigned int ng7[] = {14U, 0U};
static unsigned int ng8[] = {15U, 0U};
static unsigned int ng9[] = {4U, 0U};
static unsigned int ng10[] = {2U, 0U};
static unsigned int ng11[] = {5U, 0U};
static unsigned int ng12[] = {6U, 0U};
static unsigned int ng13[] = {7U, 0U};
static unsigned int ng14[] = {60U, 0U};
static unsigned int ng15[] = {1U, 1U};



static void Cont_21_0(char *t0)
{
    char t3[8];
    char t4[8];
    char t13[8];
    char t17[8];
    char *t1;
    char *t2;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t14;
    char *t15;
    char *t16;
    char *t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;

LAB0:    t1 = (t0 + 4448U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(21, ng0);
    t2 = (t0 + 1048U);
    t5 = *((char **)t2);
    memset(t4, 0, 8);
    t2 = (t4 + 4);
    t6 = (t5 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (t7 >> 0);
    *((unsigned int *)t4) = t8;
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t2) = t10;
    t11 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t11 & 65535U);
    t12 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t12 & 65535U);
    t14 = ((char*)((ng1)));
    t15 = (t0 + 1048U);
    t16 = *((char **)t15);
    memset(t17, 0, 8);
    t15 = (t17 + 4);
    t18 = (t16 + 4);
    t19 = *((unsigned int *)t16);
    t20 = (t19 >> 15);
    t21 = (t20 & 1);
    *((unsigned int *)t17) = t21;
    t22 = *((unsigned int *)t18);
    t23 = (t22 >> 15);
    t24 = (t23 & 1);
    *((unsigned int *)t15) = t24;
    xsi_vlog_mul_concat(t13, 16, 1, t14, 1U, t17, 1);
    xsi_vlogtype_concat(t3, 32, 32, 2U, t13, 16, t4, 16);
    t25 = (t0 + 6416);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    memcpy(t29, t3, 8);
    xsi_driver_vfirst_trans(t25, 0, 31);
    t30 = (t0 + 6256);
    *((int *)t30) = 1;

LAB1:    return;
}

static void Cont_22_1(char *t0)
{
    char t3[8];
    char t4[8];
    char t13[8];
    char t17[8];
    char *t1;
    char *t2;
    char *t5;
    char *t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t14;
    char *t15;
    char *t16;
    char *t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;

LAB0:    t1 = (t0 + 4696U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(22, ng0);
    t2 = (t0 + 1048U);
    t5 = *((char **)t2);
    memset(t4, 0, 8);
    t2 = (t4 + 4);
    t6 = (t5 + 4);
    t7 = *((unsigned int *)t5);
    t8 = (t7 >> 0);
    *((unsigned int *)t4) = t8;
    t9 = *((unsigned int *)t6);
    t10 = (t9 >> 0);
    *((unsigned int *)t2) = t10;
    t11 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t11 & 67108863U);
    t12 = *((unsigned int *)t2);
    *((unsigned int *)t2) = (t12 & 67108863U);
    t14 = ((char*)((ng2)));
    t15 = (t0 + 1048U);
    t16 = *((char **)t15);
    memset(t17, 0, 8);
    t15 = (t17 + 4);
    t18 = (t16 + 4);
    t19 = *((unsigned int *)t16);
    t20 = (t19 >> 25);
    t21 = (t20 & 1);
    *((unsigned int *)t17) = t21;
    t22 = *((unsigned int *)t18);
    t23 = (t22 >> 25);
    t24 = (t23 & 1);
    *((unsigned int *)t15) = t24;
    xsi_vlog_mul_concat(t13, 6, 1, t14, 1U, t17, 1);
    xsi_vlogtype_concat(t3, 32, 32, 2U, t13, 6, t4, 26);
    t25 = (t0 + 6480);
    t26 = (t25 + 56U);
    t27 = *((char **)t26);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    memcpy(t29, t3, 8);
    xsi_driver_vfirst_trans(t25, 0, 31);
    t30 = (t0 + 6272);
    *((int *)t30) = 1;

LAB1:    return;
}

static void Cont_24_2(char *t0)
{
    char t3[8];
    char t4[8];
    char t8[8];
    char t41[8];
    char t42[8];
    char t46[8];
    char *t1;
    char *t2;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    char *t35;
    char *t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    char *t43;
    char *t44;
    char *t45;
    char *t47;
    char *t48;
    unsigned int t49;
    unsigned int t50;
    unsigned int t51;
    unsigned int t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    unsigned int t60;
    char *t61;
    char *t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    char *t68;
    char *t69;
    unsigned int t70;
    unsigned int t71;
    unsigned int t72;
    char *t73;
    char *t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    unsigned int t78;
    char *t79;
    char *t80;
    char *t81;
    char *t82;
    char *t83;
    char *t84;

LAB0:    t1 = (t0 + 4944U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(24, ng0);
    t2 = (t0 + 3368);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng3)));
    memset(t8, 0, 8);
    t9 = (t6 + 4);
    t10 = (t7 + 4);
    t11 = *((unsigned int *)t6);
    t12 = *((unsigned int *)t7);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t9);
    t15 = *((unsigned int *)t10);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t9);
    t19 = *((unsigned int *)t10);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB7;

LAB4:    if (t20 != 0)
        goto LAB6;

LAB5:    *((unsigned int *)t8) = 1;

LAB7:    memset(t4, 0, 8);
    t24 = (t8 + 4);
    t25 = *((unsigned int *)t24);
    t26 = (~(t25));
    t27 = *((unsigned int *)t8);
    t28 = (t27 & t26);
    t29 = (t28 & 1U);
    if (t29 != 0)
        goto LAB8;

LAB9:    if (*((unsigned int *)t24) != 0)
        goto LAB10;

LAB11:    t31 = (t4 + 4);
    t32 = *((unsigned int *)t4);
    t33 = *((unsigned int *)t31);
    t34 = (t32 || t33);
    if (t34 > 0)
        goto LAB12;

LAB13:    t37 = *((unsigned int *)t4);
    t38 = (~(t37));
    t39 = *((unsigned int *)t31);
    t40 = (t38 || t39);
    if (t40 > 0)
        goto LAB14;

LAB15:    if (*((unsigned int *)t31) > 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t4) > 0)
        goto LAB18;

LAB19:    memcpy(t3, t41, 8);

LAB20:    t79 = (t0 + 6544);
    t80 = (t79 + 56U);
    t81 = *((char **)t80);
    t82 = (t81 + 56U);
    t83 = *((char **)t82);
    memcpy(t83, t3, 8);
    xsi_driver_vfirst_trans(t79, 0, 31);
    t84 = (t0 + 6288);
    *((int *)t84) = 1;

LAB1:    return;
LAB6:    t23 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB7;

LAB8:    *((unsigned int *)t4) = 1;
    goto LAB11;

LAB10:    t30 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t30) = 1;
    goto LAB11;

LAB12:    t35 = (t0 + 1688U);
    t36 = *((char **)t35);
    goto LAB13;

LAB14:    t35 = (t0 + 3368);
    t43 = (t35 + 56U);
    t44 = *((char **)t43);
    t45 = ((char*)((ng4)));
    memset(t46, 0, 8);
    t47 = (t44 + 4);
    t48 = (t45 + 4);
    t49 = *((unsigned int *)t44);
    t50 = *((unsigned int *)t45);
    t51 = (t49 ^ t50);
    t52 = *((unsigned int *)t47);
    t53 = *((unsigned int *)t48);
    t54 = (t52 ^ t53);
    t55 = (t51 | t54);
    t56 = *((unsigned int *)t47);
    t57 = *((unsigned int *)t48);
    t58 = (t56 | t57);
    t59 = (~(t58));
    t60 = (t55 & t59);
    if (t60 != 0)
        goto LAB24;

LAB21:    if (t58 != 0)
        goto LAB23;

LAB22:    *((unsigned int *)t46) = 1;

LAB24:    memset(t42, 0, 8);
    t62 = (t46 + 4);
    t63 = *((unsigned int *)t62);
    t64 = (~(t63));
    t65 = *((unsigned int *)t46);
    t66 = (t65 & t64);
    t67 = (t66 & 1U);
    if (t67 != 0)
        goto LAB25;

LAB26:    if (*((unsigned int *)t62) != 0)
        goto LAB27;

LAB28:    t69 = (t42 + 4);
    t70 = *((unsigned int *)t42);
    t71 = *((unsigned int *)t69);
    t72 = (t70 || t71);
    if (t72 > 0)
        goto LAB29;

LAB30:    t75 = *((unsigned int *)t42);
    t76 = (~(t75));
    t77 = *((unsigned int *)t69);
    t78 = (t76 || t77);
    if (t78 > 0)
        goto LAB31;

LAB32:    if (*((unsigned int *)t69) > 0)
        goto LAB33;

LAB34:    if (*((unsigned int *)t42) > 0)
        goto LAB35;

LAB36:    memcpy(t41, t73, 8);

LAB37:    goto LAB15;

LAB16:    xsi_vlog_unsigned_bit_combine(t3, 32, t36, 32, t41, 32);
    goto LAB20;

LAB18:    memcpy(t3, t36, 8);
    goto LAB20;

LAB23:    t61 = (t46 + 4);
    *((unsigned int *)t46) = 1;
    *((unsigned int *)t61) = 1;
    goto LAB24;

LAB25:    *((unsigned int *)t42) = 1;
    goto LAB28;

LAB27:    t68 = (t42 + 4);
    *((unsigned int *)t42) = 1;
    *((unsigned int *)t68) = 1;
    goto LAB28;

LAB29:    t73 = (t0 + 1208U);
    t74 = *((char **)t73);
    goto LAB30;

LAB31:    t73 = ((char*)((ng3)));
    goto LAB32;

LAB33:    xsi_vlog_unsigned_bit_combine(t41, 32, t74, 32, t73, 32);
    goto LAB37;

LAB35:    memcpy(t41, t74, 8);
    goto LAB37;

}

static void Cont_27_3(char *t0)
{
    char t3[8];
    char t4[8];
    char t8[8];
    char *t1;
    char *t2;
    char *t5;
    char *t6;
    char *t7;
    char *t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    char *t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    char *t35;
    char *t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    unsigned int t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;

LAB0:    t1 = (t0 + 5192U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(27, ng0);
    t2 = (t0 + 3528);
    t5 = (t2 + 56U);
    t6 = *((char **)t5);
    t7 = ((char*)((ng3)));
    memset(t8, 0, 8);
    t9 = (t6 + 4);
    t10 = (t7 + 4);
    t11 = *((unsigned int *)t6);
    t12 = *((unsigned int *)t7);
    t13 = (t11 ^ t12);
    t14 = *((unsigned int *)t9);
    t15 = *((unsigned int *)t10);
    t16 = (t14 ^ t15);
    t17 = (t13 | t16);
    t18 = *((unsigned int *)t9);
    t19 = *((unsigned int *)t10);
    t20 = (t18 | t19);
    t21 = (~(t20));
    t22 = (t17 & t21);
    if (t22 != 0)
        goto LAB7;

LAB4:    if (t20 != 0)
        goto LAB6;

LAB5:    *((unsigned int *)t8) = 1;

LAB7:    memset(t4, 0, 8);
    t24 = (t8 + 4);
    t25 = *((unsigned int *)t24);
    t26 = (~(t25));
    t27 = *((unsigned int *)t8);
    t28 = (t27 & t26);
    t29 = (t28 & 1U);
    if (t29 != 0)
        goto LAB8;

LAB9:    if (*((unsigned int *)t24) != 0)
        goto LAB10;

LAB11:    t31 = (t4 + 4);
    t32 = *((unsigned int *)t4);
    t33 = *((unsigned int *)t31);
    t34 = (t32 || t33);
    if (t34 > 0)
        goto LAB12;

LAB13:    t37 = *((unsigned int *)t4);
    t38 = (~(t37));
    t39 = *((unsigned int *)t31);
    t40 = (t38 || t39);
    if (t40 > 0)
        goto LAB14;

LAB15:    if (*((unsigned int *)t31) > 0)
        goto LAB16;

LAB17:    if (*((unsigned int *)t4) > 0)
        goto LAB18;

LAB19:    memcpy(t3, t41, 8);

LAB20:    t35 = (t0 + 6608);
    t42 = (t35 + 56U);
    t43 = *((char **)t42);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    memcpy(t45, t3, 8);
    xsi_driver_vfirst_trans(t35, 0, 31);
    t46 = (t0 + 6304);
    *((int *)t46) = 1;

LAB1:    return;
LAB6:    t23 = (t8 + 4);
    *((unsigned int *)t8) = 1;
    *((unsigned int *)t23) = 1;
    goto LAB7;

LAB8:    *((unsigned int *)t4) = 1;
    goto LAB11;

LAB10:    t30 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t30) = 1;
    goto LAB11;

LAB12:    t35 = (t0 + 2488U);
    t36 = *((char **)t35);
    goto LAB13;

LAB14:    t35 = (t0 + 2648U);
    t41 = *((char **)t35);
    goto LAB15;

LAB16:    xsi_vlog_unsigned_bit_combine(t3, 32, t36, 32, t41, 32);
    goto LAB20;

LAB18:    memcpy(t3, t36, 8);
    goto LAB20;

}

static void Cont_32_4(char *t0)
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

LAB0:    t1 = (t0 + 5440U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(32, ng0);
    t2 = (t0 + 3208);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t5 = (t0 + 6672);
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
    t18 = (t0 + 6320);
    *((int *)t18) = 1;

LAB1:    return;
}

static void Always_34_5(char *t0)
{
    char t4[8];
    char t5[8];
    char t26[8];
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
    char *t17;
    char *t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    char *t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    char *t38;
    char *t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    unsigned int t45;
    int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    unsigned int t50;
    char *t51;

LAB0:    t1 = (t0 + 5688U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(34, ng0);
    t2 = (t0 + 6336);
    *((int *)t2) = 1;
    t3 = (t0 + 5720);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(34, ng0);

LAB5:    xsi_set_current_line(35, ng0);
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

LAB6:    t15 = ((char*)((ng5)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t15, 6);
    if (t16 == 1)
        goto LAB7;

LAB8:    t2 = ((char*)((ng6)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB9;

LAB10:    t2 = ((char*)((ng7)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB11;

LAB12:    t2 = ((char*)((ng8)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB13;

LAB14:    t2 = ((char*)((ng9)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB15;

LAB16:    t2 = ((char*)((ng11)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB17;

LAB18:    t2 = ((char*)((ng12)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB19;

LAB20:    t2 = ((char*)((ng13)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB21;

LAB22:    t2 = ((char*)((ng14)));
    t16 = xsi_vlog_unsigned_case_xcompare(t4, 6, t2, 6);
    if (t16 == 1)
        goto LAB23;

LAB24:
LAB26:
LAB25:    xsi_set_current_line(109, ng0);

LAB52:    xsi_set_current_line(110, ng0);
    t2 = ((char*)((ng15)));
    t3 = (t0 + 3368);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 2);
    xsi_set_current_line(111, ng0);
    t2 = ((char*)((ng15)));
    t3 = (t0 + 3528);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(112, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3208);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);

LAB27:    goto LAB2;

LAB7:    xsi_set_current_line(38, ng0);

LAB28:    xsi_set_current_line(39, ng0);
    t17 = ((char*)((ng3)));
    t18 = (t0 + 3368);
    xsi_vlogvar_assign_value(t18, t17, 0, 0, 2);
    xsi_set_current_line(40, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3528);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(41, ng0);
    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    t2 = (t0 + 3208);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 1);
    goto LAB27;

LAB9:    xsi_set_current_line(46, ng0);

LAB29:    xsi_set_current_line(47, ng0);
    t3 = ((char*)((ng3)));
    t6 = (t0 + 3368);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 2);
    xsi_set_current_line(48, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3528);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(49, ng0);
    t2 = (t0 + 1528U);
    t3 = *((char **)t2);
    memset(t5, 0, 8);
    t2 = (t3 + 4);
    t9 = *((unsigned int *)t2);
    t10 = (~(t9));
    t11 = *((unsigned int *)t3);
    t12 = (t11 & t10);
    t13 = (t12 & 1U);
    if (t13 != 0)
        goto LAB33;

LAB31:    if (*((unsigned int *)t2) == 0)
        goto LAB30;

LAB32:    t6 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t6) = 1;

LAB33:    t7 = (t5 + 4);
    t8 = (t3 + 4);
    t14 = *((unsigned int *)t3);
    t19 = (~(t14));
    *((unsigned int *)t5) = t19;
    *((unsigned int *)t7) = 0;
    if (*((unsigned int *)t8) != 0)
        goto LAB35;

LAB34:    t24 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t24 & 1U);
    t25 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t25 & 1U);
    t15 = (t0 + 3208);
    xsi_vlogvar_assign_value(t15, t5, 0, 0, 1);
    goto LAB27;

LAB11:    xsi_set_current_line(54, ng0);

LAB36:    xsi_set_current_line(55, ng0);
    t3 = ((char*)((ng3)));
    t6 = (t0 + 3368);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 2);
    xsi_set_current_line(56, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3528);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(57, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    t2 = (t0 + 3208);
    xsi_vlogvar_assign_value(t2, t3, 0, 0, 1);
    goto LAB27;

LAB13:    xsi_set_current_line(62, ng0);

LAB37:    xsi_set_current_line(63, ng0);
    t3 = ((char*)((ng3)));
    t6 = (t0 + 3368);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 2);
    xsi_set_current_line(64, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3528);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(65, ng0);
    t2 = (t0 + 1368U);
    t3 = *((char **)t2);
    memset(t5, 0, 8);
    t2 = (t3 + 4);
    t9 = *((unsigned int *)t2);
    t10 = (~(t9));
    t11 = *((unsigned int *)t3);
    t12 = (t11 & t10);
    t13 = (t12 & 1U);
    if (t13 != 0)
        goto LAB41;

LAB39:    if (*((unsigned int *)t2) == 0)
        goto LAB38;

LAB40:    t6 = (t5 + 4);
    *((unsigned int *)t5) = 1;
    *((unsigned int *)t6) = 1;

LAB41:    t7 = (t5 + 4);
    t8 = (t3 + 4);
    t14 = *((unsigned int *)t3);
    t19 = (~(t14));
    *((unsigned int *)t5) = t19;
    *((unsigned int *)t7) = 0;
    if (*((unsigned int *)t8) != 0)
        goto LAB43;

LAB42:    t24 = *((unsigned int *)t5);
    *((unsigned int *)t5) = (t24 & 1U);
    t25 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t25 & 1U);
    t15 = (t0 + 1528U);
    t17 = *((char **)t15);
    t27 = *((unsigned int *)t5);
    t28 = *((unsigned int *)t17);
    t29 = (t27 | t28);
    *((unsigned int *)t26) = t29;
    t15 = (t5 + 4);
    t18 = (t17 + 4);
    t30 = (t26 + 4);
    t31 = *((unsigned int *)t15);
    t32 = *((unsigned int *)t18);
    t33 = (t31 | t32);
    *((unsigned int *)t30) = t33;
    t34 = *((unsigned int *)t30);
    t35 = (t34 != 0);
    if (t35 == 1)
        goto LAB44;

LAB45:
LAB46:    t51 = (t0 + 3208);
    xsi_vlogvar_assign_value(t51, t26, 0, 0, 1);
    goto LAB27;

LAB15:    xsi_set_current_line(70, ng0);

LAB47:    xsi_set_current_line(71, ng0);
    t3 = ((char*)((ng10)));
    t6 = (t0 + 3368);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 2);
    xsi_set_current_line(72, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 3528);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(73, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 3208);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    goto LAB27;

LAB17:    xsi_set_current_line(78, ng0);

LAB48:    xsi_set_current_line(79, ng0);
    t3 = ((char*)((ng4)));
    t6 = (t0 + 3368);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 2);
    xsi_set_current_line(80, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3528);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(81, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 3208);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    goto LAB27;

LAB19:    xsi_set_current_line(86, ng0);

LAB49:    xsi_set_current_line(87, ng0);
    t3 = ((char*)((ng10)));
    t6 = (t0 + 3368);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 2);
    xsi_set_current_line(88, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 3528);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(89, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 3208);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    goto LAB27;

LAB21:    xsi_set_current_line(94, ng0);

LAB50:    xsi_set_current_line(95, ng0);
    t3 = ((char*)((ng4)));
    t6 = (t0 + 3368);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 2);
    xsi_set_current_line(96, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3528);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(97, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 3208);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    goto LAB27;

LAB23:    xsi_set_current_line(102, ng0);

LAB51:    xsi_set_current_line(103, ng0);
    t3 = ((char*)((ng4)));
    t6 = (t0 + 3368);
    xsi_vlogvar_assign_value(t6, t3, 0, 0, 2);
    xsi_set_current_line(104, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 3528);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(105, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t0 + 3208);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    goto LAB27;

LAB30:    *((unsigned int *)t5) = 1;
    goto LAB33;

LAB35:    t20 = *((unsigned int *)t5);
    t21 = *((unsigned int *)t8);
    *((unsigned int *)t5) = (t20 | t21);
    t22 = *((unsigned int *)t7);
    t23 = *((unsigned int *)t8);
    *((unsigned int *)t7) = (t22 | t23);
    goto LAB34;

LAB38:    *((unsigned int *)t5) = 1;
    goto LAB41;

LAB43:    t20 = *((unsigned int *)t5);
    t21 = *((unsigned int *)t8);
    *((unsigned int *)t5) = (t20 | t21);
    t22 = *((unsigned int *)t7);
    t23 = *((unsigned int *)t8);
    *((unsigned int *)t7) = (t22 | t23);
    goto LAB42;

LAB44:    t36 = *((unsigned int *)t26);
    t37 = *((unsigned int *)t30);
    *((unsigned int *)t26) = (t36 | t37);
    t38 = (t5 + 4);
    t39 = (t17 + 4);
    t40 = *((unsigned int *)t38);
    t41 = (~(t40));
    t42 = *((unsigned int *)t5);
    t16 = (t42 & t41);
    t43 = *((unsigned int *)t39);
    t44 = (~(t43));
    t45 = *((unsigned int *)t17);
    t46 = (t45 & t44);
    t47 = (~(t16));
    t48 = (~(t46));
    t49 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t49 & t47);
    t50 = *((unsigned int *)t30);
    *((unsigned int *)t30) = (t50 & t48);
    goto LAB46;

}

static void implSig1_execute(char *t0)
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

LAB0:    t1 = (t0 + 5936U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = ((char*)((ng3)));
    t3 = (t0 + 6736);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memset(t7, 0, 8);
    t8 = 1U;
    t9 = t8;
    t10 = (t2 + 4);
    t11 = *((unsigned int *)t2);
    t8 = (t8 & t11);
    t12 = *((unsigned int *)t10);
    t9 = (t9 & t12);
    t13 = (t7 + 4);
    t14 = *((unsigned int *)t7);
    *((unsigned int *)t7) = (t14 | t8);
    t15 = *((unsigned int *)t13);
    *((unsigned int *)t13) = (t15 | t9);
    xsi_driver_vfirst_trans(t3, 0, 0);

LAB1:    return;
}


extern void work_m_00000000001392682046_3960456194_init()
{
	static char *pe[] = {(void *)Cont_21_0,(void *)Cont_22_1,(void *)Cont_24_2,(void *)Cont_27_3,(void *)Cont_32_4,(void *)Always_34_5,(void *)implSig1_execute};
	xsi_register_didat("work_m_00000000001392682046_3960456194", "isim/test_isim_beh.exe.sim/work/m_00000000001392682046_3960456194.didat");
	xsi_register_executes(pe);
}
