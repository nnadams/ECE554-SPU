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
static const char *ng0 = "//userspace.cae.wisc.edu/people/j/jjbrand/554/project/ECE554-SPU/hw/top_level/String_Theory/test.v";
static int ng1[] = {0, 0};
static int ng2[] = {1, 0};
static unsigned int ng3[] = {1U, 0U};
static int ng4[] = {5, 0};
static int ng5[] = {20, 0};
static unsigned int ng6[] = {96U, 0U};
static int ng7[] = {50, 0};
static int ng8[] = {128, 0};
static unsigned int ng9[] = {149U, 0U};
static unsigned int ng10[] = {0U, 0U};
static unsigned int ng11[] = {2U, 0U};
static unsigned int ng12[] = {95U, 0U};
static unsigned int ng13[] = {4U, 0U};
static unsigned int ng14[] = {16U, 0U};



static void Initial_72_0(char *t0)
{
    char t12[8];
    char t29[8];
    char *t1;
    char *t2;
    char *t3;
    unsigned int t4;
    unsigned int t5;
    unsigned int t6;
    int t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
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
    unsigned int t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    char *t28;

LAB0:    t1 = (t0 + 5248U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(72, ng0);

LAB4:    xsi_set_current_line(73, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3688);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(74, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 3848);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(75, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(76, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 4168);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    xsi_set_current_line(77, ng0);
    t2 = ((char*)((ng4)));
    t3 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = (~(t4));
    t6 = *((unsigned int *)t2);
    t7 = (t6 & t5);
    t8 = (t0 + 9156);
    *((int *)t8) = t7;

LAB5:    t9 = (t0 + 9156);
    if (*((int *)t9) > 0)
        goto LAB6;

LAB7:    xsi_set_current_line(78, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 3848);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(79, ng0);
    t2 = ((char*)((ng5)));
    t3 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = (~(t4));
    t6 = *((unsigned int *)t2);
    t7 = (t6 & t5);
    t8 = (t0 + 9160);
    *((int *)t8) = t7;

LAB9:    t9 = (t0 + 9160);
    if (*((int *)t9) > 0)
        goto LAB10;

LAB11:    xsi_set_current_line(81, ng0);

LAB13:    t2 = (t0 + 2968U);
    t3 = *((char **)t2);
    t2 = ((char*)((ng1)));
    memset(t12, 0, 8);
    t8 = (t3 + 4);
    t9 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = *((unsigned int *)t2);
    t6 = (t4 ^ t5);
    t13 = *((unsigned int *)t8);
    t14 = *((unsigned int *)t9);
    t15 = (t13 ^ t14);
    t16 = (t6 | t15);
    t17 = *((unsigned int *)t8);
    t18 = *((unsigned int *)t9);
    t19 = (t17 | t18);
    t20 = (~(t19));
    t21 = (t16 & t20);
    if (t21 != 0)
        goto LAB15;

LAB14:    if (t19 != 0)
        goto LAB16;

LAB17:    t11 = (t12 + 4);
    t22 = *((unsigned int *)t11);
    t23 = (~(t22));
    t24 = *((unsigned int *)t12);
    t25 = (t24 & t23);
    t26 = (t25 != 0);
    if (t26 > 0)
        goto LAB18;

LAB19:    xsi_set_current_line(84, ng0);
    t2 = (t0 + 6360);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB21;

LAB1:    return;
LAB6:    xsi_set_current_line(77, ng0);
    t10 = (t0 + 6312);
    *((int *)t10) = 1;
    t11 = (t0 + 5280);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB8;
    goto LAB1;

LAB8:    t2 = (t0 + 9156);
    t7 = *((int *)t2);
    *((int *)t2) = (t7 - 1);
    goto LAB5;

LAB10:    xsi_set_current_line(79, ng0);
    t10 = (t0 + 6328);
    *((int *)t10) = 1;
    t11 = (t0 + 5280);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB12;
    goto LAB1;

LAB12:    t2 = (t0 + 9160);
    t7 = *((int *)t2);
    *((int *)t2) = (t7 - 1);
    goto LAB9;

LAB15:    *((unsigned int *)t12) = 1;
    goto LAB17;

LAB16:    t10 = (t12 + 4);
    *((unsigned int *)t12) = 1;
    *((unsigned int *)t10) = 1;
    goto LAB17;

LAB18:    xsi_set_current_line(82, ng0);
    t27 = (t0 + 6344);
    *((int *)t27) = 1;
    t28 = (t0 + 5280);
    *((char **)t28) = t27;
    *((char **)t1) = &&LAB20;
    goto LAB1;

LAB20:    goto LAB13;

LAB21:    xsi_set_current_line(85, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(86, ng0);
    t2 = (t0 + 6376);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB22;
    goto LAB1;

LAB22:    xsi_set_current_line(87, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(89, ng0);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 4168);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    xsi_set_current_line(90, ng0);
    t2 = (t0 + 6392);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB23;
    goto LAB1;

LAB23:    xsi_set_current_line(91, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = (~(t4));
    t6 = *((unsigned int *)t2);
    t7 = (t6 & t5);
    t8 = (t0 + 9164);
    *((int *)t8) = t7;

LAB24:    t9 = (t0 + 9164);
    if (*((int *)t9) > 0)
        goto LAB25;

LAB26:    xsi_set_current_line(92, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(93, ng0);
    t2 = (t0 + 6424);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB28;
    goto LAB1;

LAB25:    xsi_set_current_line(91, ng0);
    t10 = (t0 + 6408);
    *((int *)t10) = 1;
    t11 = (t0 + 5280);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB27;
    goto LAB1;

LAB27:    t2 = (t0 + 9164);
    t7 = *((int *)t2);
    *((int *)t2) = (t7 - 1);
    goto LAB24;

LAB28:    xsi_set_current_line(94, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(97, ng0);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 4168);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    xsi_set_current_line(98, ng0);
    t2 = (t0 + 6440);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB29;
    goto LAB1;

LAB29:    xsi_set_current_line(99, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = (~(t4));
    t6 = *((unsigned int *)t2);
    t7 = (t6 & t5);
    t8 = (t0 + 9168);
    *((int *)t8) = t7;

LAB30:    t9 = (t0 + 9168);
    if (*((int *)t9) > 0)
        goto LAB31;

LAB32:    xsi_set_current_line(100, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(101, ng0);
    t2 = (t0 + 6472);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB34;
    goto LAB1;

LAB31:    xsi_set_current_line(99, ng0);
    t10 = (t0 + 6456);
    *((int *)t10) = 1;
    t11 = (t0 + 5280);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB33;
    goto LAB1;

LAB33:    t2 = (t0 + 9168);
    t7 = *((int *)t2);
    *((int *)t2) = (t7 - 1);
    goto LAB30;

LAB34:    xsi_set_current_line(102, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(105, ng0);
    xsi_set_current_line(105, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4328);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB35:    t2 = (t0 + 4328);
    t3 = (t2 + 56U);
    t8 = *((char **)t3);
    t9 = ((char*)((ng8)));
    t10 = ((char*)((ng2)));
    memset(t12, 0, 8);
    xsi_vlog_signed_minus(t12, 32, t9, 32, t10, 32);
    memset(t29, 0, 8);
    xsi_vlog_signed_less(t29, 32, t8, 32, t12, 32);
    t11 = (t29 + 4);
    t4 = *((unsigned int *)t11);
    t5 = (~(t4));
    t6 = *((unsigned int *)t29);
    t13 = (t6 & t5);
    t14 = (t13 != 0);
    if (t14 > 0)
        goto LAB36;

LAB37:    xsi_set_current_line(114, ng0);
    t2 = ((char*)((ng10)));
    t3 = (t0 + 4168);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    xsi_set_current_line(115, ng0);
    t2 = (t0 + 6536);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB45;
    goto LAB1;

LAB36:    xsi_set_current_line(105, ng0);

LAB38:    xsi_set_current_line(106, ng0);
    t27 = ((char*)((ng9)));
    t28 = (t0 + 4168);
    xsi_vlogvar_assign_value(t28, t27, 0, 0, 8);
    xsi_set_current_line(107, ng0);
    t2 = (t0 + 6488);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB39;
    goto LAB1;

LAB39:    xsi_set_current_line(108, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = (~(t4));
    t6 = *((unsigned int *)t2);
    t7 = (t6 & t5);
    t8 = (t0 + 9172);
    *((int *)t8) = t7;

LAB40:    t9 = (t0 + 9172);
    if (*((int *)t9) > 0)
        goto LAB41;

LAB42:    xsi_set_current_line(109, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(110, ng0);
    t2 = (t0 + 6520);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB44;
    goto LAB1;

LAB41:    xsi_set_current_line(108, ng0);
    t10 = (t0 + 6504);
    *((int *)t10) = 1;
    t11 = (t0 + 5280);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB43;
    goto LAB1;

LAB43:    t2 = (t0 + 9172);
    t7 = *((int *)t2);
    *((int *)t2) = (t7 - 1);
    goto LAB40;

LAB44:    xsi_set_current_line(111, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(105, ng0);
    t2 = (t0 + 4328);
    t3 = (t2 + 56U);
    t8 = *((char **)t3);
    t9 = ((char*)((ng2)));
    memset(t12, 0, 8);
    xsi_vlog_signed_add(t12, 32, t8, 32, t9, 32);
    t10 = (t0 + 4328);
    xsi_vlogvar_assign_value(t10, t12, 0, 0, 32);
    goto LAB35;

LAB45:    xsi_set_current_line(116, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = (~(t4));
    t6 = *((unsigned int *)t2);
    t7 = (t6 & t5);
    t8 = (t0 + 9176);
    *((int *)t8) = t7;

LAB46:    t9 = (t0 + 9176);
    if (*((int *)t9) > 0)
        goto LAB47;

LAB48:    xsi_set_current_line(117, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(118, ng0);
    t2 = (t0 + 6568);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB50;
    goto LAB1;

LAB47:    xsi_set_current_line(116, ng0);
    t10 = (t0 + 6552);
    *((int *)t10) = 1;
    t11 = (t0 + 5280);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB49;
    goto LAB1;

LAB49:    t2 = (t0 + 9176);
    t7 = *((int *)t2);
    *((int *)t2) = (t7 - 1);
    goto LAB46;

LAB50:    xsi_set_current_line(119, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(121, ng0);
    t2 = ((char*)((ng11)));
    t3 = (t0 + 4168);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    xsi_set_current_line(122, ng0);
    t2 = (t0 + 6584);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB51;
    goto LAB1;

LAB51:    xsi_set_current_line(123, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = (~(t4));
    t6 = *((unsigned int *)t2);
    t7 = (t6 & t5);
    t8 = (t0 + 9180);
    *((int *)t8) = t7;

LAB52:    t9 = (t0 + 9180);
    if (*((int *)t9) > 0)
        goto LAB53;

LAB54:    xsi_set_current_line(124, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(125, ng0);
    t2 = (t0 + 6616);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB56;
    goto LAB1;

LAB53:    xsi_set_current_line(123, ng0);
    t10 = (t0 + 6600);
    *((int *)t10) = 1;
    t11 = (t0 + 5280);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB55;
    goto LAB1;

LAB55:    t2 = (t0 + 9180);
    t7 = *((int *)t2);
    *((int *)t2) = (t7 - 1);
    goto LAB52;

LAB56:    xsi_set_current_line(126, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(130, ng0);
    xsi_set_current_line(130, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4328);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);

LAB57:    t2 = (t0 + 4328);
    t3 = (t2 + 56U);
    t8 = *((char **)t3);
    t9 = ((char*)((ng8)));
    t10 = ((char*)((ng2)));
    memset(t12, 0, 8);
    xsi_vlog_signed_minus(t12, 32, t9, 32, t10, 32);
    memset(t29, 0, 8);
    xsi_vlog_signed_less(t29, 32, t8, 32, t12, 32);
    t11 = (t29 + 4);
    t4 = *((unsigned int *)t11);
    t5 = (~(t4));
    t6 = *((unsigned int *)t29);
    t13 = (t6 & t5);
    t14 = (t13 != 0);
    if (t14 > 0)
        goto LAB58;

LAB59:    xsi_set_current_line(139, ng0);
    t2 = ((char*)((ng10)));
    t3 = (t0 + 4168);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    xsi_set_current_line(140, ng0);
    t2 = (t0 + 6680);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB67;
    goto LAB1;

LAB58:    xsi_set_current_line(130, ng0);

LAB60:    xsi_set_current_line(131, ng0);
    t27 = ((char*)((ng12)));
    t28 = (t0 + 4168);
    xsi_vlogvar_assign_value(t28, t27, 0, 0, 8);
    xsi_set_current_line(132, ng0);
    t2 = (t0 + 6632);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB61;
    goto LAB1;

LAB61:    xsi_set_current_line(133, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = (~(t4));
    t6 = *((unsigned int *)t2);
    t7 = (t6 & t5);
    t8 = (t0 + 9184);
    *((int *)t8) = t7;

LAB62:    t9 = (t0 + 9184);
    if (*((int *)t9) > 0)
        goto LAB63;

LAB64:    xsi_set_current_line(134, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(135, ng0);
    t2 = (t0 + 6664);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB66;
    goto LAB1;

LAB63:    xsi_set_current_line(133, ng0);
    t10 = (t0 + 6648);
    *((int *)t10) = 1;
    t11 = (t0 + 5280);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB65;
    goto LAB1;

LAB65:    t2 = (t0 + 9184);
    t7 = *((int *)t2);
    *((int *)t2) = (t7 - 1);
    goto LAB62;

LAB66:    xsi_set_current_line(136, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(130, ng0);
    t2 = (t0 + 4328);
    t3 = (t2 + 56U);
    t8 = *((char **)t3);
    t9 = ((char*)((ng2)));
    memset(t12, 0, 8);
    xsi_vlog_signed_add(t12, 32, t8, 32, t9, 32);
    t10 = (t0 + 4328);
    xsi_vlogvar_assign_value(t10, t12, 0, 0, 32);
    goto LAB57;

LAB67:    xsi_set_current_line(141, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = (~(t4));
    t6 = *((unsigned int *)t2);
    t7 = (t6 & t5);
    t8 = (t0 + 9188);
    *((int *)t8) = t7;

LAB68:    t9 = (t0 + 9188);
    if (*((int *)t9) > 0)
        goto LAB69;

LAB70:    xsi_set_current_line(142, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(143, ng0);
    t2 = (t0 + 6712);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB72;
    goto LAB1;

LAB69:    xsi_set_current_line(141, ng0);
    t10 = (t0 + 6696);
    *((int *)t10) = 1;
    t11 = (t0 + 5280);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB71;
    goto LAB1;

LAB71:    t2 = (t0 + 9188);
    t7 = *((int *)t2);
    *((int *)t2) = (t7 - 1);
    goto LAB68;

LAB72:    xsi_set_current_line(144, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(147, ng0);
    t2 = ((char*)((ng13)));
    t3 = (t0 + 4168);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 8);
    xsi_set_current_line(148, ng0);
    t2 = (t0 + 6728);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB73;
    goto LAB1;

LAB73:    xsi_set_current_line(149, ng0);
    t2 = ((char*)((ng7)));
    t3 = (t2 + 4);
    t4 = *((unsigned int *)t3);
    t5 = (~(t4));
    t6 = *((unsigned int *)t2);
    t7 = (t6 & t5);
    t8 = (t0 + 9192);
    *((int *)t8) = t7;

LAB74:    t9 = (t0 + 9192);
    if (*((int *)t9) > 0)
        goto LAB75;

LAB76:    xsi_set_current_line(150, ng0);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(151, ng0);
    t2 = (t0 + 6760);
    *((int *)t2) = 1;
    t3 = (t0 + 5280);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB78;
    goto LAB1;

LAB75:    xsi_set_current_line(149, ng0);
    t10 = (t0 + 6744);
    *((int *)t10) = 1;
    t11 = (t0 + 5280);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB77;
    goto LAB1;

LAB77:    t2 = (t0 + 9192);
    t7 = *((int *)t2);
    *((int *)t2) = (t7 - 1);
    goto LAB74;

LAB78:    xsi_set_current_line(152, ng0);
    t2 = ((char*)((ng1)));
    t3 = (t0 + 4008);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    goto LAB1;

}

static void Always_156_1(char *t0)
{
    char t3[8];
    char *t1;
    char *t2;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    char *t13;
    char *t14;
    char *t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;

LAB0:    t1 = (t0 + 5496U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(156, ng0);
    t2 = (t0 + 5304);
    xsi_process_wait(t2, 5000LL);
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(156, ng0);
    t4 = (t0 + 3688);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memset(t3, 0, 8);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB8;

LAB6:    if (*((unsigned int *)t7) == 0)
        goto LAB5;

LAB7:    t13 = (t3 + 4);
    *((unsigned int *)t3) = 1;
    *((unsigned int *)t13) = 1;

LAB8:    t14 = (t3 + 4);
    t15 = (t6 + 4);
    t16 = *((unsigned int *)t6);
    t17 = (~(t16));
    *((unsigned int *)t3) = t17;
    *((unsigned int *)t14) = 0;
    if (*((unsigned int *)t15) != 0)
        goto LAB10;

LAB9:    t22 = *((unsigned int *)t3);
    *((unsigned int *)t3) = (t22 & 1U);
    t23 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t23 & 1U);
    t24 = (t0 + 3688);
    xsi_vlogvar_assign_value(t24, t3, 0, 0, 1);
    goto LAB2;

LAB5:    *((unsigned int *)t3) = 1;
    goto LAB8;

LAB10:    t18 = *((unsigned int *)t3);
    t19 = *((unsigned int *)t15);
    *((unsigned int *)t3) = (t18 | t19);
    t20 = *((unsigned int *)t14);
    t21 = *((unsigned int *)t15);
    *((unsigned int *)t14) = (t20 | t21);
    goto LAB9;

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

LAB0:    t1 = (t0 + 5744U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = ((char*)((ng3)));
    t3 = (t0 + 6840);
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

static void implSig2_execute(char *t0)
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

LAB0:    t1 = (t0 + 5992U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = ((char*)((ng14)));
    t3 = (t0 + 6904);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    memset(t7, 0, 8);
    t8 = 65535U;
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
    xsi_driver_vfirst_trans(t3, 0, 15);

LAB1:    return;
}


extern void work_m_00000000001347610695_1985558087_init()
{
	static char *pe[] = {(void *)Initial_72_0,(void *)Always_156_1,(void *)implSig1_execute,(void *)implSig2_execute};
	xsi_register_didat("work_m_00000000001347610695_1985558087", "isim/test_isim_beh.exe.sim/work/m_00000000001347610695_1985558087.didat");
	xsi_register_executes(pe);
}
