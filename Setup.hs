{-# LANGUAGE Strict #-}
import Distribution.Simple
import Distribution.Simple.Setup
import Distribution.Types.PackageDescription
import Distribution.Types.LocalBuildInfo
import System.Process (callCommand)
import Data.List
import Data.Foldable

main = defaultMainWithHooks $ simpleUserHooks {
    postBuild = buildElm ["Main", "About", "Pages.TestPage"]
}

buildElm :: [String]
                -> Args
                -> Distribution.Simple.Setup.BuildFlags
                -> Distribution.Types.PackageDescription.PackageDescription
                -> Distribution.Types.LocalBuildInfo.LocalBuildInfo
                -> IO ()
buildElm modules args buildFlags pkgDescription localBuildInfo =
    for_ modules $ \mod -> 
        let moduleSourceFile = 
              let repl '.' = '/'
                  repl x   = x
              in "frontend/" <> (map repl mod) <> ".elm"
            moduleOutFile = 
              "static/scripts/" <> mod <> ".js"
            moduleOutFileMin =
              "static/scripts/" <> mod <> ".min.js"
        in do
            callCommand $ "elm make " <> moduleSourceFile <> " --optimize --output=" <> moduleOutFile
            callCommand $ "esbuild --minify " <> moduleOutFile <> " > " <> moduleOutFileMin
            callCommand $ "gzip -kf " <> moduleOutFileMin