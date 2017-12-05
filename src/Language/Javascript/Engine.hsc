module Language.Javascript.Engine 
  ( initialize
  ) where

import Foreign.Ptr (FunPtr)

#include <bindings.dsl.h>
#include <hs_mozilla.h>

#ccall initialize, IO ()

initialize :: IO ()
initialize = c'initialize
