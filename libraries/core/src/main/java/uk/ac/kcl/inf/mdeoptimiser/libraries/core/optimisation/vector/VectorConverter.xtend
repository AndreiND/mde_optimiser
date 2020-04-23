package uk.ac.kcl.inf.mdeoptimiser.libraries.core.optimisation.vector

import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EClass
import org.eclipse.emf.ecore.EClassifier
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.EPackage
import org.eclipse.emf.ecore.EReference
import org.eclipse.emf.ecore.impl.DynamicEObjectImpl
import uk.ac.kcl.inf.mdeoptimiser.languages.mopt.RulegenSpec

class VectorConverter {
	EPackage metamodel;
	RulegenSpec rulegenSpec;
	EClass vectorNode;
	EReference vectorEdge;
	EClass baseClass;
	
	new(EPackage metamodel, RulegenSpec rulegenSpec)  {
		this.metamodel = metamodel;
		this.rulegenSpec = rulegenSpec;
	}
	
	def isVectorisable() {
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
					for (EReference eref : eClass.getEReferences) {
						refsFromNode.add(eref)
					}
				} else {
					for (EReference eref : eClass.getEReferences) {
						if (eref.getEReferenceType.getName.equals(node.getName) && !eref.isContainment) {
							refsToNode.add(eref)
						}
					}
				}
			}
		}
		
		if (refsFromNode.size > 1 || refsToNode.size > 1) {
			println("Cannot vectorise due to too many incoming or outgoing relations to the specified node.")
		}
		
		var EReference opposite = null
		if (!refsFromNode.isEmpty) {
			opposite = refsFromNode.get(0).getEOpposite
		}
		
		
		if (refsFromNode.size > 0 || refsToNode.size > 0) {
			if (nodeSpec !== null) {	
				if (refsFromNode.size == 1 && refsToNode.size == 1) {
					if (opposite !== refsToNode.get(0)) {
						return false
					}
				}
				if (!refsToNode.isEmpty) {
					if (refsToNode.get(0).getUpperBound == 1) {
						this.vectorNode = refsToNode.get(0).getEContainingClass
						this.vectorEdge = refsToNode.get(0)
						this.baseClass = node
						return true
					} else if (!refsFromNode.isEmpty) {
						if (refsFromNode.get(0).getUpperBound == 1) {
							this.vectorNode = node
							this.vectorEdge = refsFromNode.get(0)
							this.baseClass = refsFromNode.get(0).getEReferenceType
							return true
						}
					}
					
				} else {
					if (refsFromNode.get(0).getUpperBound == 1) {
						this.vectorNode = node
						this.vectorEdge = refsFromNode.get(0)
						this.baseClass = refsFromNode.get(0).getEReferenceType
						return true
					}
				}
				
				
				
				
				
//				if (!refsFromNode.isEmpty) {
//					if (refsFromNode.get(0).getUpperBound == 1) {
//						this.vectorNode = node
//						this.vectorEdge = refsFromNode.get(0)
//						this.baseClass = refsFromNode.get(0).getEReferenceType
//						return true
//					} else if (!refsToNode.isEmpty) {
//						if (refsToNode.get(0).getUpperBound == 1) {
//							this.vectorNode = refsToNode.get(0).getEContainingClass
//							this.vectorEdge = refsToNode.get(0)
//							this.baseClass = node
//							return true
//						}
//					}
//				} 
//				else {
//					if (refsToNode.get(0).getUpperBound == 1) {
//						this.vectorNode = refsToNode.get(0).getEContainingClass
//						this.vectorEdge = refsToNode.get(0)
//						this.baseClass = node
//						return true
//					}
//				}
			}
			
			if (edgeSpec !== null) {
				
				if (!refsFromNode.isEmpty) {
					if (refsFromNode.get(0).getName.equals(edge)) {
						if (refsFromNode.get(0).getUpperBound == 1) {
							this.vectorNode = node
							this.vectorEdge = refsFromNode.get(0)
							this.baseClass = refsFromNode.get(0).getEReferenceType
							return true
						} else if (opposite !== null) {
							if (opposite.getUpperBound == 1) {
								this.vectorNode = opposite.getEContainingClass
								this.vectorEdge = opposite
								this.baseClass = node
								return true
							}
						}
					} else if (!refsToNode.isEmpty) {
						if (refsToNode.get(0).getName.equals(edge)) {
							if (refsToNode.get(0).getUpperBound == 1) {
								this.vectorNode = refsToNode.get(0).getEContainingClass
								this.vectorEdge = refsToNode.get(0)
								this.baseClass = node
								return true
							} else if (opposite !== null) {
								if (opposite.getUpperBound == 1) {
									this.vectorNode = opposite.getEContainingClass
									this.vectorEdge = opposite
									this.baseClass = opposite.getEReferenceType
									return true
								}
							}
						}
					}
				} else if (refsToNode.get(0).getName.equals(edge)){
					if (refsToNode.get(0).getUpperBound == 1) {
						this.vectorNode = refsToNode.get(0).getEContainingClass
						this.vectorEdge = refsToNode.get(0)
						this.baseClass = node
						return true
					}
				}
			}
		}
		return false
	}
	
	
	
	def getContainmentReference(EObject model, EClass inputClass) {
		var initialModel = model as DynamicEObjectImpl;
		var EReference target;
		for (EClassifier ec : this.metamodel.getEClassifiers) {
				if (ec instanceof EClass) {
					val eClass = ec as EClass
					for (EReference eref : eClass.getEReferences) {
						if (eref.getEReferenceType.getName.equals(inputClass.getName) && eref.isContainment && initialModel.eGet(eref) !== null) {
							target = eref;
						}
					}
				}
			}
		return target
	}
	
	def getContainmentList(EObject model, EReference target) {
		var EList<EObject> targetList;
			if (model.eClass.getEReferences.contains(target)) {
				targetList = model.eGet(target) as EList<EObject>
			} else {
				for (obj:model.eContents) {
					if (obj.eClass.getEReferences.contains(target)) {
						targetList = obj.eGet(target) as EList<EObject>
					}
				}
			}
		return targetList
	}
	
	def VectorEObject convert(EObject model) {
		var initialModel = model as DynamicEObjectImpl;
		var VectorEObject vectorObject = null;
		val nodeSpec = this.rulegenSpec.getNodeSpec;
		val edgeSpec = this.rulegenSpec.getEdgeSpec;

		if (nodeSpec === null && edgeSpec === null || this.rulegenSpec === null) {
			println("No rulegen found")
			return null;
		}
		
		
		if (isVectorisable) {
			var EReference target;
			for (EClassifier ec : this.metamodel.getEClassifiers) {
				if (ec instanceof EClass) {
					val eClass = ec as EClass
					for (EReference eref : eClass.getEReferences) {
						if (eref.getEReferenceType.getName.equals(vectorNode.getName) && eref.isContainment && initialModel.eGet(eref) !== null) {
							target = eref;
						}
					}
				}
			}
			
			if (!target.isChangeable) {
				target.setChangeable(true)
			}
			
			if (target.isUnsettable) {
				target.setUnsettable(false)
			}
			
			var String nodeString = null;
			if (this.rulegenSpec.getNodeSpec !== null) {
				nodeString = this.rulegenSpec.getNodeSpec.getNode
			} else {
				nodeString = this.rulegenSpec.getEdgeSpec.getNode
			}
			
			vectorObject = new VectorEObject(initialModel, target, vectorEdge, nodeString, this.baseClass, this.rulegenSpec)

		} else {
			println("Not able to vectorise given the current settings")
		}
		
		return vectorObject
	}
	
	def getNodeSpecNode() {
		
		val nodeSpec = this.rulegenSpec.getNodeSpec
		val edgeSpec = this.rulegenSpec.getEdgeSpec
		
		for (EClassifier ec : this.metamodel.getEClassifiers) {
			if (nodeSpec !== null) {
				if (ec.getName.equals(nodeSpec.getNode)) {
					return ec as EClass
				}
			}
				
			if (edgeSpec !== null) {
				if (ec.getName.equals(edgeSpec.getNode)) {
					return ec as EClass
				}
			}	
		}
	}
	
	def EReference getVectorEdge() {
		return this.vectorEdge
	}
}
