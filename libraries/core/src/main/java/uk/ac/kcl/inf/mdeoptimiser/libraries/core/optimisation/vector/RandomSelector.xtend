package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector

import java.util.ArrayList
import java.util.Random
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector.VectorMutationOperator

class RandomSelector {

	ArrayList<VectorMutationOperator> operators;
	ArrayList<VectorMutationOperator> triedOperators;
	
	new (ArrayList<VectorMutationOperator> operators) {
		this.operators = operators;
		this.triedOperators = newArrayList
	}

	
	def addTriedOperator(VectorMutationOperator operator) {
		triedOperators.add(operator)
	}
	
	def boolean hasUntriedOperators(){
		return triedOperators.size < this.operators.size 
	}
	def void flushTriedOperators() {
		triedOperators.clear()
	}
	
	def getNextOperator() {
		if (this.hasUntriedOperators) {
			val remainingOperators = operators.filter[o|!this.triedOperators.contains(o)].toList
			val operator = remainingOperators.remove(new Random().nextInt(remainingOperators.size))
			return operator
		}
		
		return null
	}
	
}