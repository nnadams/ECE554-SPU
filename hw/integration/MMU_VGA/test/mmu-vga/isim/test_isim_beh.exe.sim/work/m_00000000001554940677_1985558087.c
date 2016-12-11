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
static const char *ng0 = "@%d,\tspu_addr=%x,\tread-data=%x";
static const char *ng1 = "//userspace.cae.wisc.edu/people/b/barry-lenoch/Documents/School/Classes/5th_year/Fall_2016/ece554/project/ECE554-SPU/hw/integration/MMU_VGA/test/mmu_vga_test-top-level.v";
static unsigned int ng2[] = {0U, 0U};
static unsigned int ng3[] = {1U, 0U};
static unsigned int ng4[] = {8388608U, 0U};
static unsigned int ng5[] = {8388732U, 0U};
static unsigned int ng6[] = {15U, 0U};
static const char *ng7 = "test cpu instr read";
static int ng8[] = {32, 0};
static int ng9[] = {4, 0};
static const char *ng10 = "test cpu memory write";
static const char *ng11 = "test spu memory read and cpu write results";
static int ng12[] = {16, 0};
static const char *ng13 = "test memory mapped spart read and write";
static unsigned int ng14[] = {10485760U, 0U};
static const char *ng15 = "test spu result write and VGA read";
static int ng16[] = {1, 0};
static const char *ng17 = "test cpu read spu registers";
static unsigned int ng18[] = {11534336U, 0U};

void Monitor_176_3(char *);
void Monitor_176_3(char *);


static void Monitor_176_3_Func(char *t0)
{
    char t1[16];
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    t2 = xsi_vlog_time(t1, 1000.0000000000000, 1000.0000000000000);
    t3 = (t0 + 6568);
    t4 = (t3 + 56U);
    t5 = *((char **)t4);
    t6 = (t0 + 3448U);
    t7 = *((char **)t6);
    xsi_vlogfile_write(1, 0, 3, ng0, 4, t0, (char)118, t1, 64, (char)118, t5, 32, (char)118, t7, 128);

LAB1:    return;
}

static void Initial_94_0(char *t0)
{
    char t4[8];
    char *t1;
    char *t2;
    char *t3;
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

LAB0:    t1 = (t0 + 8288U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(94, ng1);

LAB4:    xsi_set_current_line(95, ng1);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 5288);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(96, ng1);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 7208);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(97, ng1);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 7368);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(98, ng1);

LAB5:    xsi_set_current_line(98, ng1);
    t2 = (t0 + 8096);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB6;

LAB1:    return;
LAB6:    xsi_set_current_line(98, ng1);
    t3 = (t0 + 5288);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    memset(t4, 0, 8);
    t7 = (t6 + 4);
    t8 = *((unsigned int *)t7);
    t9 = (~(t8));
    t10 = *((unsigned int *)t6);
    t11 = (t10 & t9);
    t12 = (t11 & 1U);
    if (t12 != 0)
        goto LAB10;

LAB8:    if (*((unsigned int *)t7) == 0)
        goto LAB7;

LAB9:    t13 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t13) = 1;

LAB10:    t14 = (t4 + 4);
    t15 = (t6 + 4);
    t16 = *((unsigned int *)t6);
    t17 = (~(t16));
    *((unsigned int *)t4) = t17;
    *((unsigned int *)t14) = 0;
    if (*((unsigned int *)t15) != 0)
        goto LAB12;

LAB11:    t22 = *((unsigned int *)t4);
    *((unsigned int *)t4) = (t22 & 1U);
    t23 = *((unsigned int *)t14);
    *((unsigned int *)t14) = (t23 & 1U);
    t24 = (t0 + 5288);
    xsi_vlogvar_assign_value(t24, t4, 0, 0, 1);
    goto LAB5;

LAB7:    *((unsigned int *)t4) = 1;
    goto LAB10;

LAB12:    t18 = *((unsigned int *)t4);
    t19 = *((unsigned int *)t15);
    *((unsigned int *)t4) = (t18 | t19);
    t20 = *((unsigned int *)t14);
    t21 = *((unsigned int *)t15);
    *((unsigned int *)t14) = (t20 | t21);
    goto LAB11;

LAB13:    goto LAB1;

}

static void Initial_101_1(char *t0)
{
    char t16[8];
    char t20[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    unsigned int t5;
    unsigned int t6;
    unsigned int t7;
    int t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t17;
    char *t18;
    char *t19;
    char *t21;

LAB0:    t1 = (t0 + 8536U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(101, ng1);

LAB4:    xsi_set_current_line(102, ng1);
    t2 = (t0 + 8344);
    xsi_process_wait(t2, 0LL);
    *((char **)t1) = &&LAB5;

LAB1:    return;
LAB5:    xsi_set_current_line(102, ng1);
    t3 = ((char*)((ng4)));
    t4 = (t0 + 6568);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 32);
    xsi_set_current_line(103, ng1);
    t2 = ((char*)((ng5)));
    t3 = (t0 + 6248);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(104, ng1);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 5928);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(105, ng1);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 5448);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(106, ng1);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 5608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(107, ng1);
    t2 = ((char*)((ng6)));
    t3 = (t0 + 5768);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 4);
    xsi_set_current_line(108, ng1);
    t2 = (t0 + 8344);
    xsi_process_wait(t2, 10000LL);
    *((char **)t1) = &&LAB6;
    goto LAB1;

LAB6:    xsi_set_current_line(108, ng1);
    t3 = ((char*)((ng2)));
    t4 = (t0 + 5448);
    xsi_vlogvar_assign_value(t4, t3, 0, 0, 1);
    xsi_set_current_line(110, ng1);
    xsi_vlogfile_write(1, 0, 0, ng7, 1, t0);
    xsi_set_current_line(111, ng1);
    t2 = ((char*)((ng8)));
    t3 = (t2 + 4);
    t5 = *((unsigned int *)t3);
    t6 = (~(t5));
    t7 = *((unsigned int *)t2);
    t8 = (t7 & t6);
    t4 = (t0 + 12992);
    *((int *)t4) = t8;

LAB7:    t9 = (t0 + 12992);
    if (*((int *)t9) > 0)
        goto LAB8;

LAB9:    xsi_set_current_line(116, ng1);
    xsi_vlogfile_write(1, 0, 0, ng10, 1, t0);
    xsi_set_current_line(117, ng1);
    t2 = ((char*)((ng8)));
    t3 = (t2 + 4);
    t5 = *((unsigned int *)t3);
    t6 = (~(t5));
    t7 = *((unsigned int *)t2);
    t8 = (t7 & t6);
    t4 = (t0 + 12996);
    *((int *)t4) = t8;

LAB12:    t9 = (t0 + 12996);
    if (*((int *)t9) > 0)
        goto LAB13;

LAB14:    xsi_set_current_line(124, ng1);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 5608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(126, ng1);
    xsi_vlogfile_write(1, 0, 0, ng11, 1, t0);
    xsi_set_current_line(127, ng1);
    t2 = ((char*)((ng12)));
    t3 = (t2 + 4);
    t5 = *((unsigned int *)t3);
    t6 = (~(t5));
    t7 = *((unsigned int *)t2);
    t8 = (t7 & t6);
    t4 = (t0 + 13000);
    *((int *)t4) = t8;

LAB17:    t9 = (t0 + 13000);
    if (*((int *)t9) > 0)
        goto LAB18;

LAB19:    xsi_set_current_line(133, ng1);
    xsi_vlogfile_write(1, 0, 0, ng13, 1, t0);
    xsi_set_current_line(134, ng1);
    t2 = (t0 + 9648);
    *((int *)t2) = 1;
    t3 = (t0 + 8568);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB22;
    goto LAB1;

LAB8:    xsi_set_current_line(111, ng1);

LAB10:    xsi_set_current_line(112, ng1);
    t10 = (t0 + 9600);
    *((int *)t10) = 1;
    t11 = (t0 + 8568);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB11;
    goto LAB1;

LAB11:    xsi_set_current_line(113, ng1);
    t12 = (t0 + 5928);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = ((char*)((ng9)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_add(t16, 32, t14, 32, t15, 32);
    t17 = (t0 + 5928);
    xsi_vlogvar_assign_value(t17, t16, 0, 0, 32);
    t2 = (t0 + 12992);
    t8 = *((int *)t2);
    *((int *)t2) = (t8 - 1);
    goto LAB7;

LAB13:    xsi_set_current_line(117, ng1);

LAB15:    xsi_set_current_line(118, ng1);
    t10 = (t0 + 9616);
    *((int *)t10) = 1;
    t11 = (t0 + 8568);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB16;
    goto LAB1;

LAB16:    xsi_set_current_line(119, ng1);
    t12 = (t0 + 6248);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = ((char*)((ng9)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_multiply(t16, 32, t14, 32, t15, 32);
    t17 = (t0 + 6248);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    memset(t20, 0, 8);
    xsi_vlog_unsigned_add(t20, 32, t16, 32, t19, 32);
    t21 = (t0 + 6088);
    xsi_vlogvar_assign_value(t21, t20, 0, 0, 32);
    xsi_set_current_line(120, ng1);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 5608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(122, ng1);
    t2 = (t0 + 6248);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t9 = ((char*)((ng9)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_add(t16, 32, t4, 32, t9, 32);
    t10 = (t0 + 6248);
    xsi_vlogvar_assign_value(t10, t16, 0, 0, 32);
    t2 = (t0 + 12996);
    t8 = *((int *)t2);
    *((int *)t2) = (t8 - 1);
    goto LAB12;

LAB18:    xsi_set_current_line(127, ng1);

LAB20:    xsi_set_current_line(128, ng1);
    t10 = (t0 + 9632);
    *((int *)t10) = 1;
    t11 = (t0 + 8568);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB21;
    goto LAB1;

LAB21:    xsi_set_current_line(129, ng1);
    t12 = (t0 + 6568);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = ((char*)((ng9)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_add(t16, 32, t14, 32, t15, 32);
    t17 = (t0 + 6568);
    xsi_vlogvar_assign_value(t17, t16, 0, 0, 32);
    t2 = (t0 + 13000);
    t8 = *((int *)t2);
    *((int *)t2) = (t8 - 1);
    goto LAB17;

LAB22:    xsi_set_current_line(135, ng1);
    t4 = ((char*)((ng14)));
    t9 = (t0 + 6248);
    xsi_vlogvar_assign_value(t9, t4, 0, 0, 32);
    xsi_set_current_line(136, ng1);
    t2 = ((char*)((ng3)));
    t3 = (t0 + 5608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(139, ng1);
    t2 = (t0 + 9664);
    *((int *)t2) = 1;
    t3 = (t0 + 8568);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB23;
    goto LAB1;

LAB23:    xsi_set_current_line(141, ng1);
    t4 = (t0 + 6248);
    t9 = (t4 + 56U);
    t10 = *((char **)t9);
    t11 = ((char*)((ng9)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_add(t16, 32, t10, 32, t11, 32);
    t12 = (t0 + 6248);
    xsi_vlogvar_assign_value(t12, t16, 0, 0, 32);
    xsi_set_current_line(142, ng1);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 5608);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 1);
    xsi_set_current_line(144, ng1);
    t2 = (t0 + 9680);
    *((int *)t2) = 1;
    t3 = (t0 + 8568);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB24;
    goto LAB1;

LAB24:    xsi_set_current_line(145, ng1);
    t4 = (t0 + 6248);
    t9 = (t4 + 56U);
    t10 = *((char **)t9);
    t11 = ((char*)((ng9)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_add(t16, 32, t10, 32, t11, 32);
    t12 = (t0 + 6248);
    xsi_vlogvar_assign_value(t12, t16, 0, 0, 32);
    xsi_set_current_line(147, ng1);
    t2 = (t0 + 9696);
    *((int *)t2) = 1;
    t3 = (t0 + 8568);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB25;
    goto LAB1;

LAB25:    xsi_set_current_line(148, ng1);
    t4 = (t0 + 6248);
    t9 = (t4 + 56U);
    t10 = *((char **)t9);
    t11 = ((char*)((ng9)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_add(t16, 32, t10, 32, t11, 32);
    t12 = (t0 + 6248);
    xsi_vlogvar_assign_value(t12, t16, 0, 0, 32);
    xsi_set_current_line(150, ng1);
    t2 = (t0 + 9712);
    *((int *)t2) = 1;
    t3 = (t0 + 8568);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB26;
    goto LAB1;

LAB26:    xsi_set_current_line(153, ng1);
    xsi_vlogfile_write(1, 0, 0, ng15, 1, t0);
    xsi_set_current_line(154, ng1);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 6888);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 4);
    xsi_set_current_line(155, ng1);
    t2 = ((char*)((ng2)));
    t3 = (t0 + 6728);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(156, ng1);
    t2 = (t0 + 9728);
    *((int *)t2) = 1;
    t3 = (t0 + 8568);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB27;
    goto LAB1;

LAB27:    xsi_set_current_line(157, ng1);
    t4 = ((char*)((ng8)));
    t9 = (t4 + 4);
    t5 = *((unsigned int *)t9);
    t6 = (~(t5));
    t7 = *((unsigned int *)t4);
    t8 = (t7 & t6);
    t10 = (t0 + 13004);
    *((int *)t10) = t8;

LAB28:    t11 = (t0 + 13004);
    if (*((int *)t11) > 0)
        goto LAB29;

LAB30:    xsi_set_current_line(163, ng1);
    xsi_vlogfile_write(1, 0, 0, ng17, 1, t0);
    xsi_set_current_line(164, ng1);
    t2 = ((char*)((ng18)));
    t3 = (t0 + 6248);
    xsi_vlogvar_assign_value(t3, t2, 0, 0, 32);
    xsi_set_current_line(165, ng1);
    t2 = ((char*)((ng12)));
    t3 = (t2 + 4);
    t5 = *((unsigned int *)t3);
    t6 = (~(t5));
    t7 = *((unsigned int *)t2);
    t8 = (t7 & t6);
    t4 = (t0 + 13008);
    *((int *)t4) = t8;

LAB33:    t9 = (t0 + 13008);
    if (*((int *)t9) > 0)
        goto LAB34;

LAB35:    xsi_set_current_line(169, ng1);
    xsi_vlog_finish(1);
    goto LAB1;

LAB29:    xsi_set_current_line(157, ng1);

LAB31:    xsi_set_current_line(158, ng1);
    t12 = (t0 + 9744);
    *((int *)t12) = 1;
    t13 = (t0 + 8568);
    *((char **)t13) = t12;
    *((char **)t1) = &&LAB32;
    goto LAB1;

LAB32:    xsi_set_current_line(159, ng1);
    t14 = (t0 + 6888);
    t15 = (t14 + 56U);
    t17 = *((char **)t15);
    t18 = ((char*)((ng16)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_add(t16, 32, t17, 4, t18, 32);
    t19 = (t0 + 6888);
    xsi_vlogvar_assign_value(t19, t16, 0, 0, 4);
    xsi_set_current_line(160, ng1);
    t2 = (t0 + 6888);
    t3 = (t2 + 56U);
    t4 = *((char **)t3);
    t9 = (t0 + 6728);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    t12 = ((char*)((ng9)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_multiply(t16, 32, t11, 32, t12, 32);
    memset(t20, 0, 8);
    xsi_vlog_unsigned_add(t20, 32, t4, 4, t16, 32);
    t13 = (t0 + 6728);
    xsi_vlogvar_assign_value(t13, t20, 0, 0, 32);
    t2 = (t0 + 13004);
    t8 = *((int *)t2);
    *((int *)t2) = (t8 - 1);
    goto LAB28;

LAB34:    xsi_set_current_line(165, ng1);

LAB36:    xsi_set_current_line(166, ng1);
    t10 = (t0 + 9760);
    *((int *)t10) = 1;
    t11 = (t0 + 8568);
    *((char **)t11) = t10;
    *((char **)t1) = &&LAB37;
    goto LAB1;

LAB37:    xsi_set_current_line(167, ng1);
    t12 = (t0 + 6248);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    t15 = ((char*)((ng9)));
    memset(t16, 0, 8);
    xsi_vlog_unsigned_add(t16, 32, t14, 32, t15, 32);
    t17 = (t0 + 6248);
    xsi_vlogvar_assign_value(t17, t16, 0, 0, 32);
    t2 = (t0 + 13008);
    t8 = *((int *)t2);
    *((int *)t2) = (t8 - 1);
    goto LAB33;

}

static void Initial_173_2(char *t0)
{

LAB0:    xsi_set_current_line(173, ng1);

LAB2:    xsi_set_current_line(176, ng1);
    Monitor_176_3(t0);

LAB1:    return;
}

void Monitor_176_3(char *t0)
{
    char *t1;
    char *t2;

LAB0:    t1 = (t0 + 8840);
    t2 = (t0 + 9776);
    xsi_vlogfile_monitor((void *)Monitor_176_3_Func, t1, t2);

LAB1:    return;
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

LAB0:    t1 = (t0 + 9280U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    t2 = ((char*)((ng2)));
    t3 = (t0 + 9856);
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


extern void work_m_00000000001554940677_1985558087_init()
{
	static char *pe[] = {(void *)Initial_94_0,(void *)Initial_101_1,(void *)Initial_173_2,(void *)Monitor_176_3,(void *)implSig1_execute};
	xsi_register_didat("work_m_00000000001554940677_1985558087", "isim/test_isim_beh.exe.sim/work/m_00000000001554940677_1985558087.didat");
	xsi_register_executes(pe);
}
