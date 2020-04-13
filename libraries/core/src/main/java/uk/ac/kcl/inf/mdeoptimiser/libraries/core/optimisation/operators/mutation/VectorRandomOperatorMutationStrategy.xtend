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
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector.VectorCreateNode
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector.VectorFlip
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector.VectorMutationOperator
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.operators.vector.VectorRemoveNode
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.RandomSelector
import uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector.VectorEObject

class VectorRandomOperatorMutationStrategy implements MutationStrategy {
	
	MutationStepSizeStrategy mutationStepSizeStrategy;
	ArrayList<VectorMutationOperator> operators;
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
		
		this.nodeSpec = this.rgs.getNodeSpec
		this.edgeSpec = this.rgs.getEdgeSpec
		
		this.randomSelector = new RandomSelector(this.operators)
		
		operators.add(new VectorFlip(1))
		if (rgs.getNodeSpec !== null) {
			this.operators.add(new VectorCreateNode(this.nodeClass))
			this.operators.add(new VectorRemoveNode(this.metamodel, this.nodeClass, "empty"))
			
		}
	
	}
	
	override mutate(Solution model) {
		// val candidateSolution = new Solution(model.getVectorModel)
		println("MODEL IN MUTATE: " + model)
		this.applyOperators(model.getVectorModel)
		
		return new Solution(model.getVectorModel)
	}
	
	def applyOperators(VectorEObject model) {
		val stepSize = this.mutationStepSizeStrategy.nextStepSize
		
		for (var step = 1; step <= stepSize; step++) {
			var VectorMutationOperator operator = null
			var operatorApplied = false
			
			do {
				operator = this.randomSelector.getNextOperator
				println("APPLYING OPERATOR: " + operator.getName)
				operatorApplied = operator.mutate(model)
				println("Gene: " + model.getGene)
				println("baseEObjectMap: " + model.baseEObjectMapToString)
				println("vectorMap: " + model.vectorMapToString)
			} while (!operatorApplied && randomSelector.hasUntriedOperators)
		}
	}
	
	def void createNode(VectorEObject model) {
		val newObject = new DynamicEObjectImpl(nodeClass)
		model.addNewVectorObject(newObject)
		println("NEW OBJECT: " + newObject)
	}
	
	def void deleteNode(VectorEObject model) {
		val EList<EObject> nodeList = getNodeList(model.getModel)
//		println("\nNODE LIST: " + nodeList)
		if (!nodeList.isEmpty) {
			val toRemove = nodeList.get(new Random().nextInt(nodeList.size))
			nodeList.remove(toRemove)
		}
	}
	
	def EList<EObject> getNodeList (EObject model) {
		for (ec:metamodel.getEClassifiers) {
			if (ec instanceof EClass) {
				val eClass = ec as EClass
//				println("ECLASS INSIDE GETNODELIST: " + eClass)
				for (EReference eref : eClass.getEReferences) {
//					println("EREF: " + eref)
//					println("EClass: " + ec)
//					println("MODEL REFS: " + model.eClass.getEReferences)
//					println("MODEL EGET EREF: " + model.eGet(eref))
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
	
//	def flipAssignment(VectorEObject model) {
//		model.flip()
//		println("Gene after flip: " + model.getGene)
//	}
	
}

