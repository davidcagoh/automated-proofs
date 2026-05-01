import Mathlib
import JepaLearningOrder.JEPA

/-!
# Helper lemmas for `laurent_separation_dominates`

These lemmas support the ε-asymptotic argument that the Laurent-sum gap
dominates the perturbation error for small ε.
-/

set_option linter.style.longLine false
set_option linter.style.whitespace false

open scoped Matrix

variable {d : ℕ}

/-
`projectedCovariance` is strictly positive.
-/
lemma projectedCovariance_pos (dat : JEPAData d) (eb : GenEigenbasis dat) (r : Fin d) :
    0 < projectedCovariance dat eb r := by
  exact mul_pos ( eb.pairs r |>.hrho_pos ) ( eb.pairs r |>.hmu_pos )

/-
When `ρ_s < ρ_r` and `λ_s ≤ λ_r`, the product `λ * ρ` is strictly ordered.
    Since `λ = ρ * μ`, we have `λ * ρ = ρ² * μ`, and the argument uses
    `λ_s * ρ_s = (ρ_s * μ_s) * ρ_s ≤ (ρ_r * μ_r) * ρ_s < (ρ_r * μ_r) * ρ_r = λ_r * ρ_r`.
-/
lemma projCov_mul_rho_strict_lt (dat : JEPAData d) (eb : GenEigenbasis dat)
    (r s : Fin d)
    (hrho : (eb.pairs s).rho < (eb.pairs r).rho)
    (hlam : projectedCovariance dat eb s ≤ projectedCovariance dat eb r) :
    projectedCovariance dat eb s * (eb.pairs s).rho <
    projectedCovariance dat eb r * (eb.pairs r).rho := by
  exact lt_of_le_of_lt ( mul_le_mul_of_nonneg_right hlam ( le_of_lt ( eb.pairs s |>.hrho_pos ) ) ) ( mul_lt_mul_of_pos_left hrho ( projectedCovariance_pos dat eb r ) )

/-
The product `projectedCovariance * ρ^k` is (weakly) monotone for `k : ℕ`.
-/
lemma projCov_mul_rho_pow_le (dat : JEPAData d) (eb : GenEigenbasis dat)
    (r s : Fin d) (k : ℕ)
    (hrho : (eb.pairs s).rho < (eb.pairs r).rho)
    (hlam : projectedCovariance dat eb s ≤ projectedCovariance dat eb r) :
    projectedCovariance dat eb s * (eb.pairs s).rho ^ k ≤
    projectedCovariance dat eb r * (eb.pairs r).rho ^ k := by
  gcongr;
  · exact pow_nonneg ( le_of_lt ( eb.pairs s |>.hrho_pos ) ) _;
  · exact le_of_lt ( projectedCovariance_pos dat eb r );
  · exact le_of_lt ( eb.pairs s |>.hrho_pos )

/-
General Finset lemma: if f ≥ g pointwise on s, then
    `∑ f - ∑ g ≥ f a - g a` for any `a ∈ s`.
-/
lemma Finset.sum_sub_ge_single {ι : Type*} [DecidableEq ι] {s : Finset ι} {f g : ι → ℝ}
    (hle : ∀ i ∈ s, g i ≤ f i) {a : ι} (ha : a ∈ s) :
    f a - g a ≤ ∑ i ∈ s, f i - ∑ i ∈ s, g i := by
  simpa only [ ← Finset.sum_sub_distrib ] using Finset.single_le_sum ( fun i _ => sub_nonneg.2 ( hle i ‹_› ) ) ha

/-
The key exponent splitting: `ε^{(2L-2)/L} = ε¹ · ε^{(L-2)/L}` for `ε > 0`.
-/
lemma rpow_two_L_minus_two_split (ε : ℝ) (hε : 0 < ε) (L : ℕ) (hL : 2 ≤ L) :
    ε ^ ((2 * (L : ℝ) - 2) / (L : ℝ)) = ε * ε ^ (((L : ℝ) - 2) / (L : ℝ)) := by
  rw [ show ( 2 * L - 2 : ℝ ) / L = 1 + ( L - 2 ) / L by rw [ one_add_div ( by positivity ) ] ; ring, Real.rpow_add hε, Real.rpow_one ]