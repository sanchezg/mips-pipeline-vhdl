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

#ifndef H_Work_full_adder_full_adder_arq_H
#define H_Work_full_adder_full_adder_arq_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_full_adder_full_adder_arq: public HSim__s6 {
public:

    HSim__s1 SE[5];

    HSim__s1 SA[2];
  char t0;
  char t1;
    Work_full_adder_full_adder_arq(const char * name);
    ~Work_full_adder_full_adder_arq();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_full_adder_full_adder_arq(const char *name);

#endif
