#ifndef __c3_trajectory_jerk_h__
#define __c3_trajectory_jerk_h__
#include "stdio.h"
#include "string.h"
#include "stdlib.h"

/* Forward Declarations */
struct SFc3_trajectory_jerkInstanceStruct;

/* Type Definitions */
#ifndef c3_typedef_c3_trajectory_jerkStackData
#define c3_typedef_c3_trajectory_jerkStackData

typedef struct {
} c3_trajectory_jerkStackData;

#endif                                 /* c3_typedef_c3_trajectory_jerkStackData */

#ifndef struct_SFc3_trajectory_jerkInstanceStruct
#define struct_SFc3_trajectory_jerkInstanceStruct

struct SFc3_trajectory_jerkInstanceStruct
{
  SimStruct *S;
  ChartInfoStruct chartInfo;
  uint8_T c3_JITStateAnimation[1];
  uint8_T c3_JITTransitionAnimation[1];
  void *c3_fEmlrtCtx;
  real_T *c3_xdd_des;
  real_T *c3_phi_des;
  real_T *c3_ydd_des;
  real_T *c3_psi;
  real_T *c3_theta_des;
};

#endif                                 /* struct_SFc3_trajectory_jerkInstanceStruct */

/* Named Constants */

/* Variable Declarations */

/* Variable Definitions */

/* Function Declarations */
extern const mxArray *sf_c3_trajectory_jerk_get_eml_resolved_functions_info();

/* Function Definitions */
extern void sf_c3_trajectory_jerk_get_check_sum(mxArray *plhs[]);
extern void c3_trajectory_jerk_method_dispatcher(SimStruct *S, int_T method,
  void *data);

#endif
