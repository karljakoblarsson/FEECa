{-# LANGUAGE TypeFamilies #-}

module Vector(Vector(..),
              vector,
              toList,
              powV) where

import Spaces hiding (toList)
import FormsTest
import Text.PrettyPrint
import Print

-- | Vectors in R^n
data Vector = Vector [Double] deriving (Eq)

instance RenderVector Vector where
    ncomps (Vector l) = length l
    components = toList

instance Dimensioned Vector where
    dim (Vector l) = length l

instance Show Vector where
    show v = "Vector:\n" ++ (show $ printVector 2 v)

instance VectorSpace Vector where
  type Fieldf Vector   = Double
  vspaceDim (Vector l) = length l
  addV (Vector l1) (Vector l2) = Vector $ zipWith (+) l1 l2
  sclV c (Vector l) = Vector $ map (c*) l

-- | Create vector from list of components.
vector :: [Double] -> Vector
vector = Vector

-- | Return vector components as list.
toList :: Vector -> [Double]
toList (Vector l) = l

-- | Generalized power funciton for vectors. Given a list l of Int with
-- | the same length as the dimension of the vector v and components cs, the
-- | function computes the product of each component (cs!!i) raised to (l!!i)th
-- | power.
powV :: Vector -> [Int] -> Double
powV (Vector cs) l = powVList cs l

powVList [] [] = mulId
powVList (v:vs) (i:is) = v ** (fromIntegral i) * powVList vs is
powVLint _ _ = error "powV: Lists do not have equal length"
