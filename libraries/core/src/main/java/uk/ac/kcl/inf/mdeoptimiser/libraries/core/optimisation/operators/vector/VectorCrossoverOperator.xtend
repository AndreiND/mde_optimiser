package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector

import java.util.List
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.interpreter.guidance.Solution

interface VectorCrossoverOperator {
	def List<Solution> breed(List<Solution> parents) 
	
	def String getName()
}