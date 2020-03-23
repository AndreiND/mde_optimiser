package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector

import org.apache.commons.lang3.StringUtils
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EClassifier
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.EReference
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.RulegenSpec

class VectorConverter {
	EPackage metamodel;
	RulegenSpec rulegenSpec;
	EClass vectorNode;
	EReference vectorEdge;
	
	new(EPackage metamodel, RulegenSpec rulegenSpec)  {
		this.metamodel = metamodel;
		this.rulegenSpec = rulegenSpec;
		println("INSIDE RULEGENSPEC: " + rulegenSpec);
	}
	
	def isVectorisable() {
		// This function should, if there is an edgeSpec, check that the reference given by this edgeSpec has an upper bound of, or that it's opposite has an upper bound of 1
		// In this case it should also check that either the nodeSpec gives an eReference belonging to the nodespec class, or that this 
		// If there is no edgeSpec, then there should be max one reference from the class and max one reference to the class, at least one of these must exist.
		// Also at least one of these must have an upper limit of 1. The origin class that holds the reference with upper bound 1 is the vector target, if both have an upper limit 1 
		// reference then the node from the rulespec becomes the vector target.
		val nodeSpec = this.rulegenSpec.getNodeSpec
		val edgeSpec = this.rulegenSpec.getEdgeSpec
		
		if (this.rulegenSpec === null || (nodeSpec === null && edgeSpec === null)) {
			return false
		}
		
		var refsFromNode = newArrayList
		var refsToNode = newArrayList
		var EClass node = null;
		var String edge = null;
		if (nodeSpec !== null) {
			for (EClassifier ec : this.metamodel.getEClassifiers) {
				if (ec.getName.equals(nodeSpec.getNode)) {
					node = ec as EClass
				}
			}
			
		} else if(edgeSpec !== null) {
			for (EClassifier ec : this.metamodel.getEClassifiers) {
				if (ec.getName.equals(edgeSpec.getNode)) {
					node = ec as EClass
				}
			}
			edge = edgeSpec.getEdge
		} else {
			println("No nodespec or rulespec specified")
			return false
		}
		
		// Populate the list of references from the node class and the list of references to the node class
		for (EClassifier ec : this.metamodel.getEClassifiers) {
			if (ec instanceof EClass) {
				val eClass = ec as EClass
				if (node.getName.equals(ec.getName)) {
					println("EClassifier matching the node has been found!")
					println("EClass: " + ec.getName + "\nReferences: ")
					for (EReference eref : eClass.getEReferences) {
						refsFromNode.add(eref)
					}
				} else {
					for (EReference eref : eClass.getEReferences) {
						// NOTE At this stage, I have decided to exclude containment references from this list, assuming that all cases where the node class is contained, the containment simply 
						// implies that the reference keeps a list of all instances of the node class, and as such is not significant information for the vectorisation process
						if (eref.getEReferenceType.getName.equals(node.getName) && !eref.isContainment) {
							refsToNode.add(eref)
						}
					}
				}
			}
		}
		
		println("refsFromNode: " + refsFromNode)
		println("refsToNode: " + refsToNode)
		val opposite = refsFromNode.get(0).getEOpposite
		
		if (refsFromNode.size > 1 || refsToNode.size > 1 || !(refsFromNode.isEmpty && refsToNode.isEmpty)) {
			if (nodeSpec !== null) {
				
				if (refsFromNode.size == 1 && refsToNode.size == 1) {
					if (opposite !== refsToNode.get(0)) {
						return false
					}
				}
				if (!refsFromNode.isEmpty) {
					if (refsFromNode.get(0).getUpperBound == 1) {
						this.vectorNode = node
						this.vectorEdge = refsFromNode.get(0)
						return true
					} else if (!refsToNode.isEmpty) {
						if (refsToNode.get(0).getUpperBound == 1) {
							this.vectorNode = refsToNode.get(0).getEContainingClass
							this.vectorEdge = refsToNode.get(0)
							return true
						}
					}
				} else {
					if (refsToNode.get(0).getUpperBound == 1) {
						this.vectorNode = refsToNode.get(0).getEContainingClass
						this.vectorEdge = refsToNode.get(0)
						return true
					}
				}
			}
			
			if (edgeSpec !== null) {
				if (!refsFromNode.isEmpty) {
					if (refsFromNode.get(0).getName.equals(edge)) {
						if (refsFromNode.get(0).getUpperBound == 1) {
							this.vectorNode = node
							this.vectorEdge = refsFromNode.get(0)
							return true
						} else if (opposite !== null) {
							if (opposite.getUpperBound == 1) {
								this.vectorNode = opposite.getEContainingClass
								this.vectorEdge = opposite
								return true
							}
						}
					} else if (!refsToNode.isEmpty) {
						if (refsToNode.get(0).getName.equals(edge)) {
							if (refsToNode.get(0).getUpperBound == 1) {
								this.vectorNode = refsToNode.get(0).getEContainingClass
								this.vectorEdge = refsToNode.get(0)
								return true
							}
						}
					}
				} else if (refsToNode.get(0).getUpperBound == 1) {
					this.vectorNode = refsToNode.get(0).getEContainingClass
					this.vectorEdge = refsToNode.get(0)
					return true
				}
			}
		}
		return false
	}
	
	def EObject convert(EObject model) {
		var initialModel = model;
		val nodeSpec = this.rulegenSpec.getNodeSpec;
		val edgeSpec = this.rulegenSpec.getEdgeSpec;
		
		println("INSIDE NodeSpec: " + nodeSpec);
		println("INSIDE EdgeSpec: " + edgeSpec);
		
		println("isVectorisable(): " + isVectorisable)
		println("vectorNode: " + this.vectorNode)
		println("VectorEdge: " + this.vectorEdge)
		
		if (nodeSpec === null && edgeSpec === null || this.rulegenSpec === null) {
			println("No rulegen found")
			return null;
		}
		
		if (isVectorisable) {
			for (EClassifier ec : this.metamodel.getEClassifiers) {
				if (ec instanceof EClass) {
				val eClass = ec as EClass
					for (EReference eref : eClass.getEReferences) {
						if (eref.getEReferenceType.equals(vectorNode.getName) && eref.isContainment) {
							var list = eref.getEContainingClass.eGet(eref)
							println("Feature List: " + list)
						}
					}
				}
			}
		
			
		} else {
			println("Not able to vectorise given the current settings")
		}
		
		return null;
	}
}