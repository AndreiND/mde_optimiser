package uk.ac.kcl.interpreter.evolvers.parameters

import org.eclipse.emf.henshin.model.Unit
import org.eclipse.emf.henshin.model.Parameter
import org.eclipse.emf.ecore.EObject
import java.util.List

interface IEvolverParametersFactory {
		
	/**
	 * Given an objective descriptor initialize the correct objective function.
	 */
	def Object getParameterValue(Unit unit, Parameter parameter, List<EObject> model);
}