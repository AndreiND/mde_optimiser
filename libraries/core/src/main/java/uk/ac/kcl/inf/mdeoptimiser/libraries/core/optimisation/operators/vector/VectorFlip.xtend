package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector

import java.util.Random
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.VectorEObject
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.EmptyStaticGeneException

class VectorFlip implements VectorMutationOperator {
	
	String name = "flip"
	int flips
	
	new (int flips) {
		this.flips = flips
	}
	
	override boolean mutate(VectorEObject veo) {
		if (veo.infinite) {
			println("Time and again")
			throw new EmptyStaticGeneException("Gene is static and empty, no mutation can occur.")
		}
		val beom = veo.getBaseEObjectMap
		if (!beom.isEmpty && !veo.getGene.isEmpty) {
			for (var i = 0;i < flips; i++) {
				val randomIndex = new Random().nextInt(veo.getGene.size)
				val currentAssignment = veo.getGene.get(randomIndex)
				var newValue = new Random().nextInt(beom.size)
				
				if (currentAssignment !== null && (beom.size > 1)) {
					if (newValue == currentAssignment) {
						while (newValue == currentAssignment) {
							newValue = new Random().nextInt(beom.size)

						}
					}
				}
				println("Flipping index: " + randomIndex)
				println("To new value: " + newValue)
				veo.getGene.set(randomIndex, newValue)
				veo.constructModelFromVector
			}
			return true
			
		}
		
		println("Flip returning false")
		return false
	} 
	
	override getName() {
		return name
	}
	
}