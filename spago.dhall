{ sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
, name =
    "password-generator"
, dependencies =
    [ "console"
    , "effect"
    , "halogen"
    , "pipes"
    , "random"
    , "sequences"
    , "node-buffer"
    ]
, packages =
    ./packages.dhall
}
