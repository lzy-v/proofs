(**********************)
(**********************)
(****              ****)
(****   Functors   ****)
(****              ****)
(**********************)
(**********************)

Require Import Main.CategoryTheory.Category.
Require Import Main.Tactics.

Set Universe Polymorphism.

(* Metavariables for functors: F, G, H *)

Record functor {C D : category} := newFunctor {
  oMap : object C -> object D;
  fMap : forall {x y}, arrow C x y -> arrow D (oMap x) (oMap y);

  fIdent : forall x, fMap (@id C x) = @id D (oMap x);
  fComp :
    forall x y z (f : arrow C x y) (g : arrow C y z),
    compose D (fMap g) (fMap f) = fMap (compose C g f);
}.

Hint Rewrite @fIdent.
Hint Rewrite @fComp.

Definition idFunctor {C : category} : @functor C C.
Proof.
  refine (newFunctor C C
    (fun x => x)
    (fun x y f => f)
    _ _
  ); magic.
Defined.

Definition compFunctor
  {C D E : category}
  (F : @functor D E)
  (G : @functor C D) :
  @functor C E.
Proof.
  refine (newFunctor C E
    (fun (x : object C) => oMap F (oMap G x))
    (fun {x y : object C} (f : arrow C x y) => fMap F (fMap G f))
    _ _
  ); magic.
Defined.
