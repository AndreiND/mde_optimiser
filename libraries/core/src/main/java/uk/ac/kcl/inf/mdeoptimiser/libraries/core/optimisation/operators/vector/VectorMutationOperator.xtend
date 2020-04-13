package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector

import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.VectorEObject

interface VectorMutationOperator {
	def boolean mutate(VectorEObject veo)
	
	def String getName();
}