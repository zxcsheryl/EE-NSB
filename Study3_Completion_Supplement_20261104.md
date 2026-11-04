# Supplement to the Study 3 completion memo: reading plan, statistics primer, and writing feedback

Prepared 2026-11-04 for Sheryl Zhang. This file adds to, and does not repeat, "Study3_Completion_Results_Interpretation_20261103". Three parts:

- Part A. A starred, ordered reading plan for the theoretical-contribution section, with what to extract from each paper.
- Part B. A primer on every statistical test in the completion do-file: purpose, what it buys this study, which code block runs it, how to read the output, and what benchmark to judge it against. Numbers from your own log are used as the worked examples.
- Part C. Publication-level writing guidance for Study 3 and the rest of the manuscript, including an audit of Rich's nine comments on Draft 1 against Draft 2.

---

## Part A. Reading plan with stars

Three stars = read in full before writing the General Discussion. Two stars = read the sections named. One star = skim for the one thing listed, cite it. The order within each tier is the order to read them. After each entry: the question to answer while reading, and the paragraph of the paper it feeds.

### Tier 1 (★★★): the five papers the theoretical contribution is built on

1. **Gal, Calder & Sternthal (2026), JCP.** Question: what are the explicit criteria by which they call Gal's omission–commission account a "framework" rather than a "theory of the effect," and which of those criteria does the two-force model already meet? Feeds: the strategy paragraph in the introduction; the first paragraph of "Theoretical contribution."
2. **Gal (2006), JDM.** Question: how exactly does Gal get WTA and WTP out of the fuzzy indifference range plus inertia, and what in that derivation implies that a non-trader is indifferent? Feeds: the "two routes to non-trading" paragraph, where you show that your categorical never-switchers are the opposite of indifferent.
3. **Gal (2021), Current Opinion in Psychology.** Question: what does Gal say the practical levers are (reframing omission as commission, sunset provisions), and what does each predict for a person who says "I would never sell"? Feeds: the Study 4 rationale and the discriminating prediction.
4. **Morewedge & Giblin (2015), TICS.** Question: where in their map does an account that uses identity and inertia together sit, and which of their listed accounts predict a categorical corner? Feeds: the rival-frameworks paragraph. Use their Figure 1 as the model for your own framework figure.
5. **Anderson (2003), Psychological Bulletin.** Question: how does he define decision avoidance, and what distinguishes status quo bias, omission bias, inaction inertia, and deferral? Feeds: the paragraph that places never-switching among structurally similar phenomena (Gal 2026's guideline 3).

### Tier 2 (★★): read the named sections

6. **Weaver & Frederick (2012), JMR.** Read the theory section and Study 1. Question: how would a reference-price account explain the hazard spike at $117 and the larger gap on the wider ladder? Feeds: a footnote in Study 3 results and one sentence in rivals.
7. **Tetlock (2003), TICS**, and **Baron & Spranca (1997), OBHDP**, sections on measurement. Question: what do "sacred" and "protected" values look like operationally, and is "I would never sell at any price" one of their markers? Feeds: the committed-refusal route; the Study 4 measure.
8. **Plott & Zeiler (2005), AER**, introduction and discussion. Question: what would they say a never-switcher is (a misconception, a procedural artifact)? Feeds: the paragraph that pre-empts the "it's noise" objection, using categorical invariance, pre-MPL prediction, and cross-arm calibration.
9. **Andersen, Harrison, Lau & Rutström (2006), Experimental Economics**, sections on frame and range effects. Question: what range manipulation did they run and what moved? Feeds: the measurement paragraph; the sentence that says your design holds the midpoint fixed and theirs did not.
10. **Kriström (1997), AJAE**, the model section only. Question: how does the spike model treat a mass of "would not pay at any price"? Feeds: one paragraph in measurement implications, where you note that contingent valuation already has a formal treatment of your phenomenon and consumer research does not.
11. **Chatterjee, Irmak & Rose (2013), JCR.** Question: how do they connect identity to the endowment effect, and do they distinguish me from mine? Feeds: the me-ness paragraph in the theory section (see Rich's comment C1 in Part C).
12. **Carmon & Ariely (2000), JCR.** Question: what do buyers and sellers each focus on, and does that give you a reason the two forces oppose for non-owners? Feeds: the alignment principle paragraph.

### Tier 3 (★): one thing each

13. Samuelson & Zeckhauser (1988): the definition of status quo bias, for the first sentence of the inertia paragraph.
14. Ritov & Baron (1992): the finding that omissions are judged less harshly than commissions, for the regret asymmetry.
15. Gilovich & Medvec (1995): short-run regret of action exceeds regret of inaction, for the same paragraph.
16. Tykocinski & Pittman (1998): inaction inertia as a structurally similar paradigm, one sentence.
17. Morewedge, Shu, Gilbert & Wilson (2009): ownership, not loss aversion, one sentence in rivals.
18. Novemsky & Kahneman (2005): loss aversion's boundaries, one sentence.
19. Carter & Gilovich (2012): experiences are closer to the self than possessions, for why experiential goods produce more never-switching.
20. Van Boven & Gilovich (2003): same point, earlier source.
21. Belk (1988); Pierce, Kostova & Dirks (2003): already cited; keep.
22. Horowitz & McConnell (2002); Tunçel & Hammitt (2014): the WTA/WTP ratio is larger for non-market goods, one sentence on goods choice.
23. Isoni, Loomes & Sugden (2011): the gap survives Plott–Zeiler procedures for lotteries, one sentence.
24. Parducci (1965); Mazar, Kőszegi & Ariely (2014): range dependence of valuations, one sentence in the measurement paragraph.
25. Simonson & Drolet (2004): anchoring affects WTA and WTP differently, for the reference-price footnote.
26. Fischer, Carmon, Ariely & Zauberman (1999): task-contingent construction of WTP/WTA, one sentence.
27. Gal & Rucker (2018), JCP: the loss-of-loss-aversion argument, one sentence in rivals.
28. Johnson, Häubl & Keinan (2007): query order, one sentence on why pre-MPL constructs predict corners.
29. Ericson & Fuster (2014): the economics review, breadth citation.
30. Dommer & Swaminathan (2013): social identity and ownership, one sentence.

If you read only Tier 1 and items 6 to 8, you can write the discussion.

---

## Part B. Statistics primer for the completion do-file

Each entry has the same five parts: purpose; what it does for this study; the code block; how to read the output; benchmark. "Code block" refers to the section numbers in "EE Study 3 - Stats Analyses 3 Completion.do." Examples quote your log.

### B1. Logistic regression (logit) and average marginal effects (margins, dydx)

**Purpose.** A regression for a binary outcome (never-switch or not). OLS on a 0/1 outcome can predict probabilities below 0 or above 1 and has non-constant error variance; logit models the log-odds of the outcome instead, which keeps predictions between 0 and 1.

**What it does here.** Every corner (Always Keep, Always Sell, Always Buy, Never Buy) is a 0/1 outcome. The logit tells you whether identity and inertia raise or lower the odds of landing in that corner.

**Code.** Section 1: `logit keepc c.id_mm##c.inertia i.mplcond if owncond==1`, then `margins, dydx(id_mm inertia)`. The `c.` prefix declares a continuous predictor; `##` enters both main effects and the product; `i.mplcond` enters range as a dummy.

**Reading the output.** The coefficient table reports log-odds. A coefficient of 2.22 on inertia means one SD more inertia multiplies the odds of Always Keep by exp(2.22) ≈ 9.2. Log-odds are hard to interpret, so the file converts them with `margins, dydx()`, which reports the average marginal effect (AME): the average change in the probability of the outcome per one-unit change in the predictor. Your log: inertia AME for Always Keep = .270, meaning one SD of inertia raises the probability of Always Keep by 27 percentage points on average; identity AME = .036, p = .19.

**Benchmark.** Report the AME, its 95% CI, and p. For "is it large," compare the AME with the base rate: Always Keep occurs in 20.7% of owners, so a 27-point AME per SD is a very large effect. Pseudo-R² (0.31 here) is not comparable to OLS R²; above 0.2 is considered strong for a logit. LR χ² tests the whole model against an intercept-only model.

### B2. Interaction terms and testparm

**Purpose.** An interaction term tests whether the effect of one predictor depends on the level of another. `testparm` tests several coefficients jointly.

**What it does here.** `c.id_mm#c.inertia` tests the conjunctive structure (does identity matter more when inertia is high?). `testparm` of the three range-by-construct terms tests whether the construct structure of a corner differs between ladders.

**Code.** Section 1, model (b): `logit keepc c.id_mm##c.inertia##i.mplcond`, then `testparm c.id_mm#i.mplcond c.inertia#i.mplcond c.id_mm#c.inertia#i.mplcond`.

**Reading the output.** The testparm line gives χ²(3) and p. Your log: Always Keep χ² = 3.56, p = .31; Always Sell p = .77; Always Buy p = .63; Never Buy p = .40. A non-significant joint test means you cannot reject "same construct structure in both ranges."

**Benchmark.** p > .10 on the joint test, and comparable AMEs within each range from `margins mplcond, dydx()`. Note the asymmetry: a non-significant interaction is weak evidence of "no difference" unless the sample is large; here the by-range AMEs are close, which is the better support.

### B3. Firth logit (firthlogit)

**Purpose.** Ordinary logit is biased and can fail to converge when the outcome is rare (fewer than about 10 events per predictor). Firth's penalized likelihood shrinks the coefficients toward zero and always produces finite estimates.

**What it does here.** Always Sell has 6 events, Never Buy 13, Always Buy 26. With four predictors, ordinary logit is unreliable for the first two. Firth gives usable estimates.

**Code.** Section 1 (end of each corner loop, except Always Keep) and section 2b: `firthlogit sellc c.id_mm##c.inertia i.mplcond if owncond==1`.

**Reading the output.** Same layout as logit. Compare the Firth coefficient with the ordinary one: if the ordinary estimate is much larger in magnitude, the ordinary model was overfitting. Your log: Always Buy identity-by-inertia interaction is −.57 (p = .16) in logit and −.71 (p = .028) in Firth; Never Buy inertia 3.26 (logit) vs 2.71 (Firth). The Firth estimates are the ones to report for those corners.

**Benchmark.** Report Firth for any corner with fewer than about 40 events when the model has four terms. Do not report AMEs from Firth (margins is not available after it); report log-odds or odds ratios.

### B4. Interval regression (intreg)

**Purpose.** A regression for an outcome that is observed only as an interval. A switcher who keeps at $150 and sells at $161 has a value somewhere in [150, 161]; a corner has a value above $161 (or $216) with no upper bound. Interval regression uses the full interval instead of a made-up midpoint, and handles the open-ended corners as censored.

**What it does here.** The switch-point model in section 1b and the endowment gap in section 7 use `val_lo` and `val_hi` so that corners contribute as "above 161" rather than as an arbitrary $162.

**Code.** `intreg val_lo val_hi i.owncond##i.mplcond if nsb==0` (section 7) and `intreg val_lo val_hi c.id_mm c.inertia i.mplcond if owncond==1 & nsb==0` (section 1b).

**Reading the output.** Coefficients are in dollars, like OLS. Your log: inertia +$17.6 per SD for owners (p < .001), −$24.3 for non-owners; identity ns in both. In section 7, the endowment gap is $6.8 (p = .054) in the normal range and $27.6 in the wide, interaction $20.8 (p < .001). The `lincom 1.owncond + 1.owncond#1.mplcond` line adds the main effect and the interaction to give the wide-range gap directly.

**Benchmark.** Same as OLS for coefficient size and p. The log-likelihood and LR χ² are for model comparison only. Report "interval regression" in the method note, with the bounds used for corners.

### B5. TOST (two one-sided tests) for equivalence

**Purpose.** An ordinary test asks "is the difference zero?" and a non-significant result only means "we could not tell." TOST asks the opposite question: "is the difference small enough to ignore?" You first state the smallest effect size of interest (SESOI), say ±5 percentage points. Then you run two one-sided tests: (i) is the difference greater than −5? (ii) is the difference less than +5? If both reject, the difference is inside the band and the two groups are equivalent for practical purposes.

**What it does here.** The claim "categorical never-switching does not respond to range" is a null claim. TOST turns it into a positive claim with a stated tolerance.

**Code.** Section 2: logit of the outcome on range, `margins, dydx(mplcond) post` to get the risk difference and its SE, then the two p-values computed from the normal distribution, and the 90% confidence interval. (A 90% CI is used because each one-sided test is at 5%.)

**Reading the output.** Three lines per test: the risk difference and SE; the 90% CI; the two p-values and the verdict. Your log, categorical NSB overall: difference +0.4 pp, 90% CI [−2.4, +3.2], p_lower = .0007, p_upper = .003, EQUIVALENT within ±5 pp. Owners: 90% CI [−3.5, +5.8], p_upper = .089, NOT equivalent at ±5 (the interval pokes above +5). Non-owners at ±3 pp: CI [−3.0, +2.7], equivalent (p = .048 and .033, barely).

**Benchmark.** Equivalent if both p < .05, which is the same as the 90% CI lying entirely inside [−SESOI, +SESOI]. Choose the SESOI before looking at the data and justify it (here: 5 points is a quarter of the owners' base rate of 20%; 3 points is about the non-owners' base rate). Report the CI, not only the verdict. A failed TOST with a CI that extends on the "wrong" side (owners: slightly more categorical NSB in the wide range) is not evidence for the artifact.

### B6. Bayes factor for two proportions (the bf01 program)

**Purpose.** A Bayes factor compares how well two hypotheses predict the data. BF01 is the ratio of the probability of the data under H0 (same proportion in both groups) to its probability under H1 (different proportions). BF01 = 20 means the data are 20 times more likely under "no difference." Unlike a p-value, it can give positive evidence for a null.

**What it does here.** It is the strongest form of the range-invariance claim, and it works with small counts, where TOST has little power.

**Code.** Section 2, program `bf01 x1 n1 x2 n2`. It uses the beta-binomial model with flat Beta(1,1) priors on the proportions and computes the two marginal likelihoods in closed form with log-gamma functions. No package needed.

**Reading the output.** One number per comparison. Your log: categorical NSB overall BF01 = 22.9; owners 12.9; non-owners 23.0; Always Keep 14.4; Always Sell 35.4; Always Buy 6.1; Never Buy 13.8. Table NSB overall 2.3; table NSB non-owners 0.15; dollar NSB non-owners 0.02.

**Benchmark.** Conventional labels (Jeffreys): 1 to 3 anecdotal, 3 to 10 moderate, 10 to 30 strong, above 30 very strong evidence for H0; the reciprocals apply for H1 (BF01 = 0.02 means BF10 = 50, very strong evidence for a difference). The flat prior is a reasonable default for a proportion; say in a footnote that results were similar with a Jeffreys Beta(0.5, 0.5) prior if you want to show robustness (change the two "1"s in the formula to 0.5).

### B7. Bayesian logit (bayes: logit)

**Purpose.** The same model as B1 but estimated by Markov chain Monte Carlo, giving a posterior distribution for each coefficient instead of a point estimate and p-value.

**What it does here.** A cross-check on B6 using a different route: the posterior for the range effect on categorical NSB.

**Code.** Section 2, `bayes, rseed() nchains(2) burnin(2500) mcmcsize(5000): logit nsb_true i.mplcond##i.owncond`, then `bayesstats summary`.

**Reading the output.** Posterior mean, SD, and the 95% equal-tailed credible interval. Your log: range effect −0.04 log-odds, 95% CrI [−1.22, +1.03]; range-by-endowment +0.16 [−1.01, +1.43]. A credible interval that straddles zero by a wide margin and is centered near zero is what "no effect" looks like.

**Benchmark.** MCSE (Monte Carlo standard error) should be small relative to the posterior SD (here .02 vs .56, fine). With two chains, Stata reports a convergence diagnostic (Rc); values below 1.1 are acceptable. Report the posterior mean and CrI.

### B8. Cross-arm prediction: calibration, O−E z-test, and AUC (roctab)

**Purpose.** A model fitted on one sample is used to predict outcomes in another. Two questions: calibration (does the predicted rate match the observed rate?) and discrimination (does the model rank the people who have the outcome above those who do not?).

**What it does here.** If never-switching is a stable state, a model of Always Keep from pre-MPL constructs fitted on the wide ladder should predict the normal ladder's Always Keep rate. If range creates corners, the observed normal rate will exceed the prediction.

**Code.** Section 3. For each endowment and side: fit `logit y_w $PRE if mplcond==1`, then `predict ph_w2n, pr` over both arms, then compare the mean of `ph_w2n` in the normal arm (expected rate) with the mean of the observed outcome. The z-test is (O − E)/sqrt(E(1−p)), the standard test of an observed count against an expected count. `roctab y_n ph_w2n` gives the AUC.

**Reading the output.** Three numbers: expected rate, observed rate, z and p; then the AUC with its CI. Your log, owners Always Keep: expected .189, observed .212, z = .88, p = .38; AUC .73 [.65, .81]. Non-owners Always Buy: expected .024, observed .105, z = 7.6, p < .001, i.e., the normal ladder has four times the corners the constructs predict. Never Buy: expected .044, observed .029, p = .28; AUC .85.

**Benchmark.** Calibration: p > .10 on the O−E test and a ratio of observed to expected between about 0.8 and 1.2. Discrimination: AUC .5 is chance, .7 acceptable, .8 good, .9 excellent. AUCs with very wide CIs (owners' Always Sell, 3 events) are uninformative; say so.

### B9. MANOVA

**Purpose.** A test of whether group means differ on several outcomes at once. It controls the error rate across the set of outcomes and picks up a pattern that no single outcome shows significantly.

**What it does here.** Section 4 tests whether dollar-format and categorical-format Always Keep differ on the three pre-MPL constructs jointly, and on all seven.

**Code.** `manova $PRE = nsbfmt if nsb_type==1`.

**Reading the output.** Four statistics are printed (Wilks' lambda, Pillai's trace, Lawley–Hotelling, Roy's largest root); with two groups they give the same F. Read the Wilks' lambda row: F and p. Your log: pre-MPL set F(3, 90) = 3.83, p = .013; all seven F(7, 86) = 3.66, p = .002. Wilks' lambda itself (0.89 and 0.77) is the proportion of variance not explained by group; 1 − lambda is a rough effect size.

**Benchmark.** p < .05 on Wilks; then look at the univariate tests (the per-construct regressions in the same section) to see which constructs carry it.

### B10. Wilcoxon rank-sum (ranksum) and Kolmogorov–Smirnov (ksmirnov)

**Purpose.** Non-parametric two-group tests. Rank-sum asks whether one group tends to have higher values than the other, without assuming normality. KS asks whether the two distributions differ anywhere in their shape.

**What it does here.** Rank-sum backs up each t-test in section 4 (small groups, skewed constructs). In section 8 both tests compare typed maxima from the normal arm with switch midpoints from the wide arm on the common $162–216 support.

**Code.** `ranksum attractiveness if nsb_type==1, by(nsbfmt)`; `ksmirnov cmp_amt, by(cmp_grp)`.

**Reading the output.** Rank-sum prints z and two-sided p; agreement with the t-test p is reassuring (attractiveness: t p = .001, rank-sum p = .001). KS prints the largest distance between the two cumulative distributions (D) and a p-value; your log: D = .595, p = .012, meaning the two distributions sit in different places (typed maxima higher).

**Benchmark.** p < .05. Report rank-sum alongside t-tests when a cell has fewer than about 30 people or the construct is skewed.

### B11. Bootstrap confidence intervals

**Purpose.** A CI computed by resampling: draw the same number of people with replacement from the group, compute the mean, repeat 1,000 times, and take the 2.5th and 97.5th percentiles of the 1,000 means. It needs no normality assumption and is appropriate for small groups like the 6-person Always Sell corner.

**What it does here.** The profile figures (section 5) show a CI cap on every point so a reader can see which corner means are separated from the adjacent sextile.

**Code.** `bootstrap r(mean), reps(1000) seed(20261103): summarize s_id if owncond==1 & bin8_c==7`, then `estat bootstrap, percentile`.

**Reading the output.** The point estimate and the percentile CI. Your log: owners' Always Keep identity .60 [.47, .73]; sextile 6 −.01 [−.24, .22]. The intervals do not overlap, which is a conservative indication of a difference (non-overlap of 95% CIs corresponds to p well below .05; overlap does not necessarily mean no difference, which is why section 5b also tests the steps directly).

**Benchmark.** Use the percentile CI (not the normal-based one) for small groups. Fix the seed so the figure is reproducible.

### B12. McNemar's test (mcc)

**Purpose.** A test for paired binary outcomes: the same people classified two ways. It asks whether the number who are "yes" under the first classification and "no" under the second differs from the reverse.

**What it does here.** Section 6 compares, for the same wide-arm participants, "corner on the simulated 10-rung full-span ladder" with "corner on the $62–161 window." If rung count mattered, the two classifications would disagree in both directions; if span mattered, almost all disagreements go one way.

**Code.** `mcc cornerA nsb_narrow if mplcond==1 & owncond==1`.

**Reading the output.** A 2×2 table of agreements and disagreements and a χ² with exact p. Your log: owners χ²(1) = 55, p < .001, with all 55 discordant cases being "corner on the window, not on the full span." That is a one-directional disagreement, which is the span signature.

**Benchmark.** p < .05 tells you the two classifications differ; the direction of the discordant cells tells you which way.

### B13. Cohen's d (esize) and the variance-ratio test (sdtest)

**Purpose.** Cohen's d is the difference between two means divided by the pooled SD, so effects can be compared across scales and studies. The variance-ratio F-test asks whether two groups have different spread.

**What it does here.** Section 7: d for the endowment gap within each range (0.35 normal, 0.65 wide). sdtest: whether the wide ladder spreads switch points (owners SD $18.5 vs $44.8, ratio .17, p < .001).

**Code.** `esize twosample valuation if nsb==0 & mplcond==0, by(owncond) cohensd`; `sdtest valuation if nsb==0 & owncond==1, by(mplcond)`.

**Benchmark.** d of .2, .5, .8 are the conventional small, medium, large. Endowment-effect meta-analyses report d around .5 to .7 for ordinary goods, so your wide-range .65 is typical and your narrow-range .35 is low, which is the point. For sdtest, a ratio far from 1 with p < .05 means the spreads differ; the F-test is sensitive to non-normality, so pair it with the visual histogram.

### B14. Two-proportion z-test from summary numbers (prtesti)

**Purpose.** Compares two proportions when you have only the counts, not the raw variable.

**What it does here.** Section 8: predicted vs observed Always Buy survival rate (3.3% vs 1.8%, z = .99, p = .32) and the share of normal-arm non-owners whose typed maximum falls on the added rungs vs the share of wide-arm non-owners who switched there (7.1% vs 6.4%, p = .75).

**Code.** `prtesti 210 .033 220 .018`.

**Benchmark.** A non-significant p here supports the reconciliation. Note that these tests have low power at these counts; the CIs on the two rates are the honest summary.

### B15. Hazard by rung (descriptive)

**Purpose.** The hazard at a rung is the share of people still "at risk" (not yet switched) who switch at that rung. It shows where on the ladder decisions cluster, independent of how many people are left.

**What it does here.** Section 9. It is the only place the posted price shows up: in every cell the hazard jumps at $117. It also shows the $205 pile-up among wide-arm owners.

**Reading the output.** One line per rung: switched n of m at risk, hazard. A spike is a rung whose hazard is two or more times its neighbors'.

**Benchmark.** None statistical; this is descriptive. Report it as a figure if you want to make the reference-price point; otherwise one sentence.

### B16. Latent class analysis (gsem, lclass) with BIC and entropy

**Purpose.** A model that finds unobserved groups ("classes") of people who share a pattern of construct scores, without using the outcome. Each person gets a probability of belonging to each class.

**What it does here.** Section 10 asks whether, among non-owners, the data contain profiles that line up with Never Buy and Always Buy when the ladder is never consulted.

**Code.** `gsem (me_ness mine_ness ... <- _cons) if owncond==0, lclass(C k)` for k = 2 to 4; `estimates stats` for BIC; `estat lcmean` for class means; `predict post*, classposteriorpr` for membership; the entropy calculation; then `tab lclass nb3`.

**Reading the output.** `estat lcmean` prints each class's mean on each construct; name the classes from those means. Your log, class 1: me-ness 1.9, status quo 5.7, commission regret 6.2, omission regret 1.6 (the inertial, detached class); class 4: me-ness 5.6, status quo 1.8, omission regret 6.0 (the attached, eager class). The cross-tab with nb3 shows 8 of 13 Never Buy in class 1 and 19 of 26 Always Buy in class 4.

**Benchmark.** Choose the number of classes by BIC (lower is better), stopping when the next class adds nothing interpretable or has fewer than about 5% of people; BIC was still falling at k = 4, so extend to 6 in the next run. Entropy above .80 (yours .87) means people are assigned to classes with little ambiguity. Report BIC for each k, class sizes, class means, and entropy.

### B17. Reading a results workbook row

Each row of EE_Study3_Completion_results.xlsx has: section, condition (E, NE, all), group, outcome, contrast, b (the estimate), se, p, sig (stars), n1, n2. For AMEs b is a probability change; for intreg b is dollars; for the standardized models b is SD units; for BF01 b is the Bayes factor and p is blank; for AUC b is the area. Sheet sec_5b holds the four step contrasts per motive per condition, with n1 and n2 the two group sizes.

---

## Part C. Writing guidance and manuscript feedback

### C1. Audit of Rich's comments on Draft 1 against Draft 2

| # | Rich's comment (Draft 1) | Status in Draft 2 | What to do |
|---|---|---|---|
| C0 | "You list four constructs, then discuss 6 (or 8)." | Partly fixed: the opening paragraph now names two families (ownership / identity / attractiveness; regret / status quo). But the subheads are Ownership, Me-ness vs Mine-ness, Attractiveness, Inertia & Status Quo, Regret, and "Ownership" is never mapped to a measured construct. | Make the subheads match the measured constructs exactly: Mine-ness (psychological ownership), Me-ness (identity incorporation), Attractiveness, Status quo preference, Action regret, Inaction regret. Fold "Ownership" into the Mine-ness subhead as its literature. |
| C1 | "Doesn't pin down me vs mine; state how they differ in their supposed effects." | Not fixed. The paragraph still argues they can be separated but never says what each should do differently. And empirically you combine them (r = .76–.85; id_mm). | Either (a) state one differential prediction and test it, or (b) say plainly that they are conceptually distinct but empirically inseparable in this data (cite the correlations) and that you therefore treat them as one identity composite. Option (b) is honest and is what the analyses do. |
| C2 | "Betrayal wasn't one of the four listed." | Removed from theory, but still appears in Study 1 results (decomposition into mine/me/betrayal; ANOVA by subtype). | Drop betrayal from Study 1 results (it is a single item and nothing later uses it), or add one sentence in Study 1 explaining it was an exploratory item retired after Study 1. |
| C3 | "Define omission and commission clearly and consistently here so readers are ready for the analysis." | Not fixed. The Zhang & Fishbach sentence still says "errors of commission ... priming errors of inaction," mixing the two vocabularies in one sentence. | Define once, in the Regret subhead, in a sentence of the form: "We distinguish action regret (regret over a transaction one made: selling for owners, buying for non-owners) from inaction regret (regret over a transaction one declined). The psychology literature calls these commission and omission regret; we use action/inaction throughout." |
| C4 | "Different terms for regret types; choose one. I prefer action/inaction." | Draft 2 theory and measures use action/inaction consistently. But the Stata variable labels, the Study 3 analysis sections, and my memos use commission/omission, and your conventions note says "commission regret, not action regret." | This is a decision for you and Rich. Rich has stated a preference for action/inaction. If you follow it, do a global replace and keep "commission/omission" only in the one defining sentence. If you prefer commission/omission (closer to Gal's vocabulary, which helps the framework positioning), tell Rich why; the Gal connection is a real reason. |
| C5 | "Label the quadrants" (Figure 1). | Cannot verify from the text export; the figure caption is unchanged. | Put the four subtype names inside the quadrants of Figure 1 and the axis names (object axis: identity; action axis: inertia) on the axes. |
| C6 | "Measures prose is hard to absorb; use bullets with an example item and refer to an appendix." | Fixed for Study 2 and Study 3 (bulleted constructs with items). Study 1 still lists the four ownership items in running prose. | Convert Study 1 to the same bullet format. Move full item sets for all three studies to a Web Appendix and keep one example item per construct in the text, as Rich asked. |
| C7, C8 | "Three-way interaction between inertia, inertia, and endowment" — "you can't use inertia twice." | The three-way model is now written correctly ("identity composite, inertia composite, and condition"). The quadratic sections (where the repeated word came from) still exist in Study 2. | These sections are leaving anyway (U-shape is retired). Where a quadratic term survives, write "inertia and its square." |

### C2. Publication-level standards for the results sections

These are the conventions JCP and JCR reviewers expect, and the places Draft 2 falls short.

1. **Every effect carries a size, an interval, and an exact p.** Write "b = 20.8, 95% CI [11.2, 30.5], p < .001" rather than "the interaction was significant." For proportions, give the counts and the rate. For binary outcomes, give AMEs in percentage points, not log-odds. Draft 2 does this in places (Study 2 valuation) but not in the NSB sections.
2. **One N per study, stated once, used everywhere.** The completion run fixes the 892/885 problem; make sure every table in Study 3 says N = 885 and every logit's "Number of obs" matches.
3. **Preregistered vs exploratory, labelled.** Study 3 has a preregistration. Each analysis is either in it or not. Use a subhead or a sentence ("The following analyses were not preregistered") at the boundary. The cross-arm prediction, the Bayes factors, the format split, the latent classes, and the rung simulation are all exploratory; the range-by-NSB chi-square, the TOST, and the endowment ANOVA are preregistered.
4. **Null claims get equivalence or Bayes evidence.** Never write "no significant difference" as if it were a finding. Write "equivalent within ±5 points (TOST both p < .01; BF01 = 23)."
5. **Tables carry the numbers; prose carries the meaning.** Draft 2's Study 2 results prose contains strings of statistics that belong in a table. A reader should be able to follow the argument from the prose alone and check it in the table.
6. **Figures.** Each figure gets a title that states the finding ("Never-switching is a step beyond extreme valuation"), axis labels in words, CIs on every point, and a note that defines the sample and the units. Use the two profile panels (owners; non-owners) as Figure 2 and the reclassification bar chart as Figure 3. No raw Stata output screenshots.
7. **Numbering.** Studies 1 to 3 currently use different heading depths (1.4 Measures, 2.1.1 Endowment). Use the journal's two-level scheme: Method (Participants and design; Procedure; Measures), Results (one subhead per hypothesis or question), Discussion.
8. **Word budget.** JCP articles run about 8,000 to 10,000 words excluding references. Draft 2's front end is long: the subscription-market paragraph in Study 1 and the restaurant anecdotes can go to one sentence each. The Theoretical Framework can lose about a third by removing the loss-aversion recap and the digital-product and air-pollution asides.
9. **Hypothesis structure.** H1 to H3 are about valuation; RQ1 to RQ3 about never-switching. After Study 3 the never-switching questions are the paper's center, so promote them to hypotheses (H4: never-switching rate is higher for endowed; H5: never-switchers differ from extreme switchers on identity and inertia; H6: categorical never-switching is invariant to ladder range; H7: the switcher gap and the corner rate depend on span). Keep RQs only for genuinely open questions.
10. **Language passes.** Specific items in Draft 2: "The present research theories that" (theorizes); "nudging participants aways"; "the lack there of" (thereof, twice); "our examination of psychological constructs are independent" (is); "genuine comparison of psychology processes" (psychological); "the forces is additive"; "Always sell" capitalized inconsistently; "Data displays distributions across Narrow and Wide market configurations" in a figure note should read "normal and wide ranges." Run a pass for "which" vs "that," and remove "importantly," "interestingly," and "we would like to note."

### C3. Feedback on how to present the Study 3 results

Beyond the section order in the 11/03 memo:

- **Open the results with the replication, in one paragraph and one table**, so the reviewer who wants "did the endowment effect hold" is satisfied immediately. Then move to range.
- **The range results need a single organizing table**, three rows (table NSB, categorical NSB, dollar NSB) by three columns of population (all, owners, non-owners), each cell containing the two rates, the risk difference with 90% CI, and BF01. Everything in section 2 of the log fits in it. Narrate it in the order: categorical invariant; table moves; the movement is dollar and non-owner.
- **Present the cross-arm prediction as a two-panel figure**: predicted vs observed corner rate for each population, with the diagonal. Three points sit on the line (Always Keep both directions, Never Buy both directions); one sits far off it (Always Buy). A reader sees censoring without reading a number.
- **Present the profile figure before the step table**, and say in the first sentence what to look at: the owners' flat plateau from sextile 4 to 6 and the jump at Always Keep.
- **Put the format gradient (categorical vs dollar within Always Keep) in a short paragraph with a table in the appendix**; it supports the operational definition but is not a headline.
- **Put the latent classes in one paragraph with the class means table in the appendix**; its job is one sentence: the two non-owner corners are opposite profiles recovered without the ladder.
- **The rung simulation and the SD-unit gap go together** under "Range and the endowment gap," with the three-row table from the 11/03 memo.
- **State the limitations inside Study 3, not only in the General Discussion**: order not randomized; Always Sell and categorical Always Buy too small to model; typed amounts inflated relative to ladder values; status quo and regret measured after the ladder; one good category.
- **Retire the inflection vocabulary entirely.** Do not mention that it was tested. Reviewers do not need the history; the preregistration shows what was planned.

### C4. Feedback on the rest of the manuscript

- **Introduction.** It currently opens with the endowment effect and arrives at never-switching late. Open with the phenomenon: a quarter of participants in a standard price list give no price, and the field treats them as noise. Then the endowment effect as the paradigm. Then the framework. Then the three studies in one paragraph.
- **Theoretical Framework.** Replace the current "Enhancing and Offsetting Forces" subsection with a statement of the framework as three propositions (object force, action force, alignment), each with its prediction for switchers (position) and for corners (entry). The Ray and Wilkie (1970) scaffold is fine; the Shu and Peck (2011) comparison paragraph is too long and defensive; cut to two sentences.
- **Study 1.** Its role is to establish the effect and the first NSB rates. Cut the market statistics; keep the lunch-routine logic. Drop betrayal. Present NSB rates by condition with CIs. Do not interpret construct differences among subtypes with single-item measures beyond a sentence.
- **Study 2.** Its role is the framing manipulation and the first full construct battery. Keep the three-way interaction and the KHB decomposition (reframed as consistent with, not proof of, mediation). Remove the quadratic/U-shape analyses and Figures 9 to 14. Replace with a short version of the profile figure if the Study 2 data support it (they should; the sextile code runs on any ladder).
- **Study 3.** As above.
- **General Discussion.** As in the 11/03 memo, plus one paragraph the earlier memo did not include: what the framework predicts outside the endowment paradigm (provider switching, renewal decisions, defaults), which is the sentence Gal 2026 says a framework paper must contain.
- **References.** Add the Tier 1 and Tier 2 papers. Gal (2021) and Gal, Calder & Sternthal (2026) are absent from Draft 2.
- **Web Appendix.** Full item sets; exclusion tables; the Draft 2 figures that leave the main text; the results workbook as supplementary data; the do-files.

### C5. A workflow for the next draft

1. Terminology decision with Rich (C4), then a global replace.
2. Theory section rewrite (C0, C1, C3) and Figure 1 relabel (C5).
3. Study 1 cleanup (betrayal; bullets; cuts).
4. Study 2 cleanup (remove U-shape; reframe KHB).
5. Study 3 written from the completion log, with the tables listed in C3.
6. General Discussion.
7. Abstract and title last.
