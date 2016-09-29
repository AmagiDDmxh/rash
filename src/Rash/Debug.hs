module Rash.Debug where

import           Control.Monad    (when)
import qualified System.IO.Unsafe as Unsafe

import qualified Rash.Options     as Opts

todo :: Show a => String -> a -> r
todo msg obj = do
  error $ "\nTODO: " ++ msg ++ ": " ++ show obj

{-# NOINLINE debug #-}
debug :: Show a => String -> a -> ()
debug msg x = do
  Unsafe.unsafePerformIO $ debugIO msg x

debugIO :: Show a => String -> a -> IO ()
debugIO msg x = do
  when (Opts.debugAll Opts.flags) $ putStrLn $ "DEBUG (" ++ msg ++ "): " ++ show x
