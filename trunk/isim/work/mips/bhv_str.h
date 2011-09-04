////////////////////////////////////////////////////////////////////////////////
//   ____  ____   
//  /   /\/   /  
// /___/  \  /   
// \   \   \/  
//  \   \        Copyright (c) 2003-2004 Xilinx, Inc.
//  /   /        All Right Reserved. 
// /---/   /\     
// \   \  /  \  
//  \___\/\___\
////////////////////////////////////////////////////////////////////////////////

#ifndef H_Work_mips_bhv_str_H
#define H_Work_mips_bhv_str_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_mips_bhv_str: public HSim__s6 {
public:

    HSim__s1 SE[7];

    HSim__s1 SA[50];
  char *t0;
    Work_mips_bhv_str(const char * name);
    ~Work_mips_bhv_str();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_mips_bhv_str(const char *name);

#endif
