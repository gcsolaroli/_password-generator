{
    name = "password-generator",
    sources = [ "src/purescript/**/*.purs", "test/purescript/**/*.purs" ],
    dependencies = [
        "console",
        "effect",
        "halogen",
        "node-buffer",
        "pipes",
        "psci-support",
        "random",
        "sequences"
    ],
    packages = ./packages.dhall
}
