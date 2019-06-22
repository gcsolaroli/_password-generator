{ sources =
    [ "src/**/*.purs", "test/**/*.purs" ]
, name =
    "password-generator"
, dependencies =
    [ "console"
    , "effect"
    , "halogen"
    , "node-buffer"
    , "pipes"
    , "psci-support"
    , "random"
    , "sequences"
    ]
, packages =
    ./packages.dhall
}
