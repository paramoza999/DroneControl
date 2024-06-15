#ifndef __c14_trajectory_jerk_h__
#define __c14_trajectory_jerk_h__
#include "stdio.h"
#include "string.h"
#include "stdlib.h"

/* Forward Declarations */
struct SFc14_trajectory_jerkInstanceStruct;

/* Type Definitions */
#ifndef c14_typedef_c14_trajectory_jerkStackData
#define c14_typedef_c14_trajectory_jerkStackData

typedef struct {
} c14_trajectory_jerkStackData;

#endif                                 /* c14_typedef_c14_trajectory_jerkStackData */

#ifndef struct_SFc14_trajectory_jerkInstanceStruct
#define struct_SFc14_trajectory_jerkInstanceStruct

struct SFc14_trajectory_jerkInstanceStruct
{
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint8_T c14_JITStateAnimation[1];
  uint8_T c14_JITTransitionAnimation[1];
  void *c14_fEmlrtCtx;
  real_T (*c14_R_BI)[9];
  real_T (*c14_attitude)[3];
};

#endif                                 /* struct_SFc14_trajectory_jerkInstanceStruct */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c14_trajectory_jerk_get_eml_resolved_functions_info();

/* Function Definitions */
extern void sf_c14_trajectory_jerk_get_check_sum(mxArray *plhs[]);
extern void c14_trajectory_jerk_method_dispatcher(SimStruct *S, int_T method,
  void *data);

#endif
