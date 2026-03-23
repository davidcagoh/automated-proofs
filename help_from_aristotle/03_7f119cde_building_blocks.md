# Aristotle Submission: 7f119cde

**Job ID**: `7f119cde-8885-4961-9a78-22f6659788eb`
**Submitted**: 2026-03-23T00:18 UTC
**Paper**: `my_theorems/JEPA_Proof_Lecture_v3.md`
**Status**: IN_PROGRESS

## Prompt

```
Fill in the sorries in AutomatedProofs/JEPA.lean. Focus ONLY on these three lemmas:
diagonal_ODE (line ~288), offDiag_ODE (line ~427), preconditioner_integral_bounded
(line ~461). The helper lemmas in AutomatedProofs/Lemmas.lean are already proved and
available. Leave all other sorries (quasiStatic_approx, offDiag_bound,
JEPA_rho_ordering) untouched.
```

## Files Sent

- `.gitignore`
- `AutomatedProofs.lean`
- `AutomatedProofs/Basic.lean`
- `AutomatedProofs/JEPA.lean`
- `AutomatedProofs/Lemmas.lean`
- `README.md`
- `lake-manifest.json`
- `lakefile.toml`
- `lean-toolchain`

## Tier

**Tier**: 1 of 2 (see `02_jepa_ode_overview.md`)
**Depends on jobs**: none — all three are formally independent in Lean (deps passed as hypotheses)
**Unblocks**: `04_be5085d7` — specifically `JEPA_rho_ordering`, which formally calls all three

## Target Lemmas

### `diagonal_ODE` (line ~288)
**Statement**: σ̇_r ≈ σ_r^{3-1/L}·λ_r* - σ_r^3·λ_r*/ρ_r* up to O(ε^{1/L}).
**Approach**: Expand preconditioned gradient flow ODE, apply `gradient_projection`
(already proved), substitute quasi-static decoder approximation, bound off-diagonal
corrections via (H-offdiag).

### `offDiag_ODE` (line ~427)
**Statement**: |ċ_{rs} + P_{rs}(t)·ρ_r*(ρ_r*-ρ_s*)·μ_s·c_{rs}| ≤ C·ε^{(2L-1)/L}.
**Approach**: Similar ODE expansion for off-diagonal terms with quasi-static
substitution. Analogous to diagonal_ODE but for cross terms.

### `preconditioner_integral_bounded` (line ~461)
**Statement**: ∫₀^{t_max} P_{rs}(u) du = O(1) for L ≥ 2.
**Approach**: Change-of-variables integral using the diagonal ODE lower bound. Key:
exponent -1/L > -1 (integrable singularity) for L ≥ 2.

## Justification

These three are the "building block" ODE lemmas — they have no cross-dependencies on
each other and are cleaner than the harder assembly lemmas. Submitted as a focused job
to give Aristotle the best chance of success without getting stuck on the hardest lemma
(quasiStatic_approx).

**Why can't we do these locally?** All three require HasDerivAt on σ_r and c_{rs},
norm estimates on the ODE residual, and substitution of the quasi-static approximation
— a chain of real-analysis steps that `ring`/`linarith`/`simp` cannot close.

**History**: Previous omnibus job `500764f2` (6 sorries, all at once) got stuck at 8%
after several hours. Cancelled and split into two focused jobs.

## Outcome

<!-- Fill in after job completes -->
