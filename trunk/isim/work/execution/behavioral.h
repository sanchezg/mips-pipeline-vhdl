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

    HSim__s1 SE[25];

    HSim__s1 SA[7];
HSimConstraints *c76;
HSimConstraints *c77;
HSimConstraints *c78;
  char *t79;
  char *t80;
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
