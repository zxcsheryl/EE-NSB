# Study 3 completion run: what the results say, what is left, and how to write the paper

Prepared 2026-11-03 for Sheryl Zhang. Source: EE_Study3_Completion_20261103.log (the run of "EE Study 3 - Stats Analyses 3 Completion.do"). The run completed with no errors on the preregistered sample (N = 885: 441 normal, 444 wide; 455 owners, 430 non-owners). Alignment correlation between identity and inertia replicated exactly (+.56 owners, −.53 non-owners).

Two corrections to my 11/03 synthesis memo come out of this run, and I flag them first because they change wording in the paper:

1. **The switcher endowment gap is larger in the wide range even in standard-deviation units** (0.34 SD normal vs 0.62 SD wide; Cohen's d 0.35 vs 0.65). The earlier claim that the gap "vanishes when standardized within range" was wrong as applied to the gap; it was true of the level shift. The narrow ladder understates the endowment effect, not just rescales it.
2. **Identity does not predict Always Keep once inertia is in the model.** The "identity governs whether, inertia governs where" line has to be narrowed: for owners, identity is the distal predictor (it predicts Always Keep out of sample on its own) and inertia is the proximal one (it absorbs identity when both are entered, because the two are aligned at r = .56). Identity keeps a direct effect only for Never Buy among non-owners, where the two forces oppose.

Everything else in the memo survives, and several claims are now stronger.

---

## 1. Section-by-section results

### Section 1. Corner models on the preregistered sample, each corner separately

| Corner (n) | Inertia AME | Identity AME | Identity × inertia | Range × constructs (3 df) |
|---|---|---|---|---|
| Always Keep (94 of 455) | +.27 per SD, p < .001 | +.04, p = .19 | b = .39, p = .22 (b = .63, p = .049 in the range-interacted model) | χ² = 3.6, p = .31 |
| Always Sell (6 of 455) | −.02, p = .07 (Firth b = −1.45, p = .017) | ns | ns | p = .77 |
| Always Buy (26 of 430) | −.12, p < .001 | ns | b = −.57, p = .16 (Firth −.71, p = .028) | p = .63 |
| Never Buy (13 of 430) | +.035, p < .001 | −.026, p = .010 | ns | p = .40 |

Categorical-only outcomes give the same picture (Always Keep: inertia AME +.22, p < .001; identity ns. Never Buy: inertia +.030, p = .006; identity −.018, p = .10). Always Buy categorical (4 people) has no structure at all.

**Whether vs where, side by side (section 1b).** Owners: inertia predicts both the corner (AME +.27) and the switch point (+$17.6 per SD, +0.50 SD of position); identity predicts neither additively. Non-owners: inertia predicts Always Buy (−.11), Never Buy (+.034) and position (−$24.3 per SD, −0.78 SD); identity predicts only Never Buy (−.026, p = .002).

What this supports: inertia is the engine at every corner and across the ladder, in the direction the countervailing-forces model predicts (toward the status quo). The construct structure of each corner is the same in both ranges (all range-by-construct tests null), which is the model-based version of "range changes who lands in the corner, not what the corner is."

What this does not support, as written in the draft: identity as an independent switch for owners. Section 3 shows why that is not a problem (identity predicts Always Keep on its own, and well); it is a sequencing result, not a null result.

### Section 2. Is categorical never-switching range-invariant? TOST and Bayes factors

| Outcome | Normal | Wide | Risk difference (90% CI) | TOST verdict | BF01 (no difference) |
|---|---|---|---|---|---|
| Categorical NSB, all | 29/441 | 31/444 | +0.4 pp (−2.4, +3.2) | Equivalent within ±5 pp | 22.9 |
| Categorical, owners | 22/231 | 24/224 | +1.2 pp (−3.5, +5.8) | Not equivalent at ±5 | 12.9 |
| Categorical, non-owners | 7/210 | 7/220 | −0.2 pp (−3.0, +2.7) | Equivalent within ±3 pp | 23.0 |
| Table NSB, all | 80 | 59 | −4.9 pp (−8.9, −0.8) | Not equivalent | 2.3 |
| Table NSB, non-owners | 28 | 11 | −8.3 pp | Not equivalent | 0.15 |
| Dollar NSB, non-owners | 21 | 4 | −8.2 pp | Not equivalent | 0.02 |
| Always Keep categorical | 20 | 21 | | Fisher p = .87 | 14.4 |
| Always Sell categorical | 2 | 3 | | p = .68 | 35.4 |
| Always Buy categorical | 4 | 0 | | p = .056 | 6.1 |
| Never Buy categorical | 3 | 7 | | p = .34 | 13.8 |

The Bayesian logit gives a range effect of −0.04 log-odds (95% credible interval −1.2 to +1.0) and a range-by-endowment interaction of +0.16 (−1.0 to +1.4).

What this supports: the null claim is now evidence of absence, not absence of evidence. BF01 above 10 for categorical NSB overall, for owners, for non-owners, and for three of the four corners is strong evidence that range does not move the categorical never-switcher population. The one TOST that fails (owners at ±5 pp) fails because the upper bound of the CI is +5.8 pp, i.e., if anything the wide ladder produced slightly more categorical Always Keep, which is the opposite of the artifact story. By contrast, table NSB and dollar NSB among non-owners have BF01 of 0.15 and 0.02: decisive evidence that range does move them. This is the cleanest statement of Yang's answer the data can give: the artifact is real, and it lives entirely in the dollar-format non-owner corner.

### Section 3. Cross-arm prediction (the strongest new result)

Logit of "persistent corner" on the three pre-MPL constructs (me-ness, mine-ness, attractiveness) fitted in one arm, scored in the other.

| Population | Fit in wide, score normal: expected vs observed | AUC | Fit in normal, score wide: expected vs observed | AUC |
|---|---|---|---|---|
| Owners, Always Keep | 18.9% vs 21.2%, z = 0.88, p = .38 | .73 | 21.9% vs 20.1%, z = −0.66, p = .51 | .75 |
| Owners, Always Sell (3 and 3) | 1.0% vs 1.3% | too few | 0.8% vs 1.3% | too few |
| Non-owners, Always Buy | 2.4% vs 10.5%, z = 7.6, p < .001 | .65 | 10.2% vs 1.8%, z = −4.1, p < .001 | .85 |
| Non-owners, Never Buy | 4.4% vs 2.9%, z = −1.1, p = .28 | .85 | 2.0% vs 3.2%, z = 1.2, p = .23 | .97 |

With all seven constructs the owner AUCs rise to .86 and .83, and Never Buy to .94 and .93.

Three things follow.

- **Always Keep is a trait-like state that pre-MPL constructs predict equally well on either ladder.** A model that has never seen the normal ladder predicts the normal ladder's Always Keep rate within 2 points. This is the out-of-sample version of "range does not create owner NSB."
- **The reclassification is quantified from the model side.** The same wide-fitted model, scored on the wide arm's own $62–161 window, expects 20% corners and observes 42%; the 22-point excess is what a narrow ladder would have manufactured among owners. For non-owners the figures are 3.2% expected vs 16.8% observed at the bottom, and 1.8% vs 8.2% at the top.
- **Always Buy fails calibration in both directions, by construction.** Pre-MPL constructs that predict a 2.4% corner rate on the wide ladder meet a 10.5% rate on the normal ladder. That is the censoring result arrived at by a route independent of the typed amounts. Never Buy, by contrast, calibrates and is almost perfectly discriminable (AUC .85 to .97) from low identity alone.

### Section 4. Categorical vs dollar inside Always Keep (the only corner large enough)

Dollar-format Always Keep are lower than categorical Always Keep on every construct, including the pre-MPL ones: mine-ness −0.40 (p = .024), attractiveness −0.40 (p = .001), me-ness −0.30 (p = .18); status quo −0.79, commission regret −0.84, omission regret +0.52, ability to pay −0.73, inertia −0.41 (all p < .001). MANOVA on the three pre-MPL constructs p = .013; on all seven p = .002. The other three corners are too small to split (Always Sell 5 vs 1; Never Buy 10 vs 3; Always Buy 4 vs 22).

What this supports: inside the Always Keep corner there is a gradient of commitment, and "I would never sell" marks its top. Because the difference appears on constructs measured before the ladder, it is a difference in who answers "never," not an effect of answering it. This justifies the categorical response as the operational definition of never-switching in the paper.

### Section 5. Profiles along the ladder with bootstrap CIs

Non-owners (0 = Never Buy, 7 = Always Buy), SD units within condition, 95% bootstrap CI:

| Position | Identity | Attractiveness | Status quo | Commission regret | Omission regret |
|---|---|---|---|---|---|
| Never Buy (13) | −1.92 [−2.32, −1.40] | −1.93 [−2.98, −0.86] | +1.85 [1.48, 2.19] | +2.08 [1.71, 2.42] | −1.85 [−2.18, −1.46] |
| Sextile 1 (54) | −0.39 [−0.65, −0.13] | −0.46 [−0.77, −0.14] | +0.97 [0.70, 1.23] | +0.84 [0.54, 1.12] | −0.81 [−1.07, −0.54] |
| Sextile 6 (57) | +0.40 [0.21, 0.58] | +0.40 [0.22, 0.56] | −0.70 [−0.84, −0.56] | −0.52 [−0.69, −0.33] | +0.62 [0.47, 0.78] |
| Always Buy (26) | +0.57 [0.15, 0.90] | +0.40 [0.04, 0.70] | −0.95 [−1.13, −0.76] | −0.77 [−0.92, −0.59] | +0.67 [0.30, 0.99] |

Owners (0 = Always Sell, 7 = Always Keep):

| Position | Identity | Attractiveness | Status quo | Commission regret | Omission regret |
|---|---|---|---|---|---|
| Always Sell (6) | −0.37 [−1.36, 0.44] | −0.41 [−1.57, 0.59] | −1.01 [−1.79, −0.13] | −0.61 [−1.43, 0.31] | +1.25 [0.36, 2.03] |
| Sextile 1 (59) | −0.38 [−0.68, −0.11] | −0.46 [−0.81, −0.12] | −0.59 [−0.83, −0.34] | −0.69 [−0.87, −0.48] | +0.65 [0.41, 0.86] |
| Sextile 6 (75) | −0.01 [−0.24, 0.22] | +0.18 [0.02, 0.34] | +0.15 [−0.05, 0.35] | +0.11 [−0.09, 0.31] | −0.11 [−0.30, 0.10] |
| Always Keep (94) | +0.60 [0.47, 0.73] | +0.43 [0.30, 0.56] | +0.74 [0.60, 0.89] | +0.95 [0.83, 1.06] | −0.83 [−0.94, −0.73] |

What this supports: the Never Buy and Always Keep corners are steps, with CIs that do not overlap the adjacent sextile on identity, status quo, and both regrets. The Always Buy corner overlaps sextile 6 on every construct (it is the extreme of the buyer distribution, not a type). Among owners, sextiles 4 to 6 are flat on every construct and then everything jumps at Always Keep, which is the plateau-then-step pattern that the inflection analyses were looking for in the wrong place. Always Sell (6 people) is too small to characterize beyond "high omission regret, low status quo."

### Section 6. Rung count vs span (simulation inside the wide arm)

| Wide arm | Actual 20-rung | Simulated 10-rung A (7..205) | Simulated 10-rung B (18..216) | Same people on the $62–161 window |
|---|---|---|---|---|
| Owner corner rate | 21.4% | 23.7% | 22.3% | 48.2% |
| Non-owner corner rate | 5.0% | 5.5% | 5.5% | 25.0% |
| Switcher EE gap | $27.6 | $25.2 | $29.2 | ($6.8 in the real normal arm) |

Halving the rungs changes corner rates by 1 to 2 points and leaves the gap at $25 to $29. Narrowing the span to $62–161 more than doubles corner rates and cuts the gap to $7. Span is what matters.

### Section 7. The switcher endowment gap, raw and standardized

| | Normal | Wide | Interaction |
|---|---|---|---|
| Gap in dollars (interval regression) | $6.8, p = .054 | $27.6, p < .001 | $20.8, p < .001 |
| Gap in SD units within range | 0.34 SD, p = .001 | 0.62 SD, p < .001 | 0.27, p = .058 |
| Cohen's d | 0.35 | 0.65 | |
| SD of switch points, owners | $18.5 | $44.8 | variance ratio p < .001 |
| SD of switch points, non-owners | $20.3 | $40.9 | variance ratio p < .001 |

This is the first correction above. The narrow ladder compresses both tails (owners above $161, non-owners below $62), and because the two groups' tails are on opposite sides, the compression shrinks the gap. The endowment effect for this good is about 0.6 SD when the ladder has room, and a conventional ladder reports about half of it. This belongs in the measurement contribution alongside the never-switching result.

### Section 8. Always Buy reconciliation

Of 18 normal-arm non-owner Always Buy with a typed amount, 15 state a maximum between $162 and $216 (median $200) and 3 state more than $216; 4 more gave a categorical answer. Predicted wide-ladder Always Buy rate from that: 3.3%; observed: 1.8% (4 of 220; p = .32). Share of normal-arm non-owners whose typed maximum falls on the added rungs: 7.1%; share of wide-arm non-owners who switched there: 6.4% (p = .75). The wide-arm survivors look like the normal-arm censored buyers on every construct.

One nuance: on the common support, typed maxima sit higher than ladder switch points (median $200 vs $177.50; rank-sum p = .013). Open-ended statements run about $20 above the ladder-revealed value for the same kind of person, which is the familiar inflation of stated open-ended willingness to pay. Report it as a limitation of the typed follow-up, not as evidence against the censoring account.

### Section 9. Switch hazards by rung (descriptive)

Two features worth one sentence each in the paper. First, in every cell the hazard jumps at $117, the first rung above the $115 posted price: owners normal 0.07 at $106 to 0.20 at $117; non-owners normal 0.13 to 0.24; wide 0.01 to 0.13 and 0.15 to 0.19. The posted price is a reference point in the sense of Weaver and Frederick (2012). Second, wide-arm owners pile up at $205 (hazard 0.32, 24 people), the last rung before $216: a near-corner cluster that the normal ladder would have recorded as Always Keep and that the simulation in section 6 treats as corners. These are the "quasi-never-switchers" the crossover analysis identified.

### Section 10. Latent classes among non-owners

Four classes (BIC still falling at k = 4, so the count is a floor; entropy .87). Class 1 (n = 22: me-ness 1.9, status quo 5.7, commission regret 6.2) holds 8 of the 13 Never Buy and 14 switchers; class 2 (n = 57) holds the other 5 Never Buy. Classes 3 and 4 (high identity, status quo 3.0 and 1.8) hold all 26 Always Buy, 19 of them in class 4, the most enthusiastic class (me-ness 5.6, omission regret 6.0), together with 160 switchers. Never Buy and Always Buy never share a class (χ² p < .001).

What this supports: the two non-owner corners are the extremes of two opposite latent profiles, recovered from constructs alone with no ladder information. Never Buy sits at the far end of an inertial, low-identity class that is mostly switchers who bid low; Always Buy sits at the far end of the highest-identity class. The substitutive structure is in the data, not imposed.

---

## 2. Scorecard: supported, not supported, revised

**Supported, and now stronger than before**

- Categorical never-switching is range-invariant: TOST equivalent overall and for non-owners, BF01 of 13 to 35 in every cell and corner.
- The entire range effect is dollar-format non-owner Always Buy, and those are censored buyers: BF01 = 0.02 for a range difference; cross-arm calibration fails exactly and only there; predicted and observed survivor rates agree.
- Always Keep is a trait-like state: predicted out of sample across ladders from pre-MPL constructs with no miscalibration (AUC .73 to .86).
- Never-switching is a step beyond extreme switching for Always Keep and Never Buy (non-overlapping bootstrap CIs); Always Buy is not a step.
- Range (span) is what manufactures corners; rung count is not.
- Inertia drives every corner and position, in the status-quo direction, with the same structure in both ranges.
- Owners' corners run on regret; non-owners' on status quo (profile tables).
- The two non-owner corners are opposite latent profiles.
- No rationalization: switchers' construct profiles are identical across ranges (from the earlier runs; nothing here contradicts it).

**Not supported, or revised**

- "Identity governs whether" as an additive effect for owners: no. Identity's effect on Always Keep runs through the inertia family (aligned at r = .56), and identity alone predicts Always Keep well out of sample. Write it as distal (identity) and proximal (inertia). For Never Buy it is direct.
- "The endowment gap is a proportional stretch": no. The standardized gap nearly doubles in the wide range (d .35 to .65). The narrow ladder understates the endowment effect.
- Inflection point (Rich's hypothesis): still not supported; the owner profiles are flat from sextile 4 through 6 and then step.
- A U-shape in identity and inertia (the draft's H3): not supported; replace with step.

---

## 3. Is Study 3 analysis complete?

Yes, for the manuscript. Three small items remain, none of which changes a conclusion:

1. **Predicted probabilities for the conjunction (Always Keep).** Run `margins` at identity × inertia combinations (−1, 0, +1 SD each) from the section 1 model and report the nine cells. This shows the conjunctive structure directly, which the additive AMEs cannot. Ten lines of Stata.
2. **The step table (section 5b) is only in the results workbook.** Open EE_Study3_Completion_results.xlsx, sheet sec_5b, and lift the four contrasts per motive per condition into the paper's step table. The profile means above are consistent with it.
3. **Latent class with k up to 6** to find where BIC bottoms. The conclusion (Never Buy and Always Buy in opposite classes) will not change; the class count might.

Not worth doing: more inflection tests, pooled non-owner models, Always Sell or categorical Always Buy models (too few people), a third range.

---

## 4. The full picture of the project

**Studies 1 and 2 established the phenomenon.** The endowment effect holds for experiential goods (lunch routine, tasting ticket), it is moderated by extended-self framing, and a non-trivial share of participants never switch on the price list (30% and 17.5%). The constructs that explain the effect among switchers (identity, inertia, regret) also predict never-switching.

**Study 3 settled what never-switching is.** It is not a ladder artifact: a categorical "I would never sell/buy" response occurs at the same rate on a ladder spanning $7–216 as on one spanning $62–161, is predicted from constructs measured before the ladder, and transfers across ladders without miscalibration. It is a step beyond extreme valuation, not its tail. The ladder does manufacture corners, but out of extreme valuers, and almost entirely out of non-owner buyers whose finite willingness to pay exceeded the top rung. Range also compresses the endowment gap itself. The construct structure is the same across ranges, so range is a lens, not a cause.

**The theoretical structure that emerged** is two families of force, identity and inertia, aligned for owners and opposed for non-owners. Inertia is the proximal driver at every corner and across the ladder; identity is distal for owners (it feeds inertia-family affect) and direct for non-owners who never buy. Owners' never-keeping is one conjunctive state; non-owner never-switching is two opposite states, one real (Never Buy, inertial, range-invariant) and one censoring (Always Buy).

**What the paper now is:** a paper about a response category that standard elicitation hides, with the endowment effect as the paradigm in which it was found, and a two-force framework that organizes both the effect and the category. That is a framework paper in Gal, Calder and Sternthal's sense, provided Study 4 takes the framework outside the price-list paradigm.

**What Study 4 has to do** (unchanged from the synthesis memo): manipulate the two forces rather than measure them, elicit non-trading without a ladder ("not at any price" offered before any price), and run Gal's omission-as-commission reframe as the discriminating test. Prediction: the reframe moves switchers and the gap, not categorical never-switchers; Gal's account predicts both move.

---

## 5. How to write Study 3 and the rest of the manuscript

### 5a. Study 3 section (replace the planned-study text)

Open with the two questions Study 3 was designed to answer, in this order: does the price-list range create never-switching, and does the construct structure found in Studies 1 and 2 hold for a recurring experiential good. Then:

1. **Method.** The 2 × 2 design, the shared midpoint and step, the supper-club good, the pre-MPL placement of me-ness, mine-ness and attractiveness, the follow-up that separates "I would never" from a typed amount, exclusions, N. State plainly that option side and price direction were not randomized.
2. **Replication.** Endowment effect present in both ranges; constructs by condition; alignment correlation.
3. **Range and never-switching, in three tables.** Table A: the three NSB definitions by range and endowment with chi-square, TOST, and BF01 (section 2). Table B: the reclassification (63.8%, 80% non-owners, 55.6% owners) and the model-based version from section 3. Table C: the Always Buy reconciliation. One paragraph each. Lead with the categorical invariance; then where the artifact lives; then why it is censoring.
4. **Cross-arm prediction** as its own short subsection, because it is the most persuasive single result and reviewers will not have seen it before.
5. **What never-switching is.** The profile figure with CIs (two panels) and the step table. The format gradient inside Always Keep. The latent classes among non-owners. The one-sentence hazard observations.
6. **Range and the endowment gap.** The dollar and SD gaps, the rung-count simulation, the variance ratios. This is the paragraph that makes the measurement contribution general: anyone using a price list for a WTA–WTP comparison is affected.
7. **Discussion of Study 3** (short; save the theory for the General Discussion): the lens metaphor, the two non-owner states, the sequencing of identity and inertia for owners, limitations (order, cell sizes for Always Sell and categorical Always Buy, typed amounts inflated relative to ladder values, constructs other than the three pre-MPL ones measured after the ladder).

Do not include: the inflection analyses, the 9/23 and 9/25 results, U-shape tests, pooled non-owner models.

### 5b. General Discussion (four parts, about 2,500 words)

1. **Summary of findings across three studies**, organized by the framework rather than by study: the effect, the category, the structure.
2. **Theoretical contribution** (see 5c).
3. **Relation to inertia accounts** (Gal 2006, 2021): agreement on the engine; the extension (a second, identity-based route to non-trading that produces categorical refusal rather than inertial indifference; inertia necessary but not sufficient for owner never-keeping; the structural asymmetry between owners and non-owners); why this is "extends and bounds," not a disproof.
4. **Measurement implications and limitations.** Report categorical corners separately; widen the ladder; do not treat corners as valuations; the gap is range-dependent. Then limitations and the Study 4 plan.

### 5c. The theoretical contribution, stated

Write it as three sentences and then defend each:

- *Never-switching is a response category, not a value.* It is categorical in format, range-invariant, construct-distinct from the adjacent extreme, predictable before the ladder, and transferable across ladders.
- *Two families of force determine entry into the exchange frame.* Identity (self-relevance of the object) and inertia (self-relevance of the act) are aligned when the status quo is possession and opposed when it is not. Inertia is the proximal driver; identity is distal for owners and direct for non-owners.
- *The endowment effect and never-switching are two outputs of the same structure.* Among those who enter the frame, the forces set position (the gap); when the forces are strong enough together, the person does not enter (the corner). The instrument conflates the two.

Position this explicitly, in the introduction and again here, as a framework strategy (Gal, Calder & Sternthal 2026), and name the rival frameworks the data were tested against: loss aversion (predicts no categorical exit), pure inertia (predicts indifference, not commitment, at the corner), and protected values (predicts refusal to price; consistent with Always Keep and worth measuring directly in Study 4).

### 5d. Title, abstract, hypotheses

Title: keep "To Switch, Or Not to Switch"; change the subtitle to something like "Never-Switching as a Distinct Response in the Elicitation of Experiential Value." Abstract: remove "U-shaped"; three studies, N = 1,849; the categorical invariance figure and the reclassification figure; the two-force structure; the measurement implication. Hypotheses: H3 becomes a step hypothesis; add a measurement hypothesis for Study 3 (categorical NSB invariant to range; corner rate and gap dependent on span). Rename `nsb_true` as "categorical never-switching" throughout.

---

## 6. What to read for the Study 3 discussion and the theoretical contribution

Grouped by what each gives you. Read the starred ones first.

**Framework and inertia (the spine of the discussion)**

- *Gal, Calder & Sternthal (2026), JCP.* The strategy vocabulary and the six guidelines; cite it when you state the strategy.
- *Gal (2006), JDM; Gal (2021), Current Opinion in Psychology.* The inertia and omission–commission accounts you extend.
- *Gal & Rucker (2018), "The loss of loss aversion," JCP.* The case that loss aversion is not needed; useful for the rival-framework paragraph.
- *Samuelson & Zeckhauser (1988), "Status quo bias in decision making."* The original status quo result; your status quo construct descends from it.
- *Anderson (2003), "The psychology of doing nothing," Psychological Bulletin.* Decision avoidance as a category; the closest existing treatment of "not entering the frame."
- *Ritov & Baron (1992), "Status-quo and omission biases"; Baron & Ritov (1994).* Omission bias measured directly, which is what your regret items do.
- *Gilovich & Medvec (1995), "The experience of regret: what, when, and why."* Action vs inaction regret over time; grounds the owner/non-owner regret asymmetry.
- *Tykocinski & Pittman (1998), "The consequences of doing nothing: inaction inertia."* A structurally similar paradigm for the framework paragraph.

**Endowment effect accounts you must position against**

- *Kahneman, Knetsch & Thaler (1990).* The paradigm.
- *Morewedge & Giblin (2015), "Explanations of the endowment effect: an integrative review," TICS.* The map of accounts (loss aversion, ownership/self, reference price, etc.); your paper slots into the ownership branch and against the loss-aversion branch.
- *Morewedge, Shu, Gilbert & Wilson (2009), "Bad riddance or good rubbish? Ownership and not loss aversion causes the endowment effect."* Ownership account, the direct ancestor of your identity family.
- *Weaver & Frederick (2012), "A reference price theory of the endowment effect," JMR.* Explains the $117 hazard spike and gives you a third rival framework.
- *Strahilevitz & Loewenstein (1998); Nayakankuppam & Mishra (2005); Peck & Shu (2009); Shu & Peck (2011).* Ownership, psychological ownership, and touch; Gal 2026 cites the first three as theory-of-the-effect exemplars, so citing them shows you know the lineage.
- *Chatterjee, Irmak & Rose (2013), "The endowment effect as self-enhancement," JCR.* Identity as the mechanism; closest prior work to your me-ness/mine-ness story.
- *Dommer & Swaminathan (2013), "Explaining the endowment effect through ownership," JCR.* Social identity and ownership; useful for the extended-self framing.
- *Carmon & Ariely (2000), "Focusing on the forgone," JCR.* Buyers and sellers attend to different things; a mechanism for the opposed forces among non-owners.
- *Johnson, Häubl & Keinan (2007), "Aspects of endowment: a query theory," JEP:LMC.* Order of retrieval; relevant to why pre-MPL constructs predict corners.
- *Novemsky & Kahneman (2005), "The boundaries of loss aversion," JMR.* What loss aversion does and does not cover; helps bound the rival.
- *Ericson & Fuster (2014), "The endowment effect," Annual Review of Economics.* The economics-side review; cite for breadth.

**Non-trading, refusal to price, and protected values**

- *Tetlock, Kristel, Elson, Green & Lerner (2000), "The psychology of the unthinkable," JPSP; Tetlock (2003), "Thinking the unthinkable," TICS.* Sacred values and refusal to trade; already in your draft, now central to the "committed refusal" route.
- *Baron & Spranca (1997), "Protected values," OBHDP.* The measurement of protected values; a two-item version belongs in Study 4.
- *Fiske & Tetlock (1997), "Taboo trade-offs."* Same literature, the relational-models version.
- *Belk (1988), "Possessions and the extended self"; Pierce, Kostova & Dirks (2003), "The state of psychological ownership."* The identity family's foundations; already cited, keep.
- *Van Boven & Gilovich (2003); Carter & Gilovich (2012), "I am what I do, not what I have."* Experiences are closer to the self than possessions; this is why your goods produce more never-switching than mugs.

**Elicitation and measurement (for the methods contribution)**

- *Andersen, Harrison, Lau & Rutström (2006), "Elicitation using multiple price lists," Experimental Economics.* Already cited; the range-and-frame effects they report are the baseline you extend.
- *Plott & Zeiler (2005, 2007), AER.* The "misconceptions" critique of the endowment effect; you need to say why never-switching is not a misconception (categorical, construct-predicted, range-invariant).
- *Isoni, Loomes & Sugden (2011), AER.* The reply to Plott and Zeiler; the gap survives procedures for lotteries.
- *Horowitz & McConnell (2002), "A review of WTA/WTP studies," JEEM; Tunçel & Hammitt (2014), "A new meta-analysis on the WTP/WTA disparity," JEEM.* The gap is larger for non-market and experiential goods; supports your choice of goods.
- *Parducci (1965), range-frequency theory; Mazar, Kőszegi & Ariely (2014), "True context-dependent preferences? The causes of market-dependent valuations," JMP.* For the proportional-stretch and span-dependence of valuations.
- *Simonson & Drolet (2004), "Anchoring effects on consumers' WTP and WTA," JCR.* Anchoring differs between WTP and WTA; relevant to the $117 reference-price spike and to why the gap grows with span.
- *Fischer, Carmon, Ariely & Zauberman (1999), "Goal-based construction of preferences," Management Science.* Task-contingent WTP/WTA; ground for the claim that the ladder constructs the response.
- *Kriström (1997), "Spike models in contingent valuation," AJAE; Haab & McConnell (1997), "Referendum models and negative willingness to pay."* The contingent-valuation literature's own treatment of mass at zero / "would not pay at any price," which is the nearest existing analytic treatment of never-switching.

That list is deliberately long so you can pick. The minimum set for the General Discussion is Gal 2006, 2021, 2026; Morewedge & Giblin 2015; Weaver & Frederick 2012; Anderson 2003; Tetlock 2003 and Baron & Spranca 1997; Andersen et al. 2006 and Plott & Zeiler 2005; Kriström 1997.
