/* Include files */

#include "trajectory_jerk_sfun.h"
#include "c14_trajectory_jerk.h"
#include "mwmathutil.h"
#ifdef utFree
#undef utFree
#endif

#ifdef utMalloc
#undef utMalloc
#endif

#ifdef __cplusplus

extern "C" void *utMalloc(size_t size);
extern "C" void utFree(void*);

#else

extern void *utMalloc(size_t size);
extern void utFree(void*);

#endif

#include "stdio.h"
#include "string.h"
#include "stdlib.h"

/* Forward Declarations */

/* Type Definitions */

/* Named Constants */
const int32_T CALL_EVENT = -1;

/* Variable Declarations */

/* Variable Definitions */
static real_T _sfTime_;

/* Function Declarations */
static void c14_c14_trajectory_jerk(SFc14_trajectory_jerkInstanceStruct
  *chartInstance, const real_T c14_b_attitude[3], real_T c14_b_R_BI[9]);
static void initialize_c14_trajectory_jerk(SFc14_trajectory_jerkInstanceStruct
  *chartInstance);
static void initialize_params_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance);
static void mdl_start_c14_trajectory_jerk(SFc14_trajectory_jerkInstanceStruct
  *chartInstance);
static void mdl_terminate_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance);
static void mdl_setup_runtime_resources_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance);
static void mdl_cleanup_runtime_resources_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance);
static void enable_c14_trajectory_jerk(SFc14_trajectory_jerkInstanceStruct
  *chartInstance);
static void disable_c14_trajectory_jerk(SFc14_trajectory_jerkInstanceStruct
  *chartInstance);
static void sf_gateway_c14_trajectory_jerk(SFc14_trajectory_jerkInstanceStruct
  *chartInstance);
static void ext_mode_exec_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance);
static const mxArray *get_sim_state_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance);
static void set_sim_state_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance, const mxArray *c14_st);
static void c14_emlrt_marshallIn(SFc14_trajectory_jerkInstanceStruct
  *chartInstance, const mxArray *c14_nullptr, const char_T *c14_identifier,
  real_T c14_y[9]);
static void c14_b_emlrt_marshallIn(SFc14_trajectory_jerkInstanceStruct
  *chartInstance, const mxArray *c14_u, const emlrtMsgIdentifier *c14_parentId,
  real_T c14_y[9]);
static void c14_raiseCudaError(SFc14_trajectory_jerkInstanceStruct
  *chartInstance, int32_T c14_errCode, const char_T *c14_file, uint32_T c14_line,
  const char_T *c14_errorName, const char_T *c14_errorString);
static void c14_checkCudaError(SFc14_trajectory_jerkInstanceStruct
  *chartInstance, cudaError_t c14_errCode, const char_T *c14_file, uint32_T
  c14_line);
static void init_dsm_address_info(SFc14_trajectory_jerkInstanceStruct
  *chartInstance);
static void init_simulink_io_address(SFc14_trajectory_jerkInstanceStruct
  *chartInstance);

/* Function Definitions */
static void c14_c14_trajectory_jerk(SFc14_trajectory_jerkInstanceStruct
  *chartInstance, const real_T c14_b_attitude[3], real_T c14_b_R_BI[9])
{
  c14_b_R_BI[0] = muDoubleScalarCos(c14_b_attitude[1]) * muDoubleScalarCos
    (c14_b_attitude[2]);
  c14_b_R_BI[3] = muDoubleScalarCos(c14_b_attitude[1]) * muDoubleScalarSin
    (c14_b_attitude[2]);
  c14_b_R_BI[6] = -muDoubleScalarSin(c14_b_attitude[1]);
  c14_b_R_BI[1] = -muDoubleScalarCos(c14_b_attitude[0]) * muDoubleScalarSin
    (c14_b_attitude[2]) + muDoubleScalarSin(c14_b_attitude[0]) *
    muDoubleScalarSin(c14_b_attitude[1]) * muDoubleScalarCos(c14_b_attitude[2]);
  c14_b_R_BI[4] = muDoubleScalarCos(c14_b_attitude[0]) * muDoubleScalarCos
    (c14_b_attitude[2]) + muDoubleScalarSin(c14_b_attitude[0]) *
    muDoubleScalarSin(c14_b_attitude[1]) * muDoubleScalarSin(c14_b_attitude[2]);
  c14_b_R_BI[7] = muDoubleScalarSin(c14_b_attitude[0]) * muDoubleScalarCos
    (c14_b_attitude[1]);
  c14_b_R_BI[2] = muDoubleScalarSin(c14_b_attitude[0]) * muDoubleScalarSin
    (c14_b_attitude[2]) + muDoubleScalarCos(c14_b_attitude[0]) *
    muDoubleScalarSin(c14_b_attitude[1]) * muDoubleScalarCos(c14_b_attitude[2]);
  c14_b_R_BI[5] = -muDoubleScalarSin(c14_b_attitude[0]) * muDoubleScalarCos
    (c14_b_attitude[2]) + muDoubleScalarCos(c14_b_attitude[0]) *
    muDoubleScalarSin(c14_b_attitude[1]) * muDoubleScalarSin(c14_b_attitude[2]);
  c14_b_R_BI[8] = muDoubleScalarCos(c14_b_attitude[0]) * muDoubleScalarCos
    (c14_b_attitude[1]);
}

static void initialize_c14_trajectory_jerk(SFc14_trajectory_jerkInstanceStruct
  *chartInstance)
{
  emlrtInitGPU(chartInstance->c14_fEmlrtCtx);
  cudaGetLastError();
  emlrtLicenseCheckR2022a(chartInstance->c14_fEmlrtCtx,
    "EMLRT:runTime:MexFunctionNeedsLicense", "distrib_computing_toolbox", 2);
  sim_mode_is_external(chartInstance->S);
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void initialize_params_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance)
{
}

static void mdl_start_c14_trajectory_jerk(SFc14_trajectory_jerkInstanceStruct
  *chartInstance)
{
  sim_mode_is_external(chartInstance->S);
}

static void mdl_terminate_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance)
{
  cudaError_t c14_errCode;
  c14_errCode = cudaGetLastError();
  if (c14_errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(c14_errCode), (char_T *)
                       cudaGetErrorName(c14_errCode), (char_T *)
                       cudaGetErrorString(c14_errCode), (char_T *)
                       "SimGPUErrorChecks", chartInstance->c14_fEmlrtCtx);
  }
}

static void mdl_setup_runtime_resources_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance)
{
  sfSetAnimationVectors(chartInstance->S, &chartInstance->c14_JITStateAnimation
                        [0], &chartInstance->c14_JITTransitionAnimation[0]);
}

static void mdl_cleanup_runtime_resources_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance)
{
}

static void enable_c14_trajectory_jerk(SFc14_trajectory_jerkInstanceStruct
  *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c14_trajectory_jerk(SFc14_trajectory_jerkInstanceStruct
  *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void sf_gateway_c14_trajectory_jerk(SFc14_trajectory_jerkInstanceStruct
  *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c14_JITTransitionAnimation[0] = 0U;
  c14_c14_trajectory_jerk(chartInstance, *chartInstance->c14_attitude,
    *chartInstance->c14_R_BI);
}

static void ext_mode_exec_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance)
{
}

static const mxArray *get_sim_state_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance)
{
  const mxArray *c14_b_y = NULL;
  const mxArray *c14_st = NULL;
  const mxArray *c14_y = NULL;
  c14_st = NULL;
  c14_y = NULL;
  sf_mex_assign(&c14_y, sf_mex_createcellmatrix(1, 1), false);
  c14_b_y = NULL;
  sf_mex_assign(&c14_b_y, sf_mex_create("y", *chartInstance->c14_R_BI, 0, 0U, 1,
    0U, 2, 3, 3), false);
  sf_mex_setcell(c14_y, 0, c14_b_y);
  sf_mex_assign(&c14_st, c14_y, false);
  return c14_st;
}

static void set_sim_state_c14_trajectory_jerk
  (SFc14_trajectory_jerkInstanceStruct *chartInstance, const mxArray *c14_st)
{
  const mxArray *c14_u;
  real_T c14_dv[9];
  int32_T c14_i;
  c14_u = sf_mex_dup(c14_st);
  c14_emlrt_marshallIn(chartInstance, sf_mex_dup(sf_mex_getcell(c14_u, 0)),
                       "R_BI", c14_dv);
  for (c14_i = 0; c14_i < 9; c14_i++) {
    (*chartInstance->c14_R_BI)[c14_i] = c14_dv[c14_i];
  }

  sf_mex_destroy(&c14_u);
  sf_mex_destroy(&c14_st);
}

const mxArray *sf_c14_trajectory_jerk_get_eml_resolved_functions_info()
{
  const mxArray *c14_nameCaptureInfo = NULL;
  c14_nameCaptureInfo = NULL;
  sf_mex_assign(&c14_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1, 0U, 2, 0, 1), false);
  return c14_nameCaptureInfo;
}

static void c14_emlrt_marshallIn(SFc14_trajectory_jerkInstanceStruct
  *chartInstance, const mxArray *c14_nullptr, const char_T *c14_identifier,
  real_T c14_y[9])
{
  emlrtMsgIdentifier c14_thisId;
  c14_thisId.fIdentifier = const_cast<const char_T *>(c14_identifier);
  c14_thisId.fParent = NULL;
  c14_thisId.bParentIsCell = false;
  c14_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c14_nullptr), &c14_thisId,
    c14_y);
  sf_mex_destroy(&c14_nullptr);
}

static void c14_b_emlrt_marshallIn(SFc14_trajectory_jerkInstanceStruct
  *chartInstance, const mxArray *c14_u, const emlrtMsgIdentifier *c14_parentId,
  real_T c14_y[9])
{
  real_T c14_dv[9];
  int32_T c14_i;
  sf_mex_import(c14_parentId, sf_mex_dup(c14_u), c14_dv, 1, 0, 0U, 1, 0U, 2, 3,
                3);
  for (c14_i = 0; c14_i < 9; c14_i++) {
    c14_y[c14_i] = c14_dv[c14_i];
  }

  sf_mex_destroy(&c14_u);
}

static void c14_raiseCudaError(SFc14_trajectory_jerkInstanceStruct
  *chartInstance, int32_T c14_errCode, const char_T *c14_file, uint32_T c14_line,
  const char_T *c14_errorName, const char_T *c14_errorString)
{
  emlrtRTEInfo c14_rtInfo;
  uint64_T c14_len;
  char_T *c14_brk;
  char_T *c14_fn;
  char_T *c14_pn;
  c14_len = strlen(c14_file);
  c14_pn = static_cast<char_T *>(calloc(c14_len + 1ULL, 1ULL));
  c14_fn = static_cast<char_T *>(calloc(c14_len + 1ULL, 1ULL));
  memcpy(c14_pn, c14_file, c14_len);
  memcpy(c14_fn, c14_file, c14_len);
  c14_brk = strrchr(c14_fn, '.');
  *c14_brk = '\x00';
  c14_brk = NULL;
  c14_brk = strrchr(c14_fn, '/');
  if (c14_brk == NULL) {
    c14_brk = strrchr(c14_fn, '\\');
  }

  if (c14_brk == NULL) {
    c14_brk = c14_fn;
  } else {
    c14_brk++;
  }

  c14_rtInfo.lineNo = c14_line;
  c14_rtInfo.colNo = 0;
  c14_rtInfo.fName = c14_brk;
  c14_rtInfo.pName = c14_pn;
  emlrtCUDAError(static_cast<uint32_T>(c14_errCode), (char_T *)c14_errorName,
                 (char_T *)c14_errorString, &c14_rtInfo,
                 chartInstance->c14_fEmlrtCtx);
}

static void c14_checkCudaError(SFc14_trajectory_jerkInstanceStruct
  *chartInstance, cudaError_t c14_errCode, const char_T *c14_file, uint32_T
  c14_line)
{
  if (c14_errCode != cudaSuccess) {
    c14_raiseCudaError(chartInstance, c14_errCode, c14_file, c14_line,
                       cudaGetErrorName(c14_errCode), cudaGetErrorString
                       (c14_errCode));
  }
}

static void init_dsm_address_info(SFc14_trajectory_jerkInstanceStruct
  *chartInstance)
{
}

static void init_simulink_io_address(SFc14_trajectory_jerkInstanceStruct
  *chartInstance)
{
  chartInstance->c14_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c14_R_BI = (real_T (*)[9])ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c14_attitude = (real_T (*)[3])ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SFunction Glue Code */
void sf_c14_trajectory_jerk_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(17653799U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(2306842680U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(2894203725U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(3773306147U);
}

mxArray *sf_c14_trajectory_jerk_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c14_trajectory_jerk_jit_fallback_info(void)
{
  const char *infoFields[] = { "fallbackType", "fallbackReason",
    "hiddenFallbackType", "hiddenFallbackReason", "incompatibleSymbol" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 5, infoFields);
  mxArray *fallbackType = mxCreateString("pre");
  mxArray *fallbackReason = mxCreateString("GPUAcceleration");
  mxArray *hiddenFallbackType = mxCreateString("none");
  mxArray *hiddenFallbackReason = mxCreateString("");
  mxArray *incompatibleSymbol = mxCreateString("chartInfo");
  mxSetField(mxInfo, 0, infoFields[0], fallbackType);
  mxSetField(mxInfo, 0, infoFields[1], fallbackReason);
  mxSetField(mxInfo, 0, infoFields[2], hiddenFallbackType);
  mxSetField(mxInfo, 0, infoFields[3], hiddenFallbackReason);
  mxSetField(mxInfo, 0, infoFields[4], incompatibleSymbol);
  return mxInfo;
}

mxArray *sf_c14_trajectory_jerk_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c14_trajectory_jerk(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  mxArray *mxVarInfo = sf_mex_decode(
    "eNpjYPT0ZQACPiCWYGRgYAPSHEDMxAABrFA+IxKGiLPAxRWAuKSyIBUkXlyU7JkCpPMSc8H8xNI"
    "Kz7y0fLD5FgwI89kImM8JFYeAD/aU6RdxAOk3QNLPgkU/C5J+ASAvKN7Jkw/KBwA0MA19"
    );
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c14_trajectory_jerk_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "sCFyIbuCo72dCr8xF114prE";
}

static void sf_opaque_initialize_c14_trajectory_jerk(void *chartInstanceVar)
{
  initialize_params_c14_trajectory_jerk((SFc14_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
  initialize_c14_trajectory_jerk((SFc14_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_enable_c14_trajectory_jerk(void *chartInstanceVar)
{
  enable_c14_trajectory_jerk((SFc14_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_disable_c14_trajectory_jerk(void *chartInstanceVar)
{
  disable_c14_trajectory_jerk((SFc14_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_gateway_c14_trajectory_jerk(void *chartInstanceVar)
{
  sf_gateway_c14_trajectory_jerk((SFc14_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c14_trajectory_jerk(SimStruct* S)
{
  return get_sim_state_c14_trajectory_jerk((SFc14_trajectory_jerkInstanceStruct *)
    sf_get_chart_instance_ptr(S));     /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c14_trajectory_jerk(SimStruct* S, const
  mxArray *st)
{
  set_sim_state_c14_trajectory_jerk((SFc14_trajectory_jerkInstanceStruct*)
    sf_get_chart_instance_ptr(S), st);
}

static void sf_opaque_cleanup_runtime_resources_c14_trajectory_jerk(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc14_trajectory_jerkInstanceStruct*) chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_trajectory_jerk_optimization_info();
    }

    mdl_cleanup_runtime_resources_c14_trajectory_jerk
      ((SFc14_trajectory_jerkInstanceStruct*) chartInstanceVar);
    ((SFc14_trajectory_jerkInstanceStruct*) chartInstanceVar)->
      ~SFc14_trajectory_jerkInstanceStruct();
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_mdl_start_c14_trajectory_jerk(void *chartInstanceVar)
{
  mdl_start_c14_trajectory_jerk((SFc14_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
  if (chartInstanceVar) {
    sf_reset_warnings_ChartRunTimeInfo(((SFc14_trajectory_jerkInstanceStruct*)
      chartInstanceVar)->S);
  }
}

static void sf_opaque_mdl_terminate_c14_trajectory_jerk(void *chartInstanceVar)
{
  mdl_terminate_c14_trajectory_jerk((SFc14_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c14_trajectory_jerk(SimStruct *S)
{
  mdlProcessParamsCommon(S);
  if (sf_machine_global_initializer_called()) {
    initialize_params_c14_trajectory_jerk((SFc14_trajectory_jerkInstanceStruct*)
      sf_get_chart_instance_ptr(S));
  }
}

const char* sf_c14_trajectory_jerk_get_post_codegen_info(void)
{
  int i;
  const char* encStrCodegen [20] = {
    "eNrdWM2P20QUn6zCiqKyKgKpPVSCAwcuSOy2iCIh2l0ngUi7bFRni8RlNbFf4mnGM+585IMjJ/4",
    "sxKl/AAf+Bk4cucEbx8mGrNn1OFK3xZLjPDu/ee/95n05pNE9IXjs4dm7S8guXt/Gc4csjrcKub",
    "F2Lu43yVeF3HuHkCihynTFUBL/I5IxjECEdjhkM0+ssGmPKprqGnoFTeEpaMmtYVL4Gc/EEBSIC",
    "BfIpDJeejVLLWdi3LEicpr19wmLkjCRlsdHuCCNTwWf/5fezJoeamwxBZHpAMQmUdKOkg6no6tZ",
    "UGYaJBCNtU29udJgQps5V/WJ5YZlHNoziLpCG4os6Gv8DQ01EJiZd4QwHS7RMs04o6I61wnVIWQ",
    "YHQbOshg/T61B9irqRX0DJqiRilHeTnngIrwitsfRzhMMa+7Ns0lNCwZ2NGJi5NhVNgWB/mOcVO",
    "BqGMgJKDqCU+GZg8679izf4FVcVs/BrgvLWjlo08Wu6FrYXG97ggzpmno7kQgo59oP25fZMUyA5",
    "/pb1NAa2IV+D7DWLO7LZ1S5LPDMJCvYCwsFNpAiZtV3eLKBygvud1g8K8BZ6kIKYqR5Zfpqoeti",
    "0moj0wDTqHV8XFHfZWxXGFBDGkHl2qco04AG53HlqTdmmg64QyNLJvey8gogakOJHlrRmko1Ro5",
    "9i+wFVy4T/NAQj6AFBvKC0cbofka5rWhzqrHCufA401ix/PQi1uVPLXBEowRi108YhxPQbgFduT",
    "5jHzlEbyfMzFugI8WyqplkNcTYSBxL/XkGZ2Is5FR0lEzDYiK4Iq4AsGpQJbAtHGFbUvMOGl/Na",
    "gUv+i6y6oxnKTWcDlxsfAMCO4vz1XVCGmFWtQWObmjQNtiQ/YitXWimDY5T83aeA3E+j95r+M2j",
    "7xXyg1UudXVf4U5RbMMCJ6XDQT7sQZ+lkN8IKc4UC7E4nN7PyIXeWztX693Bb42aOLIl7ts1XLO",
    "En/fXcHcKOdp/eG4UfY4JK9X8/DmocakdtyvwXQVHLuEueF5eP1nDN0r0krXrNvvzZA337oae5g",
    "Zut+Ds55+Gf5uP7/+Rfvnyt19+ncTb6H/pGc97hXx/OZ+tOtjkUpGvEg93N+LByTrozLsDG8gvD",
    "uJAPZp19vcfZqpdK/+W9z/C02CBy+ulirpx8a7lZGoX7wBu/Udr9u5es/6ttXgi5M/H2+E/eLK5",
    "j2V8Nf/FV5M8PT/q7r1BdeKm6tJN4qrUrcYrxpFXjNvWP996/Kb//qo6QDZ+f+c19mPzWrcvv25",
    "+/U78+tCHhfz16p05SBiPS6b24jEO1sOyp/+T+P7Lk7/lnNB2/BV/+v3w4FBQPscxffEaVNzuKf",
    "d/0+qRAqrL34Vuoi+QkrmvrM/f3shvJ0+ZiOVUf7p/8PnBNv33Hzy/AGA=",
    ""
  };

  static char newstr [1409] = "";
  newstr[0] = '\0';
  for (i = 0; i < 20; i++) {
    strcat(newstr, encStrCodegen[i]);
  }

  return newstr;
}

static void mdlSetWorkWidths_c14_trajectory_jerk(SimStruct *S)
{
  const char* newstr = sf_c14_trajectory_jerk_get_post_codegen_info();
  sf_set_work_widths(S, newstr);
  ssSetChecksum0(S,(4284908168U));
  ssSetChecksum1(S,(3927712884U));
  ssSetChecksum2(S,(3569891693U));
  ssSetChecksum3(S,(1685504704U));
}

static void mdlRTW_c14_trajectory_jerk(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlSetupRuntimeResources_c14_trajectory_jerk(SimStruct *S)
{
  SFc14_trajectory_jerkInstanceStruct *chartInstance;
  chartInstance = (SFc14_trajectory_jerkInstanceStruct *)utMalloc(sizeof
    (SFc14_trajectory_jerkInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc14_trajectory_jerkInstanceStruct));
  chartInstance = new (chartInstance) SFc14_trajectory_jerkInstanceStruct;
  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c14_trajectory_jerk;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c14_trajectory_jerk;
  chartInstance->chartInfo.mdlStart = sf_opaque_mdl_start_c14_trajectory_jerk;
  chartInstance->chartInfo.mdlTerminate =
    sf_opaque_mdl_terminate_c14_trajectory_jerk;
  chartInstance->chartInfo.mdlCleanupRuntimeResources =
    sf_opaque_cleanup_runtime_resources_c14_trajectory_jerk;
  chartInstance->chartInfo.enableChart = sf_opaque_enable_c14_trajectory_jerk;
  chartInstance->chartInfo.disableChart = sf_opaque_disable_c14_trajectory_jerk;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c14_trajectory_jerk;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c14_trajectory_jerk;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c14_trajectory_jerk;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c14_trajectory_jerk;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c14_trajectory_jerk;
  chartInstance->chartInfo.extModeExec = NULL;
  chartInstance->chartInfo.restoreLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.restoreBeforeLastMajorStepConfiguration = NULL;
  chartInstance->chartInfo.storeCurrentConfiguration = NULL;
  chartInstance->chartInfo.callAtomicSubchartUserFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartAutoFcn = NULL;
  chartInstance->chartInfo.callAtomicSubchartEventFcn = NULL;
  chartInstance->S = S;
  chartInstance->chartInfo.dispatchToExportedFcn = NULL;
  sf_init_ChartRunTimeInfo(S, &(chartInstance->chartInfo), false, 0);
  init_dsm_address_info(chartInstance);
  init_simulink_io_address(chartInstance);
  if (!sim_mode_is_rtw_gen(S)) {
  }

  mdl_setup_runtime_resources_c14_trajectory_jerk(chartInstance);
}

void c14_trajectory_jerk_method_dispatcher(SimStruct *S, int_T method, void
  *data)
{
  switch (method) {
   case SS_CALL_MDL_SETUP_RUNTIME_RESOURCES:
    mdlSetupRuntimeResources_c14_trajectory_jerk(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c14_trajectory_jerk(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c14_trajectory_jerk(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c14_trajectory_jerk_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
