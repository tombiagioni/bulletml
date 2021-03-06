(** Abstract syntax of BulletML programs. *)

(** Binary operations *)
type op =
  | Add
  | Sub
  | Mul
  | Div
  | Mod

type expr =
  | Num of float (** Constant *)
  | Op of op * expr * expr (** Binary operation *)
  | Param of int (** Function parameter *)
  | Rand (** Random value between 0.0 and 1.0 *)
  | Rank (** Difficulty factor, between 0.0 and 1.0 *)

type speed =
  | SpdAbs of expr
  | SpdRel of expr
  | SpdSeq of expr

type direction =
  | DirAbs of expr
  | DirSeq of expr
  | DirAim of expr
  | DirRel of expr

type 'a id = string

type 'a ind =
  | Direct of 'a
  | Indirect of 'a id * expr list

type subaction =
  | Repeat of expr * action ind
  | Fire of fire ind
  | ChangeSpeed of speed * expr
  | ChangeDirection of direction * expr
  | Accel of expr option * expr option * expr
  | Wait of expr
  | Vanish
  | Action of action ind

and action = subaction list

and bullet = Bullet of direction option * speed option * action ind list

and fire = direction option * speed option * bullet ind

type orientation =
  | Horizontal
  | Vertical

type elem =
  | EBullet of string * bullet
  | EAction of string * action
  | EFire of string * fire

type t = BulletML of orientation option * elem list

let ( +@ ) = fun x y -> Op (Add, x, y)
let ( -@ ) = fun x y -> Op (Sub, x, y)
let ( *@ ) = fun x y -> Op (Mul, x, y)
let ( /@ ) = fun x y -> Op (Div, x, y)
let ( %@ ) = fun x y -> Op (Mod, x, y)
let ( ~@ ) = fun x   -> Num 0. -@ x
let bulletDefault = Bullet (None, None, [])
