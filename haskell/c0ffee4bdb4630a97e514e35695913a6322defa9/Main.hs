import Data.List (find)
import qualified Data.ByteString.Char8 as Char8
import qualified Data.ByteString.Base16 as Base16
import qualified Crypto.Hash.SHA1 as SHA1

-- Format an email given a prefix, suffix, and variable part
fmtEmail prefix suffix i = prefix ++ i ++ suffix

-- Generate a list of all possible integers
bruteIntegers = iterate (+ 1) 0

-- Casted as strings
bruteIntegerStrings = map show bruteIntegers

-- Formatted as emails
bruteEmails prefix suffix =
  map fmt bruteIntegerStrings where
    fmt = fmtEmail prefix suffix

-- Bound to my email pattern
bruteMyEmails = bruteEmails "example+" "@example.com"

-- Coffee bytes
coffee = fst $ Base16.decode $ Char8.pack "c0ffee"

-- Test if given bytes begins with coffee bytes
isCoffee bytes = coffee == Char8.take (Char8.length coffee) bytes

-- Test if given hashed email begins with coffee
isCoffeeEmail email =
  isCoffee $ SHA1.hash $ Char8.pack email

main =
  let match = find isCoffeeEmail bruteMyEmails
  in case match of Just match -> putStrLn match
