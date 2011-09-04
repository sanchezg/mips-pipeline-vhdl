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

#ifndef H_Work_reg_file_arch_H
#define H_Work_reg_file_arch_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_reg_file_arch: public HSim__s6 {
public:

    HSim__s1 SE[9];

  HSimArrayType Reg_file_typebase;
  HSimArrayType Reg_file_type;
    HSim__s1 SA[1];
  int t16;
  char *t17;
    Work_reg_file_arch(const char * name);
    ~Work_reg_file_arch();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_reg_file_arch(const char *name);

#endif
