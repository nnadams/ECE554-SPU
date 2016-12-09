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
static int ng0[] = {0, 0, 0, 0};
static int ng1[] = {0, 0};
static const char *ng2 = " Warning : Input clock period of, %1.3f ns, on the %s port of instance %m exceeds allowed value of %1.3f ns at simulation time %1.3f ns.";



static void Initial_1613_0(char *t0)
{
    char *t1;
    char *t2;

LAB0:
LAB2:    t1 = ((char*)((ng0)));
    t2 = (t0 + 1880);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 64);
    t1 = ((char*)((ng0)));
    t2 = (t0 + 2040);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 64);

LAB1:    return;
}

static void Always_1618_1(char *t0)
{
    char t4[16];
    char t7[16];
    char t9[8];
    char t22[8];
    char t38[8];
    char t46[8];
    char t89[8];
    char t95[8];
    char t98[8];
    char *t1;
    char *t2;
    char *t3;
    char *t5;
    char *t6;
    char *t8;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    char *t20;
    char *t21;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    char *t37;
    char *t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    unsigned int t43;
    unsigned int t44;
    char *t45;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    char *t50;
    char *t51;
    char *t52;
    unsigned int t53;
    unsigned int t54;
    unsigned int t55;
    unsigned int t56;
    unsigned int t57;
    unsigned int t58;
    unsigned int t59;
    char *t60;
    char *t61;
    unsigned int t62;
    unsigned int t63;
    unsigned int t64;
    unsigned int t65;
    unsigned int t66;
    unsigned int t67;
    unsigned int t68;
    unsigned int t69;
    int t70;
    int t71;
    unsigned int t72;
    unsigned int t73;
    unsigned int t74;
    unsigned int t75;
    unsigned int t76;
    unsigned int t77;
    char *t78;
    unsigned int t79;
    unsigned int t80;
    unsigned int t81;
    unsigned int t82;
    unsigned int t83;
    char *t84;
    char *t85;
    char *t86;
    double t87;
    double t88;
    char *t90;
    char *t91;
    char *t92;
    double t93;
    double t94;
    double t96;
    double t97;

LAB0:    t1 = (t0 + 3208U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = (t0 + 3528);
    *((int *)t2) = 1;
    t3 = (t0 + 3240);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:
LAB5:    t5 = xsi_vlog_time(t4, 1.0000000000000000, 1.0000000000000000);
    t6 = (t0 + 1880);
    xsi_vlogvar_wait_assign_value(t6, t4, 0, 0, 64, 0LL);
    t2 = xsi_vlog_time(t4, 1.0000000000000000, 1.0000000000000000);
    t3 = (t0 + 1880);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    xsi_vlog_unsigned_minus(t7, 64, t4, 64, t6, 64);
    t8 = (t0 + 2040);
    xsi_vlogvar_wait_assign_value(t8, t7, 0, 0, 64, 0LL);
    t2 = (t0 + 2040);
    t3 = (t2 + 56U);
    t5 = *((char **)t3);
    t6 = (t0 + 608);
    t8 = *((char **)t6);
    xsi_vlog_unsigned_greater(t4, 64, t5, 64, t8, 32);
    memset(t9, 0, 8);
    t6 = (t4 + 4);
    t10 = *((unsigned int *)t6);
    t11 = (~(t10));
    t12 = *((unsigned int *)t4);
    t13 = (t12 & t11);
    t14 = (t13 & 1U);
    if (t14 != 0)
        goto LAB6;

LAB7:    if (*((unsigned int *)t6) != 0)
        goto LAB8;

LAB9:    t16 = (t9 + 4);
    t17 = *((unsigned int *)t9);
    t18 = *((unsigned int *)t16);
    t19 = (t17 || t18);
    if (t19 > 0)
        goto LAB10;

LAB11:    memcpy(t46, t9, 8);

LAB12:    t78 = (t46 + 4);
    t79 = *((unsigned int *)t78);
    t80 = (~(t79));
    t81 = *((unsigned int *)t46);
    t82 = (t81 & t80);
    t83 = (t82 != 0);
    if (t83 > 0)
        goto LAB24;

LAB25:
LAB26:    goto LAB2;

LAB6:    *((unsigned int *)t9) = 1;
    goto LAB9;

LAB8:    t15 = (t9 + 4);
    *((unsigned int *)t9) = 1;
    *((unsigned int *)t15) = 1;
    goto LAB9;

LAB10:    t20 = (t0 + 1480U);
    t21 = *((char **)t20);
    t20 = ((char*)((ng1)));
    memset(t22, 0, 8);
    t23 = (t21 + 4);
    t24 = (t20 + 4);
    t25 = *((unsigned int *)t21);
    t26 = *((unsigned int *)t20);
    t27 = (t25 ^ t26);
    t28 = *((unsigned int *)t23);
    t29 = *((unsigned int *)t24);
    t30 = (t28 ^ t29);
    t31 = (t27 | t30);
    t32 = *((unsigned int *)t23);
    t33 = *((unsigned int *)t24);
    t34 = (t32 | t33);
    t35 = (~(t34));
    t36 = (t31 & t35);
    if (t36 != 0)
        goto LAB16;

LAB13:    if (t34 != 0)
        goto LAB15;

LAB14:    *((unsigned int *)t22) = 1;

LAB16:    memset(t38, 0, 8);
    t39 = (t22 + 4);
    t40 = *((unsigned int *)t39);
    t41 = (~(t40));
    t42 = *((unsigned int *)t22);
    t43 = (t42 & t41);
    t44 = (t43 & 1U);
    if (t44 != 0)
        goto LAB17;

LAB18:    if (*((unsigned int *)t39) != 0)
        goto LAB19;

LAB20:    t47 = *((unsigned int *)t9);
    t48 = *((unsigned int *)t38);
    t49 = (t47 & t48);
    *((unsigned int *)t46) = t49;
    t50 = (t9 + 4);
    t51 = (t38 + 4);
    t52 = (t46 + 4);
    t53 = *((unsigned int *)t50);
    t54 = *((unsigned int *)t51);
    t55 = (t53 | t54);
    *((unsigned int *)t52) = t55;
    t56 = *((unsigned int *)t52);
    t57 = (t56 != 0);
    if (t57 == 1)
        goto LAB21;

LAB22:
LAB23:    goto LAB12;

LAB15:    t37 = (t22 + 4);
    *((unsigned int *)t22) = 1;
    *((unsigned int *)t37) = 1;
    goto LAB16;

LAB17:    *((unsigned int *)t38) = 1;
    goto LAB20;

LAB19:    t45 = (t38 + 4);
    *((unsigned int *)t38) = 1;
    *((unsigned int *)t45) = 1;
    goto LAB20;

LAB21:    t58 = *((unsigned int *)t46);
    t59 = *((unsigned int *)t52);
    *((unsigned int *)t46) = (t58 | t59);
    t60 = (t9 + 4);
    t61 = (t38 + 4);
    t62 = *((unsigned int *)t9);
    t63 = (~(t62));
    t64 = *((unsigned int *)t60);
    t65 = (~(t64));
    t66 = *((unsigned int *)t38);
    t67 = (~(t66));
    t68 = *((unsigned int *)t61);
    t69 = (~(t68));
    t70 = (t63 & t65);
    t71 = (t67 & t69);
    t72 = (~(t70));
    t73 = (~(t71));
    t74 = *((unsigned int *)t52);
    *((unsigned int *)t52) = (t74 & t72);
    t75 = *((unsigned int *)t52);
    *((unsigned int *)t52) = (t75 & t73);
    t76 = *((unsigned int *)t46);
    *((unsigned int *)t46) = (t76 & t72);
    t77 = *((unsigned int *)t46);
    *((unsigned int *)t46) = (t77 & t73);
    goto LAB23;

LAB24:
LAB27:    t84 = (t0 + 2040);
    t85 = (t84 + 56U);
    t86 = *((char **)t85);
    t87 = xsi_vlog_convert_to_real(t86, 64, 2);
    t88 = (t87 / 1000.0000000000000);
    *((double *)t89) = t88;
    t90 = (t0 + 472);
    t91 = *((char **)t90);
    t90 = (t0 + 608);
    t92 = *((char **)t90);
    t93 = xsi_vlog_convert_to_real(t92, 32, 1);
    t94 = (t93 / 1000.0000000000000);
    *((double *)t95) = t94;
    t90 = xsi_vlog_time(t7, 1.0000000000000000, 1.0000000000000000);
    t96 = xsi_vlog_convert_to_real(t7, 64, 2);
    t97 = (t96 / 1000.0000000000000);
    *((double *)t98) = t97;
    xsi_vlogfile_write(1, 0, 0, ng2, 5, t0, (char)114, t89, 64, (char)118, t91, 40, (char)114, t95, 64, (char)114, t98, 64);
    goto LAB26;

}


extern void unisims_ver_m_00000000000740258969_2946946538_init()
{
	static char *pe[] = {(void *)Initial_1613_0,(void *)Always_1618_1};
	xsi_register_didat("unisims_ver_m_00000000000740258969_2946946538", "isim/test_isim_beh.exe.sim/unisims_ver/m_00000000000740258969_2946946538.didat");
	xsi_register_executes(pe);
}
