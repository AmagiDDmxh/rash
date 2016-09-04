module Rash.Runner (runSource, runFile, evalAndPrint) where

import qualified Data.Either as Either
import qualified System.Exit as Exit

import Rash.AST
import qualified Rash.Interpreter as Interpreter
import qualified Rash.Bash2AST as Bash2AST

evalAndPrint :: String -> String -> IO ()
evalAndPrint name source = do
  result <- case (Bash2AST.translate name source) of
    Left err -> return . show $ err
    Right prog -> Interpreter.interpret prog [] >>= return .show
  putStrLn result
  return ()

runProgram :: Program -> [String] -> IO Exit.ExitCode
runProgram program args = do
  exit <- Interpreter.interpret program args
  return $ convertToExitCode exit

runSource :: String -> String -> [String] -> IO Exit.ExitCode
runSource name source args = do
  Either.either
    (\err -> (do
                (putStr $ show err)
                return $ Exit.ExitFailure (-1)))
    ((flip runProgram) args)
    (Bash2AST.translate name source)


runFile :: FilePath -> [String] -> IO Exit.ExitCode
runFile file args = do
  src <- readFile file
  runSource file src args

convertToExitCode :: Interpreter.Value -> Exit.ExitCode
convertToExitCode (Interpreter.VInt i) = if i == 0 then Exit.ExitSuccess else Exit.ExitFailure i
convertToExitCode _ = Exit.ExitSuccess
