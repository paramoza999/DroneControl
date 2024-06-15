/* Include files */

#include "trajectory_jerk_sfun.h"
#include "c3_trajectory_jerk.h"
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
static void c3_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct
  *chartInstance, real_T c3_b_xdd_des, real_T c3_b_ydd_des, real_T c3_b_psi,
  real_T *c3_b_phi_des, real_T *c3_b_theta_des);
static void initialize_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct
  *chartInstance);
static void initialize_params_c3_trajectory_jerk
  (SFc3_trajectory_jerkInstanceStruct *chartInstance);
static void mdl_start_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct
  *chartInstance);
static void mdl_terminate_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct *
  chartInstance);
static void mdl_setup_runtime_resources_c3_trajectory_jerk
  (SFc3_trajectory_jerkInstanceStruct *chartInstance);
static void mdl_cleanup_runtime_resources_c3_trajectory_jerk
  (SFc3_trajectory_jerkInstanceStruct *chartInstance);
static void enable_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct
  *chartInstance);
static void disable_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct
  *chartInstance);
static void sf_gateway_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct
  *chartInstance);
static void ext_mode_exec_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct *
  chartInstance);
static const mxArray *get_sim_state_c3_trajectory_jerk
  (SFc3_trajectory_jerkInstanceStruct *chartInstance);
static void set_sim_state_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct *
  chartInstance, const mxArray *c3_st);
static real_T c3_emlrt_marshallIn(SFc3_trajectory_jerkInstanceStruct
  *chartInstance, const mxArray *c3_nullptr, const char_T *c3_identifier);
static real_T c3_b_emlrt_marshallIn(SFc3_trajectory_jerkInstanceStruct
  *chartInstance, const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId);
static void c3_raiseCudaError(SFc3_trajectory_jerkInstanceStruct *chartInstance,
  int32_T c3_errCode, const char_T *c3_file, uint32_T c3_line, const char_T
  *c3_errorName, const char_T *c3_errorString);
static void c3_checkCudaError(SFc3_trajectory_jerkInstanceStruct *chartInstance,
  cudaError_t c3_errCode, const char_T *c3_file, uint32_T c3_line);
static void init_dsm_address_info(SFc3_trajectory_jerkInstanceStruct
  *chartInstance);
static void init_simulink_io_address(SFc3_trajectory_jerkInstanceStruct
  *chartInstance);

/* Function Definitions */
static void c3_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct
  *chartInstance, real_T c3_b_xdd_des, real_T c3_b_ydd_des, real_T c3_b_psi,
  real_T *c3_b_phi_des, real_T *c3_b_theta_des)
{
  const mxArray *c3_b_y = NULL;
  const mxArray *c3_y = NULL;
  *c3_b_phi_des = -0.1019367991845056 * (c3_b_xdd_des * muDoubleScalarSin
    (c3_b_psi) - c3_b_ydd_des * muDoubleScalarCos(c3_b_psi));
  sf_mex_printf("%s =\\n", "phi_des");
  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_create("y", c3_b_phi_des, 0, 0U, 0, 0U, 0), false);
  sf_mex_call(chartInstance->c3_fEmlrtCtx, NULL, "disp", 0U, 1U, 14, c3_y);
  *c3_b_theta_des = -0.1019367991845056 * (c3_b_xdd_des * muDoubleScalarCos
    (c3_b_psi) + c3_b_ydd_des * muDoubleScalarSin(c3_b_psi));
  sf_mex_printf("%s =\\n", "theta_des");
  c3_b_y = NULL;
  sf_mex_assign(&c3_b_y, sf_mex_create("y", c3_b_theta_des, 0, 0U, 0, 0U, 0),
                false);
  sf_mex_call(chartInstance->c3_fEmlrtCtx, NULL, "disp", 0U, 1U, 14, c3_b_y);
}

static void initialize_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct
  *chartInstance)
{
  emlrtInitGPU(chartInstance->c3_fEmlrtCtx);
  cudaGetLastError();
  emlrtLicenseCheckR2022a(chartInstance->c3_fEmlrtCtx,
    "EMLRT:runTime:MexFunctionNeedsLicense", "distrib_computing_toolbox", 2);
  sim_mode_is_external(chartInstance->S);
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void initialize_params_c3_trajectory_jerk
  (SFc3_trajectory_jerkInstanceStruct *chartInstance)
{
}

static void mdl_start_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct
  *chartInstance)
{
  sim_mode_is_external(chartInstance->S);
}

static void mdl_terminate_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct *
  chartInstance)
{
  cudaError_t c3_errCode;
  c3_errCode = cudaGetLastError();
  if (c3_errCode != cudaSuccess) {
    emlrtThinCUDAError(static_cast<uint32_T>(c3_errCode), (char_T *)
                       cudaGetErrorName(c3_errCode), (char_T *)
                       cudaGetErrorString(c3_errCode), (char_T *)
                       "SimGPUErrorChecks", chartInstance->c3_fEmlrtCtx);
  }
}

static void mdl_setup_runtime_resources_c3_trajectory_jerk
  (SFc3_trajectory_jerkInstanceStruct *chartInstance)
{
  sfSetAnimationVectors(chartInstance->S, &chartInstance->c3_JITStateAnimation[0],
                        &chartInstance->c3_JITTransitionAnimation[0]);
}

static void mdl_cleanup_runtime_resources_c3_trajectory_jerk
  (SFc3_trajectory_jerkInstanceStruct *chartInstance)
{
}

static void enable_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct
  *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void disable_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct
  *chartInstance)
{
  _sfTime_ = sf_get_time(chartInstance->S);
}

static void sf_gateway_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct
  *chartInstance)
{
  real_T c3_d;
  real_T c3_d1;
  _sfTime_ = sf_get_time(chartInstance->S);
  chartInstance->c3_JITTransitionAnimation[0] = 0U;
  c3_c3_trajectory_jerk(chartInstance, *chartInstance->c3_xdd_des,
                        *chartInstance->c3_ydd_des, *chartInstance->c3_psi,
                        &c3_d, &c3_d1);
  *chartInstance->c3_theta_des = c3_d1;
  *chartInstance->c3_phi_des = c3_d;
}

static void ext_mode_exec_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct *
  chartInstance)
{
}

static const mxArray *get_sim_state_c3_trajectory_jerk
  (SFc3_trajectory_jerkInstanceStruct *chartInstance)
{
  const mxArray *c3_b_y = NULL;
  const mxArray *c3_c_y = NULL;
  const mxArray *c3_st;
  const mxArray *c3_y = NULL;
  c3_st = NULL;
  c3_st = NULL;
  c3_y = NULL;
  sf_mex_assign(&c3_y, sf_mex_createcellmatrix(2, 1), false);
  c3_b_y = NULL;
  sf_mex_assign(&c3_b_y, sf_mex_create("y", chartInstance->c3_phi_des, 0, 0U, 0,
    0U, 0), false);
  sf_mex_setcell(c3_y, 0, c3_b_y);
  c3_c_y = NULL;
  sf_mex_assign(&c3_c_y, sf_mex_create("y", chartInstance->c3_theta_des, 0, 0U,
    0, 0U, 0), false);
  sf_mex_setcell(c3_y, 1, c3_c_y);
  sf_mex_assign(&c3_st, c3_y, false);
  return c3_st;
}

static void set_sim_state_c3_trajectory_jerk(SFc3_trajectory_jerkInstanceStruct *
  chartInstance, const mxArray *c3_st)
{
  const mxArray *c3_u;
  c3_u = sf_mex_dup(c3_st);
  *chartInstance->c3_phi_des = c3_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell(c3_u, 0)), "phi_des");
  *chartInstance->c3_theta_des = c3_emlrt_marshallIn(chartInstance, sf_mex_dup
    (sf_mex_getcell(c3_u, 1)), "theta_des");
  sf_mex_destroy(&c3_u);
  sf_mex_destroy(&c3_st);
}

const mxArray *sf_c3_trajectory_jerk_get_eml_resolved_functions_info()
{
  const mxArray *c3_nameCaptureInfo = NULL;
  c3_nameCaptureInfo = NULL;
  sf_mex_assign(&c3_nameCaptureInfo, sf_mex_create("nameCaptureInfo", NULL, 0,
    0U, 1, 0U, 2, 0, 1), false);
  return c3_nameCaptureInfo;
}

static real_T c3_emlrt_marshallIn(SFc3_trajectory_jerkInstanceStruct
  *chartInstance, const mxArray *c3_nullptr, const char_T *c3_identifier)
{
  emlrtMsgIdentifier c3_thisId;
  real_T c3_y;
  c3_thisId.fIdentifier = const_cast<const char_T *>(c3_identifier);
  c3_thisId.fParent = NULL;
  c3_thisId.bParentIsCell = false;
  c3_y = c3_b_emlrt_marshallIn(chartInstance, sf_mex_dup(c3_nullptr), &c3_thisId);
  sf_mex_destroy(&c3_nullptr);
  return c3_y;
}

static real_T c3_b_emlrt_marshallIn(SFc3_trajectory_jerkInstanceStruct
  *chartInstance, const mxArray *c3_u, const emlrtMsgIdentifier *c3_parentId)
{
  real_T c3_d;
  real_T c3_y;
  sf_mex_import(c3_parentId, sf_mex_dup(c3_u), &c3_d, 1, 0, 0U, 0, 0U, 0);
  c3_y = c3_d;
  sf_mex_destroy(&c3_u);
  return c3_y;
}

static void c3_raiseCudaError(SFc3_trajectory_jerkInstanceStruct *chartInstance,
  int32_T c3_errCode, const char_T *c3_file, uint32_T c3_line, const char_T
  *c3_errorName, const char_T *c3_errorString)
{
  emlrtRTEInfo c3_rtInfo;
  uint64_T c3_len;
  char_T *c3_brk;
  char_T *c3_fn;
  char_T *c3_pn;
  c3_len = strlen(c3_file);
  c3_pn = static_cast<char_T *>(calloc(c3_len + 1ULL, 1ULL));
  c3_fn = static_cast<char_T *>(calloc(c3_len + 1ULL, 1ULL));
  memcpy(c3_pn, c3_file, c3_len);
  memcpy(c3_fn, c3_file, c3_len);
  c3_brk = strrchr(c3_fn, '.');
  *c3_brk = '\x00';
  c3_brk = NULL;
  c3_brk = strrchr(c3_fn, '/');
  if (c3_brk == NULL) {
    c3_brk = strrchr(c3_fn, '\\');
  }

  if (c3_brk == NULL) {
    c3_brk = c3_fn;
  } else {
    c3_brk++;
  }

  c3_rtInfo.lineNo = c3_line;
  c3_rtInfo.colNo = 0;
  c3_rtInfo.fName = c3_brk;
  c3_rtInfo.pName = c3_pn;
  emlrtCUDAError(static_cast<uint32_T>(c3_errCode), (char_T *)c3_errorName,
                 (char_T *)c3_errorString, &c3_rtInfo,
                 chartInstance->c3_fEmlrtCtx);
}

static void c3_checkCudaError(SFc3_trajectory_jerkInstanceStruct *chartInstance,
  cudaError_t c3_errCode, const char_T *c3_file, uint32_T c3_line)
{
  if (c3_errCode != cudaSuccess) {
    c3_raiseCudaError(chartInstance, c3_errCode, c3_file, c3_line,
                      cudaGetErrorName(c3_errCode), cudaGetErrorString
                      (c3_errCode));
  }
}

static void init_dsm_address_info(SFc3_trajectory_jerkInstanceStruct
  *chartInstance)
{
}

static void init_simulink_io_address(SFc3_trajectory_jerkInstanceStruct
  *chartInstance)
{
  chartInstance->c3_fEmlrtCtx = (void *)sfrtGetEmlrtCtx(chartInstance->S);
  chartInstance->c3_xdd_des = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 0);
  chartInstance->c3_phi_des = (real_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c3_ydd_des = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 1);
  chartInstance->c3_psi = (real_T *)ssGetInputPortSignal_wrapper
    (chartInstance->S, 2);
  chartInstance->c3_theta_des = (real_T *)ssGetOutputPortSignal_wrapper
    (chartInstance->S, 2);
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* SFunction Glue Code */
void sf_c3_trajectory_jerk_get_check_sum(mxArray *plhs[])
{
  ((real_T *)mxGetPr((plhs[0])))[0] = (real_T)(3245189126U);
  ((real_T *)mxGetPr((plhs[0])))[1] = (real_T)(3573125509U);
  ((real_T *)mxGetPr((plhs[0])))[2] = (real_T)(1290004641U);
  ((real_T *)mxGetPr((plhs[0])))[3] = (real_T)(2872569169U);
}

mxArray *sf_c3_trajectory_jerk_third_party_uses_info(void)
{
  mxArray * mxcell3p = mxCreateCellMatrix(1,0);
  return(mxcell3p);
}

mxArray *sf_c3_trajectory_jerk_jit_fallback_info(void)
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

mxArray *sf_c3_trajectory_jerk_updateBuildInfo_args_info(void)
{
  mxArray *mxBIArgs = mxCreateCellMatrix(1,0);
  return mxBIArgs;
}

static const mxArray *sf_get_sim_state_info_c3_trajectory_jerk(void)
{
  const char *infoFields[] = { "chartChecksum", "varInfo" };

  mxArray *mxInfo = mxCreateStructMatrix(1, 1, 2, infoFields);
  mxArray *mxVarInfo = sf_mex_decode(
    "eNpjYPT0ZQACPiD+wMjAwAakOYCYiQECWKF8RqgYI1ycBS6uAMQllQWpIPHiomTPFCCdl5gL5ie"
    "WVnjmpeWDzbdgQJjPhsV8RiTzOaHiEPDBnjL9Ig7o+lmw6GdH0i8A5RdkZManpBaD3Q8Lp4Hzhw"
    "LYHw4E/MGJ5g8QvyQjtSQR7BOEP0AAAIDPFtk="
    );
  mxArray *mxChecksum = mxCreateDoubleMatrix(1, 4, mxREAL);
  sf_c3_trajectory_jerk_get_check_sum(&mxChecksum);
  mxSetField(mxInfo, 0, infoFields[0], mxChecksum);
  mxSetField(mxInfo, 0, infoFields[1], mxVarInfo);
  return mxInfo;
}

static const char* sf_get_instance_specialization(void)
{
  return "sMtLs8ofMki7VphfTfIASx";
}

static void sf_opaque_initialize_c3_trajectory_jerk(void *chartInstanceVar)
{
  initialize_params_c3_trajectory_jerk((SFc3_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
  initialize_c3_trajectory_jerk((SFc3_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_enable_c3_trajectory_jerk(void *chartInstanceVar)
{
  enable_c3_trajectory_jerk((SFc3_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_disable_c3_trajectory_jerk(void *chartInstanceVar)
{
  disable_c3_trajectory_jerk((SFc3_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
}

static void sf_opaque_gateway_c3_trajectory_jerk(void *chartInstanceVar)
{
  sf_gateway_c3_trajectory_jerk((SFc3_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
}

static const mxArray* sf_opaque_get_sim_state_c3_trajectory_jerk(SimStruct* S)
{
  return get_sim_state_c3_trajectory_jerk((SFc3_trajectory_jerkInstanceStruct *)
    sf_get_chart_instance_ptr(S));     /* raw sim ctx */
}

static void sf_opaque_set_sim_state_c3_trajectory_jerk(SimStruct* S, const
  mxArray *st)
{
  set_sim_state_c3_trajectory_jerk((SFc3_trajectory_jerkInstanceStruct*)
    sf_get_chart_instance_ptr(S), st);
}

static void sf_opaque_cleanup_runtime_resources_c3_trajectory_jerk(void
  *chartInstanceVar)
{
  if (chartInstanceVar!=NULL) {
    SimStruct *S = ((SFc3_trajectory_jerkInstanceStruct*) chartInstanceVar)->S;
    if (sim_mode_is_rtw_gen(S) || sim_mode_is_external(S)) {
      sf_clear_rtw_identifier(S);
      unload_trajectory_jerk_optimization_info();
    }

    mdl_cleanup_runtime_resources_c3_trajectory_jerk
      ((SFc3_trajectory_jerkInstanceStruct*) chartInstanceVar);
    ((SFc3_trajectory_jerkInstanceStruct*) chartInstanceVar)->
      ~SFc3_trajectory_jerkInstanceStruct();
    utFree(chartInstanceVar);
    if (ssGetUserData(S)!= NULL) {
      sf_free_ChartRunTimeInfo(S);
    }

    ssSetUserData(S,NULL);
  }
}

static void sf_opaque_mdl_start_c3_trajectory_jerk(void *chartInstanceVar)
{
  mdl_start_c3_trajectory_jerk((SFc3_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
  if (chartInstanceVar) {
    sf_reset_warnings_ChartRunTimeInfo(((SFc3_trajectory_jerkInstanceStruct*)
      chartInstanceVar)->S);
  }
}

static void sf_opaque_mdl_terminate_c3_trajectory_jerk(void *chartInstanceVar)
{
  mdl_terminate_c3_trajectory_jerk((SFc3_trajectory_jerkInstanceStruct*)
    chartInstanceVar);
}

extern unsigned int sf_machine_global_initializer_called(void);
static void mdlProcessParameters_c3_trajectory_jerk(SimStruct *S)
{
  mdlProcessParamsCommon(S);
  if (sf_machine_global_initializer_called()) {
    initialize_params_c3_trajectory_jerk((SFc3_trajectory_jerkInstanceStruct*)
      sf_get_chart_instance_ptr(S));
  }
}

const char* sf_c3_trajectory_jerk_get_post_codegen_info(void)
{
  int i;
  const char* encStrCodegen [21] = {
    "eNrdWFtv40QUdtJSKCrLchHsAxL7ABJCQixbod0HLu3mApEaGuG0SLxUE/s4ns14xjuXXBAv/BP",
    "+BX+AH8Ev4Jk3eEKccdw0ckLjcUAtWHLdY+ebc87ncxt7tU7Xw+MOnu/d87w9vL6AZ92bH8/lcm",
    "3pnN/f9T7J5d6LnhfEROoOj4TnfgQihCFw30QRnTpiuUl6RJJEVdDLSQJfgxLMaCq4m/GURyCBB",
    "7hAKqR20qtoYhjlo7bhgdWsvolpEPuxMCx8gguS8JSz2d/pTY3uocYmlRDoNkCoYynMMG4zMrye",
    "BaknjRiCkTKJM1cKtG9S66rqGqZpyqA1haDDlSbIgtrgr6+JhoaeOkcIVf4lWiQpo4SX5zomyoc",
    "Uo0PDWRri31Ojkb2SelHfgHKihaSEtRLWsBFeEttjaGcXw5o586wT3YSBGQ4pH1p2pUmAo/8YJy",
    "W4ihpiDJIM4ZQ75qD1rjXNXvAiLsvnYMeGZaUcNMn8rahK2Exva4wMqYp62wFvEMaUG7Yv0hMYA",
    "8v0N4kmFbBz/Q5gpWjYF+dE2ixwzCTD6TMDObYheEjLv+FxAZUV3K+weJaA08SGFIRI88L0xUKb",
    "YtIoLZIGplHz5KSkvlVsh2uQEQmgdO2ThCpAg7O4ctQbUkUGzKKRJZ15WXoF4JWhnooMb06EHCH",
    "HrkX2iiubCW5oCIfQBA1ZwWhhdJ8TZkranCiscDY8zhRWLDe9iLX5UwkckCCG0PYTyqALyi6gSt",
    "dn7CPH6O2Y6lkTVCBpWjaTjIIQG4llqT9L4YyPuJjwthSJn08E18QVAFYNIjm2hSfYluSsjcaXs",
    "1rCs76NrCrjWUI0IwMbG18Ax85ifbWdkASYVS2OoxsatA3Wp99ha+eKKo3j1KyV5UCYzaP3am7z",
    "6Cu5fLjIpY7qS3xTBNswx0npeJANe9CnCWQ3fIIzxVzMD6v3gXeld79+vd46/leriPO2xH25hNt",
    "dw8+rS7i7uRwcXmhJnmK+Cjm7eApytN7vgxJ8l8F5K7grfYt9xxK+tkavt3TdxNfOCl87Xq1Wy3",
    "BHS7iXCnp2C7i9nLPX/vzph58PXv7w0fu///r9p+++s018/Fh3i+c7ufzW5Xy26GDjlSJfJh7eK",
    "MSDlVVXn6jHIuqO6KPzNI76UefYn87X+21D/tUL9l7ev4+nxgKX1UsZdMJ8r2VlYuZ7ALv+4yV7",
    "9zbwsb8UT2jZ59vhXz8q4tfx9XyBLyunMb0Ise4ux+/N+XH/qBjX6/zYL/hhZR2DJpknq/l42+v",
    "fTdXbm8SVqcc7FXH1f7H+/5O4bf1z7TP/9d8/uKYueIXf373FflxXn1zmjdvm1y+e2zzwdi5/tv",
    "gW0IgpC9fsRvLHuGGI1j39n8T3H478vZnLLctf/jHz28NjTtgMtx/z7V1+uyftd7TFIwlErd/j3",
    "URfuLxu6vsHhfy28oTyUEzUBx89/PjhNv33L38+B68=",
    ""
  };

  static char newstr [1469] = "";
  newstr[0] = '\0';
  for (i = 0; i < 21; i++) {
    strcat(newstr, encStrCodegen[i]);
  }

  return newstr;
}

static void mdlSetWorkWidths_c3_trajectory_jerk(SimStruct *S)
{
  const char* newstr = sf_c3_trajectory_jerk_get_post_codegen_info();
  sf_set_work_widths(S, newstr);
  ssSetChecksum0(S,(2176318995U));
  ssSetChecksum1(S,(789515460U));
  ssSetChecksum2(S,(3874957879U));
  ssSetChecksum3(S,(606420348U));
}

static void mdlRTW_c3_trajectory_jerk(SimStruct *S)
{
  if (sim_mode_is_rtw_gen(S)) {
    ssWriteRTWStrParam(S, "StateflowChartType", "Embedded MATLAB");
  }
}

static void mdlSetupRuntimeResources_c3_trajectory_jerk(SimStruct *S)
{
  SFc3_trajectory_jerkInstanceStruct *chartInstance;
  chartInstance = (SFc3_trajectory_jerkInstanceStruct *)utMalloc(sizeof
    (SFc3_trajectory_jerkInstanceStruct));
  if (chartInstance==NULL) {
    sf_mex_error_message("Could not allocate memory for chart instance.");
  }

  memset(chartInstance, 0, sizeof(SFc3_trajectory_jerkInstanceStruct));
  chartInstance = new (chartInstance) SFc3_trajectory_jerkInstanceStruct;
  chartInstance->chartInfo.chartInstance = chartInstance;
  chartInstance->chartInfo.isEMLChart = 1;
  chartInstance->chartInfo.chartInitialized = 0;
  chartInstance->chartInfo.sFunctionGateway =
    sf_opaque_gateway_c3_trajectory_jerk;
  chartInstance->chartInfo.initializeChart =
    sf_opaque_initialize_c3_trajectory_jerk;
  chartInstance->chartInfo.mdlStart = sf_opaque_mdl_start_c3_trajectory_jerk;
  chartInstance->chartInfo.mdlTerminate =
    sf_opaque_mdl_terminate_c3_trajectory_jerk;
  chartInstance->chartInfo.mdlCleanupRuntimeResources =
    sf_opaque_cleanup_runtime_resources_c3_trajectory_jerk;
  chartInstance->chartInfo.enableChart = sf_opaque_enable_c3_trajectory_jerk;
  chartInstance->chartInfo.disableChart = sf_opaque_disable_c3_trajectory_jerk;
  chartInstance->chartInfo.getSimState =
    sf_opaque_get_sim_state_c3_trajectory_jerk;
  chartInstance->chartInfo.setSimState =
    sf_opaque_set_sim_state_c3_trajectory_jerk;
  chartInstance->chartInfo.getSimStateInfo =
    sf_get_sim_state_info_c3_trajectory_jerk;
  chartInstance->chartInfo.zeroCrossings = NULL;
  chartInstance->chartInfo.outputs = NULL;
  chartInstance->chartInfo.derivatives = NULL;
  chartInstance->chartInfo.mdlRTW = mdlRTW_c3_trajectory_jerk;
  chartInstance->chartInfo.mdlSetWorkWidths =
    mdlSetWorkWidths_c3_trajectory_jerk;
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

  mdl_setup_runtime_resources_c3_trajectory_jerk(chartInstance);
}

void c3_trajectory_jerk_method_dispatcher(SimStruct *S, int_T method, void *data)
{
  switch (method) {
   case SS_CALL_MDL_SETUP_RUNTIME_RESOURCES:
    mdlSetupRuntimeResources_c3_trajectory_jerk(S);
    break;

   case SS_CALL_MDL_SET_WORK_WIDTHS:
    mdlSetWorkWidths_c3_trajectory_jerk(S);
    break;

   case SS_CALL_MDL_PROCESS_PARAMETERS:
    mdlProcessParameters_c3_trajectory_jerk(S);
    break;

   default:
    /* Unhandled method */
    sf_mex_error_message("Stateflow Internal Error:\n"
                         "Error calling c3_trajectory_jerk_method_dispatcher.\n"
                         "Can't handle method %d.\n", method);
    break;
  }
}
