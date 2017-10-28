package uk.ac.kcl.interpreter.evolvers.parameters

import java.util.List
import uk.ac.kcl.mdeoptimise.EvolverSpec
import org.eclipse.emf.henshin.model.Unit
import org.eclipse.emf.henshin.model.Parameter
import java.util.Map
import java.util.HashMap
import uk.ac.kcl.interpreter.evolvers.parameters.functions.RandomEvolverParameter
import java.io.InvalidObjectException
import org.eclipse.emf.ecore.EObject

class EvolverParametersFactory implements IEvolverParametersFactory {
	
	private List<EvolverSpec> evolvers;
	//Triple <UnitName, <ParameterName, Function>>
	private Map<String, Map<String, IEvolverParametersFunction>> evolverParameterFunctions;
	
	
	//TODO Add an evolver spec adapter
	new(List<EvolverSpec> evolvers){
		this.evolvers = evolvers;
		
		//Load the parameter functions for each of the evolvers specified in the DSL
		loadParameters()
	}
	
	def void loadParameters(){
		
		evolverParameterFunctions = new HashMap<String, Map<String, IEvolverParametersFunction>>();
		
		for(var evolverId = 0; evolverId < evolvers.length; evolverId++){
			
			val evolver = evolvers.get(evolverId)

			val parameters = new HashMap<String, IEvolverParametersFunction>();
			
			evolver.parameters.forEach[ 
				parameter | parameters.put(parameter.name, getParameter(new EvolverParameterAdapter(parameter)
			))]
			
			evolverParameterFunctions.put(evolver.unit, parameters)
		}
	}
	
	def IEvolverParametersFunction getParameter(EvolverParameterAdapter parameter){
		switch(parameter.function){
			case "Random":
				return new RandomEvolverParameter()
			default:
				//TODO This should perhaps check that there is a class based parameter and then try to initialize it
				//or fail if that is not possible
				throw new InvalidObjectException("Invalid objective type: " + parameter.function)
		}
	}
	
	override getParameterValue(Unit unit, Parameter parameter, List<EObject> model) {
		
		val parameterFunction = evolverParameterFunctions.get(unit.name).get(parameter.name)
		
		return parameterFunction.sample(model)
	}
	
}