package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector

import java.util.List
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.interpreter.guidance.Solution

class VectorNPointCrossover implements VectorCrossoverOperator {
	
	int crossovers
	String name = "nPoint"
	
	new(int crossovers) {
		this.crossovers = crossovers
	}
	
	// Assuming 2 parents in all cases
	override List<Solution> breed(List<Solution> parents) {
		for (parent:parents) {
			if (parent.getVectorModel === null) {
				return null
			}
			val parent1 = parents.get(0)
			val parent2 = parents.get(1)
			
			
		}
	}
	
	override String getName() {
		return name
	}
}