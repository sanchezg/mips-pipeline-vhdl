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

#ifndef H_Work_instruction_decode_behavioral_H
#define H_Work_instruction_decode_behavioral_H
#ifdef __MINGW32__
#include "xsimMinGW.h"
#else
#include "xsim.h"
#endif


class Work_instruction_decode_behavioral: public HSim__s6 {
public:

    HSim__s1 SE[21];

    HSim__s1 SA[3];
  char *t14;
  char *t15;
HSimConstraints *c16;
HSimConstraints *c17;
HSimConstraints *c18;
HSimConstraints *c19;
HSimConstraints *c20;
HSimConstraints *c21;
    Work_instruction_decode_behavioral(const char * name);
    ~Work_instruction_decode_behavioral();
    void constructObject();
    void constructPorts();
    void reset();
    void architectureInstantiate(HSimConfigDecl* cfg);
    virtual void vhdlArchImplement();
};



HSim__s6 *createWork_instruction_decode_behavioral(const char *name);

#endif
