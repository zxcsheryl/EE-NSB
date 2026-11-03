****************************************************************************************************
* Project : EE Study 3 - Completion analyses (items 1-11 of the 2026-11-03 synthesis memo, section 5)
* Author  : Sheryl Zhang (with Claude)
* Date    : 2026-11-03
* Data    : EE_Study3_Cleaned_Data_20260922 with Invalid NSB.dta  ->  analysis sample N = 885
* Log     : EE_Study3_Completion_20261103.log
* Output  : EE_Study3_Completion_results.dta / .xlsx   (one row per estimate, sheet "all_long",
*           plus one sheet per section)
*           C_profile_E.png, C_profile_NE.png   (sextile profiles with bootstrap 95% CIs)
*
* HOW TO RUN: open in the Do-file Editor, highlight nothing, click Do. Runs in one sitting.
*             Close the .xlsx output in Excel first, or the export at the end will fail.
*             Sections are independent after 【0】, so you can also run 【0】 + any one section.
*             Optional ssc packages (firthlogit) are installed if missing; everything else is
*             official Stata 17. Every model is wrapped in capture noisily, so one failing
*             model prints its error and the file keeps going.
*
* Section map (memo item in brackets):
*   【0】 Setup, sample, integrity, variables
*   【1】 Binary NSB models on the preregistered sample, each corner separately      [item 1]
*   【2】 Equivalence (TOST) and Bayes factors: categorical NSB by range              [item 2]
*   【3】 Cross-arm prediction of persistent corners from pre-MPL constructs           [item 3]
*   【4】 Within-corner format analysis: categorical vs dollar, every corner n >= 15   [item 4]
*   【5】 Sextile profile figures with bootstrap CIs + corner-step gap table          [item 5]
*   【6】 Rung-count sensitivity: simulate a 10-rung $7-216 ladder inside the wide arm [item 6]
*   【7】 Switcher endowment effect: raw vs within-range standardized gap             [item 7]
*   【8】 Always Buy censoring reconciliation                                          [item 8]
*   【9】 Order / position check (descriptive; order was not randomized)              [item 9]
*   【10】 Latent class on the three-way response among non-owners                     [item 10]
*   【11】 Export results
*
* Conventions (from the project memory file): sample = comp_pass=="1" & nsb_invalid!=1;
*   inertia = (zsq - zir + zar)/3; id_mm = (zme + zmi)/2; owncond 0 = Non-Endowed, 1 = Endowed;
*   mplcond 0 = Normal, 1 = Wide; never pool corners; ASCII "->" in titles; "commission regret"
*   in text (the variable is still Action_Regret).
****************************************************************************************************
clear all
set more off
set varabbrev off
set linesize 220
capture log close _all
set seed 20261103
version 17

* ---- working folder: edit this ONE line if needed (no trailing backslash) -----------------------
global WD "D:\Sheryl临时文件\EE Study 3 Survey Response"
capture cd "$WD"
if _rc di as error "Could not cd to the folder above; staying in: `c(pwd)'"

log using "EE_Study3_Completion_20261103.log", replace text

global DATA "EE_Study3_Cleaned_Data_20260922 with Invalid NSB"
global RES  "EE_Study3_Completion_results"

foreach p in firthlogit {
    capture which `p'
    if _rc capture ssc install `p', replace
}

capture program drop hdr
program define hdr
    di _n as result "{hline 110}" _n as result `"`0'"' _n as result "{hline 110}"
end

****************************************************************************************************
**#【0】 Setup, sample, integrity, variables
****************************************************************************************************
hdr 0. DATA AND SAMPLE
use "$DATA", clear

* --- every variable this file needs; stop with a clear message if one is missing ---
foreach v in valuation owncond mplcond nsb nsb_type nsb_invalid nsb_hi nsb_table nsb_true nsb_dollar ///
             nsb_narrow nsb_wide assetAmount moneyAmount val_lo val_hi fu_amount fu_amount_ok ///
             me_ness mine_ness attractiveness Status_Quo Action_Regret Inaction_Regret Pay_Ability ///
             mpl_pass Q_TerminateFlag ac_pass comp_pass ipfreq {
    capture confirm variable `v'
    if _rc {
        di as error "Variable `v' not found in $DATA - fix the name and rerun."
        exit 111
    }
}
* optional variables: sections that need them are skipped with a message if absent
local HAVE_GRP3 = 1
capture confirm variable grp3
if _rc local HAVE_GRP3 = 0
local HAVE_CROSS = 1
capture confirm variable crossover
if _rc local HAVE_CROSS = 0
local HAVE_RS = 1
capture confirm variable Routine_Seeking
if _rc local HAVE_RS = 0

* --- analysis sample: same rule as "EE Study 3 - Stats Analyses 2.do" section 0 (prereg Q6) ---
capture drop ip_dup
gen byte ip_dup = (ipfreq>1 & !missing(ipfreq))
keep if mpl_pass==1 & Q_TerminateFlag=="Complete" & ac_pass=="1" & comp_pass=="1" ///
      & nsb_invalid!=1 & !missing(mplcond) & ip_dup==0
quietly count
local N = r(N)
di as result "Analysis N = `N' (expected 885)"
if `N' != 885 di as error "WARNING: N is not 885 - check the data file before interpreting."

* --- integrity: NSB coding must be internally consistent ---
assert inlist(nsb, 0, 1)
assert inlist(nsb_type, 1, 2, 3, 4) if nsb==1
assert inlist(nsb_type, 1, 2) if nsb==1 & owncond==1
assert inlist(nsb_type, 3, 4) if nsb==1 & owncond==0
assert !missing(valuation, owncond, mplcond)
count if nsb==1 & nsb_true!=1 & nsb_dollar!=1        // should be 0 on the valid sample
count if nsb_true==1 & nsb_dollar==1                   // should be 0

capture drop pid
gen long pid = _n

* --- composites re-standardized within THIS sample (same recipe as Stats Analyses 2, section 0) ---
capture drop zme zmi zat zsq zar zir zpay id_mm id_full inertia
foreach pair in "me_ness zme" "mine_ness zmi" "attractiveness zat" "Status_Quo zsq" ///
                "Action_Regret zar" "Inaction_Regret zir" "Pay_Ability zpay" {
    local v : word 1 of `pair'
    local z : word 2 of `pair'
    egen double `z' = std(`v')
}
gen double id_mm   = (zme + zmi)/2
gen double id_full = (zme + zmi + zat)/3
gen double inertia = (zsq - zir + zar)/3
label var id_mm   "Identity composite (me + mine only)"
label var inertia "Inertia composite (SQ + commission - omission)"

* --- within-condition standardized motives (same recipe as Inflection v2) ---
local raw   attractiveness me_ness mine_ness Status_Quo Action_Regret Inaction_Regret Pay_Ability
local short att            me      mine      sq         ar            ir              pay
forvalues k = 1/7 {
    local v : word `k' of `raw'
    local s : word `k' of `short'
    capture drop s_`s'
    bysort owncond: egen double s_`s' = std(`v')
}
capture drop s_id s_inert tmp_id tmp_in
gen double tmp_id = (s_me + s_mine)/2
gen double tmp_in = (s_sq - s_ir + s_ar)/3
bysort owncond: egen double s_id    = std(tmp_id)
bysort owncond: egen double s_inert = std(tmp_in)
drop tmp_id tmp_in
label var s_att   "Attractiveness (SD within condition)"
label var s_id    "Identity: me + mine (SD within condition)"
label var s_sq    "Status quo (SD within condition)"
label var s_ar    "Commission (action) regret (SD within condition)"
label var s_ir    "Omission (inaction) regret (SD within condition)"
label var s_inert "Inertia composite (SD within condition)"

* --- grouping variables ---
capture drop grp6
gen byte grp6 = .
replace grp6 = 1 if nsb_type==1               // Always Keep
replace grp6 = 2 if nsb_type==2               // Always Sell
replace grp6 = 3 if nsb_type==4               // Always Buy
replace grp6 = 4 if nsb_type==3               // Never Buy
replace grp6 = 5 if nsb==0 & owncond==1       // Endowed switchers
replace grp6 = 6 if nsb==0 & owncond==0       // Non-endowed switchers
label define g6 1 "AK" 2 "AS" 3 "AB" 4 "NB" 5 "Sw-E" 6 "Sw-NE", replace
label values grp6 g6

* one binary outcome per corner, defined within its own endowment condition (never pooled)
capture drop keepc sellc buyc nobuyc
gen byte keepc  = (nsb_type==1) if owncond==1
gen byte sellc  = (nsb_type==2) if owncond==1
gen byte buyc   = (nsb_type==4) if owncond==0
gen byte nobuyc = (nsb_type==3) if owncond==0
label var keepc  "Always Keep (owners)"
label var sellc  "Always Sell (owners)"
label var buyc   "Always Buy (non-owners)"
label var nobuyc "Never Buy (non-owners)"

* categorical-only versions (the operational definition of NSB recommended in the memo)
capture drop keepc_cat sellc_cat buyc_cat nobuyc_cat
gen byte keepc_cat  = (nsb_type==1 & nsb_true==1) if owncond==1
gen byte sellc_cat  = (nsb_type==2 & nsb_true==1) if owncond==1
gen byte buyc_cat   = (nsb_type==4 & nsb_true==1) if owncond==0
gen byte nobuyc_cat = (nsb_type==3 & nsb_true==1) if owncond==0

* response format: switcher / categorical corner / dollar corner
capture drop t3
gen byte t3 = cond(nsb==0,1, cond(nsb_true==1,2, cond(nsb_dollar==1,3,.)))
label define t3l 1 "Switcher" 2 "NSB-categ" 3 "NSB-dollar", replace
label values t3 t3l
capture drop nsbfmt
gen byte nsbfmt = .
replace nsbfmt = 0 if nsb_true==1
replace nsbfmt = 1 if nsb_dollar==1
label define fmtl 0 "Categorical" 1 "Dollar", replace
label values nsbfmt fmtl

* pre-MPL constructs (measured before the price list in Study 3) and the full construct set
global PRE   me_ness mine_ness attractiveness
global CONS  me_ness mine_ness attractiveness Status_Quo Action_Regret Inaction_Regret Pay_Ability
global CV    $CONS id_mm inertia
global ALLM  s_att s_id s_sq s_ar s_ir s_inert

tab owncond mplcond
tab grp6 mplcond
tab t3 mplcond
bysort owncond: correlate id_mm inertia     // alignment parameter (+.56 owners / -.53 non-owners)

* --- results file: every estimate, one row each ---
capture postclose RES
postfile RES str4 section str3 cond str14 group str20 outcome str30 contrast double(b se p n1 n2) ///
    using "$RES.dta", replace
* helper: post one row (section cond group outcome contrast b se p n1 n2)
capture program drop prow
program define prow
    args section cond group outcome contrast b se p n1 n2
    post RES ("`section'") ("`cond'") ("`group'") ("`outcome'") ("`contrast'") (`b') (`se') (`p') (`n1') (`n2')
end

****************************************************************************************************
**#【1】 Binary NSB models on the preregistered sample (N = 885), each corner separately  [item 1]
****************************************************************************************************
hdr 1. BINARY NSB MODELS, EACH CORNER SEPARATELY, PREREG SAMPLE
/* Why: the 9/25 response flagged that earlier logits ran on N = 892 (invalid NSB included).
   Every model here runs on the N = 885 sample built in section 0, and every corner is its own
   outcome inside its own endowment condition (Always Keep and Always Sell among owners; Always
   Buy and Never Buy among non-owners). Three specifications per corner:
     (a) id_mm x inertia + range dummy            (pooled over range, range as covariate)
     (b) id_mm x inertia x range                  (does the construct structure differ by range?)
     (c) same as (a), categorical-only outcome    (operational NSB definition)
   Sparse corners (AS, AB, NB) are also fitted with Firth logit.                                   */
foreach y in keepc sellc buyc nobuyc {
    local s = cond(inlist("`y'","keepc","sellc"), 1, 0)
    local cl = cond(`s'==1, "E", "NE")
    quietly count if `y'==1
    local k = r(N)
    quietly count if !missing(`y')
    local n = r(N)
    di _n as result "==== `y' : `k' of `n' (owncond==`s') ===="
    * (a)
    capture noisily logit `y' c.id_mm##c.inertia i.mplcond if owncond==`s'
    if _rc==0 {
        capture noisily margins, dydx(id_mm inertia) post
        if _rc==0 {
            foreach x in id_mm inertia {
                prow "1" "`cl'" "`y'" "`y'" "AME_`x'_a" (_b[`x']) (_se[`x']) (2*normal(-abs(_b[`x']/_se[`x']))) (`k') (`n')
            }
        }
    }
    * (b)
    capture noisily logit `y' c.id_mm##c.inertia##i.mplcond if owncond==`s'
    if _rc==0 {
        capture noisily testparm c.id_mm#i.mplcond c.inertia#i.mplcond c.id_mm#c.inertia#i.mplcond
        if _rc==0 prow "1" "`cl'" "`y'" "`y'" "range_x_constructs_chi2" (r(chi2)) (.) (r(p)) (`k') (`n')
        capture noisily margins mplcond, dydx(id_mm inertia)
    }
    * (c) categorical-only
    quietly count if `y'_cat==1
    local kc = r(N)
    capture noisily logit `y'_cat c.id_mm##c.inertia i.mplcond if owncond==`s'
    if _rc==0 {
        capture noisily margins, dydx(id_mm inertia) post
        if _rc==0 {
            foreach x in id_mm inertia {
                prow "1" "`cl'" "`y'_cat" "`y'_cat" "AME_`x'_a" (_b[`x']) (_se[`x']) (2*normal(-abs(_b[`x']/_se[`x']))) (`kc') (`n')
            }
        }
    }
    * Firth for the sparse corners
    if "`y'"!="keepc" {
        capture noisily firthlogit `y' c.id_mm##c.inertia i.mplcond if owncond==`s'
    }
}

* Whether vs where (memo Pattern B), same sample: identity in the binary corner model vs in the
* switch-point model. Reported side by side so the paper can cite one table.
hdr 1b. WHETHER (corner logit) VS WHERE (switch point among switchers), by endowment
foreach s in 1 0 {
    local cl = cond(`s'==1, "E", "NE")
    local ytop = cond(`s'==1, "keepc", "buyc")
    local ybot = cond(`s'==1, "sellc", "nobuyc")
    di _n as result "---- owncond==`s' : WHETHER ----"
    foreach y in `ytop' `ybot' {
        capture noisily logit `y' c.id_mm c.inertia i.mplcond if owncond==`s'
        if _rc==0 {
            capture noisily margins, dydx(id_mm inertia) post
            if _rc==0 {
                foreach x in id_mm inertia {
                    prow "1b" "`cl'" "`y'" "whether" "AME_`x'" (_b[`x']) (_se[`x']) (2*normal(-abs(_b[`x']/_se[`x']))) (.) (.)
                }
            }
        }
    }
    di _n as result "---- owncond==`s' : WHERE (interval regression, switchers only) ----"
    capture noisily intreg val_lo val_hi c.id_mm c.inertia i.mplcond if owncond==`s' & nsb==0
    if _rc==0 {
        foreach x in id_mm inertia {
            prow "1b" "`cl'" "switchers" "where" "b_`x'" (_b[`x']) (_se[`x']) (2*normal(-abs(_b[`x']/_se[`x']))) (e(N)) (.)
        }
    }
    * standardized position (so the two conditions and ranges are on one scale)
    capture drop zv_tmp
    bysort owncond mplcond: egen double zv_tmp = std(valuation) if nsb==0
    capture noisily regress zv_tmp c.id_mm c.inertia i.mplcond if owncond==`s' & nsb==0, vce(robust)
    if _rc==0 {
        foreach x in id_mm inertia {
            prow "1b" "`cl'" "switchers" "where_z" "b_`x'" (_b[`x']) (_se[`x']) (2*ttail(e(df_r),abs(_b[`x']/_se[`x']))) (e(N)) (.)
        }
    }
    capture drop zv_tmp
}

****************************************************************************************************
**#【2】 Equivalence (TOST) and Bayes factors: categorical NSB by range  [item 2]
****************************************************************************************************
hdr 2. CATEGORICAL NSB BY RANGE: TOST + BAYES FACTORS
/* The claim "categorical NSB does not respond to range" is a null claim. Two complements to the
   chi-square:
   (a) TOST on the average marginal effect of range, with a pre-stated smallest effect of interest
       (SESOI). Overall +/-5 pp (as in the prereg follow-up), owners +/-5 pp, non-owners +/-3 pp
       (their base rate is ~3%, so a 5-pp bound would be vacuous).
   (b) Bayes factor BF01 for "same proportion in both ranges" vs "different proportions", from the
       beta-binomial model with uniform Beta(1,1) priors (analytic; no package needed).
       BF01 > 3 = moderate evidence for no difference; > 10 = strong.
   Done for categorical NSB (nsb_true), table NSB (nsb_table) and dollar NSB (nsb_dollar), overall
   and within endowment, and for each corner separately.                                          */

* ---- (b) helper: BF01 for two binomial proportions, Beta(1,1) priors ----
capture program drop bf01
program define bf01, rclass
    args x1 n1 x2 n2
    * log marginal likelihood under H1 (independent p's) and H0 (common p)
    local lB1 = lngamma(`x1'+1) + lngamma(`n1'-`x1'+1) - lngamma(`n1'+2)
    local lB2 = lngamma(`x2'+1) + lngamma(`n2'-`x2'+1) - lngamma(`n2'+2)
    local lB0 = lngamma(`x1'+`x2'+1) + lngamma(`n1'+`n2'-`x1'-`x2'+1) - lngamma(`n1'+`n2'+2)
    local lbf = `lB0' - (`lB1' + `lB2')
    return scalar bf01 = exp(`lbf')
    di as result "   BF01 (no difference vs difference) = " %7.2f exp(`lbf')
end

foreach y in nsb_true nsb_table nsb_dollar {
    foreach s in 2 1 0 {
        if `s'==2 {
            local cond ""
            local cl "all"
            local sesoi = .05
        }
        else {
            local cond "& owncond==`s'"
            local cl = cond(`s'==1, "E", "NE")
            local sesoi = cond(`s'==1, .05, .03)
        }
        di _n as result "==== `y' by range, `cl' (SESOI = +/-`sesoi') ===="
        capture noisily tab mplcond `y' if 1 `cond', row chi2 exact
        quietly count if mplcond==0 `cond'
        local n0 = r(N)
        quietly count if mplcond==0 & `y'==1 `cond'
        local x0 = r(N)
        quietly count if mplcond==1 `cond'
        local n1 = r(N)
        quietly count if mplcond==1 & `y'==1 `cond'
        local x1 = r(N)
        * (a) TOST on the risk difference (AME of range from a logit; same formulas as Stats Analyses 2)
        capture noisily {
            quietly logit `y' i.mplcond if 1 `cond'
            margins, dydx(mplcond) post
            local d    = _b[1.mplcond]
            local se   = _se[1.mplcond]
            local p_lo = 1 - normal((`d' + `sesoi')/`se')     // H0: effect <= -SESOI
            local p_hi = normal((`d' - `sesoi')/`se')         // H0: effect >= +SESOI
            local ci_l = `d' - invnormal(.95)*`se'
            local ci_h = `d' + invnormal(.95)*`se'
            di as result "   risk difference (wide - normal) = " %6.4f `d' "   SE = " %6.4f `se'
            di as result "   90% CI = [" %6.4f `ci_l' ", " %6.4f `ci_h' "]   (equivalent if inside +/-`sesoi')"
            di as result "   TOST p_lower = " %6.4f `p_lo' "   p_upper = " %6.4f `p_hi' "  -> " ///
                cond(max(`p_lo',`p_hi')<.05, "EQUIVALENT", "NOT equivalent")
            prow "2" "`cl'" "`y'" "riskdiff" "wide-normal" (`d') (`se') (max(`p_lo',`p_hi')) (`n0') (`n1')
        }
        * (b) Bayes factor
        bf01 `x0' `n0' `x1' `n1'
        prow "2" "`cl'" "`y'" "BF01" "x0/n0 vs x1/n1" (r(bf01)) (.) (.) (`x0') (`x1')
    }
}

* each corner separately (categorical definition), with Firth for the small ones
hdr 2b. EACH CORNER BY RANGE (categorical definition)
foreach y in keepc_cat sellc_cat buyc_cat nobuyc_cat {
    local s = cond(inlist("`y'","keepc_cat","sellc_cat"), 1, 0)
    local cl = cond(`s'==1, "E", "NE")
    di _n as result "==== `y' by range ===="
    capture noisily tab mplcond `y' if owncond==`s', row exact
    quietly count if mplcond==0 & owncond==`s'
    local n0 = r(N)
    quietly count if mplcond==0 & owncond==`s' & `y'==1
    local x0 = r(N)
    quietly count if mplcond==1 & owncond==`s'
    local n1 = r(N)
    quietly count if mplcond==1 & owncond==`s' & `y'==1
    local x1 = r(N)
    bf01 `x0' `n0' `x1' `n1'
    prow "2b" "`cl'" "`y'" "BF01" "x0/n0 vs x1/n1" (r(bf01)) (.) (.) (`x0') (`x1')
    capture noisily firthlogit `y' i.mplcond if owncond==`s'
    if _rc==0 prow "2b" "`cl'" "`y'" "firth_logit" "wide-normal (log odds)" (_b[1.mplcond]) (_se[1.mplcond]) (2*normal(-abs(_b[1.mplcond]/_se[1.mplcond]))) (`x0') (`x1')
}

* Bayesian logit as a cross-check (official Stata; skipped silently if it fails)
capture noisily {
    bayes, rseed(20261103) nchains(2) burnin(2500) mcmcsize(5000): logit nsb_true i.mplcond##i.owncond
    bayesstats summary {nsb_true:1.mplcond} {nsb_true:1.mplcond#1.owncond}
}

****************************************************************************************************
**#【3】 Cross-arm prediction of persistent corners from pre-MPL constructs  [item 3]
****************************************************************************************************
hdr 3. CROSS-ARM PREDICTION
/* Logic: if NSB is a trait, a model fitted in one range arm should predict the OTHER arm's
   corner rate on the same price window. If range creates NSB, the normal arm's observed corner
   rate will exceed what a wide-arm model predicts, by about the reclassification share.
   Step A: fit logit(persistent corner) ~ pre-MPL constructs in the WIDE arm (outcome = nsb_wide,
           corner on the $7-216 ladder), for each endowment, top and bottom corner separately.
   Step B: score the NORMAL arm; compare mean predicted probability with the observed nsb_narrow
           rate (corner on the $62-161 ladder) and with the observed categorical rate.
   Step C: reverse (fit in normal on nsb_narrow, score the wide arm; compare with nsb_narrow in
           wide, which is defined on the same $62-161 window, and with nsb_wide).
   Also: AUC of each model in the other arm (discrimination transfers?), and calibration-in-the-
   large as a z-test on observed minus expected counts.
   Primary predictor set = $PRE (me_ness, mine_ness, attractiveness: measured before the MPL).
   Secondary = $CONS (adds status quo, both regrets, ability to pay; measured after the MPL).    */
capture drop xb_* ph_*
foreach set in PRE CONS {
    foreach s in 1 0 {
        local cl = cond(`s'==1, "E", "NE")
        foreach side in top bot {
            * outcome definitions on each ladder, within the side
            if "`side'"=="top" {
                local yw "(nsb_wide==1   & nsb_hi==1)"
                local yn "(nsb_narrow==1 & nsb_hi==1)"
                * in the wide arm, "would be a top corner on $62-161" = switch point at or above $161
                local ynw "(nsb_narrow==1 & (nsb_hi==1 | (nsb==0 & assetAmount>=161)))"
            }
            else {
                local yw "(nsb_wide==1   & nsb_hi==0)"
                local yn "(nsb_narrow==1 & nsb_hi==0)"
                local ynw "(nsb_narrow==1 & (nsb_hi==0 | (nsb==0 & moneyAmount<=62)))"
            }
            capture drop y_w y_n y_nw
            gen byte y_w  = `yw'  if mplcond==1 & owncond==`s'
            gen byte y_n  = `yn'  if mplcond==0 & owncond==`s'
            gen byte y_nw = `ynw' if mplcond==1 & owncond==`s'
            di _n as result "==== set=`set'  owncond==`s'  side=`side' ===="
            tab y_w if mplcond==1 & owncond==`s'
            tab y_n if mplcond==0 & owncond==`s'
            * ---- A: fit in wide, score normal ----
            capture noisily logit y_w $`set' if mplcond==1 & owncond==`s'
            if _rc==0 & e(N)>0 {
                capture drop ph_w2n
                quietly predict double ph_w2n if owncond==`s', pr
                quietly summarize ph_w2n if mplcond==0 & owncond==`s'
                local exp_n = r(mean)
                local nn    = r(N)
                quietly summarize y_n if mplcond==0 & owncond==`s'
                local obs_n = r(mean)
                local O = `obs_n'*`nn'
                local E = `exp_n'*`nn'
                local z = (`O' - `E')/sqrt(`E'*(1-`exp_n'))
                di as result "   wide-fitted model scored on NORMAL arm: expected corner rate = " %6.3f `exp_n' ///
                    "   observed nsb_narrow rate = " %6.3f `obs_n' "   (O-E z = " %5.2f `z' ", p = " %5.3f 2*normal(-abs(`z')) ")"
                prow "3" "`cl'" "`set'_`side'" "wide->normal" "obs-exp rate" (`obs_n'-`exp_n') (sqrt(`exp_n'*(1-`exp_n')/`nn')) (2*normal(-abs(`z'))) (`O') (`E')
                capture noisily roctab y_n ph_w2n if mplcond==0 & owncond==`s'
                if _rc==0 prow "3" "`cl'" "`set'_`side'" "wide->normal" "AUC in normal" (r(area)) (r(se)) (.) (`nn') (.)
                * same model scored on the wide arm's own $62-161 window (the reclassification check)
                quietly summarize ph_w2n if mplcond==1 & owncond==`s'
                local exp_nw = r(mean)
                quietly summarize y_nw if mplcond==1 & owncond==`s'
                di as result "   ... and on the WIDE arm's own $62-161 window: expected = " %6.3f `exp_nw' "   observed = " %6.3f r(mean)
                prow "3" "`cl'" "`set'_`side'" "wide->wide62-161" "obs-exp rate" (r(mean)-`exp_nw') (.) (.) (r(N)) (.)
            }
            * ---- C: fit in normal, score wide ----
            capture noisily logit y_n $`set' if mplcond==0 & owncond==`s'
            if _rc==0 & e(N)>0 {
                capture drop ph_n2w
                quietly predict double ph_n2w if owncond==`s', pr
                quietly summarize ph_n2w if mplcond==1 & owncond==`s'
                local exp_w = r(mean)
                local nw    = r(N)
                quietly summarize y_w if mplcond==1 & owncond==`s'
                local obs_w = r(mean)
                local O = `obs_w'*`nw'
                local E = `exp_w'*`nw'
                local z = (`O' - `E')/sqrt(`E'*(1-`exp_w'))
                di as result "   normal-fitted model scored on WIDE arm: expected corner rate = " %6.3f `exp_w' ///
                    "   observed nsb_wide rate = " %6.3f `obs_w' "   (O-E z = " %5.2f `z' ", p = " %5.3f 2*normal(-abs(`z')) ")"
                prow "3" "`cl'" "`set'_`side'" "normal->wide" "obs-exp rate" (`obs_w'-`exp_w') (sqrt(`exp_w'*(1-`exp_w')/`nw')) (2*normal(-abs(`z'))) (`O') (`E')
                quietly summarize y_nw if mplcond==1 & owncond==`s'
                di as result "   ... observed on the wide arm's $62-161 window = " %6.3f r(mean) "  (expected " %6.3f `exp_w' ")"
                prow "3" "`cl'" "`set'_`side'" "normal->wide62-161" "obs-exp rate" (r(mean)-`exp_w') (.) (.) (r(N)) (.)
                capture noisily roctab y_w ph_n2w if mplcond==1 & owncond==`s'
                if _rc==0 prow "3" "`cl'" "`set'_`side'" "normal->wide" "AUC in wide" (r(area)) (r(se)) (.) (`nw') (.)
            }
        }
    }
}
capture drop y_w y_n y_nw ph_w2n ph_n2w

****************************************************************************************************
**#【4】 Within-corner format analysis: categorical vs dollar, every corner with n >= 15  [item 4]
****************************************************************************************************
hdr 4. CATEGORICAL VS DOLLAR WITHIN EACH CORNER (pre-MPL constructs first, then all)
/* Extends the 10/13 analysis (Always Keep only) to every corner with at least 15 people, in one
   table. Pre-MPL constructs cannot have been shaped by the ladder, so a format difference on
   them is a difference in who chooses "never" vs a number, not a consequence of the ladder.     */
levelsof nsb_type if nsb==1, local(types)
foreach k of local types {
    local t : label (nsb_type) `k'
    local s = cond(inlist(`k',1,2), 1, 0)
    local cl = cond(`s'==1, "E", "NE")
    quietly count if nsb_type==`k'
    local n = r(N)
    quietly count if nsb_type==`k' & nsbfmt==0
    local nc = r(N)
    quietly count if nsb_type==`k' & nsbfmt==1
    local nd = r(N)
    di _n as result "==== nsb_type `k' (`t'): n = `n'  categorical = `nc'  dollar = `nd' ===="
    if `n' < 15 | `nc' < 5 | `nd' < 5 {
        di as text "   skipped (cell too small)"
        continue
    }
    tabstat $CV if nsb_type==`k', by(nsbfmt) stat(n mean sd) format(%6.2f) longstub
    foreach v of global CV {
        capture noisily {
            quietly regress `v' i.nsbfmt if nsb_type==`k', vce(robust)
            local b  = _b[1.nsbfmt]
            local se = _se[1.nsbfmt]
            local p  = 2*ttail(e(df_r), abs(`b'/`se'))
            quietly ranksum `v' if nsb_type==`k', by(nsbfmt)
            local prs = 2*normal(-abs(r(z)))
            di as result "   `v': dollar - categorical = " %6.2f `b' "  (SE " %5.2f `se' ", p = " %5.3f `p' "; rank-sum p = " %5.3f `prs' ")"
            prow "4" "`cl'" "`t'" "`v'" "dollar-categ" (`b') (`se') (`p') (`nc') (`nd')
        }
    }
    capture noisily manova $PRE  = nsbfmt if nsb_type==`k'
    capture noisily manova $CONS = nsbfmt if nsb_type==`k'
    * does the format gap depend on range inside this corner?
    foreach v in id_mm inertia attractiveness {
        capture noisily regress `v' i.nsbfmt##i.mplcond if nsb_type==`k', vce(robust)
    }
}

****************************************************************************************************
**#【5】 Sextile profile figures with bootstrap CIs + corner-step gap table  [item 5]
****************************************************************************************************
hdr 5. PROFILES ALONG THE LADDER WITH 95% BOOTSTRAP CIs
/* Same position variable as Inflection v2 (percentile among switchers within owncond x mplcond,
   sextiles, NSB at the ends). Adds: bootstrap CIs on every point, and a one-table summary of the
   two steps that matter (extreme switchers minus middle; NSB minus extreme switchers).         */
foreach v in rk_c n_c pct_c nsbL nsbR bin8_c {
    capture drop `v'
}
bysort owncond mplcond: egen double rk_c = rank(valuation) if nsb==0
bysort owncond mplcond: egen double n_c  = count(valuation) if nsb==0
gen double pct_c = (rk_c - 0.5)/n_c
gen byte nsbL = (nsb==1 & inlist(nsb_type, 2, 3))
gen byte nsbR = (nsb==1 & inlist(nsb_type, 1, 4))
assert nsbL + nsbR == nsb
label define bin8lbl 0 "0 NSB-L" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7 NSB-R", replace
gen byte bin8_c = floor(pct_c*6) + 1 if nsb==0
replace  bin8_c = 6 if bin8_c==7 & nsb==0
replace  bin8_c = 0 if nsbL==1
replace  bin8_c = 7 if nsbR==1
label values bin8_c bin8lbl
tab bin8_c owncond

* bootstrap means by position (percentile CI), saved to a small dataset per condition, then plotted
forvalues s = 0/1 {
    local tag = cond(`s'==1, "E", "NE")
    local ttl = cond(`s'==1, "Endowed: 0 = Always Sell, 7 = Always Keep", "Non-endowed: 0 = Never Buy, 7 = Always Buy")
    tempfile prof_`tag'
    capture postclose PP
    postfile PP byte bin8 str8 motive double(mean lo hi n) using `prof_`tag'', replace
    foreach m in s_att s_id s_sq s_ar s_ir s_inert {
        forvalues b = 0/7 {
            quietly count if owncond==`s' & bin8_c==`b' & !missing(`m')
            local n = r(N)
            if `n' < 2 continue
            capture noisily {
                quietly bootstrap r(mean), reps(1000) seed(20261103) nowarn nodots: ///
                    summarize `m' if owncond==`s' & bin8_c==`b'
                matrix B = e(b)
                quietly estat bootstrap, percentile
                matrix CI = e(ci_percentile)
                post PP (`b') ("`m'") (B[1,1]) (CI[1,1]) (CI[2,1]) (`n')
            }
        }
    }
    postclose PP
    preserve
        use `prof_`tag'', clear
        sort motive bin8
        list, noobs clean sepby(motive)
        * export the table rows
        quietly count
        forvalues i = 1/`=r(N)' {
            local m  = motive[`i']
            local b  = bin8[`i']
            prow "5" "`tag'" "bin`b'" "`m'" "boot mean [lo,hi]" (mean[`i']) (.) (.) (lo[`i']) (hi[`i'])
        }
        * figure: valuation motives solid, inertia motives dashed, CI caps on every point
        reshape wide mean lo hi n, i(bin8) j(motive) string
        twoway (rcap los_att his_att bin8, lcolor(gs10)) (connected means_att bin8, lwidth(medthick)) ///
               (rcap los_id  his_id  bin8, lcolor(gs10)) (connected means_id  bin8, lwidth(medthick)) ///
               (rcap los_sq  his_sq  bin8, lcolor(gs10)) (connected means_sq  bin8, lpattern(dash)) ///
               (rcap los_ar  his_ar  bin8, lcolor(gs10)) (connected means_ar  bin8, lpattern(dash)) ///
               (rcap los_ir  his_ir  bin8, lcolor(gs10)) (connected means_ir  bin8, lpattern(dash)), ///
               xlabel(0 "NSB-L" 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "NSB-R") ///
               yline(0, lcolor(gs10)) xline(0.5 6.5, lcolor(gs12) lpattern(shortdash)) ///
               legend(order(2 "Attractiveness" 4 "Identity" 6 "Status quo" 8 "Commission regret" 10 "Omission regret") rows(2) size(small)) ///
               ytitle("Mean, SD units within condition") ///
               xtitle("Position: sextiles of switchers within range; NSB at the ends") ///
               title("`ttl'", size(medium)) ///
               note("Solid = valuation motives; dashed = inertia/regret motives. Caps = bootstrap 95% CI (1000 reps).") ///
               name(cprof_`tag', replace)
        graph export "C_profile_`tag'.png", replace width(1800)
    restore
}

* the two steps, as regression contrasts with robust SEs (sextile scheme S1: 1-2 | 3-4 | 5-6)
hdr 5b. STEP SIZES: extreme switchers - middle, and NSB - extreme switchers
capture drop r5
gen byte r5 = cond(bin8_c==0, 1, cond(inlist(bin8_c,1,2), 2, cond(inlist(bin8_c,3,4), 3, cond(inlist(bin8_c,5,6), 4, 5))))
label define r5l 1 "NSB-L" 2 "Switch L-ext" 3 "Middle" 4 "Switch R-ext" 5 "NSB-R", replace
label values r5 r5l
foreach s in 1 0 {
    local cl = cond(`s'==1, "E", "NE")
    foreach m of global ALLM {
        capture noisily {
            quietly regress `m' i.r5 if owncond==`s', vce(robust)
            foreach c in "2 3 Lext-Mid" "1 2 NSBL-Lext" "4 3 Rext-Mid" "5 4 NSBR-Rext" {
                local a : word 1 of `c'
                local b : word 2 of `c'
                local lab : word 3 of `c'
                quietly lincom `a'.r5 - `b'.r5
                quietly count if owncond==`s' & r5==`a'
                local na = r(N)
                quietly count if owncond==`s' & r5==`b'
                local nb = r(N)
                prow "5b" "`cl'" "`m'" "step" "`lab'" (r(estimate)) (r(se)) (r(p)) (`na') (`nb')
            }
        }
    }
    di _n as result "owncond==`s': step table written to results (section 5b)."
}

****************************************************************************************************
**#【6】 Rung-count sensitivity: simulate a 10-rung ladder inside the wide arm  [item 6]
****************************************************************************************************
hdr 6. RUNG-COUNT SIMULATION (wide arm only)
/* The wide ladder has 20 rungs ($7 ... $216, $11 apart); the normal ladder has 10 ($62 ... $161).
   Range (span) and rung count are confounded. Simulation: keep every other rung of the wide ladder
   so it has 10 rungs, $22 apart, and the same $7-216 span. Two versions, because 20 rungs cannot be
   halved symmetrically:
      A: rungs 7, 29, ..., 205  (drops 216 as a rung; top corner = keeps/buys at 205 and beyond)
      B: rungs 18, 40, ..., 216 (drops 7 as a rung; bottom corner = sells/does not buy at 18 and below)
   A switcher's coarse switch interval is the pair of coarse rungs that bracket the fine switch.
   Corner on the coarse ladder = would still not have switched by the last coarse rung.
   If corner rates and the switcher EE gap are essentially unchanged, rung count is not what drove
   the Study 3 range effect. This is a SIMULATION, not a manipulation; say so in the paper.       */
capture drop coarseA coarseB valA valB cornerA cornerB
* fine switch: assetAmount = last rung on the keep/buy side, moneyAmount = first rung on the other side
* (switchers), per the 9/21 note. Corners: nsb_hi==1 top, nsb_hi==0 bottom.
* version A rung set: 7 + 22*j, j = 0..9  -> 7 ... 205
gen byte cornerA = nsb
replace cornerA = 1 if nsb==0 & mplcond==1 & assetAmount>=205          // switched only at 205->216
gen double valA = .
replace valA = valuation if nsb==0 & mplcond==1 & assetAmount<205
* coarse interval midpoint: lower coarse rung <= assetAmount, next coarse rung > assetAmount
replace valA = (7 + 22*floor((assetAmount-7)/22)) + 11 if nsb==0 & mplcond==1 & assetAmount<205
* version B rung set: 18 + 22*j, j = 0..9 -> 18 ... 216
gen byte cornerB = nsb
replace cornerB = 1 if nsb==0 & mplcond==1 & moneyAmount<=18           // switched at 7->18
gen double valB = .
replace valB = (18 + 22*floor((assetAmount-18)/22)) + 11 if nsb==0 & mplcond==1 & moneyAmount>18
label var cornerA "Corner on simulated 10-rung ladder A (7..205)"
label var cornerB "Corner on simulated 10-rung ladder B (18..216)"

di _n as result "Corner rates in the wide arm: actual 20-rung vs simulated 10-rung ladders"
foreach s in 1 0 {
    di _n as result "---- owncond==`s' ----"
    quietly count if mplcond==1 & owncond==`s'
    local n = r(N)
    foreach y in nsb cornerA cornerB nsb_narrow {
        quietly count if mplcond==1 & owncond==`s' & `y'==1
        di as result "   `y': " r(N) " of `n' = " %5.3f r(N)/`n'
        local cl = cond(`s'==1,"E","NE")
        prow "6" "`cl'" "wide arm" "`y'" "corner rate" (r(N)/`n') (.) (.) (r(N)) (`n')
    }
    * the comparison that matters: nsb_narrow (same $62-161 window, 10 rungs) vs cornerA/B (10 rungs, full span)
    capture noisily mcnemar cornerA nsb_narrow if mplcond==1 & owncond==`s'
    capture noisily mcnemar cornerB nsb_narrow if mplcond==1 & owncond==`s'
}
* switcher endowment gap on the actual vs simulated ladders (wide arm)
di _n as result "Switcher endowment gap (wide arm): actual vs simulated 10-rung ladders"
capture noisily regress valuation i.owncond if mplcond==1 & nsb==0, vce(robust)
if _rc==0 prow "6" "all" "wide arm" "EE gap switchers" "actual 20-rung" (_b[1.owncond]) (_se[1.owncond]) (2*ttail(e(df_r),abs(_b[1.owncond]/_se[1.owncond]))) (e(N)) (.)
capture noisily regress valA i.owncond if mplcond==1 & cornerA==0, vce(robust)
if _rc==0 prow "6" "all" "wide arm" "EE gap switchers" "simulated A 10-rung" (_b[1.owncond]) (_se[1.owncond]) (2*ttail(e(df_r),abs(_b[1.owncond]/_se[1.owncond]))) (e(N)) (.)
capture noisily regress valB i.owncond if mplcond==1 & cornerB==0, vce(robust)
if _rc==0 prow "6" "all" "wide arm" "EE gap switchers" "simulated B 10-rung" (_b[1.owncond]) (_se[1.owncond]) (2*ttail(e(df_r),abs(_b[1.owncond]/_se[1.owncond]))) (e(N)) (.)
* and the normal arm for reference (10 rungs, narrow span)
capture noisily regress valuation i.owncond if mplcond==0 & nsb==0, vce(robust)
if _rc==0 prow "6" "all" "normal arm" "EE gap switchers" "actual 10-rung narrow" (_b[1.owncond]) (_se[1.owncond]) (2*ttail(e(df_r),abs(_b[1.owncond]/_se[1.owncond]))) (e(N)) (.)

****************************************************************************************************
**#【7】 Switcher endowment effect: raw vs within-range standardized gap  [item 7]
****************************************************************************************************
hdr 7. SWITCHER ENDOWMENT GAP: RAW ($) AND STANDARDIZED (SD within range)
* raw, interval regression with the correct bounds
capture noisily intreg val_lo val_hi i.owncond##i.mplcond if nsb==0
if _rc==0 {
    capture noisily margins mplcond, dydx(owncond)
    capture noisily lincom 1.owncond + 1.owncond#1.mplcond
    prow "7" "all" "switchers" "EE gap $" "normal" (_b[1.owncond]) (_se[1.owncond]) (2*normal(-abs(_b[1.owncond]/_se[1.owncond]))) (e(N)) (.)
    prow "7" "all" "switchers" "EE gap $" "wide - normal (interaction)" (_b[1.owncond#1.mplcond]) (_se[1.owncond#1.mplcond]) (2*normal(-abs(_b[1.owncond#1.mplcond]/_se[1.owncond#1.mplcond]))) (e(N)) (.)
}
* standardized within range (switchers), both endowment groups pooled within range for the SD
capture drop zval_r
bysort mplcond: egen double zval_r = std(valuation) if nsb==0
capture noisily regress zval_r i.owncond##i.mplcond if nsb==0, vce(robust)
if _rc==0 {
    capture noisily margins mplcond, dydx(owncond)
    prow "7" "all" "switchers" "EE gap SD" "normal" (_b[1.owncond]) (_se[1.owncond]) (2*ttail(e(df_r),abs(_b[1.owncond]/_se[1.owncond]))) (e(N)) (.)
    prow "7" "all" "switchers" "EE gap SD" "wide - normal (interaction)" (_b[1.owncond#1.mplcond]) (_se[1.owncond#1.mplcond]) (2*ttail(e(df_r),abs(_b[1.owncond#1.mplcond]/_se[1.owncond#1.mplcond]))) (e(N)) (.)
}
* Cohen's d within each range (switchers)
foreach r in 0 1 {
    capture noisily esize twosample valuation if nsb==0 & mplcond==`r', by(owncond) cohensd
    if _rc==0 prow "7" "all" "switchers" "Cohen d" "mplcond=`r'" (r(d)) (.) (.) (r(N_1)) (r(N_2))
}
* spread: variance ratio by range, within endowment (switchers)
foreach s in 1 0 {
    capture noisily sdtest valuation if nsb==0 & owncond==`s', by(mplcond)
}
capture drop zval_r

****************************************************************************************************
**#【8】 Always Buy censoring reconciliation  [item 8]
****************************************************************************************************
hdr 8. ALWAYS BUY: CENSORED BUYERS OR NEVER-SWITCHERS?
/* Normal-arm non-owner Always Buy who typed an amount: where does their stated maximum sit relative
   to the rungs the wide ladder added ($172-216)? Predicted survivors on the wide ladder = share
   with a stated amount above $216. Compare with the wide arm's observed Always Buy rate, and
   compare the normal-arm stated amounts (within $162-216) with the wide arm's switch points above
   $161 (same support).                                                                            */
quietly count if owncond==0 & mplcond==0
local nNE0 = r(N)
quietly count if owncond==0 & mplcond==1
local nNE1 = r(N)
di _n as result "Normal-arm non-owner Always Buy with a typed amount:"
capture noisily summarize fu_amount if owncond==0 & mplcond==0 & nsb_type==4 & nsb_dollar==1 & fu_amount_ok==1, detail
capture noisily tab fu_amount if owncond==0 & mplcond==0 & nsb_type==4 & nsb_dollar==1 & fu_amount_ok==1
quietly count if owncond==0 & mplcond==0 & nsb_type==4 & nsb_dollar==1 & fu_amount_ok==1
local nAB = r(N)
quietly count if owncond==0 & mplcond==0 & nsb_type==4 & nsb_dollar==1 & fu_amount_ok==1 & fu_amount>216
local nAbove = r(N)
quietly count if owncond==0 & mplcond==0 & nsb_type==4 & nsb_dollar==1 & fu_amount_ok==1 & inrange(fu_amount,162,216)
local nIn = r(N)
quietly count if owncond==0 & mplcond==0 & nsb_type==4 & nsb_true==1
local nABcat = r(N)
di as result "   typed amount: `nAB'   of which within $162-216: `nIn'   above $216: `nAbove'   categorical AB: `nABcat'"
local pred_surv = (`nAbove' + `nABcat')/`nNE0'
quietly count if owncond==0 & mplcond==1 & nsb_type==4
local obsAB1 = r(N)
di as result "   predicted wide-ladder Always Buy rate (typed > $216 plus categorical) = " %6.3f `pred_surv' ///
    "   observed = " %6.3f `obsAB1'/`nNE1' " (`obsAB1' of `nNE1')"
prow "8" "NE" "Always Buy" "survivor rate" "predicted" (`pred_surv') (.) (.) (`nAbove'+`nABcat') (`nNE0')
prow "8" "NE" "Always Buy" "survivor rate" "observed wide" (`obsAB1'/`nNE1') (.) (.) (`obsAB1') (`nNE1')
capture noisily prtesti `nNE0' `pred_surv' `nNE1' `=`obsAB1'/`nNE1''
* share of normal-arm non-owners who would land on the added rungs vs wide non-owners who did
local pIn = `nIn'/`nNE0'
quietly count if owncond==0 & mplcond==1 & nsb==0 & assetAmount>=161
local nSwAbove = r(N)
di as result "   normal arm: typed max within $162-216 = " %6.3f `pIn' "   wide arm: switched above $161 = " %6.3f `nSwAbove'/`nNE1'
prow "8" "NE" "Always Buy" "added-rung share" "normal typed 162-216" (`pIn') (.) (.) (`nIn') (`nNE0')
prow "8" "NE" "Always Buy" "added-rung share" "wide switched >161" (`nSwAbove'/`nNE1') (.) (.) (`nSwAbove') (`nNE1')
capture noisily prtesti `nNE0' `pIn' `nNE1' `=`nSwAbove'/`nNE1''
* distribution comparison on the common support $162-216
capture drop cmp_amt cmp_grp
gen double cmp_amt = .
gen byte   cmp_grp = .
replace cmp_amt = fu_amount if owncond==0 & mplcond==0 & nsb_type==4 & nsb_dollar==1 & fu_amount_ok==1 & inrange(fu_amount,162,216)
replace cmp_grp = 0 if !missing(cmp_amt)
replace cmp_amt = valuation if owncond==0 & mplcond==1 & nsb==0 & assetAmount>=161
replace cmp_grp = 1 if owncond==0 & mplcond==1 & nsb==0 & assetAmount>=161
label define cmpl 0 "Normal: typed max 162-216" 1 "Wide: switch midpoint >161", replace
label values cmp_grp cmpl
capture noisily tabstat cmp_amt, by(cmp_grp) stat(n p50 mean sd min max) format(%7.1f)
capture noisily ranksum cmp_amt, by(cmp_grp)
capture noisily ksmirnov cmp_amt, by(cmp_grp)
* do the wide-arm survivors look like the normal-arm censored buyers on constructs? (descriptive)
capture noisily tabstat $CV if owncond==0 & nsb_type==4, by(mplcond) stat(n mean sd) format(%6.2f) longstub
capture noisily tabstat $CV if owncond==0 & ((mplcond==0 & nsb_type==4) | (mplcond==1 & nsb==0 & assetAmount>=161)), ///
    by(mplcond) stat(n mean sd) format(%6.2f) longstub
capture drop cmp_amt cmp_grp

****************************************************************************************************
**#【9】 Order / position check (descriptive)  [item 9]
****************************************************************************************************
hdr 9. ORDER CHECK (no randomization of option side or price direction: descriptive only)
/* Nothing here can test an order effect, because order was constant. What CAN be reported:
   (a) the hazard of switching at each rung (a spike at the first or last rung would suggest a
       position artifact), by range and endowment;
   (b) monotonicity failures were already excluded (mpl_pass).
   Report (a) and state the limitation in the paper.                                              */
foreach s in 1 0 {
    foreach r in 0 1 {
        local first = cond(`r'==1, 7, 62)
        local last  = cond(`r'==1, 216, 161)
        di _n as result "---- owncond==`s' mplcond==`r' : switch hazard by rung (switchers + top corner at risk) ----"
        quietly count if owncond==`s' & mplcond==`r'
        local risk = r(N)
        * bottom corner = "switched" before the first rung
        quietly count if owncond==`s' & mplcond==`r' & nsb==1 & nsb_hi==0
        di as text "   below $`first' (bottom corner): " r(N) " of `risk'"
        local risk = `risk' - r(N)
        forvalues p = `first'(11)`last' {
            quietly count if owncond==`s' & mplcond==`r' & nsb==0 & moneyAmount==`p'
            local sw = r(N)
            if `risk'>0 di as text "   rung $`p': switched `sw' of `risk' at risk -> hazard " %5.3f `sw'/`risk'
            local risk = `risk' - `sw'
        }
        quietly count if owncond==`s' & mplcond==`r' & nsb==1 & nsb_hi==1
        di as text "   top corner (never switched): " r(N)
    }
}

****************************************************************************************************
**#【10】 Latent class on the three-way response among non-owners  [item 10]
****************************************************************************************************
hdr 10. LATENT CLASSES FROM CONSTRUCTS ONLY, NON-OWNERS: do the data recover Never Buy vs Always Buy?
/* Same gsem lclass approach as Stats Analyses 2, section 7k, but restricted to non-owners and
   cross-tabulated with the three-way response (switcher / Never Buy / Always Buy). A two- or
   three-class solution in which one class is "low identity + high status quo" and another is
   "high identity + low status quo" recovers the two non-owner processes without imposing them.  */
capture drop nb3
gen byte nb3 = .
replace nb3 = 0 if owncond==0 & nsb==0
replace nb3 = 1 if owncond==0 & nsb_type==3         // Never Buy
replace nb3 = 2 if owncond==0 & nsb_type==4         // Always Buy
label define nb3 0 "Switcher" 1 "Never Buy" 2 "Always Buy", replace
label values nb3 nb3
capture noisily {
    local LCV me_ness mine_ness attractiveness Status_Quo Action_Regret Inaction_Regret
    forvalues k = 2/4 {
        quietly capture gsem (`LCV' <- _cons) if owncond==0, lclass(C `k') emopts(iterate(200)) iterate(500) nonrtolerance
        if _rc==0 {
            estimates store lcNE`k'
            di as result "classes = `k'  BIC follows"
        }
    }
    capture noisily estimates stats lcNE2 lcNE3 lcNE4
    * pick the lowest-BIC k that estimated
    local best = .
    local bestbic = .
    forvalues k = 2/4 {
        capture estimates restore lcNE`k'
        if _rc==0 {
            quietly estat ic
            matrix S = r(S)
            local bic = S[1,6]
            if missing(`bestbic') | `bic' < `bestbic' {
                local bestbic = `bic'
                local best = `k'
            }
        }
    }
    di as result "BIC-selected number of classes among non-owners = `best'"
    estimates restore lcNE`best'
    estat lcprob
    estat lcmean
    capture drop post* maxpost lclass _ent
    predict post*, classposteriorpr
    egen double maxpost = rowmax(post*)
    gen byte lclass = .
    forvalues j = 1/`best' {
        replace lclass = `j' if post`j'==maxpost
    }
    gen double _ent = 0
    forvalues j = 1/`best' {
        replace _ent = _ent - post`j'*ln(post`j') if post`j'>0
    }
    quietly summarize _ent if owncond==0
    di as result "Relative entropy = " %5.3f 1 - r(sum)/(r(N)*ln(`best'))
    tab lclass nb3 if owncond==0, col chi2
    tab lclass nb3 if owncond==0 & mplcond==0, col
    tab lclass nb3 if owncond==0 & mplcond==1, col
    tabstat `LCV' id_mm inertia if owncond==0, by(lclass) stat(n mean) format(%6.2f) longstub
}

****************************************************************************************************
**#【11】 Export results
****************************************************************************************************
hdr 11. EXPORT
postclose RES
preserve
    use "$RES.dta", clear
    gen str3 sig = cond(p<.001, "***", cond(p<.01, "**", cond(p<.05, "*", cond(p<.10, "+", ""))))
    replace sig = "" if missing(p)
    order section cond group outcome contrast b se p sig n1 n2
    save "$RES.dta", replace
    export excel using "$RES.xlsx", sheet("all_long") replace firstrow(variables)
    levelsof section, local(secs)
    foreach sct of local secs {
        export excel using "$RES.xlsx" if section=="`sct'", sheet("sec_`sct'") sheetreplace firstrow(variables)
    }
    di as result "Results written to $RES.dta and $RES.xlsx"
restore

di _n as result "Done. Log: EE_Study3_Completion_20261103.log   Figures: C_profile_E.png, C_profile_NE.png"
log close
