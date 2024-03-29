// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header

#ifndef _VAdderWrapper__Syms_H_
#define _VAdderWrapper__Syms_H_

#include "verilated.h"

// INCLUDE MODULE CLASSES
#include "VAdderWrapper.h"

// SYMS CLASS
class VAdderWrapper__Syms : public VerilatedSyms {
  public:
    
    // LOCAL STATE
    const char* __Vm_namep;
    bool __Vm_didInit;
    
    // SUBCELL STATE
    VAdderWrapper*                 TOPp;
    
    // CREATORS
    VAdderWrapper__Syms(VAdderWrapper* topp, const char* namep);
    ~VAdderWrapper__Syms() {}
    
    // METHODS
    inline const char* name() { return __Vm_namep; }
    
} VL_ATTR_ALIGNED(64);

#endif  // guard
