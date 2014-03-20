open Bulletml.Syntax
open Bulletml.Interp
open Bulletml.Interp_types

let bml = (*{{{*)
  BulletML (Horizontal, [EAction ("top", [Repeat (Num 20.,Direct ([Fire (Direct ((Some (DirAim (((Num 0. -@ Num 60.) +@ (Rand *@ Num 120.)))), None, Indirect ("hmgLsr", [])))); Repeat (Num 8.,Direct ([Wait (Num 1.); Fire (Direct ((Some (DirSeq (Num 0.)), None, Indirect ("hmgLsr", []))))])); Wait (Num 10.)])); Wait (Num 60.)]); EBullet ("hmgLsr",Bullet (None,Some (SpdAbs (Num 2.)),[Direct ([ChangeSpeed (SpdAbs (Num 0.3),Num 30.); Wait (Num 100.); ChangeSpeed (SpdAbs (Num 5.),Num 100.)]); Direct ([Repeat (Num 12.,Direct ([ChangeDirection (DirAim (Num 0.),(Num 45. -@ (Rank *@ Num 30.))); Wait (Num 5.)]))])]))])
(*}}}*)

let screen_w = 400
let screen_h = 300
let enemy_pos = (200., 100.)
let ship_pos = ref (200., 250.)

let params =
  { p_screen_w = screen_w
  ; p_screen_h = screen_h
  ; p_enemy = enemy_pos
  ; p_ship = !ship_pos
  }

let mouse_handler e =
  ship_pos := (float e##clientX, float e##clientY);
  Js._true

let create_canvas () =
  let c = Dom_html.createCanvas Dom_html.document in
  c##width <- screen_w;
  c##height <- screen_h;
  c##onmousemove <- Dom_html.handler mouse_handler;
  c

let draw_px ~color ctx data i j =
  let (r, g, b) = color in
  let p = 4 * (j * screen_w + i) in
  Dom_html.pixel_set data (p+0) r;
  Dom_html.pixel_set data (p+1) g;
  Dom_html.pixel_set data (p+2) b;
  Dom_html.pixel_set data (p+3) 255;
  ()

(* A clearRect would be better but it does not work *)
let clear (ctx, img) =
  let data = img##data in
  let color = (0xff, 0xff, 0xff) in
  for i = 0 to screen_w do
    for j = 0 to screen_h do
      draw_px ~color ctx data i j
    done
  done

let draw_bullet ?(color=(0xfa, 0x69, 0x00)) ctx img x y =
  let data = img##data in
  let i0 = int_of_float x in
  let j0 = int_of_float y in
  let pix =
    [ -2,  0 ; -2,  1 ; -2,  2 ; -2, -1
    ; -1,  0 ; -1,  1 ; -1,  2 ; -1,  3
    ; -1, -1 ; -1, -2 ;  0,  0 ;  0,  1
    ;  0,  2 ;  0,  3 ;  0, -1 ;  0, -2
    ;  1,  0 ;  1,  1 ;  1,  2 ;  1,  3
    ;  1, -1 ;  1, -2 ;  2,  0 ;  2,  1
    ;  2,  2 ;  2,  3 ;  2, -1 ;  2, -2
    ;  3,  0 ;  3,  1 ;  3,  2 ;  3, -1
    ]
  in
  List.iter (fun (i, j) -> draw_px ~color ctx data (i0 + i) (j0 + j)) pix

let draw (ctx, img) root =
  let objs =
    List.filter
      (fun o -> not o.vanished)
      (collect_obj root)
  in
  let r = ref 0 in
  List.iter (fun o -> let (x, y) = o.pos in draw_bullet ctx img x y;incr r) objs;
  !r

let draw_ship (ctx, img) =
  let color = (0x69, 0xD2, 0xE7) in
  let (x, y) = !ship_pos in
  draw_bullet ~color ctx img x y

let draw_msg ctx msg =
  ctx##fillText (Js.string msg, 0., 10.)

let _ =
  let open Lwt in
  let canvas = create_canvas () in
  Dom.appendChild Dom_html.document##body canvas;
  let (global_env, obj0, _top) = prepare bml params in
  let stop = ref false in
  canvas##onclick <- Dom_html.handler (fun e -> stop := true ; Js._true);
  let rec go frame obj () =
    let env =
      { global_env with
        frame = frame
      ; ship_pos = !ship_pos
      }
    in
    let ctx = canvas##getContext (Dom_html._2d_) in
    let img = ctx##getImageData (0., 0., float screen_w, float screen_h) in
    clear (ctx, img);
    let perf = draw (ctx, img) obj in
    draw_ship (ctx, img);
    ctx##putImageData (img, 0., 0.);
    draw_msg ctx (string_of_int perf ^ " bullets");
    let k = if !stop then begin
        stop := false;
        go 1 obj0
      end else
        go (frame + 1) (animate env obj)
    in
    Lwt_js.yield () >>= k
  in
  go 1 obj0 ()