package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector

import java.util.ArrayList
import java.util.Random
import org.moeaframework.Instrumenter
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.AlgorithmSpec
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.mutation.selection.OperatorSelectionStrategy
import org.eclipse.emf.henshin.model.Unit

class RandomSelector {

	ArrayList<String> operators;
	ArrayList<String> triedOperators;
	
	new (ArrayList<String> operators) {
		this.operators = operators;
		this.triedOperators = newArrayList
	}

	
	def addTriedOperator(String operator) {
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