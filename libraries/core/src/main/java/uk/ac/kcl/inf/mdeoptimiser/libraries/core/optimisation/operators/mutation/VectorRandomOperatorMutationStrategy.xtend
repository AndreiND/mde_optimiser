package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.mutation

import java.util.ArrayList
import java.util.Random
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.impl.DynamicEObjectImpl
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.RulegenEdge
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.RulegenNode
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.RulegenSpec
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.interpreter.guidance.Solution
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.adaptation.MutationStepSizeStrategy
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.RandomSelector
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.VectorEObject

class VectorRandomOperatorMutationStrategy implements MutationStrategy {
	
	MutationStepSizeStrategy mutationStepSizeStrategy;
	ArrayList<String> operators;
	RulegenSpec rgs;
	EReference vectorEdge;
	RandomSelector randomSelector;
	EClass nodeClass;
	RulegenNode nodeSpec;
	RulegenEdge edgeSpec;
	EPackage metamodel;
	
	new (MutationStepSizeStrategy mutationStepSizeStrategy, RulegenSpec rgs, EReference vectorEdge, EClass node, EPackage metamodel) {
		this.mutationStepSizeStrategy = mutationStepSizeStrategy;
		this.rgs = rgs
		this.vectorEdge = vectorEdge
		this.metamodel = metamodel
		nodeClass = node
		operators = newArrayList
		operators.add("create")
		operators.add("delete")
		if (rgs.getEdgeSpec !== null) {
			this.operators.add("addToEdge")
			this.operators.add("removeFromEdge")
		}
		
		this.nodeSpec = this.rgs.getNodeSpec
		this.edgeSpec = this.rgs.getEdgeSpec
		
		this.randomSelector = new RandomSelector(this.operators)
		
	}
	
	override mutate(Solution model) {
		val candidateSolution = model.getModel as VectorEObject
		this.applyOperators(candidateSolution)
		
		println("CONTENTS AFTER OPERATIONS APPLIED: " + candidateSolution.getModel.eContents)
		return new Solution(candidateSolution)
	}
	
	def applyOperators(VectorEObject model) {
		val stepSize = this.mutationStepSizeStrategy.nextStepSize
		
		for (var step = 1; step <= stepSize; step++) {
			var String operator = null
			
			do {
				operator = this.randomSelector.getNextOperator
				switch operator {
					case "create": {
						println("CREATING NEW EOBJECT")
						createNode(model)
					}
					case "delete": {
						println("DELETING EOBJECT")
						deleteNode(model)
					}
					default: {
						println("Other operator found")
					}
				}
			} while (randomSelector.hasUntriedOperators)
		}
	}
	
	def void createNode(VectorEObject model) {
		var EReference containmentRef = null;
		var EObject containmentObj = null;
		for (ec:metamodel.getEClassifiers) {
			if (ec instanceof EClass) {
				val eClass = ec
				for (eref:eClass.getEReferences) {
					println("ERefType name: " + eref.getEReferenceType.getName)
					println("nodeClass name: " + nodeClass.getName)
					if (eref.getEReferenceType.getName.equals(nodeClass.getName) && eref.isContainment) {
						containmentRef = eref
					}
				}
			}
		}
		if (containmentRef === null) {
			println("CONTAINMETREF IS NULL!")
		} else {
			println("CONTAINMENTREF: " + containmentRef)
			println("MODEL ECLASS: " + model.eClass)
			println("MODEL ECLASS EREFS: " + model.eClass.getEReferences)
			if (model.eClass.getEReferences.contains(containmentRef)) {
				containmentObj = model
			} else {
				for (obj:model.eContents) {
					if (obj.eClass.getEReferences.contains(containmentRef)) {
						containmentObj = obj
					}
				}
			}
		}
		
		
		
		
		
		val newObject = new DynamicEObjectImpl(nodeClass)
		val containmentList = containmentObj.eGet(containmentRef) as EList<DynamicEObjectImpl>
		containmentList.add(newObject)
		println("NEW OBJECT: " + newObject)
		println("MODEL ECONTENTS AFTER CREATION OF NEW OBJECT: " + model.eContents)
		
	}
	
	def void deleteNode(VectorEObject model) {
		val EList<EObject> nodeList = getNodeList(model)
		println("\nNODE LIST: " + nodeList)
		if (!nodeList.isEmpty) {
			val toRemove = nodeList.get(new Random().nextInt(nodeList.size))
			nodeList.remove(toRemove)
		}
	}
	
	def EList<EObject> getNodeList (EObject model) {
		for (ec:metamodel.getEClassifiers) {
			if (ec instanceof EClass) {
				val eClass = ec as EClass
				println("ECLASS INSIDE GETNODELIST: " + eClass)
				for (EReference eref : eClass.getEReferences) {
					println("EREF: " + eref)
					println("EClass: " + ec)
					println("MODEL REFS: " + model.eClass.getEReferences)
					println("MODEL EGET EREF: " + model.eGet(eref))
					if (eref.getEReferenceType.getName.equals(nodeClass.getName) && eref.isContainment) {
						if (model.eGet(eref) !== null) {
							return model.eGet(eref) as EList<EObject>
						} else {
							for (obj:model.eContents) {
								if (obj.eClass.getName.equals(ec.getName)) {
									return obj.eGet(eref) as EList<EObject>
								}
							}
						}
					}
				}
			}
		}
	}
	
}

