# Study 3, the NSB findings, and the Gal papers: where the project stands and how to take it higher

Prepared 2026-11-03 for Sheryl Zhang (EE & NSB project, with Rich Lutz).

This document answers, in order, the questions you asked:

1. What I read and what I skipped.
2. Did the existing analyses answer Yang's question about MPL range artificially creating NSBs? What is still missing?
3. What new patterns the Study 3 data point to.
4. What those patterns mean for theory and for the paper's theme and contribution.
5. What analyses would complete Study 3.
6. Is the paper leaning toward "theory of the effect" or "theoretical framework" (Gal, Calder & Sternthal 2026)? How to move it toward a framework.
7. How the findings align or conflict with Gal 2006 and Gal 2021, and whether you extend or disprove Gal.
8. How all three Gal papers inform positioning and Study 4.
9. Additional recommendations on the manuscript and on publishing prospects.

Throughout, "AK / AS / AB / NB" mean Always Keep, Always Sell, Always Buy, Never Buy. "Commission regret" is what the data files call action regret; "omission regret" is inaction regret. "Categorical NSB" is what the files call `nsb_true`; "dollar NSB" is `nsb_dollar`; "table NSB" is `nsb_table`.

---

## 1. Coverage: what I read and what I skipped

Read in full:

- EE & NSB Manuscript [Draft 2] (the whole draft, including the planned Study 3 section and the empty General Discussion).
- All three Gal papers: Gal, Calder & Sternthal (2026, JCP); Gal (2021, Current Opinion in Psychology); Gal (2006, Judgment and Decision Making).
- Both do-files: EE Study 3 - Clean Data.do; EE Study 3 - Stats Analyses 2.do (sections 0 through the 9/23 inflection start; the remaining ~700 lines are the 9/23–9/25 inflection code that is documented line by line in the 0923 and 0925 Claude responses, and I used those).
- EE_Study3_Inflection_v2_Regions.do and the v2 logs (20260928, 20260930).
- The most recent log, EE_Study3_Analyses_20261013.log (construct profiles by range within corner; dollar vs categorical within Always Keep).
- All dated Claude Response documents (0916, 0919, 0921, 0922, 0923, 0925, 0928, 0929, 0930), which carry the interpretation of every other log.
- Emails to Rich (9/23, 9/30, 10/2), Rich's reply with the inflection-point idea, the preregistration draft, the survey export (EE_Study_3_Final Updated), and your memory/conventions file.
- Excel workbooks: Inflection_Results_Summary (v2 scorecard with your margin notes), v2b gap test, NSB_Format_by_Range, Constructs_by_Crossover Updated, H4_Subtype_Results, Manuscript_Tables, Email_Support_Tables, Construct_Reliability. The largest sheets were read in part (the first several hundred rows of each); the remainder repeats the per-scheme detail that the scorecard sheets summarize.
- 20261001.pptx: two Stata graph screenshots, the sextile construct profiles for non-endowed (0 = Never Buy, 7 = Always Buy) and endowed (0 = Always Sell, 7 = Always Keep). These are the best figures in the project and I refer to them below.

Skimmed or skipped, and why:

- 20260915.pptx (22 slides): screenshots of Stata output from Study 2 (variables `selfcond`, `id_mm` by framing condition, margins tables). It is Study 2 diagnostic material, not Study 3, so I only confirmed what it was.
- The 9/21, 9/23, 9/25 full logs: I did not re-read every page because the dated responses reproduce every number I needed, and the 9/23 and 9/25 inflection analyses were later retracted (see section 3).
- Nothing else in the folder was skipped.

One thing I could not verify: the Study 3 manuscript section says the order of options and of price levels was randomized (Jack et al. 2022). The survey export and the cleaning do-file show no such randomization. If it was not implemented, that sentence must be removed and the limitation stated.

---

## 2. Yang's question: did the analyses answer whether MPL range artificially creates NSBs?

Short answer: yes, substantively and in a more interesting way than a yes/no, but two gaps remain before it is airtight.

### 2a. What has been established

The design isolates range from midpoint (normal $62–161, 10 rungs; wide $7–216, 20 rungs; shared midpoint $111.50, $11 steps). Three facts together answer Yang.

**Fact 1. Range changes who shows up in the corners, but only the unconfirmed kind.** Table NSB differs by range (p ≈ .05). Categorical NSB, the people who say "I would never sell/buy" in the follow-up, does not: 6.6% vs 7.0% overall (p = .81; equivalent within ±5 points), owners 9.5% vs 10.7%, non-owners 3.3% vs 3.2%. Dollar NSB, the people who type a finite amount, is where the entire range effect lives, and only among non-owners: 10.0% to 1.8% (p < .001). Nearly all of that is Always Buy, 24 to 5.

**Fact 2. The vanished Always Buy were censored buyers, not never-switchers.** Among normal-range Always Buy with a valid typed amount, 15 of 18 stated a maximum between $165 and $215 (median $200). The wide ladder has rungs there, and a matching share of wide non-owners switched there (6.3% vs 7.1% predicted, median switch $177.50). The 3 who stated $250–350 predict about 1.4% surviving corners on the wide ladder; 1.8% (4 people, $250–500) was observed. None of the censored buyers gave a categorical "never." This is the cleanest piece of evidence in the study: the short ladder was recording finite, high willingness to pay as a corner.

**Fact 3. Holding the price window fixed, the wide frame reclassifies most narrow-window corners.** Of the 163 wide-arm respondents who would have been corners on the $62–161 window, 104 (63.8%) switch somewhere on the wide ladder; 80% for non-owners, 55.6% for owners. A conventional MPL would have reported 36.7% NSB in this sample; the ladder-independent figure is 13.3% (2.76× inflation). And the reclassified people are not never-switchers in disguise: normal-arm corners match wide-arm persistent corners on every construct (all p > .20 within Always Keep; MANOVA p = .65), while crossovers look like switchers on identity and only intermediate on inertia.

So the answer to Yang is: a narrow range does manufacture corners, by a lot, but it manufactures them out of extreme valuers, not out of thin air, and the categorical never-switcher population is untouched by range. The owner/non-owner asymmetry (4× owner NSB survives even on a deliberately over-wide ladder) is itself evidence that NSB is not a ladder artifact.

### 2b. What is still missing

1. **Range and rung count are confounded.** Wide = 20 rungs, normal = 10. The dollar-NSB reclassification could in principle reflect having more choices rather than a wider span. The censoring analysis in Fact 2 (stated amounts sit exactly where the wide ladder added rungs) makes "span" the only sensible reading, but a reviewer will ask. The fix is cheap: in Study 4, include a wide-span, 10-rung ladder ($22 steps) or a narrow-span, 20-rung ladder ($5.50 steps). One extra cell.

2. **The categorical equivalence claim rests on 60 people.** "Equivalent within ±5 points" at n = 29 vs 31 is a wide bound. Run a proper TOST by condition with the SESOI stated in advance (e.g., ±4 points for owners, ±3 for non-owners), and report Bayes factors for the null (a `bayes: logit` or a simple beta-binomial BF). A reader of Gal 2026 will be sensitized to "we found no difference" claims; a Bayes factor converts that from absence of evidence to evidence of absence.

3. **The categorical answer is a self-classification, measured after the MPL.** Reviewers will say the follow-up is another expression of the same corner behavior. Two checks strengthen it: (a) show that categorical NSB are behaviorally distinct from dollar NSB on constructs measured before the MPL (me-ness, mine-ness, pre-MPL attractiveness were moved before the MPL in Study 3, so this is doable); the 10/13 log already shows dollar-format AK are lower than categorical AK on inertia (−.42), status quo (−.79), commission regret (−.85), attractiveness (−.39) and marginally identity (−.24); (b) show that categorical NSB in the normal arm would be predicted to persist on the wide ladder from pre-MPL constructs alone (see the cross-arm prediction analysis in section 5).

4. **The wide ladder is not a neutral lens either.** Switcher valuations spread (SD ~$19 to ~$43) and the endowment gap among switchers quadruples ($7 to $28; interaction b = 20.83, p < .001), while the level shift disappears when valuations are standardized within range (p = .93). That is a range-frequency / proportional-stretch effect (Parducci), which means the wide arm did not "reveal" true valuations; it rescaled them. Yang's question therefore has a second half you should state explicitly: range affects switchers' valuations continuously and corner membership discretely, and only the first of those touches the endowment effect's magnitude. The right answer to "is the endowment effect a range artifact?" is "its dollar size is range-dependent, its presence is not, and NSB is range-independent among the categorically committed."

5. **Order effects.** Not randomized (see section 1). Say so in limitations and fix it in Study 4.

---

## 3. New patterns the data point to

These are the findings that survived the two retractions (the 9/23 "amplification" and the 9/25 "attenuation" inflection analyses were both artifacts; the v2 cutpoint analysis settled it). I list them in order of importance for the paper.

**Pattern A. NSB is a step, not an extreme.** On the sextile profiles (20261001 deck), constructs change roughly linearly across switcher sextiles and then jump at the corners. For non-owners, identity and attractiveness drop from about −0.4 SD in the lowest switcher sextile to −1.9 SD at Never Buy; status quo and commission regret jump from +1.0 to +2.0. For owners, omission regret falls from −0.1 SD in sextile 6 to −0.8 at Always Keep, while identity rises from 0 to +0.6 and status quo from +0.2 to +0.75. In the v2 analysis, inertia separates tails from middle 1.5 to 2× more than valuation motives do (v2b gap test, 6 of 8 blocks supported), and NSB sit a further step beyond extreme switchers. The old U-shape hypothesis is dead; what replaces it is a discontinuity, and discontinuity is a stronger claim.

**Pattern B. Identity governs whether; inertia governs where.** Identity is a powerful moderator in the binary NSB models (significant three-way terms) and essentially null in the continuous switch-point models. Inertia predicts position within the ladder and the tails. This is the theoretical core of Study 3 and should be stated as a proposition.

**Pattern C. The two forces combine conjunctively for owners and substitutively for non-owners.** For owners, identity and inertia point the same way (r = +.56) and never-keeping requires both to be high. For non-owners they oppose (r = −.53), and the two corners are two different processes: Never Buy = low identity + high inertia (Gal's inertial agent); Always Buy = high identity, low status quo, high omission regret (a buyer the ladder could not reach). Pooling non-owner NSB averaged a positive and a negative slope, which is why the pooled interaction went negative. Model each corner separately, always.

**Pattern D. Owners' extremes run on regret; non-owners' extremes run on status quo.** In the endowed profile, the lines that move most at the corners are omission regret (Always Sell high, Always Keep low) and commission regret (Always Keep high). In the non-endowed profile, status quo and commission regret dominate the Never Buy corner. This maps onto Gal 2021's omission/commission account (section 7) better than anything in the current theory section.

**Pattern E. Range is a measurement lens, not a creator of types.** Normal-arm corners ≈ wide-arm persistent corners on every construct; crossovers ≈ switchers on identity; switchers are identical across ranges (no rationalization of the ladder). Range changes which bin a person lands in, not who they are.

**Pattern F. Always Buy is mostly censoring.** Among non-owners, AB ≈ extreme buyers on constructs and disappears on the wide ladder; AB should be presented as the ceiling artifact that validates the NSB construct by contrast, not as a fourth type.

**Pattern G. Format matters within a corner.** Categorical AK are higher than dollar AK on inertia, status quo, commission regret, and attractiveness (10/13 log, MANOVA p = .0001). This is a gradient of commitment inside the corner and supports treating "categorical never" as the operational definition of NSB in the paper (rename `nsb_true` to categorical NSB so you do not assume the conclusion in the variable name).

**Pattern H. The endowment effect's dollar magnitude is instrument-dependent.** Switchers' gap $7 vs $28. The within-range standardized gap is invariant. This belongs in the measurement contribution, and it links directly to Gal 2026's "replication paradox" discussion.

**Pattern I. Recurring vs single-event experiential goods.** Study 2 (one tasting event) NSB 17.5%; Study 3 normal arm, same price neighborhood, recurring membership: table NSB is higher (owners ~22%). You planned this comparison in the manuscript; it is now a free descriptive result (with the caveat that the ladders differ).

---

## 4. What this means for theory, theme, and contribution

The manuscript's present thesis is "NSB is U-shaped in identity and inertia, and the endowment effect for experiential goods is driven by identity and inertia through regret." Study 3 replaces the first half and sharpens the second.

**The theme becomes: never-switching is a categorical exit from the exchange frame, produced when identity and inertia align, and it is distinct from extreme valuation.** The endowment effect proper (the WTA–WTP gap among switchers) is a continuous phenomenon governed by inertia and scaled by the instrument. NSB is a discrete phenomenon governed by identity (whether) with inertia setting the surrounding slope (where). The two are related but not the same thing, and the standard MPL conflates them by recording both as corners.

Three contributions follow, each defensible from the data you already have:

1. **A measurement contribution.** The first design that varies MPL range holding midpoint and step fixed, with a categorical/dollar follow-up that separates committed non-traders from censored valuers. Deliverable: the 63.8% reclassification table, the censoring reconciliation, and the instrument-dependence of the EE magnitude. This is the part that directly answers Yang and will be cited by anyone using MPL.

2. **A phenomenon contribution.** NSB as a stable, range-invariant, construct-distinct behavior that standard elicitation hides. 7% categorical NSB that is 3× more frequent among owners, on a ladder that reaches $216 for a $115 good, is a result in its own right.

3. **A process contribution.** The countervailing forces structure (identity vs inertia, aligned for owners, opposed for non-owners) explains an asymmetry no single-force account predicts: why owner NSB is one thing (Always Keep, conjunctive) and non-owner NSB is two things (Never Buy, inertial; Always Buy, censoring). This is where you touch Gal.

The paper's title still works ("To Switch, Or Not to Switch") but the subtitle should move from "Exploring the Boundaries of the Endowment Effect" toward something like "Never-Switching as a Distinct Response in Endowment Elicitation," because the boundaries language promises a moderator paper, which is exactly the theory-of-the-effect framing Gal 2026 warns about.

---

## 5. Analyses to complete Study 3

Listed in priority order. Items 1–5 are needed for the manuscript; 6–9 are for robustness and reviewer defense; 10–11 are optional.

1. **Rerun every binary NSB model on the preregistered sample** (`comp_pass=="1" & nsb_invalid!=1`, N = 885). The 9/25 response flagged that the logits ran on N = 892. Do this before anything else so every table in the paper has one N.

2. **Formal equivalence and Bayesian tests for categorical NSB by range**, overall and by endowment, with preregistered-style SESOI stated in the text. Report TOST p-values and BF01. Also run `firthlogit` for the non-owner cells (7 vs 7).

3. **Cross-arm prediction (the strongest range-artifact test available in-sample).** Fit a logit predicting persistent corner (categorical NSB, or wide-arm persistent corner) from pre-MPL constructs only (me-ness, mine-ness, pre-MPL attractiveness, plus status quo and regret if you are willing to accept their post-MPL timing) in the wide arm, then score the normal arm and compare predicted vs observed NSB. If NSB is a trait, calibration should hold across arms; if range creates NSB, normal-arm observed will exceed predicted by roughly the reclassification share. Do the reverse direction too. This turns "range-invariant" into an out-of-sample claim.

4. **A clean within-corner format analysis** (categorical vs dollar) for every corner with n ≥ 15, on constructs measured before the MPL, reported as one table (the 10/13 log already does this for AK; extend and standardize).

5. **Finalize the sextile profile figures** (the two in the 20261001 deck) as Figure 2a/2b, with the vertical dashed lines at the corners, a note that positions are within-range sextiles, and bootstrap CIs on the corner means. Add the v2b gap test as its table. Keep ASCII in titles.

6. **Rung-count sensitivity within the wide arm.** Recompute wide-arm corner and switch-point distributions after deleting every other rung (simulating a 10-rung, $22-step, $7–216 ladder) by collapsing adjacent intervals. If corner rates and construct profiles are unchanged, you have in-sample evidence that span, not rung count, drives the result. Say clearly that this is a simulation, not a manipulation.

7. **Interval regression with condition-appropriate bounds for the switcher EE**, reporting both raw and within-range standardized gaps, and a formal test that the standardized gap does not differ by range. This already exists in pieces; consolidate it.

8. **Decompose the Always Buy disappearance** with the predicted-survivor calculation written as a one-paragraph reconciliation (predicted 1.4%, observed 1.8%). Include the switch-point distribution of wide-arm non-owners above $161 against the normal-arm stated amounts (a QQ-style comparison or a two-sample KS on the overlapping support).

9. **Order-position check.** Even without randomization, test whether corner rates differ by the position of the first rung (ascending only, so this is weak) and report it as a limitation.

10. **Latent class on the three-way response (switch / categorical corner / dollar corner)** by endowment, to see whether the data recover the two non-owner processes without you imposing them. You have the `gsem lclass` code; two classes among non-owners should reproduce NB vs AB.

11. **Recurring vs single-event comparison with Study 2**, descriptive only, using the Study 2 ladder and the Study 3 normal ladder, both restricted to the overlapping price window.

Things not to do: do not return to the inflection-point analyses; do not report pooled non-owner NSB models; do not use "refusal"; do not call `nsb_true` "true" in the paper.

---

## 6. Theory of the effect or theoretical framework? How to move toward framework

### 6a. Where the manuscript is now

By Gal, Calder & Sternthal's criteria, Draft 2 is a theory-of-the-effect paper, and a good one of that kind. The signatures:

- The object of explanation is the endowment effect for experiential goods; H1–H5 are moderators and mediators of that effect (extended self, identity constructs, regret, framing).
- Mechanism is claimed through measured mediators (KHB: 72.8% / 82% through regret). Gal 2026 specifically warns that measured mediators may be alternative measures of the dependent variable, and your regret items ask about selling/buying this membership.
- The contribution is framed as extending the boundary conditions of the effect ("Exploring the Boundaries").
- The theory section cites Gal 2006 for inertia but does not engage the inertia/omission account as a rival or parent framework.

This is the dominant strategy (60 of 66 recent JCR/JCP articles in their count). It is publishable, but it is also the strategy most exposed to their Table 2 challenges: the replication paradox (your EE magnitude is range-dependent), surface-level constructs, mediators as alternative DVs, and too many theories.

### 6b. What a theoretical-framework version looks like

Gal 2026's example of the framework strategy for the endowment effect is Gal's own omission–commission account: it was not designed for the endowment effect; it organizes the endowment effect along with status quo bias, default effects, and inaction inertia. Their six practical guidelines translate for you as follows.

1. **Be explicit about the strategy.** One paragraph at the end of the introduction: "We pursue a framework strategy: we treat never-switching as one instance of a general process in which identity-based and inertia-based forces jointly determine whether a person enters an exchange frame at all, and we use the endowment paradigm as the setting in which that process is easiest to observe."

2. **Abstract the core process beyond the focal effect.** The abstract process is: *two families of force, one tied to the self-relevance of the object (identity) and one tied to the self-relevance of the act (inertia: status quo, omission and commission regret), that are aligned when the status quo is possession and opposed when it is non-possession, and that produce a discrete exit from trade when both are high.* State that as the framework and derive the endowment effect, NSB, and the owner/non-owner asymmetry from it. Your Table 1 (object vs action axes) is already this; promote it from a classification device to the framework.

3. **Connect to structurally similar paradigms.** Non-trading in markets (no-trade / "not for sale" responses in BDM and contingent valuation; protest responses and zero bids in the CV literature), protected values and taboo trade-offs (Tetlock, already cited; the sacred-value literature treats refusal to price as categorical, which is your NSB), brand/provider loyalty and switching costs in services, default and status quo effects (Samuelson & Zeckhauser), inaction inertia, and the "I'd never sell my ..." responses in possession research. NSB is the behavioral signature all of these share: a participant who will not give the elicitation a number.

4. **Design one study beyond the original paradigm.** This is Study 4 (section 8). Gal's guideline is explicit that a framework claim needs at least one test outside the paradigm the effect was found in. An MPL endowment study with a new good is still inside the paradigm.

5. **Frame the contribution as a framework.** The discussion should say what the framework organizes (EE magnitude among switchers, NSB incidence, the owner/non-owner structural difference, instrument dependence) and what it predicts elsewhere (where NSB-like exits should appear outside endowment).

6. **Use rival frameworks as stress tests.** Three rivals, each of which the data speak to:
   - *Loss aversion / prospect theory.* Predicts a continuous gap and no categorical exit; cannot produce the range-invariant categorical corner without an auxiliary assumption. Your data: NSB categorical, range-invariant, construct-distinct.
   - *Gal's inertia / omission–commission.* Predicts non-trading from indifference plus the asymmetric responsibility of acting. Your data fit it for Never Buy and for position within the ladder, but not for Always Keep, where identity does independent work and preferences are strong, not fuzzy (section 7).
   - *Reason-based choice / 3A resource allocation (Gal 2026's own examples).* Predict that a stated reason or a resource-protection motive produces the exit. Your categorical follow-up gives reasons; the protected-values literature predicts moral outrage at pricing, which you can test in Study 4 with an item or two.

Note on mediators: Gal 2026 is pointed about measured mediation. Keep the KHB results but reposition them as "consistent with," and lean on the manipulations (endowment, extended-self framing in Study 1/2, range in Study 3, and the Study 4 manipulations) for causal claims. Moving me-ness/mine-ness before the MPL in Study 3 was the right move; say so.

---

## 7. Alignment with Gal 2006 and Gal 2021

### 7a. Where you agree with Gal

- **Inertia is central, loss aversion is not needed.** Your model has no loss-aversion construct and explains the EE through inertia plus identity. Gal 2006's claim that inertia renders loss aversion superfluous is one your data support: inertia is the axis that separates tails from middle (v2), and the EE among switchers is explained by the same inertia family.
- **Omission vs commission asymmetry.** Gal 2021 argues commission is seen as more causal, so it requires more justification; trading away is a commission, retaining is an omission. Your endowed profile shows exactly that: commission regret rises steeply at Always Keep, omission regret falls; the mirror image at Always Sell. For non-owners, buying is the commission, and Never Buy is high commission regret and status quo. Your regret items are, in effect, a direct measurement of the asymmetry Gal infers.
- **Status quo as the default state.** Gal 2006's "psychological law of inertia" (maintain the status quo unless impelled by a motive) is your status quo construct, and it is what dominates the non-owner corner.
- **Fuzzy preferences and the indifference range.** Gal 2006 derives WTP and WTA as the bounds of a fuzzy indifference range. Your switchers behave like this: their position shifts continuously with inertia and rescales with range, which is what you expect from people whose preference is a range rather than a point.

### 7b. Where you diverge, and the contribution that follows

**Divergence 1: Gal's non-trader is indifferent; your never-switcher is committed.** Gal 2006 explains non-trading as fuzzy indifference plus inertia: people do not trade because they do not care enough to overcome the default. Your categorical never-switchers are the opposite of indifferent: they are the highest-identity, highest-attractiveness people in the sample (owner AK identity +0.6 SD, attractiveness +0.4; non-owner NB identity −1.9 SD, attractiveness −1.9). They have strong, directional preferences. Their exit from the ladder is not "I cannot tell" but "this is not for sale / not for me." That is a second route to non-trading that Gal's framework does not contain. Stated as a proposition: *there are two non-trading states, inertial indifference (Gal) and committed refusal-to-price (identity); the first produces position near the midpoint of a range, the second produces categorical exit from the range.*

**Divergence 2: Inertia is necessary but not sufficient for owner NSB.** For owners, inertia alone does not produce Always Keep; identity must also be high (conjunctive structure). Gal's law of inertia predicts retention from inertia alone. Your data say inertia sets the slope, identity throws the switch. This is an extension: a boundary on Gal's account for self-relevant goods.

**Divergence 3: The asymmetry between owners and non-owners is structural, not just directional.** In Gal, buyer and seller differ in which act is the commission. In your data they also differ in how the forces combine (aligned vs opposed), which produces one owner corner type and two non-owner corner types. Gal's framework predicts the sign; yours predicts the shape.

**Divergence 4: Gal 2021's practical lever is testable and you have not tested it.** Gal reports that framing the omission as a commission ("receive $0") eliminated the EE. Your framework predicts that this reframe should move switchers (whose position is inertia-governed) and leave categorical never-switchers untouched (identity-governed). Gal's account predicts it should reduce NSB too, since NSB in his framework is inertia. That is a crisp, discriminating test for Study 4.

**Do you disprove Gal?** No, and you should not claim to. You show that Gal's process is present and dominant in the middle of the distribution and at the non-owner Never Buy corner, and that a second process (identity) is required at the owner corner and to produce categorical exit. The honest framing is "extends and bounds," which is also the framing Gal 2026 would call framework progress (organizing a new phenomenon, NSB, under a process that was not designed for it, and identifying what the parent process cannot do).

One more point of contact: Gal 2006's quarters experiment (85% retain) and the single-bet vs allocation experiment both show that inertia is strongest when the decision is framed as "change or not" rather than as allocation. Your MPL is a sequence of binary change-or-not decisions, which is the frame most hospitable to inertia. A Study 4 cell with a direct allocation or open-ended price would test whether NSB survives a frame that removes the inertia advantage.

---

## 8. How the three papers inform positioning and Study 4

### 8a. Positioning sentences you can use

- "Following Gal, Calder and Sternthal (2026), we pursue a framework rather than a theory of the endowment effect: we propose that whether a person enters an exchange frame at all is determined jointly by identity- and inertia-based forces, and we use endowment elicitation as a paradigm in which that process can be observed directly."
- "Gal's (2006, 2021) inertia account explains why sellers demand more than buyers offer without recourse to loss aversion. Our data support that account for the continuous component of the endowment effect and for non-owners who never buy, and extend it by showing a second, identity-based route to non-trading that produces categorical refusal to price rather than inertial indifference."
- "Never-switching is not a measurement failure to be minimized (cf. Andersen et al. 2006; Jack et al. 2022) but a response category with a stable construct profile that standard multiple price lists hide by recording it alongside censored valuations."

### 8b. Study 4 design

The purpose of Study 4, given everything above, is to (i) step outside the MPL endowment paradigm, (ii) manipulate the two forces directly, and (iii) run the Gal 2021 reframe as the discriminating test. One design that does all three:

**Design.** 2 (endowed vs non-endowed) × 2 (identity: enhanced extended-self vignette vs base, as in Study 1) × 2 (act frame: standard "keep vs sell" / "buy vs don't buy" vs Gal's omission-as-commission reframe, e.g., "receive $X vs receive $0 and keep the membership"). Elicitation: a single wide ladder (reuse $7–216 with the categorical/dollar follow-up, order randomized), plus an open-ended stated amount with an explicit "I would not sell/buy at any price" option offered before the ladder for half the sample (order counterbalanced). The pre-ladder "not at any price" option is the out-of-paradigm measure: it is NSB elicited without a ladder at all.

**Predictions that discriminate.**
- Identity manipulation raises categorical NSB (whether) and does not move switchers' position (where). Inertia-side manipulation (the act reframe) moves switchers' position and the EE gap among switchers, and does not move categorical NSB. This is Pattern B as a causal test.
- Gal's reframe shrinks the switcher EE (replicating Gal 2021) but leaves categorical NSB intact. Gal's account predicts both shrink.
- Ladder-free "not at any price" responses match ladder categorical NSB in rate and construct profile, and both are unaffected by range (you can add a normal-range ladder cell if budget allows; otherwise rely on Study 3).
- Among non-owners, the identity manipulation reduces Never Buy, the reframe reduces position-driven low bids, and Always Buy stays near zero on the wide ladder.

**Why this is "beyond the paradigm."** It elicits non-trading without a price list, manipulates the forces rather than measuring them, and tests an intervention derived from a rival framework. If you want to go further, a non-endowment setting that the same framework should organize is a provider-switching decision (keep current supper-club vs switch to an equivalent at a discount), where the "never switch" response is the dependent variable and no WTA/WTP is elicited. That would be a strong Study 5 or a Study 4b.

**Measurement details to carry over.** Me-ness, mine-ness and attractiveness before any choice; status quo and the regret items immediately after the vignette and before the ladder if you can tolerate the demand concern (otherwise keep them post-ladder and say so); randomized option side and price direction; a manipulation check for identity; a two-item protected-values / "it would be wrong to put a price on this" measure to speak to the sacred-values rival; and the rung-count cell from section 2b if the budget allows.

### 8c. What Study 4 should not try to do

Do not re-test the inflection point. Do not add a third range. Do not use a new category of good that changes three things at once; keep the supper club so Study 3 and Study 4 are directly comparable.

---

## 9. Manuscript and publishing recommendations

**Abstract and hypotheses.** Remove "U-shaped." Replace H3/RQ language about curvature with the whether/where proposition and the conjunctive/substitutive structure. Update N to Studies 1–3 (451 + 513 + 885).

**Theory section.** Add a subsection "Inertia accounts of the endowment effect" that presents Gal 2006/2021 fairly as the leading post-loss-aversion account, then introduces identity as the second force and the alignment principle. Cite Gal 2026 in the introduction when stating the strategy. Table 1 becomes the framework figure.

**Study 3 section.** Rewrite in past tense. Order: design and the range manipulation (with the honest note on order randomization); the three-way response taxonomy; Fact 1–3 from section 2; Patterns A–E; the construct profiles figure; what did not hold (inflection). Report the 63.8% table first because it needs no model.

**General Discussion.** Four parts: (1) the framework and what it organizes; (2) relation to Gal (section 7b); (3) measurement implications for anyone using MPLs (report categorical corners separately; widen the ladder; do not treat corners as valuations); (4) limitations (order, self-report constructs, single good category, post-MPL timing of some constructs, modest categorical-NSB cell sizes) and Study 4.

**Reviewer risks to pre-empt.** Mediators as alternative DVs (Gal 2026); "never" responses as demand or satisficing (answer: construct-distinct, range-invariant, predicted from pre-MPL constructs); rung-count confound; the EE magnitude being instrument-dependent (turn it into a contribution, not a confession).

**Journal fit.** JCP is the natural home given Gal 2026 appeared there and the editors are signaling interest in framework-style contributions; JCR if Study 4 lands cleanly and the provider-switching extension is included. For an experimental-economics audience (JEBO, Experimental Economics) the measurement contribution alone is publishable, but the identity constructs will be a harder sell there.

**The single most valuable thing in your data** is the pair of sextile profile figures plus the 63.8% reclassification table. Together they show, without a model, that never-switching is a different kind of response from extreme valuation and that the standard instrument hides it. Build the paper outward from those two exhibits.
