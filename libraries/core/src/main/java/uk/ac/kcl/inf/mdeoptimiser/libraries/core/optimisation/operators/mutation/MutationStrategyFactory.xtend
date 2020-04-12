package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.mutation

import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.EReference
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.AlgorithmSpec
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.Parameter
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.RulegenSpec
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.interpreter.henshin.HenshinExecutor
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.adaptation.MutationStepSizeStrategy
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.mutation.selection.RandomOperatorSelector

class MutationStrategyFactory {

	HenshinExecutor henshinExecutor
	MutationStrategy mutationStrategy
	MutationStepSizeStrategy mutationStepSizeStrategy
	Parameter mutationStrategyParameter
	RulegenSpec rgs
	EReference vectorEdge
	EClass node;
	EPackage metamodel;
	
	new(HenshinExecutor henshinExecutor, MutationStepSizeStrategy mutationStepSizeStrategy,
		AlgorithmSpec algorithmSpec) {
		this.henshinExecutor = henshinExecutor;
		this.mutationStepSizeStrategy = mutationStepSizeStrategy
		this.mutationStrategyParameter = getMutationStrategyParameter(algorithmSpec)
	}
	
	new(HenshinExecutor henshinExecutor, MutationStepSizeStrategy mutationStepSizeStrategy, AlgorithmSpec algorithmSpec, RulegenSpec rgs, EReference vectorEdge, EClass node, EPackage metamodel) {
		this.henshinExecutor = henshinExecutor;
		this.mutationStepSizeStrategy = mutationStepSizeStrategy
		this.mutationStrategyParameter = getMutationStrategyParameter(algorithmSpec)
		this.rgs = rgs
		this.vectorEdge = vectorEdge;
		this.node = node;
		this.metamodel = metamodel
	}
	
	/**
	 * Get the 'mutation.strategy' parameter configuration from the specified algorithm parameters
	 * 
	 * @return Parameter containing the 'mutation.step' parameter
	 */
	def Parameter getMutationStrategyParameter(AlgorithmSpec algorithmSpec) {
		return algorithmSpec.parameters.filter[parameter|parameter.name.equals("mutation.strategy")].head
	}

	def MutationStrategy getStrategy() {

		if (this.mutationStrategy === null) {
			
			//TODO This should be an enum perhaps
			val strategyType = getMutationStrategySpecification(this.mutationStrategyParameter);
			
			switch strategyType {
				
				case "random": {
					return new RandomOperatorMutationStrategy(this.henshinExecutor, this.mutationStepSizeStrategy, new RandomOperatorSelector(this.henshinExecutor))
				}
				
				case "repetitive": {
					return new RepetitiveOperatorMutationStrategy(this.henshinExecutor, this.mutationStepSizeStrategy, new RandomOperatorSelector(this.henshinExecutor))
				}
				
				//Manual Henshin Matching Strategy
				case "manual": {
					return new ManualMatchingMutationStrategy(this.henshinExecutor, this.mutationStepSizeStrategy)
				}
				
				case "VectorRandom" : {
					return new VectorRandomOperatorMutationStrategy(this.mutationStepSizeStrategy, this.rgs, this.vectorEdge, this.node, this.metamodel)
				}
			}
		}
		
		return this.mutationStrategy;
	}
	
	def getMutationStrategySpecification(Parameter parameter) {
		
		if(this.mutationStrategyParameter === null) {
			return "random"
		}
		
		if (this.mutationStrategyParameter.value.numeric !== null) {
			return "random"
		}

		// Do we have a function name to use as a stategy without other parameters
		// eg: random then we return the name of the strategy to initialize it from the factory (this is only allowed to be random or repetitive
		// currently)
		if (this.mutationStrategyParameter.value.functional !== null) {
			return this.mutationStrategyParameter.value.functional
		}
	}
}
