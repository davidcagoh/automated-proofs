# Aristotle Help Request: Lemmas.lean Remaining Sorries

**Date:** 2026-03-22
**Submitted file:** `AutomatedProofs/Lemmas.lean`
**Prompt to use:** `"Fill in all the sorries in this project"`

---

## What we're asking Aristotle to prove

Three sorry'd lemmas in `AutomatedProofs/Lemmas.lean`. The file also contains
`gronwall_integral_ineq` which is ALREADY PROVED (no sorry). Aristotle should
not need to touch it, but it serves as context.

### 1. `pd_quadratic_lower_bound` (line ~65)

**Statement:** For a positive definite d×d real matrix A, there exists λ > 0 such that
`dotProduct x (A.mulVec x) ≥ λ * dotProduct x x` for all x.

**Why it needs Aristotle:** This is the Rayleigh quotient minimum on a compact sphere —
a standard linear algebra result, but requires `IsCompact.exists_isMinOn` applied to the
unit sphere in `Fin d → ℝ`. Aristotle is better positioned to navigate the exact Mathlib
API for compactness arguments in finite-dimensional spaces.

**PROVIDED SOLUTION block is included in the docstring** with exact steps.

### 2. `frobenius_pd_lower_bound` (line ~86)

**Statement:** For positive definite A and any matrix M:
`Matrix.trace (Mᵀ * M * A) ≥ λ * Matrix.trace (Mᵀ * M)`

**Why it needs Aristotle:** Depends on #1. Once #1 is proved, this reduces to a
column-by-column sum argument using `Matrix.trace` as a sum over diagonal entries.
The `sorry` body already sets up the key intermediate step.

**PROVIDED SOLUTION block is included in the docstring.**

### 3. `gronwall_approx_ode_bound` (line ~260)

**Statement:** If `|f'(t) + α(t)·f(t)| ≤ η` and `|f(0)| ≤ f₀`, then
`|f(t)| ≤ (f₀ + T·η) · exp(A_int)` where `A_int ≥ ∫₀ᵗ α`.

**Why it needs Aristotle:** Requires FTC (expressing |f(t)| via |f(0)| + ∫|f'|),
then applying `gronwall_integral_ineq` (which IS proved in this file). The key
intermediates are: `|f'| ≤ α|f| + η`, triangle inequality under FTC, then Gronwall.

**PROVIDED SOLUTION block is included in the docstring.**

---

## Justification for submitting

These 3 lemmas are:
1. **Contained**: each sorry'd goal is small and well-specified with a PROVIDED SOLUTION
2. **Not blocked on unproved Mathlib gaps**: unlike `gronwall_integral_ineq` (which we
   proved manually), these use standard Mathlib results for compactness and analysis
3. **Good Aristotle fit**: Aristotle excels at navigating Mathlib API for known-result proofs

We are NOT asking Aristotle to prove the JEPA-specific ODE lemmas
(`quasiStatic_approx`, `diagonal_ODE`, `offDiag_ODE`) which require deep matrix ODE
expertise and have failed 3 times in previous submissions.

---

## Submission instructions

```bash
# Preview what will be packaged (should be minimal: just the Lean project files)
python scripts/submit.py my_theorems/JEPA.md "Fill in all the sorries in AutomatedProofs/Lemmas.lean" --dry-run

# Submit for real
python scripts/submit.py my_theorems/JEPA.md "Fill in all the sorries in AutomatedProofs/Lemmas.lean"
```

**Note:** The submission packages the full project (not just Lemmas.lean), but the prompt
directs Aristotle to focus on Lemmas.lean. JEPA.lean sorries are intentionally left for a
future submission once the Lemmas are proved.

## Expected result

When Aristotle completes:
```bash
python scripts/retrieve.py
```
Then check `reports/JEPA_annotated.md` for the sorry-fill status.
