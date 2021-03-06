
let testspecs =
  let open Bulletml.Syntax in
  [ ("fragments/01.xml", `Bullet ( (*{{{*)
       Bullet (Some (DirAim (Num 270.)), Some (SpdAbs (Num 2.)), [
           Direct [Accel (None, Some (Num 3.), Num 120.)]
         ]
         ))) (*}}}*)
  ; ("fragments/02.xml", `Action (*{{{*)
       [ ChangeSpeed (SpdAbs (Num 0.), Num 60.)
       ; Wait (Num 60.)
       ; Fire (Direct (None, None, Direct bulletDefault))
       ; Fire (Direct (Some (DirAbs (
           Num 330. +@ Rand *@ Num 25.
         )), None, Indirect ("downAccel", [])))
       ; Vanish
       ]) (*}}}*)
  ; ("fragments/03.xml", `Fire (*{{{*)
       (Some (DirAbs (Num 270.)), Some (SpdAbs (Num 2.)), Indirect ("rocket", []))
    ) (*}}}*)
  ; ("fragments/04.xml", `Action (*{{{*)
       [ Repeat (Num 100., Direct [
            Fire (Direct (Some (DirAbs (
                Num 220. +@ Rand *@ Num 100.
              )), None, Indirect ("backBurst", [])))
          ; Wait (Num 6.)
          ])
       ]) (*}}}*)
  ; ("[Dodonpachi]_hibachi.xml"), `Bulletml ( (* {{{ *)
      BulletML (None,
                [ EAction ("allWay",
                           [ Fire
                               ( Direct
                                   ( Some (DirAim (Op (Add, ~@ (Num 50.), Op (Mul, Rand, Num 20.))))
                                   , Some (SpdAbs (Op (Add, Num 1., Rank)))
                                   , Direct bulletDefault
                                   )
                               )
                           ; Repeat
                               ( Op (Add, Num 15., Op (Mul, Op (Mul, Num 16., Rank), Rank))
                               , Direct
                                   [ Fire
                                       ( Direct
                                           ( Some (DirSeq (Op (Sub, Num 24., Op (Mul, Rank, Num 12.))))
                                           , Some (SpdSeq (Num 0.))
                                           , Direct bulletDefault
                                           )
                                       )
                                   ])
                           ])
                ; EAction ("right",
                           [ ChangeDirection (DirAbs (Num 90.), Num 1.)
                           ; ChangeSpeed (SpdAbs (Num 1.), Num 1.)
                           ; Repeat
                               ( Num 25.
                               , Direct
                                   [ Action (Indirect ("allWay", []))
                                   ; Wait (Num 3.)
                                   ])
                           ])

                ; EAction ("left",
                           [ ChangeDirection (DirAbs (~@ (Num 90.)), Num 1.)
                           ; ChangeSpeed (SpdAbs (Num 1.), Num 1.)
                           ; Repeat
                               ( Num 25.
                               , Direct
                                   [ Action (Indirect ("allWay", []))
                                   ; Wait (Num 3.)
                                   ])
                           ])

                ; EAction ("top",
                           [ Repeat
                               ( Num 2.
                               , Direct
                                   [ Action (Indirect ("right", []))
                                   ; Action (Indirect ("left", []))
                                   ; Action (Indirect ("left", []))
                                   ; Action (Indirect ("right", []))
                                   ])
                           ; ChangeSpeed (SpdAbs (Num 0.), Num 1.)
                           ; Wait (Num 1.)
                           ])
                ]))
  (* }}} *)
  ; ("[MDA]_circular_sun.xml", `Bulletml ( (* {{{ *)
      BulletML (Some Vertical,
                [ EAction ("top",
                           [ ChangeSpeed (SpdAbs (Num 0.75), Num 1.)
                           ; ChangeDirection (DirAbs (Num 90.), Num 1.)
                           ; Wait (Num 1.)
                           ; ChangeDirection (DirSeq (Num 0.7), Num 514.)
                           ; Wait (Num 2.)
                           ; Repeat (Num 32., (Direct
                                                 [ Action (Indirect ("shoot", []))
                                                 ; Wait (Num 16.)
                                                 ]))
                           ; ChangeSpeed (SpdAbs (Num 0.), Num 1.)
                           ; Wait (Num 120.)
                           ])
                ; EAction ("shoot",
                           [ Repeat (Num 1. +@ Num 63. *@ Rank, Direct
                                       [ Fire (Direct
                                                 ( Some (DirSeq (Num 360. /@ (Num 1. +@ Num 63. *@ Rank)))
                                                 , Some (SpdAbs (Num 1.28 +@ Num 0.08 *@ Rand))
                                                 , Indirect ("curve", [])
                                                 ))])
                           ])
                ; EBullet ("curve",
                           Bullet (None, None, [ Direct
                                                   [ ChangeDirection (DirSeq (Num 1.25 -@ Num 1.6 *@ Rand), Num 360.)
                                                   ; Wait (Num 360.)
                                                   ; Vanish
                                                   ]
                                               ]))
                ])
    )
    )
  (* }}} *)
  ; ("[1943]_rolling_fire.xml", `Bulletml ( (* {{{ *)
      BulletML (Some Vertical,
                [ EAction ("top",
                           [ Fire (Direct (None, None, Indirect ("roll", [])))
                           ])
                ; EBullet ("roll",
                           Bullet (None , None, [ Direct
                                                    [ Wait (Num 40. +@ Rand *@ Num 20.)
                                                    ; ChangeDirection (DirRel
                                                                         (~@ (Num 90.)), Num 4.)
                                                    ; ChangeSpeed (SpdAbs (Num 3.), Num 4.)
                                                    ; Wait (Num 4.)
                                                    ; ChangeDirection (DirSeq (Num 15.), Num 9999.)
                                                    ; Wait (Num 80. +@ Rand *@ Num 40.)
                                                    ; Vanish
                                                    ]]))
                ]
               )))
  (* }}} *)
  ; ("[Dodonpachi]_kitiku_1.xml", `Bulletml ( (* {{{ *)
      BulletML (None,
                [ EBullet ("fast",
                           Bullet (None, Some (SpdAbs (Num 10.)), [ Direct (
                               [ Wait (Num 6.)
                               ; ChangeSpeed (SpdAbs (Num 0.), Num 1.)
                               ; Wait (Num 20.)
                               ; Repeat ((Num 10. +@ Rank *@ Num 18.), Direct (
                                   [ Fire (Direct (( Some (DirSeq (((~@ (Num 11.)) -@ Rand *@ Num 2.)))
                                                   , Some (SpdAbs (Num 1.5))
                                                   , Direct bulletDefault)))
                                   ; Action (Indirect ("add3", []))
                                   ; Repeat (Num 4., Direct (
                                       [ Fire (Direct (( Some (DirSeq (Num 0.))
                                                       , Some (SpdSeq ((Num 0.1 +@ (Rank *@ Num 0.2))))
                                                       , Direct bulletDefault)))
                                       ; Action (Indirect ("add3", []))
                                       ]))
                                   ; Wait ((Num 336. /@ (Num 10. +@ Rank *@ Num 18.)))]))
                               ; Vanish
                               ])]))
                ; EAction ("add3",
                           [ Repeat (Num 3., Direct ([Fire (Direct (( Some (DirSeq (Num 90.))
                                                                    , Some (SpdSeq (Num 0.))
                                                                    , Direct bulletDefault)))]))
                           ])
                ; EFire ("slowColorChange",
                         ( Some (DirAbs ((Num 180. +@ Num 45. *@ Param 1)))
                         , Some (SpdAbs (Num 7.))
                         , Direct (Bullet (None, None, [Direct (
                             [ Wait (Num 6.)
                             ; ChangeSpeed (SpdAbs (Num 0.), Num 1.)
                             ; Repeat ((Num 50. +@ Rank *@ Num 50.), Direct (
                                 [ Fire (Direct (( Some (DirSeq (((Num 8. -@ Rank *@ Num 4.) *@ Param 1)))
                                                 , Some (SpdAbs (Num 1.2))
                                                 , Direct bulletDefault)))
                                 ; Action (Indirect ("add3", []))
                                 ; Wait (((Num 8. -@ Rank *@ Num 4.) +@ Rand))
                                 ]))
                             ; Vanish
                             ])]))))
                ; EFire ("slow",
                         ( None
                         , None
                         , Direct (Bullet (None, None, [Direct (
                             [ Fire (Indirect ("slowColorChange", [Param 1]))
                             ; Vanish
                             ])]))))
                ; EAction ("top",
                           [ Fire (Direct ((Some (DirAbs (~@ (Num 85.))), None, Indirect ("fast", []))))
                           ; Wait (Num 1.)
                           ; Fire (Direct ((Some (DirAbs (Num 85.)), None, Indirect ("fast", []))))
                           ; Wait (Num 1.)
                           ; Fire (Indirect ("slow", [Num (1.)]))
                           ; Wait (Num 1.)
                           ; Fire (Indirect ("slow", [~@ (Num 1.)]))
                           ; Wait (Num 430.)
                           ])
                ])
    ))
  (* }}} *)
  ]

let clist lx ly =
  List.for_all2 OUnit.cmp_float lx ly

let tests () =
  let mk_test (n, s) =
    let run_test () =
      let fname = "examples/" ^ n in
      let x = Xml.parse_file fname in
      let str = Xml.to_string_fmt x in
      print_endline str;
      match s, x with
      | `Bullet bspec, Xml.Element ("bullet", _, ns) ->
        let b = Bulletml.Parser.parse_bullet ns in
        OUnit.assert_equal bspec b
      | `Action aspec, Xml.Element ("action", [], ns) ->
        let a = Bulletml.Parser.parse_action ns in
        OUnit.assert_equal aspec a
      | `Fire fspec, Xml.Element ("fire", [], ns) ->
        let f = Bulletml.Parser.parse_fire ns in
        OUnit.assert_equal fspec f
      | `Bulletml bspec, _ ->
        let b = Bulletml.Parser.parse_xml x in
        OUnit.assert_equal ~printer:Bulletml.Printer.print_bulletml bspec b
      | _ -> assert false
    in
    (n, `Quick, run_test)
  in
  List.map mk_test testspecs

let parse_example n =
  Bulletml.Parser.parse_auto ("examples/" ^ n)

let for_all_examples f () =
  let files_a = (Sys.readdir "examples") in
  Array.sort String.compare files_a;
  let files =
    List.filter
      (fun x -> "examples/" ^ x |> Sys.is_directory |> not)
      (Array.to_list files_a)
  in
  List.iter (fun n ->
      f n (parse_example n)
    ) files

let compile b =
  let open Bulletml.Syntax in
  let open Bulletml.Interp_types in
  let params =
    { p_ship = (100., 50.)
    ; p_enemy = (100., 300.)
    ; p_screen_w = 200
    ; p_screen_h = 200
    ; p_rank = 0.5
    }
  in
  let (env, obj, top) = Bulletml.Interp.prepare b params () in
  let top_act = List.assoc top env.actions in
  Bulletml.Interp.build_prog env [] (Action (Direct top_act))

let compspecs =
  let open Bulletml.Syntax in
  let open Bulletml.Interp_types in
  [ ("[1943]_rolling_fire.xml",
     [ OpEnterScope
     ; OpFire ((None, None, Indirect ("roll", [])))
     ; OpLeaveScope
     ])
  ; ("[Bulletsmorph]_aba_4.xml",
     [ OpEnterScope
     ; OpFire (None, Some (SpdAbs (Num 0.1)), Indirect ("cross", []))
     ; OpWaitE (Num 5.)
     ; OpRepeatE
         ( Num 40. +@ (Num 60.) *@ Rank
         , [ Fire ( Direct
                      ( None
                      , Some (SpdSeq (Num 0.04))
                      , Indirect ("cross", [])
                      )
                  )
           ; Wait (Num 20. -@ (Num 10.) *@ Rank)
           ]
         )
     ; OpWaitE (Num 60.)
     ; OpLeaveScope
     ])
  ; ("[OtakuTwo]_self-2020.xml",
     [ OpEnterScope
     ; OpDirE (DirAbs (Num 0.), Num 1.)
     ; OpWaitE (Num 1.)
     ; OpSpdE (SpdAbs (Num 5.), Num 1.)
     ; OpWaitE (Num 15.)
     ; OpSpdE (SpdAbs (Num 0.), Num 1.)
     ; OpRepeatE (Num 45.,
                  [ Fire (Indirect ("seed", [Num 1.]))
                  ; Fire (Indirect ("seed", [Num 0. -@ Num 1.]))
                  ; Wait (Num 30.)
                  ])
     ; OpWaitE (Num 450.)
     ; OpLeaveScope
     ])
  ; ("[ESP_RADE]_round_5_boss_gara_5.xml",
     [ OpEnterScope
     ; OpEnterScope
     ; OpCall ("gara5", [])
     ; OpLeaveScope
     ; OpLeaveScope
     ])
  ]

let tests_compile () =
  let open Bulletml.Syntax in
  let open Bulletml.Interp_types in
  let printer ops = Bulletml.Printer.print_list Bulletml.Printer.print_opcode ops in
  let mk_test (n, spec) =
    let f () =
      let got =
        compile (parse_example n)
      in
      OUnit.assert_equal ~printer got spec;
    in
    (n, `Quick, f)
  in
  let mk_test_direct (n, a, spec) =
    let f () =
      let got =
        compile (BulletML (Some Vertical, [EAction ("top", a)]))
      in
      OUnit.assert_equal ~printer got spec;
    in
    (n, `Quick, f)
  in
  let compspecs_dir =
    [ ("vanish", [Vanish], [OpVanish])
    ; ("accel", [Accel(Some (Num 3.), Some (Num 5.), Num 1.)],
       [OpAccelE(Num 3., Num 5., Num 1.)])
    ; ("acceldef", [Accel(None, None, Num 1.)],
       [OpAccelE(Num 0., Num 0., Num 1.)])
    ]
  in
  let enclose_scope (n, sas, ops) =
    (n, sas, OpEnterScope :: ops @ [OpLeaveScope])
  in
  List.map mk_test compspecs @ List.map mk_test_direct (List.map enclose_scope compspecs_dir)

let parse_all =
  for_all_examples (fun _n _b -> ())

let compile_all =
  for_all_examples (fun n b ->
      try
        let _ops = compile b in ()
      with Not_found ->
        OUnit.assert_failure ("Cannot compile " ^ n)
    )

let tests_interp () =
  let open Bulletml.Interp in
  let open Bulletml.Interp_types in
  let open Bulletml.Syntax in
  let env =
    { frame = 0
    ; ship_pos = (1., 0.)
    ; screen_w = 10
    ; screen_h = 10
    ; actions = [("f", [])]
    ; bullets = []
    ; fires = []
    ; hooks = []
    ; rank = 0.5
    }
  in
  let make_tc (name, before, after) =
    let f () =
      let o = initial_obj before (0., 0.) () in
      let o2 = animate env o in
      let printer = Bulletml.Printer.print_list Bulletml.Printer.print_opcode in
      OUnit.assert_equal ~printer after o2.prog
    in
    (name, `Quick, f)
  in
  let bullet = Bullet (None, None, []) in
  let fire = (None, None, Direct bullet) in
  let tcs =
    [ "Wait 2",  [OpWaitE (Num 2.)], [OpWaitN 1]
    ; "Wait 1",  [OpWaitE (Num 1.)], []
    ; "Repeat 3",
      [OpRepeatE (Num 3., [Fire (Direct fire)])],
      [OpFire fire;OpFire fire]
    ; "Wait 0",  [OpWaitE (Num 0.);OpFire fire], []
    ; "Call", [OpCall ("f", [])], []
    ]
  in
  let get_frames prog =
    let o0 = initial_obj prog (0., 0.) () in
    let o1 = animate { env with frame = 1 } o0 in
    let o2 = animate { env with frame = 2 } o1 in
    let o3 = animate { env with frame = 3 } o2 in
    let o4 = animate { env with frame = 4 } o3 in
    let o5 = animate { env with frame = 5 } o4 in
    let o6 = animate { env with frame = 6 } o5 in
    [o0;o1;o2;o3;o4;o5;o6]
  in
  let printer = Bulletml.Printer.print_list string_of_float in
  let t1 = ("ChangeSpd", `Quick, fun () ->
      let os = get_frames [OpSpdE (SpdAbs (Num 5.), Num 5.)] in
      OUnit.assert_equal ~printer
        [0.;1.;2.;3.;4.;5.;5.]
        (List.map (fun o -> o.speed) os)
    ) in
  let t2 = ("ChangeDir", `Quick, fun () ->
      let os = get_frames [OpDirE (DirAbs (Num 50.), Num 5.)] in
      OUnit.assert_equal
        ~cmp:clist
        ~printer
        [0.;10.;20.;30.;40.;50.;50.]
        (List.map (fun o -> in_degs o.dir) os)
    ) in
  let t3 = ("Fire", `Quick, fun () ->
      let os = get_frames [OpFire fire] in
      OUnit.assert_equal ~printer
        [0.;1.;2.;3.;4.;5.]
        (List.map (fun o ->
             match o.children with
             | [bullet] -> fst bullet.pos
             | _ -> OUnit.assert_failure "no child"
           ) (List.tl os))
    ) in
  let t_accel h v exp =
    let os = get_frames [OpAccelE (Num h, Num v, Num 5.)] in
    let print_speed_vec = Bulletml.Printer.print_position in (* works too *)
    let printer = Bulletml.Printer.print_list print_speed_vec in
    let speed_vec o =
      Bulletml.Interp.from_polar (o.speed, o.dir)
    in
    OUnit.assert_equal ~printer
      exp
      (List.map speed_vec os)
  in
  let t4 = ("Accel 0", `Quick, fun () ->
      t_accel 0. 0.
        [ (0., 0.)
        ; (0., 0.)
        ; (0., 0.)
        ; (0., 0.)
        ; (0., 0.)
        ; (0., 0.)
        ; (0., 0.)
        ]
    ) in
  let t5 = ("Accel 1, 2", `Quick, fun () ->
      t_accel 1. 2.
        [ (0., 0.)
        ; (1., 2.)
        ; (2., 4.)
        ; (3., 6.)
        ; (4., 8.)
        ; (5., 10.)
        ; (5., 10.)
        ]
    ) in
  let make_eval_tc (e, r) =
    make_tc (Bulletml.Printer.print_expr e, [OpWaitE e], [OpWaitN (r-1)])
  in
  let ev_tests =
    [ (Num 3., 3)
    ; (Num 1. +@ Num 2., 3)
    ; (Num 6. /@ Num 2., 3)
    ; (Num 44. %@ Num 7., 2)
    ; (Num 4. *@ Rank, 2) (* Rank is supposed to be 0.5 for tests *)
    ]
  in
  t1::t2::t3::t4::t5::List.map make_tc tcs @ List.map make_eval_tc ev_tests

let tests_unit () =
  let open Bulletml.Interp in
  let open Bulletml.Interp_types in
  let t_polar =
    List.map (fun (xy, (r, d)) ->
        let rt = (r, ADeg d) in
        let prt (r, t) =
          Printf.sprintf "(%.2f:%.2f°)" r (in_degs t)
        in
        let pxy = Bulletml.Printer.print_position in
        let cxy (xa, ya) (xb, yb) =
          OUnit.cmp_float xa xb && OUnit.cmp_float ya yb
        in
        let crt (ra, ta) (rb, tb) =
          (* A bit hackish but we can't rely on from_polar *)
          OUnit.cmp_float ra rb
          &&
          OUnit.cmp_float (in_rads (sub_angle ta tb)) 0.
        in
        ("polar " ^ pxy xy, `Quick, fun () ->
            OUnit.assert_equal ~cmp:crt ~printer:prt rt (polar xy);
            OUnit.assert_equal ~cmp:cxy ~printer:pxy xy (from_polar rt);
        ))
      [ (1., 1.), (sqrt 2., 45.)
      ; (1., -1.), (sqrt 2., 135.)
      ; (-1., -1.), (sqrt 2., -135.)
      ; (-1., 1.), (sqrt 2., -45.)
      ]
  in
  let t_angle = ("misc", `Quick, fun () ->
      OUnit.assert_equal (ADeg 180.) (add_angle (ADeg 90.) (ADeg 90.));
      OUnit.assert_equal (ARad 2.) (add_angle (ARad 1.) (ARad 1.));
      OUnit.assert_equal (ARad pi) (add_angle (ARad (pi/.2.)) (ADeg 90.));
      OUnit.assert_equal (ADeg 0.) (sub_angle (ADeg 45.) (ADeg 45.));
      OUnit.assert_raises ~msg:"replicate (-1)" (Invalid_argument "replicate")
        (fun () -> replicate (-1) true);
      let fn = "examples/pat/01.pat" in
      let c = open_in fn in
      let spec = "    fire ();\n    ^^^^" in
      OUnit.assert_equal spec (Bulletml.Parser.highlight c 3 4 7);
      close_in c
    )
  in
  t_angle :: t_polar

let shoot script =
  let open Bulletml.Syntax in
  Fire (Direct (None, None, Direct (Bullet (None, None, [Direct script]))))

let tests_syntax () =
  let open Bulletml.Syntax in
  let tcs =
    [(`File "01.pat", `OK (
         BulletML
           ( None
           , [ EAction
                 ( "top"
                 , [ Repeat
                       ( Num 500.
                       , Direct
                           [ shoot []
                           ; Wait (Num 15.)
                           ])
                   ]
                 )
             ]
           )
       ))
    ; (`File "02.pat", `OK (
        BulletML
          ( None
          , [ EAction
                ( "top"
                , [ Repeat
                      ( Num 500.
                      , Direct
                          [ shoot
                              [ Repeat
                                  ( Num 10.
                                  , Direct
                                      [ Wait (Num 60.)
                                      ; ChangeSpeed (SpdAbs (Num 0.), Num 1.)
                                      ; Wait (Num 60.)
                                      ; ChangeSpeed (SpdAbs (Num 1.), Num 1.)
                                      ])]
                          ; Wait (Num 15.)
                          ])
                  ]
                )
            ]
          )
      ))
    ; ( `String "action x ( wait 3; );"
      , `OK (BulletML ( None , [ EAction ("x", [Wait (Num 3.)])]))
      )
    ; ( `String "action x ( wait );"
      , `Err)
    ]
  in
  let make_tc (w, res) =
    let f () =
      let b () =
        match w with
        | `File fn -> Bulletml.Parser.parse_auto ("examples/pat/" ^ fn)
        | `String s -> Bulletml.Parser.parse_pat_string s
      in
      match res with
      | `OK spec -> OUnit.assert_equal spec (b ())
      | `Err -> OUnit.assert_raises (Failure "parse error") b
    in
    let n = match w with
      | `File fn -> fn
      | `String s -> s
    in
    (n, `Quick, f)
  in
  List.map make_tc tcs

let _ =
  Alcotest.run "BulletML"
    [ ("parse", [("Parse examples", `Quick, parse_all)])
    ; ("pspec", tests ())
    ; ("comp", [("Compile examples", `Quick, compile_all)])
    ; ("cspec", tests_compile ())
    ; ("interp", tests_interp ())
    ; ("unit", tests_unit ())
    ; ("psyn", tests_syntax ())
    ]
