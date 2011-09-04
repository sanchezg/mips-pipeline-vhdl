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

#ifndef H_Work_execution_behavioral_H
#define H_Work_execution_behavioral_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_execution_behavioral: public HSim__s6 {
public:

    HSim__s1 SE[16];

    HSim__s1 SA[3];
HSimConstraints *c87;
HSimConstraints *c88;
HSimConstraints *c89;
  char *t90;
  char *t91;
    Work_execution_behavioral(const char * name);
    ~Work_execution_behavioral();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_execution_behavioral(const char *name);

#endif
